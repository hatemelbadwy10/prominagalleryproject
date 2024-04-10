import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData theme(BuildContext context ){
return ThemeData(
  textTheme: Theme.of(context).textTheme.apply(
    bodyColor: Colors.black,
    fontFamily: 'Tajawal',
  ),
);

}