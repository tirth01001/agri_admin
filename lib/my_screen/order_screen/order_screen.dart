import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/constant/responsive.dart';
import 'package:flutter_dashboard/model/orders.dart';
import 'package:flutter_dashboard/my_screen/order_screen/components/order_view_card.dart';
import 'package:flutter_dashboard/splesh_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<String> orderFilters = [
    "All",
    "Confirmed",
    "Processing",
    "Shipped",
    "Out of Delivery",
    "Delivered",
    "Cancelled",
    "Returned",
 
  ];

  String selectedFilter = "All"; // Default selected filter

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: orderFilters.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedFilter = orderFilters[_tabController.index];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          tabs: orderFilters.map((status) => Tab(text: status)).toList(),
        ),
      ),
      body: StreamBuilder(
        stream: _getOrdersStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          List<DocumentSnapshot> snaps = snapshot.data!.docs;

          return SingleChildScrollView(
            child: StaggeredGrid.count(
              crossAxisCount: Responsive.isMobile() ? 3 : Responsive.isTablet() ? 4 : 8,
              children: List.generate(snaps.length, (index) {
                Orders orders = Orders.fromFirebase(snaps[index]);
                return OrderViewCard(orders: orders);
              }),
            ),
          );
        },
      ),
    );
  }

  Stream<QuerySnapshot> _getOrdersStream() {
    var query = FirebaseFirestore.instance.collection("e_farmer_order").where('sid', isEqualTo: globalAuthModel.sellerId);

    if (selectedFilter != "All") {
      query = query.where('order.order_status', isEqualTo: selectedFilter);
    }

    return query.snapshots();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}




// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dashboard/constant/responsive.dart';
// import 'package:flutter_dashboard/model/orders.dart';
// import 'package:flutter_dashboard/model/popular.dart';
// import 'package:flutter_dashboard/my_screen/order_screen/components/order_view_card.dart';
// import 'package:flutter_dashboard/splesh_screen.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// class OrderScreen extends StatefulWidget {
//   const OrderScreen({super.key});

//   @override
//   State<OrderScreen> createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {

//   // List<Orders> fakeOrder = [
//   //   Orders.fill(
//   //     orderId: "ABc..12", 
//   //     bill: {}, 
//   //     productModel: Product(), 
//   //     shipping: {}, 
//   //     orderStatus: "Shipping", 
//   //     paymentMode: "Paypal", 
//   //     placeDate: Timestamp.now(), 
//   //     sellId: globalAuthModel.sellerId, 
//   //     user: {
//   //       "dp": "",
//   //       "id": "",
//   //       "mobile": "",
//   //       "name": "",
//   //       "state": "",
//   //       "uid": "",
//   //     }
//   //   )
//   // ];


//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Orders"),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection("e_farmer_order")
//         .where('sid',isEqualTo: globalAuthModel.sellerId)
//         // .orderBy('order.order_place_date')
//         .snapshots(),
//         builder: (context, snapshot) {

//           if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){

//             return const Center(child: CircularProgressIndicator(),);
//           }

//           if(snapshot.hasError){

//             return Center(child: Text(snapshot.error.toString()),);
//           }

//           List<DocumentSnapshot> snaps = snapshot.data!.docs;

//           return SingleChildScrollView(
//             child: StaggeredGrid.count(
//               crossAxisCount: Responsive.isMobile() ? 3 : Responsive.isTablet() ? 4 : 8 ,
//               children: List.generate(snaps.length, (index){

//                 Orders orders = Orders.fromFirebase(snaps[index]);
          
//                 return OrderViewCard(
//                   orders: orders,
//                 );
//               }),
//             ),
//           );
//         }
//       ),
//     );
//   }
// }