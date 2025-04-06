


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/firebase/loading.dart';
import 'package:flutter_dashboard/provider/product_edit_provider.dart';
import 'package:flutter_dashboard/utils/functions.dart';
import 'package:flutter_dashboard/widget/button.dart';
import 'package:flutter_dashboard/widget/input.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class ImageAddDialog extends StatelessWidget {

  final ProductEditProvider productEditProvider;
  const ImageAddDialog({super.key,required this.productEditProvider});

  @override
  Widget build(BuildContext context) { 


    void showNetwork() {

      showDialog(
        context: context, 
        builder: (context) {
          
          final TextEditingController url = TextEditingController();

          return AlertDialog(
            // backgroundColor: Colors.grey.shade400,
            content: Container(
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Network Image",style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                    ),),
                    InputField(
                      controller: url,
                      hint: "URL",
                      prefix: Icon(Icons.network_cell),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: Button(
                            height: 50,
                            onTap: (){
            
                              productEditProvider.addImage(url.text);
                              // widget.productEditProvider.addImage(url.text);
                              Navigator.pop(context);
                            },
                            prefixIcon: const Icon(IconlyLight.plus,color: Colors.white,),
                            text: "ADD",
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    }



    void pickImageAndUpload() async {
      File ? file = await pickFile();
      if(file != null){
        Loading<String?>(
          context,
          process: uploadImageToFirebase(file,toAdmin: false),
          onSucess: (data) {
            if(data != null){
              productEditProvider.addImage(data);
            }
          },
        ).executeProcess();
      }
    }

    return ChangeNotifierProvider.value(
      value: productEditProvider,
      child: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
      
            IconButton(
              onPressed: pickImageAndUpload, 
              icon: const Icon(IconlyLight.image,size: 40,)
            ),

            IconButton(
              onPressed: showNetwork, 
              icon: const Icon(IconlyLight.arrowDownSquare,size: 40,)
            ),
      
          ],
        ),
      ),
    );
  }
}