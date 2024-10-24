import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileUtils {
  static Future<String> getApplicationCachePath() async {
    final directory = await getApplicationCacheDirectory();
    return directory.path;
  }

  static Future<String> getFileName(File file,
      {bool includeFileExt = true}) async {
    var fileName = file.path.split('/').last;
    if (!includeFileExt) {
      fileName = fileName.split('.').first;
    }
    return fileName;
  }

  static Future<void> deleteFileInPath(String? path) async {
    if (path == null) return;
    await File(path).delete();
  }

  static void _deleteFileInIsolate(Map<String, dynamic> data) {
    final String? path = data['path'];

    if (path != null) {
      try {
        File(path).deleteSync();
      } catch (e) {
        // Handle any errors that occur during file deletion.
        debugPrint('Error deleting file: $e');
      }
    }
  }

  static Future<void> deleteFileInIsolateAsync(String? path) async {
    final receivePort = ReceivePort();
    final data = {'path': path};

    await Isolate.spawn(
      _deleteFileInIsolate,
      data,
      onError: receivePort.sendPort,
    );

    receivePort.listen((message) {
      if (message is SendPort) {
        message.send(null); // Signal that the operation is completed.
        receivePort.close();
      } else if (message is Exception) {
        debugPrint('Error in isolate: $message');
      }
    });
  }

  static Future<File> saveFile(String fileName, Uint8List data) async {
    var tempDir = await getTemporaryDirectory();
    var tempPath = tempDir.path;
    return await File(
      '$tempPath/$fileName',
    ).writeAsBytes(data);
  }

  static String getFileNameViaUrl(
    String url, {
    bool includeFileExt = true,
    bool includeRandomSuffix = false,
  }) {
    var fileName = url.split('/').last;
    var fileExt = fileName.split('.').last;
    fileName = fileName.split('.').first;
    if (includeRandomSuffix) {
      fileName = '$fileName-${DateTime.now().toIso8601String()}';
    }
    if (!includeFileExt) {
      return fileName;
    }
    return '$fileName.$fileExt';
  }
}
