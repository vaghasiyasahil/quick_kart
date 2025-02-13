import 'dart:convert';
/// id : "1"
/// name : "abc"
/// price : "100"
/// description : "des"
/// imagedata : "image"
/// imagename : "imagePar"

class UpdateProductModel {
  String? id;
  String? name;
  String? price;
  String? description;
  String? imagedata;
  String? imagename;

  UpdateProductModel(this.id, this.name, this.price, this.description, this.imagedata, this.imagename);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['price'] = price;
    map['description'] = description;
    map['imagedata'] = imagedata;
    map['imagename'] = imagename;
    return map;
  }

}