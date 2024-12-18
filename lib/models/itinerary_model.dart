class Itinerary {
  final int id;
  final String name;
  final String cityDescription;
  final String cityName;
  final List<ItineraryDetail> details;
  final int? price;

  Itinerary({
    required this.id,
    required this.name,
    required this.cityDescription,
    required this.cityName,
    required this.details,
    this.price,
  });

  factory Itinerary.fromJson(Map<String, dynamic> json) {
    return Itinerary(
      id: json['id'],
      name: json['name'],
      cityDescription: json['city_deskripsi'],
      cityName: json['city'],
      price: json['price'],
      details: (json['itinerary_details'] as List)
          .map((detail) => ItineraryDetail.fromJson(detail))
          .toList(),
    );
  }
}

class ItineraryDetail {
  final int day;
  final String wisataName;
  final String wisataDescription;
  final String wisataImage;

  ItineraryDetail({
    required this.day,
    required this.wisataName,
    required this.wisataDescription,
    required this.wisataImage,
  });

  factory ItineraryDetail.fromJson(Map<String, dynamic> json) {
    return ItineraryDetail(
      day: json['day'],
      wisataName: json['wisata']['name'],
      wisataDescription: json['wisata']['description'],
      wisataImage: json['wisata']['image'],
    );
  }
}
