import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/model/popular.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

typedef ProductCardOnTaped = void Function(Product data);

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.data, this.ontap});

  final Product data;
  final ProductCardOnTaped? ontap;

  @override
  Widget build(BuildContext context) {
    // final data = datas[index % datas.length];
    const borderRadius = BorderRadius.all(Radius.circular(20));
    return InkWell(
      borderRadius: borderRadius,
      onTap: () => ontap?.call(data),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: borderRadius,
                color: Color(0xFFeeeeee),
              ),
              child: Stack(
                children: [
                  // Image.asset(data.images[0], width: 182, height: 182),
                  SizedBox(
                    width: 182,
                    height: 182,
                    child: CachedNetworkImage(
                      imageUrl: data.images.first,
                      errorWidget: (context, url, error) => const Center(child: Icon(IconlyBold.image),),
                    )
                  ),
                  // Image.asset(data.icon, width: 182, height: 182),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Text(
                      'Rs.${data.price.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF212121)),
                    ),
                  )
                  // Positioned(
                  //   top: 16,
                  //   right: 16,
                  //   child: Image.asset('assets/icons/not_collected@2x.png', width: 28, height: 28),
                  // )
                ],
              ),
            ),
            const SizedBox(height: 12),
            FittedBox(
              child: Text(
                data.title,
                style: const TextStyle(
                  color: Color(0xFF212121),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildSoldPoint(4.5, 6937),
            const SizedBox(height: 10),
            // Text(
            //   'Rs.${data.price.toStringAsFixed(2)}',
            //   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF212121)),
            // ),
            // const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildSoldPoint(double star, int sold) {
    return Row(
      children: [
        Image.asset('assets/icons/start@2x.png', width: 20, height: 20),
        const SizedBox(width: 8),
        Text(
          '${data.star}',
          style: const TextStyle(
            color: Color(0xFF616161),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          '|',
          style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF616161), fontSize: 14),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            color: const Color(0xFF101010).withOpacity(0.08),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Text(
            '${data.sold} sold',
            style: const TextStyle(
              color: Color(0xFF35383F),
              fontWeight: FontWeight.w500,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }
}
