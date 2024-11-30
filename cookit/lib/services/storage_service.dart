import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


Future<File?> pickImage() async{
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery );
  return pickedFile != null ? File(pickedFile.path) : null;
}


class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File imageFile) async{
    String fileName = 'recipes/${DateTime.now().millisecondsSinceEpoch}';
    Reference ref = _storage.ref().child(fileName);
    await ref.putFile(imageFile);
    return await ref.getDownloadURL();
  }
}
