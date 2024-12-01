class AddNewWorkspaces {
  final String? itemName;
  final String? date;
  final String? startTime;
  final String? endTime;
  final String? imagePath;
  final String? price;
  final String? statues;

  AddNewWorkspaces(
      {this.itemName,
      this.date,
      this.startTime,
      this.endTime,
      this.imagePath,
      this.price,
      this.statues});
}

class BookedDetails {
  final String? itemName;
  final String? itemDescription;
  final String? date;
  final String? startTime;
  final String? endTime;
  final String? imagePath;
  final String? price;

  BookedDetails(
      {this.itemName,
      this.itemDescription,
      this.date,
      this.startTime,
      this.endTime,
      this.imagePath,
      this.price});
}
