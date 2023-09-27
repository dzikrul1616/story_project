import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:story_app/const/color.dart';

class BarEmpty {
 static  PreferredSize emptyAppBar(context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(0.0),
      child: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: appPrimary,
          ),
        ),
        backgroundColor: appPrimary,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
    );
  }
}
