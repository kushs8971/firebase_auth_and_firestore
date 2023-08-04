import 'package:adhicine/constants/app_styles.dart';
import 'package:adhicine/models/type_model.dart';
import 'package:flutter/material.dart';
import 'package:android_intent/android_intent.dart';

List<TypeModel> types = [
  TypeModel(image: 'pill', name: 'Tablet'),
  TypeModel(image: 'capsule', name: 'Capsule'),
  TypeModel(image: 'cream', name: 'Cream'),
  TypeModel(image: 'drop', name: 'Drop'),
  TypeModel(image: 'syringe', name: 'Syringe'),
];

void showNoConnectionDialog(context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20,),
              Text(
                "Your device is not\n connected",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 50,),
              Image.asset("assets/images/connection-error.png",
                height: 120,
                width: 120,
              ),
              SizedBox(height: 50),
              Text("Connect your device with",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        print("BLUETOOTH CALLED");
                        _openBluetoothSettings();
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30)
                          ),
                          color: AppStyles.purpleShade,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.bluetooth,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: 60,
                    width: 1,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        print("WIFI OPENED");
                        _openWifiSettings();
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30)
                          ),
                          color: AppStyles.purpleShade,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.wifi_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _openWifiSettings() {
  AndroidIntent intent = AndroidIntent(
    action: 'android.settings.WIFI_SETTINGS',
  );
  intent.launch();
}

void _openBluetoothSettings() {
  AndroidIntent intent = AndroidIntent(
    action: 'android.settings.BLUETOOTH_SETTINGS',
  );
  intent.launch();
}

bool isEmailValid(String email) {
  // Define a regular expression pattern for email validation
  final pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';

  // Create a RegExp object using the pattern
  final regExp = RegExp(pattern);

  // Use the hasMatch method to check if the email matches the pattern
  return regExp.hasMatch(email);
}

String? isPasswordValid(String? value){
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters';
  }
  bool hasNumber = RegExp(r'[0-9]').hasMatch(value);

  if(!hasNumber){
    return 'Password must have one number';
  }

  bool hasSpecialChar = RegExp(r'[!@#\$&*~%^,]').hasMatch(value);

  if(!hasSpecialChar){
    return 'Password must have one special character';
  }

  return null;
}