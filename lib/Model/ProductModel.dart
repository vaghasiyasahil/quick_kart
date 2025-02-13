class ProductModel {
  String? userId;
  String? pName;
  String? pPrize;
  String? pDes;
  String? productImage;


  ProductModel(this.userId, this.pName, this.pPrize, this.pDes, this.productImage);


  Map<String,dynamic> toJson() {
    Map<String,dynamic> data={};
    data['userid']=userId;
    data['pname']=pName;
    data['pprize']=pPrize;
    data['pdes']=pDes;
    data['productimage']=productImage;
    return data;
  }
}