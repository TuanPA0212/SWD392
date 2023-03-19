class Event2 {
  final int eventId;
  final String name;
  final String email;
  final String location;
  final String img;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final int clubId;
  final String clubName;
  final int studentId;
  final String studentName;

  Event2(
      {required this.eventId,
      required this.name,
      required this.email,
      required this.location,
      required this.img,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.clubId,
      required this.clubName,
      required this.studentId,
      required this.studentName});

  factory Event2.fromJson(Map<String, dynamic> json) {
    return Event2(
      eventId: json['event_id'] ?? 0,
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      location: json['location'] ?? "",
      img: json['img'] ?? "",
      description: json['description'] ?? "",
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : DateTime.now(),
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : DateTime.now(),
      clubId: json['club_id'] ?? 0,
      clubName: json['club_name'] ?? "",
      studentId: json['student_id'] ?? 0,
      studentName: json['student_name'] ?? "",
    );
  }
}
