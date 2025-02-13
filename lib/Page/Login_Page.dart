import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quick_kart/Model/LoginModel.dart';
import 'package:quick_kart/Page/Home_Page.dart';
import 'package:quick_kart/Page/Register_Page.dart';
import 'package:http/http.dart' as http;
import 'package:quick_kart/Services/preferences.dart';

import '../Services/allData.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool showPass=true;
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        SystemNavigator.pop();
      },
      child: SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(height: 100,),
              Center(
                  child: Text(
                    "Hello Again!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ),
              Padding(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Text(
                  "Fill Your Details Or Continue With Social Media",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey
                  ),
                ),
              ),
          
              SizedBox(
                height: 20,
              ),
              Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),
              Padding(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    hintText: "Enter Email",
                    suffixIcon: Icon(Icons.email),
                    hintStyle: TextStyle(
                        color: Colors.grey
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blue
                        )
                    ),
                  ),
                ),
              ),
          
              SizedBox(
                height: 20,
              ),
              Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Password",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),
              Padding(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: TextField(
                  controller: password,
                  cursorColor: Colors.blue,
                  obscureText: showPass,
                  decoration: InputDecoration(
                    hintText: "Enter Password",
                    suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        showPass=!showPass;
                      });
                    }, icon: Icon(showPass?CupertinoIcons.eye_slash_fill:CupertinoIcons.eye)),
                    hintStyle: TextStyle(
                        color: Colors.grey
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blue
                        )
                    ),
                  ),
                ),
              ),
          
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: login,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                          Radius.circular(10)
                      )
                  ),
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  width: double.infinity,
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),
                  ),
                ),
              ),
          
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New User? ",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage(),));
                    },
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> login() async {
    try{
      if(email.text!="" && password.text!=""){
        if(GetUtils.isEmail(email.text)){
          var url=Uri.parse("${allData.mainAPI}login.php");
          {
            LoginModel data=LoginModel(email.text, password.text);
            var response=await http.post(url,body: data.toJson());
            if(response.statusCode==200){
              var data=jsonDecode(response.body);
              if(data['connection']==1){
                if(data['result']==1){
                  print(data['userdata']);
                  preferences.setUserId(int.parse(data['userdata']['id']));
                  preferences.setIsLogin(true);
                   Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
                  Get.snackbar(
                    "Success",
                    "Login Successfully.",
                    colorText: Colors.green,
                    snackPosition: SnackPosition.TOP,
                  );
                }else if(data['result']==0){
                  Get.snackbar(
                    "Error",
                    "Wrong Email and Password.",
                    colorText: Colors.red,
                    snackPosition: SnackPosition.TOP,
                  );
                }else{
                  Get.snackbar(
                    "Error",
                    "Something Went Wrong.",
                    colorText: Colors.red,
                    snackPosition: SnackPosition.TOP,
                  );
                }
              }else{
                Get.snackbar(
                  "Error",
                  "Something Went Wrong.",
                  colorText: Colors.red,
                  snackPosition: SnackPosition.TOP,
                );
              }
            }else{
              Get.snackbar(
                "Error",
                "Something Went Wrong.",
                colorText: Colors.red,
                snackPosition: SnackPosition.TOP,
              );
            }
          }
        }else{
          Get.snackbar(
            "Error",
            "Please Enter Valid Email.",
            colorText: Colors.red,
            snackPosition: SnackPosition.TOP,
          );
        }
      }else{
        Get.snackbar(
          "Error",
          "Please Enter All Fields.",
          colorText: Colors.red,
          snackPosition: SnackPosition.TOP,
        );
      }
    }catch(e){
      Get.snackbar(
        "Error",
        "Something Went Wrong.",
        colorText: Colors.red,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
