class Review {
  final String id;
  final String userId;
  final String itemId;
  final int stars;
  final String comment;

  Review({
    required this.id,
    required this.userId,
    required this.itemId,
    required this.stars,
    required this.comment,
  });
}
