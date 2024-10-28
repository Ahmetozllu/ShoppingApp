class GlobalItemModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;
  

  GlobalItemModel(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image,
      this.rating});

  GlobalItemModel.fromJson(Map<String, dynamic> json) {
    final dynamic priceValue = json['price'];

  if (priceValue is int) {
    price = priceValue.toDouble();
  } else if (priceValue is double) {
    price = priceValue;
  } else {
    price = null; 
  }

    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['description'] = description;
    data['category'] = category;
    data['image'] = image;
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    return data;
  }
}

class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    final dynamic priceValue = json['rate'];
    final double rate =
        (priceValue is int) ? priceValue.toDouble() : priceValue.toDouble();
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rate'] = rate;
    data['count'] = count;
    return data;
  }
}
