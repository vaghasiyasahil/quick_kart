import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_kart/Model/ProductModel.dart';
import 'package:quick_kart/Model/UpdateProductModel.dart';
import 'package:quick_kart/Page/Home_Page.dart';
import 'package:quick_kart/Page/Products_Details_Page.dart';
import 'package:quick_kart/Services/preferences.dart';
import 'package:http/http.dart' as http;

import '../Model/ViewProductModel.dart';
import '../Services/allData.dart';

class AddProductPage extends StatefulWidget {
  Productdata? uData;
  AddProductPage({this.uData,super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {

  TextEditingController pName=TextEditingController();
  TextEditingController pPrice=TextEditingController();
  TextEditingController pDes=TextEditingController();
  TextEditingController pImage=TextEditingController();

  XFile? image;
  ImagePicker picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.uData!=null){
      pName.text=widget.uData!.proname!;
      pPrice.text=widget.uData!.proprice!;
      pDes.text=widget.uData!.prodes!;
      pImage.text=widget.uData!.proimage!;
    }
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if(widget.uData==null){
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsDetailsPage(data: widget.uData!),));
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.teal.shade50,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            
                Center(
                    child: Text(
                      "Add Products",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),
            
                SizedBox(
                  height: 20,
                ),
                Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Products Name",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: TextField(
                    controller: pName,
                    cursorColor: Colors.blue,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Enter Products Name",
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
                      "Products Price",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: pPrice,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      hintText: "Enter Products Price",
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
                      "Products Description",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: TextField(
                    controller: pDes,
                    cursorColor: Colors.blue,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Enter Products Description",
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
                      "Select Image",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: TextField(
                    readOnly: true,
                    onTap: () async {
                      image=await picker.pickImage(source: ImageSource.gallery);
                      if(image!.path!=null){
                        pImage.text=image!.path.split("/")[image!.path.split("/").length-1];
                      }
                      setState(() {});
                    },
                    controller: pImage,
                    cursorColor: Colors.blue,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.photo),
                      hintText: "Enter Products Description",
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
                  onTap: widget.uData==null?addProducts:updateProducts,
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
                      "Add Products",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),
                    ),
                  ),
                ),
            
              ],
            ),
          ),
        ),
      ),
    );
  }
  addProducts() async {
    try{
      if(pName.text!="" && pPrice.text!="" && pDes.text!="" && pImage.text!=""){


        var url=Uri.parse("${allData.mainAPI}addProduct.php");
        List<int> imageBytes = await image!.readAsBytes();
        String imageString = base64Encode(imageBytes);
        ProductModel productModel=ProductModel(
            preferences.getUserId().toString(),
            pName.text,
            pPrice.text,
            pDes.text,
            imageString
        );
        var response=await http.post(url,body: productModel.toJson());
        print("response=${response.body}");


        if(response.statusCode==200){
          var data=jsonDecode(response.body);
          if(data['connection']==1){
            if(data['productaddd']==1){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
              Get.snackbar(
                "Success",
                "Products Successfully.",
                colorText: Colors.green,
                snackPosition: SnackPosition.TOP,
              );
            }else if(data['productaddd']==0){
              Get.snackbar(
                "Error",
                "Products Not Add, Please Try Again.",
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
  updateProducts() async {
    try{
      if(pName.text!="" && pPrice.text!="" && pDes.text!="" && pImage.text!=""){

        var url=Uri.parse("${allData.mainAPI}updateproduct.php");
        String imageString;
        if(image!=null){
          print("Image update new");
          List<int> imageBytes = await image!.readAsBytes();
          imageString = await base64Encode(imageBytes);
        }else{
          print("Image update old");
          String imageUrl="${allData.mainAPI}${widget.uData!.proimage!}";
          var responseImg = await http.get(Uri.parse(imageUrl));
          imageString = await base64Encode(responseImg.bodyBytes);
        }
        print("Image String = $imageString");
        UpdateProductModel updateProductModel = UpdateProductModel(
            widget.uData!.id,
            pName.text,
            pPrice.text,
            pDes.text,
            imageString,
            widget.uData!.proimage
        );
        var response=await http.post(url,body: updateProductModel.toJson());
        print("response=${response.body}");
        print("status code=${response.statusCode}");

        if(response.statusCode==200){
          print("data");
          var data=jsonDecode(response.body);
          print("dat adf");
          if(data['connection']==1){
            if(data['result']==1){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
              Get.snackbar(
                "Success",
                "Products Update Successfully.",
                colorText: Colors.green,
                snackPosition: SnackPosition.TOP,
              );
            }else if(data['result']==0){
              Get.snackbar(
                "Error",
                "Products Not Update, Please Try Again.",
                colorText: Colors.red,
                snackPosition: SnackPosition.TOP,
              );
            }else{
              print("error");
              Get.snackbar(
                "Error",
                "Something Went Wrong.",
                colorText: Colors.red,
                snackPosition: SnackPosition.TOP,
              );
            }
          }else{
            print("object");
            Get.snackbar(
              "Error",
              "Something Went Wrong.",
              colorText: Colors.red,
              snackPosition: SnackPosition.TOP,
            );
          }
        }else{
          print("  ============");
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
          "Please Enter All Fields.",
          colorText: Colors.red,
          snackPosition: SnackPosition.TOP,
        );
      }
    }catch(e){
      print(" = = = = = = = ");
      Get.snackbar(
        "Error",
        "Something Went Wrong.",
        colorText: Colors.red,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
