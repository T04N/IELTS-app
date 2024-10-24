// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:ielts_tev/model/input.dart';
import 'package:ielts_tev/repository/input_repository.dart';
import 'package:ielts_tev/repository/output_repository.dart';
import 'package:ielts_tev/service/storage_service.dart';

class HomeBloc {
  final InputRepository inputRepository;
  final OutputRepository outputRepository;
  final StorageService storageService;
  HomeBloc({
    required this.inputRepository,
    required this.outputRepository,
    required this.storageService,
  });

  // File? inputFile;
  Stream<Input?> get inputStream => getOutputByEmail("Example");

  Future<void> uploadInput(File inputFile) async {
    try {
      String fileUrl = await storageService.uploadInput(inputFile);
      Input input = Input(
          email: "Example",
          fileName: inputFile.path.split('/').last,
          url: fileUrl);
      await inputRepository.addInput(input);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  Stream<Input?> getOutputByEmail(String email) {
    return outputRepository.getOutputByEmail(email);
  }

  void onFileChange(File input) {
    input = input;
  }
}
