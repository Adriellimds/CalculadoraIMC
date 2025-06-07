import 'package:flutter/material.dart';

class AppColors{
  static const Color lightGreen = Color(0XFFD9F9E4);
  static const Color darkGreen = Color.fromARGB(255, 61, 165, 97);
}

class AppTextStyles{
  static const TextStyle tituloText = TextStyle(
    fontFamily: 'Tuffy',
    color: AppColors.darkGreen,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle buttonText = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle imputText = TextStyle(
    fontFamily: 'Tuffy',
    color: Color.fromARGB(255, 24, 90, 47),
    fontSize: 26,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle infoText = TextStyle(
    fontFamily: 'Tuffy',
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
}

class AppButtonStyles{
   
    static ButtonStyle roundedButton(Color backgroundColor){
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.darkGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      textStyle: AppTextStyles.buttonText,
      foregroundColor: Colors.white,
    );
  }
}