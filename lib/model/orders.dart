





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dashboard/model/popular.dart';

class Orders {

  final String orderId;
  final String sellId;
  late String orderStatus;
  final Timestamp placeDate;
  final String paymentMode;
  late Product productModel;
  late Map<String,dynamic> bill,shipping,user;

  Orders.empty({this.orderId="",this.sellId="",this.paymentMode=""}) : placeDate=Timestamp.fromMicrosecondsSinceEpoch(10);

  Orders.fill({
    required this.orderId,
    required this.bill,
    required this.productModel,
    required this.shipping,
    required this.orderStatus,
    required this.paymentMode,
    required this.placeDate,
    required this.sellId,
    required this.user,
  });

  factory Orders.fromFirebase(DocumentSnapshot snap) => Orders.fill(
    orderId: snap.get('order')["oid"], 
    bill: snap.get('billing'), 
    productModel: Product.fromMap(snap.get('product')), 
    shipping: snap.get('shipping'),
    orderStatus: snap.get('order')['order_status'],
    paymentMode: snap.get('order')["payment_mode"],
    placeDate: snap.get('order')['order_place_date'],
    user: snap.get('customer'),
    sellId: snap.get('sid'),
  );


  Map<String,dynamic> get toMap => {
    "sid": sellId, 
    "order":{
      "oid": orderId,
      "order_status": orderStatus,
      "order_place_date": placeDate,
      "payment_mode": paymentMode,
    },
    "product": productModel.toMap(),
    "shipping": shipping,
    "billing": bill,
    "customer":user
  };

}