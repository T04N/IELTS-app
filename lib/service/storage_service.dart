import 'dart:io';
import 'package:ielts_tev/model/image_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Uploads a file and returns the download URL
  Future<String> uploadInput(File input) async {
    try {
      // Create a reference to the file location in Firebase Storage
      final ref = _storage.ref().child(
          'input/${DateTime.now().millisecondsSinceEpoch}_${input.path.split('/').last}');

      // Upload the file
      UploadTask uploadTask = ref.putFile(input);

      // Wait until the upload is complete
      await uploadTask.whenComplete(() {});

      // Get the download URL
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      throw Exception('Error uploading file: $e');
    }
  }

  Future<List<ImageModel>> loadUserImages() async {
    try {
      // Fetch list of items from storage
      final listResult = await _storage.ref().listAll();

      // Wait for all the asynchronous operations to complete
      final images = await Future.wait(listResult.items.map((item) async {
        final url = await item.getDownloadURL();
        return ImageModel(url: url, name: item.name);
      }).toList());

      return images;
    } catch (e) {
      throw Exception('Error getting images: $e');
    }
  }
}
