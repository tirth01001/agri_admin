import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/screens/product/product_sale_report.dart';
import 'package:flutter_dashboard/widget/button.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_dashboard/model/popular.dart';
import 'package:flutter_dashboard/my_screen/product_screen/components/product_edit.dart';
import 'package:flutter_dashboard/size_config.dart';

class ProductDetail extends StatefulWidget {

  final Product product;
  const ProductDetail({super.key,required this.product});

  // static String route() => '/shop_detail';

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int _quantity = 0;
  bool _iscollected = false; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: getProportionateScreenHeight(428),
                  leading: IconButton(
                    icon: Image.asset('assets/icons/back@2x.png', scale: 2),
                    onPressed: () => Navigator.pop(context),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      color: const Color(0xFFeeeeee),
                      child: CachedNetworkImage(
                        fit: BoxFit.none,
                        imageUrl: widget.product.images.first,
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
                        ..._buildTitle(),
                        const SizedBox(height: 16),
                        _buildLine(),
                        const SizedBox(height: 16),
                        ..._buildDescription(),
                        const SizedBox(height: 34),
                        const Text("Customer Reviews",style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),),
                        const SizedBox(height: 34),
                        ProductRatingView(
                          product: widget.product,
                        ),
                        // _buildQuantity(),
                        // Button(
                        //   width: maxW-40,
                        //   height: 40,
                        //   prefixIcon: const Icon(IconlyBold.graph,color: Colors.white,),
                        //   text: "Product Report",
                        //   onTap: (){

                        //     Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductSaleReport()));
                        //   },
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
    );
  }

  List<Widget> _buildTitle() {
    return <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            child: Text(
              widget.product.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
          ),
          IconButton(
            onPressed: () => setState(() => _iscollected = !_iscollected),
            icon: Image.asset('assets/icons/${_iscollected ? 'bold' : 'light'}/heart@2x.png'),
            iconSize: 28,
          ),
        ],
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: Color(0xFFeeeeee),
            ),
            child: Text(
              '${widget.product.sold} sold',
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 16),
          Image.asset('assets/icons/start@2x.png', height: 20, width: 20),
          const SizedBox(width: 8),
          Text(
            '${widget.product.star} (${widget.product.rateCount} reviews)',
            style:const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ];
  }

  Widget _buildLine() {
    return Container(height: 1, color: const Color(0xFFEEEEEE));
  }

  List<Widget> _buildDescription() {
    return [
      const Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      ExpandableText(
        widget.product.lastDescr,
        expandText: 'view more',
        collapseText: 'view less',
        linkStyle: const TextStyle(color: Color(0xFF424242), fontWeight: FontWeight.bold),
      ),
    ];
  }

  Widget _buildQuantity() {
    return Row(
      children: [
        const Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(width: 20),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            color: Color(0xFFF3F3F3),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Material(
            color: Colors.transparent,
            child: Row(
              children: [
                InkWell(
                  child: Image.asset('assets/icons/detail/minus@2x.png', scale: 2),
                  onTap: () {
                    if (_quantity <= 0) return;
                    setState(() => _quantity -= 1);
                  },
                ),
                const SizedBox(width: 20),
                Text('$_quantity',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )),
                const SizedBox(width: 20),
                InkWell(
                  child: Image.asset('assets/icons/detail/plus@2x.png', scale: 2),
                  onTap: () => setState(() => _quantity += 1),
                ),
              ],
            ),
          ),
        ),
        
      ],
    );
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
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(29)),
              // splashColor: const Color(0xFFEEEEEE),
              onTap: () {


                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductEdit(
                  product: widget.product,
                )));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset('assets/icons/detail/bag@2x.png', scale: 2),
                  Icon(IconlyBold.edit,color: Colors.white,),
                  SizedBox(width: 16),
                  Text(
                    'Update Product',
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
                    Text(widget.product.price.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
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



// class ExpandableText extends StatefulWidget {
//   ExpandableText({this.text = ""});
//   //text is the total text of our expandable widget
//   final String text;
//   @override
//   _ExpandableTextState createState() => _ExpandableTextState();
// }

// class _ExpandableTextState extends State<ExpandableText> {
//   static const viewMore = ' view more...';
//   static const fixedLength = 50;
//   late String textToDisplay;
//   @override
//   void initState() {
//     //if the text has more than a certain number of characters, the text we display will consist of that number of characters;
//     //if it's not longer we display all the text
//     print(widget.text.length);

//     //we arbitrarily chose 25 as the length
//     textToDisplay = widget.text.length > 25 ? widget.text.substring(0, 25) + viewMore : widget.text;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       child: Text(textToDisplay),
//       onTap: () {
//         //if the text is not expanded we show it all
//         if (widget.text.length > 25 && textToDisplay.length <= (25 + viewMore.length)) {
//           setState(() {
//             textToDisplay = widget.text;
//           });
//         }
//         //else if the text is already expanded we contract it back
//         else if (widget.text.length > 25) {
//           setState(() {
//             textToDisplay = widget.text.substring(0, 25) + viewMore;
//           });
//         }
//       },
//     );
//   }
// }
