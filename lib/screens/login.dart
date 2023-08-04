import 'package:adhicine/constants/app_styles.dart';
import 'package:adhicine/constants/utils.dart';
import 'package:adhicine/screens/signup.dart';
import 'package:adhicine/services/authentication_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  void _openWifiSettings() async {
    const String wifiUrl = 'wifi:';
    if (await canLaunch(wifiUrl)) {
      await launch(wifiUrl);
    } else {
      // Handle the case where the user's device does not support opening Wi-Fi settings.
    }
  }

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  bool obscured = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 40,),
                Center(
                  child: Icon(
                    Icons.medical_information_rounded,
                    color: AppStyles.purpleShade,
                    size: 60,
                  ),
                ),
                Text("Adhicine",
                  style: TextStyle(
                      color: AppStyles.purpleShade,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("Sign In",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Image.asset("assets/images/arroba.png",
                        color: Color(0xff46d0c3),
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                )
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock_outline_rounded,
                        color: Color(0xff46d0c3),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          child: TextFormField(
                            obscureText: obscured,
                            controller: _passwordController,
                            decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      obscured = !obscured;
                                    });
                                  },
                                  child: Icon(
                                    obscured ?
                                    Icons.visibility_off_rounded :
                                    Icons.visibility_rounded
                                    ,
                                  ),
                                ),
                                border: UnderlineInputBorder()
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Text("Forgot Password?",
                      style: TextStyle(
                          color: AppStyles.purpleShade
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                Container(
                  height: 60,
                  width: double.maxFinite,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppStyles.purpleShade
                      ),
                      onPressed: () async {
                        if(validateForm()){
                          final credential = await AuthenticationService(context).signIn(email: _emailController.text, password: _passwordController.text);
                          if(credential!=null){
                            Navigator.pushReplacementNamed(context, '/home');
                          }
                        }

                      },
                      child: Text("Sign In",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        ),
                      )
                  ),
                ),
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: AppStyles.greyShade,
                        ),
                      ),
                      Container(
                        child: Text("  OR  ",
                          style: TextStyle(
                              color: AppStyles.greyShade
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                            height: 1,
                            color: AppStyles.greyShade,
                          ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40,),
                GestureDetector(
                  onTap: () async {
                    final credentials = await AuthenticationService(context).signInWithGoogle(context);
                    if (credentials != null) {
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  },
                  child: Container(
                    height: 60,
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            color: AppStyles.greyShade
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/google.png",
                          height: 30,
                          width: 30,
                        ),
                        SizedBox(width: 10,),
                        Text("Continue with Google",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, '/signup');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("New to Adhicine?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text("Sign Up",
                        style: TextStyle(
                            color: AppStyles.purpleShade,
                            fontSize: 14
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40,),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  bool validateForm(){
    if(!isEmailValid(_emailController.text.trim())){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter a valid email!'
        ),
        behavior: SnackBarBehavior.floating, // Use floating behavior
        margin: EdgeInsets.fromLTRB(20,0,20,50),
      ));
      return false;
    }
    if(_passwordController.text.trim()==''){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter a password!'),
        behavior: SnackBarBehavior.floating, // Use floating behavior
        margin: EdgeInsets.fromLTRB(20,0,20,50),
      ));
      return false;
    }
    return true;
  }

}
