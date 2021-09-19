class HomeModel
{
  bool ? status;
  HomeDataModel ? data;
  HomeModel.fromJason(Map<String,dynamic> json)
  {
    status=json['status'];
    data=HomeDataModel.fromJason(json['data']);
  }
}

class HomeDataModel
{
  List<BannerModel> banners=[];
  List<ProductModel> products=[];
HomeDataModel.fromJason(Map<String,dynamic> json)
{
  json['banners'].forEach((element)
      {
        banners.add(BannerModel.fromJson(element));
      });
  json['products'].forEach((element)
  {
    products.add(ProductModel.fromJson(element));
  });
}
}
class BannerModel
{
  int ?id;
  String ?image;

  BannerModel.fromJson(Map<String,dynamic> json)
  {
     id=json['id'];
     image=json['image'];
  }
}
class ProductModel
{
  int ? id;
  dynamic  price;
  dynamic  oldPrice;
  dynamic  discount;
  String ? image;
  String ? name;
  bool ? inFavorites;
  bool ? isCart;
  ProductModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    isCart = json['in_cart'];
  }
}