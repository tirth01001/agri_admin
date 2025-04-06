

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickFile() async {
  final picker = ImagePicker();
  final pickFile = await picker.pickImage(source: ImageSource.gallery);
  return pickFile != null ? File(pickFile.path) : null;
} 


// Future<String?> uploadProductImageToFirebase(File files) async {
//   try{

//   }catch(e){

//   }
// }

Future<String?> uploadImageToFirebase(File file,{bool toAdmin=true}) async {
  try{  
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref;
    if(toAdmin){
      ref = storage.ref().child('admin/${DateTime.now().millisecondsSinceEpoch}.png');
    }else{
      ref = storage.ref().child('product/${DateTime.now().millisecondsSinceEpoch}.png');
    }
    await ref.putFile(file);
    String url = await ref.getDownloadURL();
    print(url);
    return url;
  }catch(e){
    debugPrint("Failed : $e");
  } 
  return null;
}