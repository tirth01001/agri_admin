import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/my_screen/product_screen/components/product_edit.dart';
import 'package:flutter_dashboard/splesh_screen.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_dashboard/components/product_card.dart';
import 'package:flutter_dashboard/constant/responsive.dart';
import 'package:flutter_dashboard/model/popular.dart';
import 'package:flutter_dashboard/my_screen/product_screen/detail_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  // late final datas = homePopularProducts;
  
  @override
  Widget build(BuildContext context) { 

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ), 
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("e_farmer_admin").doc(globalAuthModel.logId).collection("manage_product").snapshots(),
        builder: (context, snapshot) {

          if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){

            return const Center(child: CircularProgressIndicator(),);
          } 


          List<DocumentSnapshot> snaps = snapshot.data?.docs ?? [];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
            
              child: StaggeredGrid.count(
                crossAxisCount: Responsive.isMobile() ? 3 : Responsive.isTablet() ? 4 : 8 ,
                // crossAxisCount: 3,
                children: List.generate(
                  snaps.length, (index) => _buildPopularItem(context, snaps[index])),
              ),
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: (){

          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductEdit()));
        },
        child: const Icon(IconlyBold.edit,color: Colors.white,),
      ),
    );
  }

  Widget _buildPopularItem(BuildContext context,DocumentSnapshot fromSnap) {
    // final data = datas[index % datas.length];

    final Product product = Product.fromSnap(fromSnap);

    // return Container(width: 20,height: 20,color: Colors.amber,);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ProductCard(
        data: product,
        ontap: (data) => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail(product: data))),
        // ontap: (data) => Navigator.pushNamed(context, ShopDetailScreen.route()),
      ),
    );
  }

}