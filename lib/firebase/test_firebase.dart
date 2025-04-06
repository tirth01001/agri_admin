


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dashboard/firebase/test_data.dart';
import 'package:flutter_dashboard/splesh_screen.dart';



Future<void> insertFakeSummary() async {
try{

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  WriteBatch batch = firebaseFirestore.batch();

  for(int i=0;i<summ.length;i++){
    DocumentReference ref1 = firebaseFirestore.collection("e_farmer_admin").doc(globalAuthModel.logId).collection("summary").doc(
      summ[i].keys.first,
    );
    batch.set(ref1, summ[i][summ[i].keys.first]);
  }

  await batch.commit();
}catch(e){

  print(e);

}
}