class Itinerary {
  final int id;
  final String name;
  final String cityDescription;
  final int price;
  final String city;
  final List<ItineraryDetail> itineraryDetails;

  Itinerary({
    required this.id,
    required this.name,
    required this.cityDescription,
    required this.price,
    required this.city,
    required this.itineraryDetails,
  });

  factory Itinerary.fromJson(Map<String, dynamic> json) {
    return Itinerary(
      id: json['id'],
      name: json['name'],
      cityDescription: json['city_deskripsi'] ?? '',
      price: json['price'] ?? 0,
      city: json['city'] ?? '',
      itineraryDetails: (json['itinerary_details'] as List<dynamic>)
          .map((detail) => ItineraryDetail.fromJson(detail))
          .toList(),
    );
  }
}

class ItineraryDetail {
  final int day;
  final String wisataName;
  final int wisataId;
  final String description;
  final String image;

  ItineraryDetail({
    required this.day,
    required this.wisataName,
    required this.wisataId,
    required this.description,
    required this.image,
  });

  factory ItineraryDetail.fromJson(Map<String, dynamic> json) {
    return ItineraryDetail(
      day: json['day'],
      wisataName: json['wisata']['name'],
      wisataId: json['wisata']['id'],
      description: json['wisata']['description'],
      image: json['wisata']['image'],
    );
  }
}
