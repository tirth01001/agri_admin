



import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/firebase/shared_pref_service.dart';
import 'package:flutter_dashboard/model/auth_model.dart';
import 'package:flutter_dashboard/model/popular.dart';
import 'package:flutter_dashboard/splesh_screen.dart';


class FirebaseService {

  static FirebaseService service = FirebaseService();


  Future<AuthModel> init(String id) async {
    try{

      AuthModel temp = AuthModel.empty();

      await FirebaseFirestore.instance.collection("e_farmer_admin").doc(id).get().then((snap){
        if(snap.exists){
          temp = AuthModel.empty(
            logId: id,
            logo: snap.get('c_detail')["c_logo"],
            address: snap.get("c_detail")['c_address'],
            email: snap.get('login')['email'],
            sellerId: snap.get('c_detail')["sell_id"],
            mobile: snap.get('login')['mobile'],
            userName: snap.get('c_name'),
            name: snap.get('c_detail')["c_name"],
          );
        }
      });
      return temp;
    }catch(e){
      print(e);
    }
    return AuthModel.empty();
  }
  

  Future<int> delay() async{
    await Future.delayed(const Duration(seconds: 1));
    return 10;
  }

  Future<List<dynamic>> login(String email,String password) async {
    try{

      if(email.isEmpty){
        throw Exception("Please enter email address !");
      }else if(password.isEmpty){
        throw Exception("Please enter password");
      }

      RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      if(!emailRegExp.hasMatch(email)){
        throw Exception("Please enter valid email address !");
      }


      String test = "${email.substring(0,email.lastIndexOf("@"))}@admin.com";
      AuthModel temp = AuthModel.empty();
      await FirebaseFirestore.instance.collection("e_farmer_admin").doc(test).get().then((snap){
        if(snap.exists){
          if(password == snap.get('login')["password"]){
            temp = AuthModel.empty(
              logId: test,
              logo: snap.get('c_detail')["c_logo"],
              address: snap.get("c_detail")['address'],
              email: snap.get('login')['email'],
              sellerId: snap.get('c_detail')["sell_id"],
              mobile: snap.get('login')['mobile'],
              userName: snap.get('login')['user_name'],
              name: snap.get('c_detail')["name"],
            );
          }else{
            throw Exception("Password dose not match !");
          }
        }else{
          throw Exception("Email id not found !");
        }
      });
      
      return [temp];
    }catch(e){
      // print(e);
      //
      return [AuthModel.empty(),e.toString()];
    }
  }


  Future<AuthModel> register(AuthModel model,String createdPassword) async {
    try{

      String test = "${model.email.substring(0,model.email.lastIndexOf("@"))}@admin.com";      
      String sid =  "${model.email.substring(0,model.email.lastIndexOf("@"))}${generateRandomString(10)}.sell";
      String userName = "${model.email.substring(0,model.email.lastIndexOf("@"))}_${Random().nextInt(1000)+100}";
      
      await FirebaseFirestore.instance.collection("e_farmer_admin").doc(test).set({
        'login': {
          'email': model.email,
          'password': createdPassword,
          'recovery_question':"",
          'recovery_answer':"",
          'mobile': model.mobile,
          'user_name': userName,
        },
        'c_detail':{
          'address': model.address,
          'c_logo': model.logo,
          'c_email': model.email,
          'name': model.name,
          'sell_id': sid, 
        },
      });


      await FirebaseFirestore.instance.collection("e_farmer_admin").doc(test).collection("summary").doc("dash_board").set({
        'total_product': 0,
        'total_user': 0,
        'total_order': 0,
        'total_revenue': 0,
        'balance': 0,
      });

      return AuthModel.empty(
        logId: test,
        address: model.address,
        email: model.email,
        userName: userName,
        sellerId: sid,
        logo: model.logo,
        name: model.name,
        mobile: model.mobile
      );
    }catch(e){
      //
    }
    return AuthModel.empty();
  }


