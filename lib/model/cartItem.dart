class EventCartItem {
  final int eventId;
  final String eventName;
  final String eventImage;
  final int eventPoint;
  int quantity;

  EventCartItem({
    required this.eventId,
    required this.eventName,
    required this.eventImage,
    required this.eventPoint,
    this.quantity = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'eventName': eventName,
      'eventImage': eventImage,
      'eventPoint': eventPoint,
    };
  }

  factory EventCartItem.fromJson(Map<String, dynamic> json) {
    return EventCartItem(
      eventId: json['eventId'],
      eventName: json['eventName'],
      eventImage: json['eventImage'],
      eventPoint: json['eventPoint'],
      quantity: json['quantity'] ?? 1,
    );
  }
}
