import 'package:adhicine/constants/app_styles.dart';
import 'package:flutter/material.dart';

class CustomSearchTextField extends StatefulWidget {

  final TextEditingController controller;

  const CustomSearchTextField({Key? key, required this.controller}) : super(key: key);

  @override
  State<CustomSearchTextField> createState() => _CustomSearchTextFieldState();
}

class _CustomSearchTextFieldState extends State<CustomSearchTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
              color: AppStyles.greyShade
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                width: 1,
                color: AppStyles.greyShade
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                width: 1,
                color: AppStyles.greyShade
            ),
          ),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          prefixIcon: Container(
            child: Icon(
              Icons.search_rounded,
              color: AppStyles.greyShade,
              size: 24,
            ),
          ),
          suffixIcon: Container(
            child: Icon(
              Icons.mic,
              color: AppStyles.greyShade,
              size: 24,
            ),
          ),
          hintText: 'Search Medicine Name',
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal
          ),
        ),
      ),
    );
  }
}
