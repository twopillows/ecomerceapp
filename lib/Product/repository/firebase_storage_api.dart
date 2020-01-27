import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageAPI {
  StorageReference _firebaseStorageAPI = FirebaseStorage.instance.ref();

  Future<StorageUploadTask> uploadFile(String path, File image) async{
    return _firebaseStorageAPI.child(path).putFile(image);
  }
}
