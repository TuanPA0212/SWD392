class Event {
  int? eventId;
  String? eventName;
  String? email;
  String? location;
  String? img;
  Null? description;
  String? startDate;
  String? endDate;
  int? clubId;
  String? clubName;
  int? studentId;
  String? studentName;

  Event(
      {this.eventId,
      this.eventName,
      this.email,
      this.location,
      this.img,
      this.description,
      this.startDate,
      this.endDate,
      this.clubId,
      this.clubName,
      this.studentId,
      this.studentName});

  Event.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    eventName = json['event_name'];
    email = json['email'];
    location = json['location'];
    img = json['img'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    clubId = json['club_id'];
    clubName = json['club_name'];
    studentId = json['student_id'];
    studentName = json['student_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['event_name'] = this.eventName;
    data['email'] = this.email;
    data['location'] = this.location;
    data['img'] = this.img;
    data['description'] = this.description;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['club_id'] = this.clubId;
    data['club_name'] = this.clubName;
    data['student_id'] = this.studentId;
    data['student_name'] = this.studentName;
    return data;
  }
}