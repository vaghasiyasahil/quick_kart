import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_kart/Page/Add_Product_Page.dart';
import 'package:quick_kart/Page/Home_Page.dart';
import 'package:http/http.dart' as http;
import 'package:quick_kart/Services/allData.dart';
import '../Model/ViewProductModel.dart';

class ProductsDetailsPage extends StatefulWidget {
  Productdata data;
  ProductsDetailsPage({required this.data,super.key});

  @override
  State<ProductsDetailsPage> createState() => _ProductsDetailsPageState();
}

class _ProductsDetailsPageState extends State<ProductsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
        },
        child: SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal.shade50,
        appBar: AppBar(
          backgroundColor: Colors.teal.shade50,
          title: Text("${widget.data.proname}"),
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black
          ),
          actions: [
            IconButton(onPressed: () {
              showDialog(context: context, builder: (context) => AlertDialog(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.zero
                ),
                title: Text("Delete"),
                content: Text("Are you sure you want to delete this product?"),
                actions: [
                  TextButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: Text("No,Cancel",style: TextStyle(color: Colors.green),)),
                  TextButton(onPressed: () {
                    deleteProduct();
                  }, child: Text("Yes,Delete",style: TextStyle(color: Colors.red),))
                ],
              ),);
            }, icon: Icon(Icons.delete)),
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductPage(uData: widget.data,),));
            }, icon: Icon(Icons.edit))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Image.network(
                  "${allData.mainAPI}${widget.data.proimage}",
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 15,right: 15),
                  child: Text(
                    "${widget.data.proname}",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 15,right: 15),
                  child: Text(
                    "\$${widget.data.proprice}",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "${widget.data.prodes}",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    )
    );
  }

  Future<void> deleteProduct() async {
    try{
      var url=Uri.parse("${allData.mainAPI}deleteproduct.php");
      var response=await http.post(url,body: {"id":"${widget.data.id}"});
      if(response.statusCode==200){
        var data=jsonDecode(response.body);
        if(data['connection']==1){
          if(data['result']==1){
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
            Get.snackbar(
              "Success",
              "Products Delete Successfully.",
              colorText: Colors.green,
              snackPosition: SnackPosition.TOP,
            );
          }else if(data['result']==0){
            Get.snackbar(
              "Error",
              "Products Not Delete, Please Delete Again!",
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
