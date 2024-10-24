import 'dart:io';
import 'package:ielts_tev/gen/assets.gen.dart';
import 'package:ielts_tev/presentation/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? pickedImage;

  // Function to pick image from source (camera/gallery)
  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      int fileSize = await pickedFile.length();
      // Check if the file size is less than or equal to 4MB
      if (fileSize <= 4 * 1024 * 1024) {
        setState(() {
          pickedImage = File(pickedFile.path);
        });
        await context.read<HomeBloc>().uploadInput(File(pickedFile.path));
      } else {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    'File size exceeds 4MB. Please choose a smaller file.')),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yolo app"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(children: [
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                      image: pickedImage != null
                          ? FileImage(pickedImage!)
                          : Assets.images.placeholderImage.provider(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: context.read<HomeBloc>().inputStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else if (snapshot.hasData && snapshot.data != null) {
                      final input = snapshot.data!;
                      return Container(
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          image: DecorationImage(
                            image: NetworkImage(input.url),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        width: 200,
                        height: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: Assets.images.placeholderImage.provider(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(
                width: 16,
              ),
            ]),
            ElevatedButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  return _buildImageSourceSheet(context);
                },
              ),
              child: const Text("Pick Image"),
            ),
          ],
        ),
      ),
    );
  }

  // Build the bottom sheet for choosing image source
  Widget _buildImageSourceSheet(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _buildImageSourceOption(
                text: 'Take Photo',
                onTap: () {
                  Navigator.pop(context);
                  _getImage(ImageSource.camera);
                },
              ),
              const Divider(height: 1),
              _buildImageSourceOption(
                text: 'Choose from Gallery',
                onTap: () {
                  Navigator.pop(context);
                  _getImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Build individual options for image source (camera or gallery)
  Widget _buildImageSourceOption(
      {required String text, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Center(child: Text(text)),
      ),
    );
  }
}
