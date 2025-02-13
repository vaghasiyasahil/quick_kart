import 'dart:convert';
/// connection : 1
/// result : 1
/// productdata : [{"ID":"2","UID":"7","PRO_NAME":"first","PRO_DES":"first des","PRO_PRICE":"100","PRO_IMAGE":"ProductImage/first67874773.jpg"},{"ID":"6","UID":"7","PRO_NAME":"first","PRO_DES":"first des","PRO_PRICE":"100","PRO_IMAGE":"ProductImage/first73835043.jpg"},{"ID":"7","UID":"7","PRO_NAME":"first","PRO_DES":"first des","PRO_PRICE":"100","PRO_IMAGE":"ProductImage/first41168545.jpg"}]

ViewProductModel viewProductModelFromJson(String str) => ViewProductModel.fromJson(json.decode(str));
String viewProductModelToJson(ViewProductModel data) => json.encode(data.toJson());
class ViewProductModel {
  ViewProductModel({
      int? connection, 
      int? result, 
      List<Productdata>? productdata,}){
    _connection = connection;
    _result = result;
    _productdata = productdata;
}

  ViewProductModel.fromJson(dynamic json) {
    _connection = json['connection'];
    _result = json['result'];
    if (json['productdata'] != null) {
      _productdata = [];
      json['productdata'].forEach((v) {
        _productdata?.add(Productdata.fromJson(v));
      });
    }
  }
  int? _connection;
  int? _result;
  List<Productdata>? _productdata;

  int? get connection => _connection;
  int? get result => _result;
  List<Productdata>? get productdata => _productdata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['connection'] = _connection;
    map['result'] = _result;
    if (_productdata != null) {
      map['productdata'] = _productdata?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// ID : "2"
/// UID : "7"
/// PRO_NAME : "first"
/// PRO_DES : "first des"
/// PRO_PRICE : "100"
/// PRO_IMAGE : "ProductImage/first67874773.jpg"

Productdata productdataFromJson(String str) => Productdata.fromJson(json.decode(str));
String productdataToJson(Productdata data) => json.encode(data.toJson());
class Productdata {
  Productdata({
      String? id, 
      String? uid, 
      String? proname, 
      String? prodes, 
      String? proprice, 
      String? proimage,}){
    _id = id;
    _uid = uid;
    _proname = proname;
    _prodes = prodes;
    _proprice = proprice;
    _proimage = proimage;
}

  Productdata.fromJson(dynamic json) {
    _id = json['ID'];
    _uid = json['UID'];
    _proname = json['PRO_NAME'];
    _prodes = json['PRO_DES'];
    _proprice = json['PRO_PRICE'];
    _proimage = json['PRO_IMAGE'];
  }
  String? _id;
  String? _uid;
  String? _proname;
  String? _prodes;
  String? _proprice;
  String? _proimage;

  String? get id => _id;
  String? get uid => _uid;
  String? get proname => _proname;
  String? get prodes => _prodes;
  String? get proprice => _proprice;
  String? get proimage => _proimage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = _id;
    map['UID'] = _uid;
    map['PRO_NAME'] = _proname;
    map['PRO_DES'] = _prodes;
    map['PRO_PRICE'] = _proprice;
    map['PRO_IMAGE'] = _proimage;
    return map;
  }

}