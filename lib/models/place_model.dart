import 'package:travel_savy/models/type_model.dart';

class DestinationModel {
  String name;
  String image;
  List<String> type;
  int distance;

  DestinationModel(
      {required this.name,
      required this.image,
      required this.type,
      required this.distance});
}

var places = [
  DestinationModel(
      name: "Japan ",
      image: "japan.png",
      type: [Type.country],
      distance: 100),
  DestinationModel(
      name: "Japan ",
      image: "japan.png",
      type: [Type.country],
      distance: 100),
  DestinationModel(
      name: "Japan ",
      image: "japan.png",
      type: [Type.country],
      distance: 100)
];
