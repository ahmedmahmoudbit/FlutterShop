class ShopFavoritesModel {
  late bool status;
  ShopFavoritesDetails? data;

  ShopFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? ShopFavoritesDetails.fromJson(json['data']) : null;
  }
}

class ShopFavoritesDetails {
  late List<FavoriteData> data = [];

  ShopFavoritesDetails.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(FavoriteData.fromJson(element));
    });
  }
}

class FavoriteData {
  late int id;
  late ProductFavorite product;

  FavoriteData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    product = ProductFavorite.fromJson(json['product']);
  }
}

class ProductFavorite {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;

  ProductFavorite.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    price = json['price'] ?? 0;
    oldPrice = json['old_price'] ?? 0;
    discount = json['discount'] ?? 0;
    image = json['image'] ?? '';
    name = json['name'] ?? '';
    inFavorites = json['in_favorites'] ?? false;
    inCart = json['in_cart'] ?? false;
  }
}