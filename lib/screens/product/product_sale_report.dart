


import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/model/popular.dart';
import 'package:flutter_dashboard/screens/product/rating.dart';

class ProductRatingView extends StatelessWidget {

  final Product product;
  const ProductRatingView({super.key,required this.product});

  Widget ratingCard(Map<String,dynamic> data) {

    Timestamp stamp = data["timestamp"];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                child: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    data["user_dp"]
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data["user_name"],style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold
                    ),),
                    Text(stamp.toDate().toString(),style: const TextStyle(fontSize: 12,color: Colors.grey),),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 10,),
          RatingStars(rating: data["rating"]),
          const SizedBox(height: 10,),
          Text(data["comment_title"],style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),),
          const SizedBox(height: 10,),
          Text(data["comment"],style: const TextStyle(
            fontSize: 15,
            color: Colors.grey
          ),),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return  Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("e_farmer_product_rating").doc(product.pid).snapshots(), 
        builder: (context, snapshot) {

          if(!snapshot.hasData){

            return const Center(child: CircularProgressIndicator(),);
          }


          Map<String,dynamic>  reviews = snapshot.data?.data() ?? {};
          List<dynamic> reviewsList = reviews["rating"] ?? []; 


          if(reviewsList.isEmpty){

            return const Center(
              child: Text("Product has no reviews !"),
            );
          }
          
          return Column(
            children: List.generate(reviewsList.length, (index){
          
              return ratingCard(reviewsList[index]);
            }),
          );
        },
      ),
    );
  }
}