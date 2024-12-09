import 'package:travel_savy/controllers/CityController.dart';

class DestinationModel {
  final int id;
  final String name;
  final String description;
  final String image;

  DestinationModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }
}
