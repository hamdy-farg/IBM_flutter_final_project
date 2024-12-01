class AddNewWorkspaces {
  final String? itemName;
  final String? date;
  final String? hours;
  final String? imagePath;
  final String? price;
  final String? statues;

  AddNewWorkspaces(
      {this.itemName,
      this.date,
      this.hours,
      this.imagePath,
      this.price,
      this.statues});
}

class BookedDetails {
  final String? itemName;
  final String? itemDescription;
  final String? date;
  final String? startHours;
  final String? endHours;
  final String? imagePath;
  final String? ptice;

  BookedDetails(
      {required this.itemName,
      required this.itemDescription,
      required this.date,
      required this.startHours,
      required this.endHours,
      required this.imagePath,
      required this.ptice});
}
