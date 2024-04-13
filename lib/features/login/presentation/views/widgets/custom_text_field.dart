import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
        required this.hint,
        this.obscureText,
        required this.validatorWord, required this.textEditingController, this.validator,

      });
  final String hint;
final TextEditingController textEditingController;
  final bool? obscureText;
  final String? Function(String?)? validator;

  final String validatorWord;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60.h,
      width: double.infinity,

      decoration: BoxDecoration(

        color: Colors.white,
        borderRadius:  BorderRadius.circular(50),
      ),
      child: TextFormField(
        controller: textEditingController,
        obscureText: obscureText ?? false,
        validator: (value) => value!.isEmpty ? ' required $validatorWord ' : null,

        decoration: InputDecoration(

            border:
            InputBorder.none,
            contentPadding:const EdgeInsets.only(left: 20),
            hintText: hint,
            hintStyle: Styles.textStyle15.copyWith(color: Colors.grey
            ,fontWeight: FontWeight.w500
            )
        ),
      ),
    );
  }
}
