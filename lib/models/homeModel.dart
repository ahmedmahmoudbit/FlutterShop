class HomeModel {
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductsModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });

    json['products'].forEach((element) {
      products.add(ProductsModel.fromJson(element));
    });
  }


}

class BannerModel {
  int? id;
  String? image;
  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsModel {
  int? id;
  dynamic oldPrice;
  dynamic price;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCar;
  ProductsModel.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  oldPrice = json['old_price'];
  price = json['price'];
  discount = json['discount'];
  image = json['image'];
  name = json['name'];
  inFavorites = json['in_favorites'];
  inCar = json['in_cart'];
  description = json['description'];
  }
}