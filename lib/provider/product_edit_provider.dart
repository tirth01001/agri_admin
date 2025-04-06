

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/model/popular.dart';

class ProductEditProvider extends ChangeNotifier {

  Product ? product;

  final List<String> categorys = [
    "Seeds & Plants",
    "Fertilizers & Soil Enhancers",
    "Pesticides & Insecticides",
    "Farm Machinery & Tools",
    "Irrigation & Water Management",
    "Grain",
    "Organic Farming Products"
  ];

  List<String> images = []; 
  String selectedCategory = "Seeds & Plants";

  void init(Product ? product){
    this.product = product;
    if(product != null){
      images = product.images.cast<String>();
    }
  }


  void addImage(String url){
    images.add(url);
    if(product != null) product!.images= images;
    notifyListeners();
  }

  void selectCategory(String ? cate) {
    selectedCategory = cate ?? selectedCategory;
    notifyListeners();
  }

}