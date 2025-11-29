class Reservation {
  final String id;
  final String itemId;
  final String renterId;
  final DateTime startDate;
  final DateTime endDate;
  final String status;

  Reservation({
    required this.id,
    required this.itemId,
    required this.renterId,
    required this.startDate,
    required this.endDate,
    this.status = 'pending',
  });
}
