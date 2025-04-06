


import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_dashboard/size_config.dart';

class Button extends StatelessWidget {

  final String ? text;
  final Widget ? prefixIcon;
  final VoidCallback ? onTap; 
  final double ? height;
  final double ? width;
  final EdgeInsets ? margin;
  const Button({super.key,this.margin,this.height,this.width,this.onTap,this.prefixIcon,this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 58,
      width: width ?? getProportionateScreenWidth(258),
      margin: margin,
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(29)),
          // splashColor: const Color(0xFFEEEEEE),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset('assets/icons/detail/bag@2x.png', scale: 2),
              prefixIcon ?? const Icon(IconlyBold.edit,color: Colors.white,),
              const SizedBox(width: 16),
              Text(
                text ?? 'Update Product',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}