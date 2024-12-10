class City {
  final int id;
  final String name;
  final String description;

  City({required this.id, required this.name, required this.description});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Wisata {
  final int id;
  final String name;
  final City city;
  final List<Category> categories;
  final String jenisWisata;
  final int? price;
  final String openTime;
  final String closeTime;
  final String description;
  final String image;
  final bool isFree;

  Wisata({
    required this.id,
    required this.name,
    required this.city,
    required this.categories,
    required this.jenisWisata,
    required this.price,
    required this.openTime,
    required this.closeTime,
    required this.description,
    required this.image,
    required this.isFree,
  });

  factory Wisata.fromJson(Map<String, dynamic> json) {
    var categoryList = (json['categories'] as List)
        .map((category) => Category.fromJson(category))
        .toList();

    return Wisata(
      id: json['id'],
      name: json['name'],
      city: City.fromJson(json['city']),
      categories: categoryList,
      jenisWisata: json['jenis_wisata'],
      price: json['price'],
      openTime: json['open_time'],
      closeTime: json['close_time'],
      description: json['description'],
      image: json['image'],
      isFree: json['is_free'],
    );
  }
}
