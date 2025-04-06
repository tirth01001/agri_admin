import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating; // Rating value between 0.0 to 5.0
  
  const RatingStars({required this.rating});
  
  @override
  Widget build(BuildContext context) {
    // Create a list of 5 stars based on the rating
    List<Widget> stars = [];
    
    for (int i = 1; i <= 5; i++) {
      if (rating >= i) {
        // Full star
        stars.add(const Icon(Icons.star, color: Colors.black));
      } else if (rating > i - 1 && rating < i) {
        // Half star
        stars.add(const Icon(Icons.star_half, color: Colors.black));
      } else {
        // Empty star
        stars.add(const Icon(Icons.star_border, color: Colors.black));
      }
    }
     
    return Row(
      children: stars,
    );
  }
}
