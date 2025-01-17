import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
class ToastNotificationMessage{
  void showNotificationSuccess({required String message,required BuildContext context}){
    toastification.show(
      context: context, // optional if you use ToastificationWrapper
      title: Text('Successfully'),
      autoCloseDuration: const Duration(seconds: 5),
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      icon: Icon(Icons.check_circle_outlined),
      description: RichText(text: TextSpan(text: message)),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
    // ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(
    //       message,
    //       style: TextStyle(color: Colors.white),
    //     ),
    //       backgroundColor: Colors.green,
    //     )
    // );
  }
  void showToastNotificationError({required String message,required BuildContext context}){
    toastification.show(
      context: context,
      autoCloseDuration: const Duration(seconds: 5),
      title: Text('Error'),
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
      icon: Icon(Icons.highlight_remove),
      description: RichText(text: TextSpan(text: message)),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
    // ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text(
    //       message,
    //       style: TextStyle(color: Colors.white),
    //     ),
    //       backgroundColor: Colors.red,
    //     )
    // );
  }
}