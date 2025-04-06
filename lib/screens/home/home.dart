import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/components/product_card.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/model/popular.dart';
import 'package:flutter_dashboard/my_screen/order_screen/components/order_view_card.dart';
import 'package:flutter_dashboard/my_screen/product_screen/detail_screen.dart';
import 'package:flutter_dashboard/screens/home/chart_conf.dart';
import 'package:flutter_dashboard/screens/home/components/dash_box.dart';
import 'package:flutter_dashboard/screens/home/hearder.dart';
import 'package:flutter_dashboard/screens/home/most_popular.dart';
import 'package:flutter_dashboard/screens/home/search_field.dart';
import 'package:flutter_dashboard/screens/home/special_offer.dart';
import 'package:flutter_dashboard/screens/mostpopular/most_popular_screen.dart';
import 'package:flutter_dashboard/screens/special_offers/special_offers_screen.dart';
import 'package:flutter_dashboard/splesh_screen.dart';
import 'package:rxdart/rxdart.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  static String route() => '/home';

  const HomeScreen({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  

  final Map<String,String> dash = {
    "Product": "assets/images/product.png",
    "Order": "assets/images/order.png",
    "Revenue": "assets/images/revenue.png",
    "User": "assets/images/user.png",
  };

  @override
  Widget build(BuildContext context) {

    const padding = EdgeInsets.fromLTRB(24, 24, 24, 0);

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("e_farmer_admin").doc(globalAuthModel.logId).collection("summary").snapshots(),
        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.waiting){

            return const Center(child: CircularProgressIndicator(),);
          }

          List<DocumentSnapshot> ? summary ;

          if(snapshot.hasData){
            summary = snapshot.data?.docs;
            // print(summary?.last.data().toString());
          }
        


          return CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.only(top: 24),
                sliver: SliverAppBar(
                  pinned: true, 
                  flexibleSpace: HomeAppBar(
                    balance: summary!.last.get('balance').toString(),
                  ),
                ),
              ),
              SliverPadding(
                padding: padding,
                // padding: const EdgeInsets.only(),
                sliver: SliverToBoxAdapter(
                  child: _buildBody(
                    context,
                    summary != null ? summary.last.data() as Map<String,dynamic> : {},
                    summary??[],
                  ),
                ),
                // sliver: SliverList(
                //   // delegate: ,
                //   // delegate: SliverChildBuilderDelegate(
                //   //   ((context, index) => _buildBody(context)),
                //   //   childCount: 1,
                //   // ),
                // ),
              ),
              SliverPadding(
                padding: padding,
                sliver: SliverToBoxAdapter(
                  child: _buildPopulars(),
                )
              ),
              const SliverAppBar(flexibleSpace: SizedBox(height: 24))
            ],
          );
        }
      ),
    );
  }


  Widget _buildBody(BuildContext context,Map<String,dynamic> ? data,List<DocumentSnapshot> snaps){

    // print(data);
    List<String> keys = dash.keys.toList();
    List<String> values = ["0","0","0","0"];
    List<String> dataKey = data?.keys.toList() ??[];
    if(data != null && dataKey.isNotEmpty){
      for(int i=0;i<values.length;i++){
        values[i] == data[dataKey[i]].toString();
      }
    }
    if(snaps.isNotEmpty) snaps.removeLast();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        //Dash Board Point Showing Product Data
        Align(
          alignment: Alignment.center,
          child: Wrap(
            spacing: (maxW/3-40)-48,
            children: List.generate(keys.length, (index){
              return DashBox(
                name: keys[index], 
                image: dash[keys[index]]!, 
                // value: "0"
                value: index == 0 ? (data?["total_product"].toString() ?? "0") :
                       index == 1 ? (data?["total_order"].toString() ?? "0") : 
                       index == 2 ? (data?["total_revenue"].toString() ?? "0") : data?["total_user"].toString() ?? "0",
              );
            }),
          ),
        ),

        const SizedBox(height: 20,),

        if(snaps.isNotEmpty)
        const Text("Yearly Chart",style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),),
        const SizedBox(height: 20,),

        if(snaps.isNotEmpty)
          Container(
            width: maxW,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8)
            ),
            child: BarChart(
              BarChartData(
                barTouchData: barTouchData,
                titlesData: titlesData(snaps),
                borderData: borderData,
                barGroups: barGroups(snaps),
                gridData: const FlGridData(show: false),
                alignment: BarChartAlignment.spaceAround,
                maxY: 150,
              )
            )
          ),
        const SizedBox(height: 20,),

        if(snaps.isNotEmpty)
        const Text("Monthly Chart",style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),),
        const SizedBox(height: 20,),

        if(snaps.isNotEmpty)
          Container(
            width: maxW,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8)
            ),
            child: BarChart(
              BarChartData(
                barTouchData: barTouchData,
                titlesData: titlesData(snaps,type: "m"),
                borderData: borderData,
                barGroups: barGroups(snaps,type: "m"),
                gridData: const FlGridData(show: false),
                alignment: BarChartAlignment.spaceAround,
                maxY: 150,
              )
            )
          ),
        // const SizedBox(height: 20,),
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //     children: List.generate(4, (index){
          
        //       return OrderViewCard(tempImage: fakeImage[index],);
        //     }),
        //   ),
        // )
        
      ],
    );
  }


  

  Widget _buildPopulars() => const SizedBox();

  // Widget _buildBody(BuildContext context) {
  //   return Column(
  //     children: [
  //       const SearchField(),
  //       const SizedBox(height: 24),
  //       SpecialOffers(onTapSeeAll: () => _onTapSpecialOffersSeeAll(context)),
  //       const SizedBox(height: 24),
  //       MostPopularTitle(onTapseeAll: () => _onTapMostPopularSeeAll(context)),
  //       const SizedBox(height: 24),
  //       const MostPupularCategory(),
  //     ],
  //   );
  // }

  // Widget _buildPopulars() {
  //   return SliverGrid(
  //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
  //       maxCrossAxisExtent: 185,
  //       mainAxisSpacing: 24,
  //       crossAxisSpacing: 16,
  //       mainAxisExtent: 285,
  //     ),
  //     delegate: SliverChildBuilderDelegate(_buildPopularItem, childCount: 30),
  //   );
  // }

  // Widget _buildPopularItem(BuildContext context, int index) {
  //   final data = datas[index % datas.length];

  //   return ProductCard(
  //     data: data,
  //     ontap: (data) => Navigator.pushNamed(context, ShopDetailScreen.route()),
  //   );
  // }

  // void _onTapMostPopularSeeAll(BuildContext context) {
  //   Navigator.pushNamed(context, MostPopularScreen.route());
  // }

  // void _onTapSpecialOffersSeeAll(BuildContext context) {
  //   Navigator.pushNamed(context, SpecialOfferScreen.route());
  // }
}
