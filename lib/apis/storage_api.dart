import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:dsa_proj/constants/appwrite_constants.dart';
import 'package:dsa_proj/core/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageAPIProvider = Provider((ref) {
  return StorageAPI(storage: ref.watch(appwriteStorageProvider));
});

class StorageAPI {
  final Storage _storage;
  StorageAPI({required Storage storage}) : _storage = storage;

  Future<List<String>> uploadImages(List<File> files) async {
    List<String> imageLinks = [];
    for (final file in files) {
      final uploadedImage = await _storage.createFile(
        bucketId: AppwriteConstants.imagesBucket,
        fileId: ID.unique(),
        file: InputFile.fromPath(path: file.path),
      );
      imageLinks.add(AppwriteConstants.imageURL(uploadedImage.$id));
    }
    return imageLinks;
  }
}
