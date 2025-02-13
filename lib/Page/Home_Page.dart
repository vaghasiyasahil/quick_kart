import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:quick_kart/Model/ViewProductModel.dart';
import 'package:quick_kart/Page/Add_Product_Page.dart';
import 'package:http/http.dart' as http;
import 'package:quick_kart/Page/Products_Details_Page.dart';
import 'package:quick_kart/Services/preferences.dart';

import '../Services/allData.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          SystemNavigator.pop();
        },
        child: SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal.shade50,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.teal.shade50,
          title: Text("Explore"),
          centerTitle: true,
          titleTextStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }else if(!snapshot.hasData){
              return Center(
                child: Text(
                  "No Products Available",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.blue
                  ),
                ),
              );
            }else if(snapshot.hasData){

              if (snapshot.data!.productdata == null || snapshot.data!.productdata!.isEmpty) {
                return Center(
                  child: Text(
                    "No Products Available",
                    style: TextStyle(fontSize: 30, color: Colors.blue),
                  ),
                );
              }

              return Padding(
                padding: EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.8
                  ),
                  itemCount: snapshot.data!.productdata!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)
                              ),
                              child: Image.network(
                                "${allData.mainAPI}${snapshot.data!.productdata![index].proimage}",
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(left: 15,top: 7),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${snapshot.data!.productdata![index].proname}",
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.blue,
                                        ),
                                      )
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                              margin: EdgeInsets.only(left: 15,top: 7),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "\$${snapshot.data!.productdata![index].proprice}",
                                                style: TextStyle(
                                                  fontSize: 25,
                                                ),
                                              )
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsDetailsPage(data: snapshot.data!.productdata![index]),));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            // margin: EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                                color: CupertinoColors.activeBlue,
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(15),
                                                    bottomRight: Radius.circular(10)
                                                )
                                            ),
                                            child: Icon(Icons.add,color: Colors.white,size: 20,),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            }else{
              return Center(
                child: Text(
                  "Something Went Wrong.",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.blue
                  ),
                ),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add,color: Colors.white,),
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductPage(),));
          },
        ),
      ),
    )
    );
  }

  Future<ViewProductModel> getData() async {
    var url=Uri.parse("${allData.mainAPI}viewProduct.php");
    var response=await http.post(url,body: {"userid":"${preferences.getUserId()}"});
    Map tempData=jsonDecode(response.body);
    return ViewProductModel.fromJson(tempData);
  }
}
