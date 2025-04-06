


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/firebase/firebase_service.dart';
import 'package:flutter_dashboard/firebase/loading.dart';
import 'package:flutter_dashboard/my_screen/product_screen/components/image_add_dialog.dart';
import 'package:flutter_dashboard/provider/product_edit_provider.dart';
import 'package:flutter_dashboard/screens/tabbar/tabbar.dart';
import 'package:flutter_dashboard/splesh_screen.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/model/popular.dart';
import 'package:flutter_dashboard/widget/button.dart';
import 'package:flutter_dashboard/widget/input.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ProductEdit extends StatefulWidget {

  final Product ? product;
  const ProductEdit({super.key,this.product});

  @override
  State<ProductEdit> createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {

  final TextEditingController _id = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _size = TextEditingController();
  final TextEditingController _sizeIn = TextEditingController();
  final TextEditingController _off = TextEditingController();
  final TextEditingController _descr = TextEditingController();

  


  @override
  void initState() {
    super.initState();
    _initDetail();
    if(widget.product == null){
      var uuid = const Uuid();
      _id.text = uuid.v8();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _destroy();
  }

  void _destroy(){
    _id.dispose();
    _name.dispose();
    _price.dispose();
    _size.dispose();
    _sizeIn.dispose();
    _off.dispose();
    _descr.dispose();
  }

  void _initDetail() {
    if(widget.product == null) return;
    _id.text = widget.product!.pid;
    _name.text = widget.product!.title;
    _price.text = widget.product!.price.toString();
    _size.text = widget.product!.size["p_size"].toString();
    _sizeIn.text = widget.product!.size["size_in"].toString();
    _off.text = widget.product!.offer["off"].toString();
    _descr.text = widget.product!.lastDescr;
  }

  final ProductEditProvider productEditProvider =ProductEditProvider();

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider.value(
      value: productEditProvider..init(widget.product),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Image.asset('assets/icons/back@2x.png', scale: 2),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            if(widget.product != null) IconButton(
              onPressed: deleteProduct, 
              icon: const Icon(IconlyLight.delete,color: Colors.red,)
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),

                Consumer<ProductEditProvider>(
                  builder: (context, provider, child) {

                    if(widget.product != null && widget.product!.images.isNotEmpty) {
                      return Container(
                        width: maxW-20,
                        height: 200,
                        child: PageView(
                          children: List.generate(widget.product?.images.length ?? 0, (index){
                  
                            return CachedNetworkImage(
                              imageUrl: widget.product!.images[index],
                              errorWidget: (context, error, stackTrace) => const Center(child: Icon(IconlyLight.image),),
                            );
                          }),
                        ), 
                      );
                      
                    } else if(provider.images.isNotEmpty){

                      return Container(
                        width: maxW-20,
                        height: 200,
                        child: PageView(
                          children: List.generate(provider.images.length, (index){
                  
                            return CachedNetworkImage(
                              imageUrl: provider.images[index],
                              errorWidget: (context, error, stackTrace) => const Center(child: Icon(IconlyLight.image),),
                            );
                          }),
                        ), 
                      );
                    } 
                    else {

                      return Container(
                        width: maxW-40,
                        height: 200,
                        // margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text("Tap \"Add Image\" button to add image !"),
                        ),
                      );
                    }          
                  },
                ),
          
            
                Consumer<ProductEditProvider>(
                  builder: (context,provider,child) {

                    return Button(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      prefixIcon: const Icon(IconlyBold.image,color: Colors.white,),
                      text: "Add Image",
                      width: maxW-20,
                      height: 50,
                      onTap: (){
                          
                        showModalBottomSheet(
                          context: context, 
                          builder: (context) => ImageAddDialog(
                            productEditProvider: provider,
                          ),
                        );
                          
                      },
                    );
                  }
                ),
            
                const SizedBox(height: 10,),
                Text("Product Detail",style: TextStyle(
                  fontSize: 18,
                ),),
            
                InputField(
                  controller: _id,
                  prefix: const Icon(IconlyLight.document),
                  hint: "Product ID",
                  isDisable: true,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                ),
            
                InputField(
                  controller: _name,
                  prefix: const Icon(IconlyLight.bag),
                  hint: "Product Name",
                  margin: const EdgeInsets.symmetric(vertical: 10),
                ),
            
                InputField(
                  controller: _price,
                  prefix: const Icon(IconlyLight.graph),
                  hint: "Product Price",
                  margin: const EdgeInsets.symmetric(vertical: 10),
                ),


                const SizedBox(height: 10,),
                Text("Product Category",style: TextStyle(
                  fontSize: 18,
                ),),
                const SizedBox(height: 10,),

                Consumer<ProductEditProvider>(
                  builder: (context,provider,child) {

                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFf3f3f3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        underline: const SizedBox(),
                        borderRadius: BorderRadius.circular(8),
                        value: provider.selectedCategory,
                        items: List.generate(provider.categorys.length, (index){
                      
                          return DropdownMenuItem(
                            value: provider.categorys[index],
                            child: Text(provider.categorys[index]),
                          );
                        }), 
                        onChanged: (value) {
                      
                          provider.selectCategory(value);
                      
                        },
                      ),
                    );
                  }
                ),
            
                // InputField(
                //   prefix: Icon(IconlyLight.document),
                //   hint: "Product Price",
                //   margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                // ),
            
                const SizedBox(height: 20,),
                
                Text("Product Size",style: TextStyle(
                  fontSize: 18,
                ),),
            
                InputField(
                  controller: _size,
                  prefix: const Icon(IconlyLight.filter),
                  hint: "Product Size",
                  margin: const EdgeInsets.symmetric(vertical: 10),
                ),
            
                InputField(
                  controller: _sizeIn,
                  prefix: const Icon(IconlyLight.filter),
                  hint: "Size In",
                  margin: const EdgeInsets.symmetric(vertical: 10),
                ),
            
            
      
                const SizedBox(height: 20,),
                Text("Product Offer",style: TextStyle(
                  fontSize: 18,
                ),),
            
                InputField(
                  controller: _off,
                  prefix: const Icon(IconlyLight.discount),
                  hint: "Off %",
                  margin: const EdgeInsets.symmetric(vertical: 10),
                ),
            
      
                const SizedBox(height: 20,),
                
                const Text("Product Description",style: TextStyle(
                  fontSize: 18,
                ),),
            
                InputField(
                  controller: _descr,
                  prefix: const Icon(IconlyLight.activity),
                  hint: "Description",
                  margin: const EdgeInsets.symmetric(vertical: 10),
                ),
            
            
                const SizedBox(height: 20,),
      
                if(widget.product == null) Button(
                  width: maxW-40,
                  height: 50,
                  text: "Create Product",
                  prefixIcon: const Icon(IconlyBold.upload,color: Colors.white,),
                  onTap: _createProduct,
                ) else Button(
                  width: maxW-40,
                  height: 50,
                  text: "Update Product",
                  prefixIcon: const Icon(IconlyBold.edit,color: Colors.white,),
                  onTap: ()=> updateProduct(widget.product!),
                ),
            
                const SizedBox(height: 20,),
      
            
            
              ],
            ),
          ),
        ),
      ),
    );
  }

  ////
  ///
  ///
  ///
  ///
  ///
  void updateProduct(Product product){

    product.title = _name.text;
    product.price = double.parse(_price.text);
    product.category = productEditProvider.selectedCategory;
    product.size = {
      "p_size": int.tryParse(_size.text) ?? 0,
      "size_in": _sizeIn.text
    };
    product.offer = {
      "off": double.tryParse(_off.text)??0.0,
      "save_price": 0,
    };
    product.lastDescr = _descr.text;
    product.category = productEditProvider.selectedCategory;
    product.images = productEditProvider.images;

    Loading<bool>(
      context,
      process: FirebaseService.service.updateProduct(product),
      onSucess: (data) {
        
        Navigator.pop(context);
        Navigator.pop(context);
      },
    ).executeProcess();

  }

  void _createProduct(){

    if(productEditProvider.images.isEmpty){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            height: 100,
            child: const Center(child: Text("Please Add at lest one image !"),),
          ),
        ),
      );
      return;
    }

    Product product = Product();
    product.title = _name.text;
    product.pid = _id.text;
    product.price = double.tryParse(_price.text) ?? 0;
    product.size = {
      "p_size": int.tryParse(_size.text) ?? 0,
      "size_in": _sizeIn.text
    };
    product.offer = {
      "off": double.tryParse(_off.text)??0.0,
      "save_price": 0,
    };
    
    product.lastDescr = _descr.text;
    product.category = productEditProvider.selectedCategory;
    product.images = productEditProvider.images;
    product.sid = globalAuthModel.sellerId;
    Loading<bool>(
      context,
      process: FirebaseService.service.createProduct(product),
      // onSucess: (data) {
        
      //   showDialog(
      //     context: context, 
      //     builder: (context){

      //       return AlertDialog(
      //         content: Container(
      //           child: const Text("Product Uplaoded"),
      //         ),
      //       );
      //     }
      //   );
      // },
    ).executeProcess();

  }



  void deleteProduct() async {
    if(productEditProvider.product != null){
      Loading(
        context, 
        process: FirebaseService.service.deleteProduct(productEditProvider.product!)
      ).executeProcess();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const FRTabbarScreen()), (route) => false);
    }
  }

}