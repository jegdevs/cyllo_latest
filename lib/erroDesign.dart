import 'package:flutter/material.dart';
class Customsnackbar {
  SnackBar showSnackBar(String title, String errorMessage, String errortype,
      void Function()? onPressed) {
    final custumsnack = SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(10),
      ),
      backgroundColor: getColorBasedOnErrorType(errortype),
      content: SizedBox(height: 38,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.error,
            color: Colors.white,),
            Flexible(
              child: Text(
                errorMessage,
                style:  TextStyle(
                    color: Colors.white,
                    fontSize: 16),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 4),
            //   child: OutlinedButton(
            //     onPressed: onPressed,
            //     style: OutlinedButton.styleFrom(
            //       backgroundColor: Colors.white,
            //       side: BorderSide.none,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10), // Rounded corners
            //       ),
            //       padding: const EdgeInsets.symmetric(
            //         horizontal: 8,
            //         vertical: 6,
            //       ), // Reduced padding for the button
            //     ),
            //     child: Text(
            //       getbuttontext(errortype),
            //       style: const TextStyle(
            //           color: Colors.black,
            //           fontWeight: FontWeight.bold), // Black text color
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      margin:  EdgeInsets.fromLTRB(20, 0, 20, 20),
      padding:  EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    );
    return custumsnack;
  }

  Color getColorBasedOnErrorType(String errorType) {
    switch (errorType) {
      case 'error':
        return Color.fromARGB(205, 214, 65, 65);
      case 'warning':
        return Colors.yellow;
      case 'success':
        return Colors.green;
      default:
        return const Color.fromARGB(255, 173, 216, 230);
    }
  }

  // String getbuttontext(String errorType) {
  //   switch (errorType) {
  //     case 'error':
  //       return 'Retry';
  //     case 'warning':
  //       return 'Okay';
  //     case 'success':
  //       return 'Done';
  //     default:
  //       return 'Cancel';
  //   }
  // }
}