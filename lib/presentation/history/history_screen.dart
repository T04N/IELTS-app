import 'package:auto_route/auto_route.dart';
import 'package:ielts_tev/model/image_model.dart';
import 'package:ielts_tev/utils/wiget/image_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ielts_tev/presentation/history/bloc/history_bloc.dart'; // Import HistoryBloc

@RoutePage()
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryBloc>().loadImages();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),
      body: Column(
        children: [
          // ElevatedButton(
          //   onPressed: () {
          //     // Trigger the HistoryBloc to load images when button is clicked
          //     context.read<HistoryBloc>().loadImages();
          //   },
          //   child: const Text('Load Images'),
          // ),
          const SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<List<ImageModel>>(
              stream: context.read<HistoryBloc>().imageStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(),);
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No images found.'));
                } else {
                  // Display the images in a grid
                  final images = snapshot.data!;
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // 3 images per row
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      final image = images[index];
                      return ImageGridItem(imageUrl: image.url);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
