import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';



class CustomProgressHud extends StatelessWidget {
  const CustomProgressHud ({super.key, required this.child, required this.inAsyncCall});
  final Widget child;
  final bool inAsyncCall;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: inAsyncCall,
        child: child

    );
  }
}