  String generateRandomString(int length) {
    const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(
      length, 
      (_) => characters.codeUnitAt(random.nextInt(characters.length))
    ));
  }

  Future<bool> createProduct(Product product) async {
    try{

      FirebaseFirestore firestore = FirebaseFirestore.instance;

      WriteBatch writeBatch = firestore.batch();

      DocumentReference up1 = firestore.collection("e_farmer_admin").doc(globalAuthModel.logId).collection("manage_product").doc(product.pid);
      DocumentReference up2 = firestore.collection("e_farmer_admin").doc(globalAuthModel.logId).collection("summary").doc("dash_board");
      DocumentReference up3 = firestore.collection("e_farmer_product").doc(product.pid);
      DocumentReference up4 = firestore.collection("e_farmer_product_rating").doc(product.pid);

      if(product.cid.isEmpty || product.sid.isEmpty){
        product.sid = globalAuthModel.sellerId;
        product.cid = globalAuthModel.logId;
      }

      writeBatch.set(up1, product.toMap());
      writeBatch.update(up2, {
        'total_product': FieldValue.increment(1)
      });
      writeBatch.set(up3, product.toMap());
      writeBatch.set(up4,{
        'avg_review': 0,
        'star_1_count': 0,
        'star_2_count': 0,
        'star_3_count': 0,
        'star_4_count': 0,
        'star_5_count': 0,
        'total_review': 0,
      });

      await writeBatch.commit();
      // await FirebaseFirestore.instance.collection("e_farmer_admin").doc(globalAuthModel.logId).collection("manage_product").doc(productModel.productId).set(
      //   productModel.toMap()
      // );
      // await FirebaseFirestore.instance.collection("e_farmer_admin").doc(globalAuthModel.logId).collection("summary").doc("dash_board").update({
      //   "total_product": FieldValue.increment(1),
      // });
      // await FirebaseFirestore.instance.collection("e_farmer_product").doc(productModel.productId).set(
      //   productModel.toMap()
      // );
      return true;
    }catch(e){
      debugPrint(e.toString());
      //
    }
    return false;
  }


  Future<bool> updateProduct(Product model) async {
    try{
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      WriteBatch batch = firestore.batch();
      DocumentReference up1 = firestore.collection("e_farmer_admin").doc(globalAuthModel.logId).collection("manage_product").doc(model.pid);
      DocumentReference up2 = firestore.collection("e_farmer_product").doc(model.pid);
      batch.update(up1, model.toMap());
      batch.update(up2, model.toMap());
      await batch.commit();
      return true;
    }catch(e){
      print(e);
      //
    }
    return false;
  }

  Future<bool> deleteProduct(Product model) async {
    try{
      final FirebaseFirestore firebase = FirebaseFirestore.instance;

      WriteBatch batch = firebase.batch();
      DocumentReference up1 = firebase.collection("e_farmer_admin").doc(globalAuthModel.logId).collection("manage_product").doc(model.pid);
      DocumentReference up3 = firebase.collection("e_farmer_admin").doc(globalAuthModel.logId).collection("summary").doc("dash_board");
      DocumentReference up2 = firebase.collection("e_farmer_product").doc(model.pid);
      batch.delete(up1);
      batch.delete(up2);
      batch.update(up3,{
        'total_product': FieldValue.increment(-1)
      });
      await batch.commit();
      return true;
    }catch(e){
      //
    }
    return false;
  } 


  Future<bool> changeStatus(String status,String orderId) async {
    try{
      await FirebaseFirestore.instance.collection("e_farmer_order").doc(orderId).update({
        "order.order_status": status
      });
      return true;
    }catch(e){
      //
    }
    return false;
  }

  Future<bool> signOut() async {
    try{

      await FirebaseFirestore.instance.collection("e_farmer_admin").doc(globalAuthModel.logId).update({
        'login.is_active': false
      });
      SharedPrefService.service.saveUserLogData(AuthModel.empty());

      return true;
    }catch(e){
      debugPrint(e.toString());
    }
    return false;
  }


  void updateProfile() async  {
    try{
      await FirebaseFirestore.instance.collection("e_farmer_admin").doc(globalAuthModel.logId).update({
        'c_detail.address': globalAuthModel.address,
        'c_detail.c_logo': globalAuthModel.logo,
        'c_detail.name': globalAuthModel.name,
        'login.email': globalAuthModel.email,
        'login.mobile': globalAuthModel.mobile,
      });
    }catch(e){
      //
    }
  }


}