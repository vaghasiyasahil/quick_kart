import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_kart/Model/RegisterModel.dart';
import 'package:quick_kart/Page/Login_Page.dart';
import 'package:http/http.dart' as http;

import '../Services/allData.dart';
import '../Services/preferences.dart';
import 'Home_Page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  bool showPass=true;
  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80,),
                Center(
                    child: Text(
                      "Register Account",
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
                      "Your Name",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: TextField(
                    controller: name,
                    cursorColor: Colors.blue,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "Enter Name",
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
                    cursorColor: Colors.blue,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Enter Email",
                      suffixIcon: Icon(Icons.account_circle),
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
                  onTap: register,
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
                      "Sign Up",
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
                      "Already Have Account? ",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                      },
                      child: Text(
                        "Log In",
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
      ),
    );
  }
  Future<void> register() async {
    try{
      if(name.text!="" && email.text!="" && password.text!=""){
        if(GetUtils.isEmail(email.text)){
          var url=Uri.parse("${allData.mainAPI}Register.php");
          RegisterModel data=RegisterModel(name.text, email.text, password.text);
          var response=await http.post(url,body: data.toJson());
          if(response.statusCode==200){
            var data=jsonDecode(response.body);
            if(data['connection']==1){
              if(data['result']==1){
                preferences.setIsLogin(true);
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                Get.snackbar(
                  "Success",
                  "Register Successfully, Please Login.",
                  colorText: Colors.green,
                  snackPosition: SnackPosition.TOP,
                );
              }else if(data['result']==2){
                Get.snackbar(
                  "Error",
                  "Email Already Exists.",
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
