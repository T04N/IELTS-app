import 'dart:async';

import 'package:ielts_tev/model/image_model.dart';
import 'package:ielts_tev/service/storage_service.dart';

class HistoryBloc {
  final StorageService _storageService;

  final _imageController = StreamController<List<ImageModel>>.broadcast();
  Stream<List<ImageModel>> get imageStream => _imageController.stream;

  HistoryBloc(this._storageService);

  Future<void> loadImages() async {
    try {
      final images = await _storageService.loadUserImages();
      _imageController.add(images);
    } catch (e) {
      _imageController.addError(e);
    }
  }

  void dispose() {
    _imageController.close();
  }
}

