import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:ecomerceapp/Product/repository/firebase_storage_api.dart';

class FirebaseStorageRepository {
  final _firebase_storage_api = FirebaseStorageAPI();

  Future<StorageUploadTask> uploadFile(String path, File image) =>
      _firebase_storage_api.uploadFile(path, image);
}
