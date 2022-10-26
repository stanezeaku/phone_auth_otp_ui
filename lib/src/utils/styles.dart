import 'package:flutter/material.dart';

const kAppColor = Color(0xFF3bd38a);
BoxDecoration shadowContainer() {
    return const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black26,
              blurRadius: 15.0,
              offset: Offset(0.0, 0.75)
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        )
    );
}

TextStyle boldLabel() {
    return const TextStyle(
        fontSize: 18,
        fontFamily: 'medium'
    );
}

TextStyle simpleLabel() {
    return const TextStyle(
        color: Colors.grey,
        fontSize: 14,
    );
}

InputDecoration textInputDecoration(val) {
    return InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintText: '$val',
        hintStyle: const TextStyle(
            color: Colors.grey
        ),
        border: outlineBorder(),
        focusedBorder: outlineBorder(),
        enabledBorder: outlineBorder()
    );
}

OutlineInputBorder outlineBorder() {
    return OutlineInputBorder(
        borderRadius: const BorderRadius.all(
            Radius.circular(8)
        ),
        borderSide: BorderSide(
            color: (Colors.grey[300])!
        )
    );
}

  ButtonStyle outlineButtonStyle() {
    return OutlinedButton.styleFrom(
        elevation: 0,
        side: const BorderSide(
            color: Colors.black,
            width: 1,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
        ),
        primary: Colors.black,
        textStyle: const TextStyle(
            fontSize: 16,
            fontFamily: 'medium'
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
    );
}

