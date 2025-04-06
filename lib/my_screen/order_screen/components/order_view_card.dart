import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/model/orders.dart';
import 'package:flutter_dashboard/my_screen/order_screen/components/order_detail_page.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class OrderViewCard extends StatelessWidget {
  final Orders orders;
  const OrderViewCard({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDetailPage(
                      orders: orders,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Color(0xFFeeeeee),
              ),
              child: Stack(
                children: [
                  // Image.asset(data.images[0], width: 182, height: 182),
                  SizedBox(
                      width: 182,
                      height: 182,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          // fit: BoxFit.cover,
                          imageUrl: orders.productModel.images.first,
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(IconlyBold.image),
                          ),
                        ),
                      )),
                  // Image.asset(data.icon, width: 182, height: 182),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      width: 28,
                      height: 28,
                      child: CircleAvatar(
                        backgroundImage:
                            CachedNetworkImageProvider(orders.user["dp"]),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Text(
              orders.productModel.title,
              style: const TextStyle(
                color: Color(0xFF212121),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text("Quantity ${orders.productModel.buyQty}"),
            Text(
              "Rs.${orders.productModel.price}",
              style: const TextStyle(
                color: Color(0xFF212121),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
