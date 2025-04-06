

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/model/orders.dart';

class OrderProvider  extends ChangeNotifier {

  Orders orders = Orders.empty();

  void init(Orders order){
    orders = order;
  }

  List<String> orderFilters = [
    "Processing",
    "Shipped",
    "Out of Delivery",
    "Delivered",
    "Cancelled",
    "Returned",
  ];

  String currantStatus = "Processing";

  void update(int idx){
    currantStatus = orderFilters[idx];
    notifyListeners();
  }

  void updateValue(String value){
    currantStatus = value;
    notifyListeners();
  }



}