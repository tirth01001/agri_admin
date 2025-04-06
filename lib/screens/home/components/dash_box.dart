



import 'package:flutter/material.dart';
import 'package:flutter_dashboard/main.dart';

class DashBox extends StatelessWidget {

  final String image;
  final String name;
  final String value;
  const DashBox({super.key,required this.image,required this.name,required this.value});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: maxW/3-10,
      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      constraints: const BoxConstraints(
        maxHeight: 140
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8)
      ),
      child: IntrinsicHeight(
        child: Column(
          children: [
            Image.asset(image),
            const SizedBox(height: 10,),
            Text(name),
            const SizedBox(height: 6,),
            Text(value),
            const SizedBox(height: 6,),
          ],
        ),
      ),
    );
  }
}