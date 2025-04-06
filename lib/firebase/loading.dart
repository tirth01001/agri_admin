

import 'package:flutter/material.dart';

class Loading<T> {

  final BuildContext context;
  final Future<T> process;
  final List<Future<T>>  ? processList;
  final void Function(T  data) ? onSucess;
  final void Function(T ? data,String msg) ? onFail;
  Loading(this.context,{required this.process,this.processList,this.onFail,this.onSucess});

  void _start(){
    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(),));    
  }


  void _stop() => Navigator.pop(context);

  void executeProcess() async {
    _start();
    T ? returnData;
    try{
      returnData = await process;
      if(returnData != null){
        if(onSucess != null) onSucess!(returnData);
      }
    }catch(e){
      print(e);
      if(onFail != null) onFail!(returnData,e.toString());
    }
    _stop();
  }


  // void executeWithNextProcess(Loading nextProcess) async {
  //   executeProcess();
    
  // }

  // void executeAll() async {
  //   _start();
  //   _stop();
  // }


} 