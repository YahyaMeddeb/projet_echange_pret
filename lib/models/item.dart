class Item {
  final String id;
  final String ownerId;
  final String title;
  final String description;
  final double pricePerDay;
  final String status;

  Item({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.description,
    required this.pricePerDay,
    this.status = 'available',
  });
}
