


import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/model/orders.dart';
import 'package:flutter_dashboard/my_screen/order_screen/components/order_invoice.dart';
import 'package:flutter_dashboard/my_screen/order_screen/components/order_update_dialog.dart';
import 'package:flutter_dashboard/provider/order_provider.dart';
import 'package:flutter_dashboard/size_config.dart';
import 'package:flutter_dashboard/widget/button.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class OrderDetailPage extends StatefulWidget {

  final Orders orders;
  const OrderDetailPage({super.key,required this.orders});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {

  List<String> orderFilters = [
    "Processing",
    "Shipped",
    "Out of Delivery",
    "Delivered",
    "Cancelled",
    "Returned",
  ];

  String selectedStatus = "Processing";
  
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => OrderProvider()..init(widget.orders),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    leadingWidth: 100,
                    expandedHeight: getProportionateScreenHeight(428),
                    leading: Row(
                      children: [
                        IconButton(
                          icon: Image.asset('assets/icons/back@2x.png', scale: 2),
                          onPressed: () => Navigator.pop(context),
                        ),
                        CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            widget.orders.user["dp"],
                          ),
                        )
                      ],
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        color: const Color(0xFFeeeeee),
                        child: CachedNetworkImage(
                          fit: BoxFit.none,
                          imageUrl: widget.orders.productModel.images.first,
                          errorWidget: (context, url, error) => const Center(child: Icon(IconlyBold.image),),
                        ),
                        // child: Image.asset(
                        //   'assets/icons/products/detail_sofa.png',
                        //   fit: BoxFit.none,
                        // ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding( 
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ..._buildTitle(),
                          const SizedBox(height: 16),
                          _buildLine(),
                          const SizedBox(height: 16),
                          ..._buildDescription(),
                          const SizedBox(height: 24),
                          // Button(
                          //   width: maxW-40,
                          //   height: 40,
                          //   onTap: (){

                          //     generateInvoice();
                          //     // Navigator.push(context, MaterialPageRoute(builder: (context)=> GenerateInvoicePage()));
                          //   },
                          //   prefixIcon: const Icon(IconlyBold.document,color: Colors.white,),
                          //   text: "Invoice",
                          // ),
                          const SizedBox(height: 115),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              _buldFloatBar()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLine() {
    return Container(height: 1, color: const Color(0xFFEEEEEE));
  }

  List<Widget> _buildDescription() {
    return [
      const Text('Order Detail', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10,),
      Text("Order ID: ${widget.orders.orderId}"),
      Text("Order Status: ${widget.orders.orderStatus}"),
      Text("Order Place Date: ${widget.orders.placeDate.toDate()}"),
      const SizedBox(height: 10,),
      const Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      ExpandableText(
        widget.orders.productModel.lastDescr,
        expandText: 'view more',
        collapseText: 'view less',
        linkStyle: const TextStyle(color: Color(0xFF424242), fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      const Text('Customer Detail', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Text("Name: ${widget.orders.user["name"]}"),
      Text("State: ${widget.orders.user["state"]}"),
      Text("Mobile Number: ${widget.orders.user["mobile"]}"),
      Text("Shipping Address: ${widget.orders.shipping["address"]}"),
      Text("PIN code: ${widget.orders.shipping["pin_code"]}"),
      const SizedBox(height: 10),
      const Text('Billing Detail', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      Text("Purchase Quantity: ${widget.orders.productModel.buyQty}"),
      Text("Total Price: ${widget.orders.productModel.price * widget.orders.productModel.buyQty }"),
      Text("Paid:  ${widget.orders.bill["total_pay"]}"),
      Text("Payment Type: Paypal"),
    ];
  }

  Widget _buldFloatBar() {
    buildAddCard() => Container(
          height: 58,
          width: getProportionateScreenWidth(258),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(29)),
            color: const Color(0xFF101010),
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 8),
                blurRadius: 20,
                color: const Color(0xFF101010).withOpacity(0.25),
              ),
            ],
          ),
          child: Consumer<OrderProvider>(
            builder: (context,provider,child) {

              return Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(29)),
                  // splashColor: const Color(0xFFEEEEEE),
                  onTap: () {
              
              
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductEdit(
                    //   product: widget.product,
                    // )));
              
                    
              
                    showDialog(
                      context: context, 
                      builder: (context) => OrderUpdateDialog(
                        provider: provider,
                      ),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset('assets/icons/detail/bag@2x.png', scale: 2),
                      Icon(IconlyBold.edit,color: Colors.white,),
                      SizedBox(width: 16),
                      Text(
                        'Update Status',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
        );

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            _buildLine(),
            const SizedBox(height: 21),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total price', style: TextStyle(color: Color(0xFF757575), fontSize: 12)),
                    SizedBox(height: 6),
                    Text("Rs.${widget.orders.productModel.price * widget.orders.productModel.buyQty }", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  ],
                ),
                buildAddCard()
              ],
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }

}