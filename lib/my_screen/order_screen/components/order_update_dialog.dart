


import 'package:flutter/material.dart';
import 'package:flutter_dashboard/firebase/firebase_service.dart';
import 'package:flutter_dashboard/firebase/loading.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/provider/order_provider.dart';
import 'package:flutter_dashboard/widget/button.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class OrderUpdateDialog extends StatelessWidget {

  final OrderProvider provider;
  const OrderUpdateDialog({super.key,required this.provider});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider.value(
      value: provider,
      child: AlertDialog(
        content: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Update Status",style: TextStyle(
                fontSize: 18,
              ),),
              Consumer<OrderProvider>(
                builder: (context,provider,child) {
                
                  return DropdownButton(
                    borderRadius: BorderRadius.circular(8),
                    value: provider.currantStatus,
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    underline: const SizedBox(),
                    items: List.generate(provider.orderFilters.length, (index){
                  
                      return DropdownMenuItem(
                        value: provider.orderFilters[index],
                        child: Text(provider.orderFilters[index]),
                      );
                    }), 
                    onChanged: (value) {
                      provider.updateValue(value??provider.currantStatus);
                    }, 
                  );
                }
              ),
              const SizedBox(height: 10,),
              Button(
                width: maxW-40,
                height: 50,
                // margin: const EdgeInsets.symmetric(horizontal: 20,),
                onTap: (){

                  Loading(
                    context, 
                    process: FirebaseService.service.changeStatus(provider.currantStatus, provider.orders.orderId)
                  ).executeProcess();

                },
                prefixIcon: const Icon(IconlyBold.upload,color: Colors.white,),
                text: "Update",
              )
            ],
          ),
        ),
      ),
    );
  }
}