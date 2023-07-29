class EventCartItem {
  final int eventId;
  final String eventName;
  final String eventImage;
  // final int eventPoint;
  final int eventPrice;
  int quantity;

  EventCartItem({
    required this.eventId,
    required this.eventName,
    required this.eventImage,
    // required this.eventPoint,
    required this.eventPrice,
    this.quantity = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'eventName': eventName,
      'eventImage': eventImage,
      'eventPrice': eventPrice,
    };
  }

  factory EventCartItem.fromJson(Map<String, dynamic> json) {
    return EventCartItem(
      eventId: json['eventId'],
      eventName: json['eventName'],
      eventImage: json['eventImage'],
      // eventPoint: json['eventPoint'],
      eventPrice: json['eventPrice'] ?? 0,
      quantity: json['quantity'] ?? 1,
    );
  }
}
