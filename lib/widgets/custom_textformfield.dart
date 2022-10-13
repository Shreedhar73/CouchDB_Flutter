import 'package:flutter/material.dart';

import '../utils/styles.dart';

Widget customTextFormField(controller,hintText,[validate=false]){
    return Padding(
      padding: const EdgeInsets.only(bottom:15),
      child: TextFormField(
        controller: controller,
        // keyboardType: keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if ( validate && (value == null || value.isEmpty)) {
            return 'Enter $hintText';
          }
          return null;
        },
        
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10,right: 5,top: 20,bottom:20),
          filled: true,
          fillColor: whiteGrey,
          hintText: hintText,
          hintStyle: chatBoxHintStyle,
          isDense: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              color: transparent,
              width: 1.0
            )
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              color: transparent,
              width: 1.0
            )
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              color: transparent,
              width: 1.0
            )
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          )
        ),
      ),
    );
  

}