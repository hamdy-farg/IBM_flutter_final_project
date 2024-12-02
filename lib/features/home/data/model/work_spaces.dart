class WorkSpacess {
  final String? itemName;
  final String? imagePath;
  final String? location;

  WorkSpacess(
      {required this.itemName,
      required this.imagePath,
      required this.location});
}

class RoomCard {
  final String? price;
  final String? itemName;
  final String? imagePath;
  final String? location;

  RoomCard({this.price, this.itemName, this.imagePath, this.location});
}

class ComfortablePlacesItems {
  final String? price;
  final String? itemName;
  final String? imagePath;
  final String? location;

  ComfortablePlacesItems(
      {this.price, this.itemName, this.imagePath, this.location});
}
