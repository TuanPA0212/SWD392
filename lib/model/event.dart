class Event {
  final int eventId;
  final String eventName;
  final String email;
  final String location;
  final String img;
  final String? description;
  final String startDate;
  final String endDate;
  final int clubId;
  final String clubName;
  final int studentId;
  final String studentName;

  Event(
      {required this.eventId,
      required this.eventName,
      required this.email,
      required this.location,
      required this.img,
      this.description,
      required this.startDate,
      required this.endDate,
      required this.clubId,
      required this.clubName,
      required this.studentId,
      required this.studentName});

  // Event.fromJson(Map<String, dynamic> json) {
  //   eventId = json['event_id'];
  //   eventName = json['event_name'];
  //   email = json['email'];
  //   location = json['location'];
  //   img = json['img'];
  //   description = json['description'];
  //   startDate = json['start_date'];
  //   endDate = json['end_date'];
  //   clubId = json['club_id'];
  //   clubName = json['club_name'];
  //   studentId = json['student_id'];
  //   studentName = json['student_name'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['event_id'] = this.eventId;
  //   data['event_name'] = this.eventName;
  //   data['email'] = this.email;
  //   data['location'] = this.location;
  //   data['img'] = this.img;
  //   data['description'] = this.description;
  //   data['start_date'] = this.startDate;
  //   data['end_date'] = this.endDate;
  //   data['club_id'] = this.clubId;
  //   data['club_name'] = this.clubName;
  //   data['student_id'] = this.studentId;
  //   data['student_name'] = this.studentName;
  //   return data;
  // }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventId: json['event_id'],
      eventName: json['event_name'] ?? "",
      email: json['email'] ?? "",
      location: json['location'] ?? "",
      img: json['img'],
      description: json['description'] ?? "",
      startDate: json['start_date'] ?? "",
      endDate: json['end_date'] ?? "",
      clubId: json['club_id'] ?? 0,
      clubName: json['club_name'] ?? "",
      studentId: json['student_id'] ?? 0,
      studentName: json['student_name'] ?? "",
    );
  }
}
