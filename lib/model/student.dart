class Student {
  int studentId;
  int? dpmId;
  int? campusId;
  String name;
  String? address;
  String? phone;
  String email;
  DateTime birthday;
  String? studentImg;
  int? point;

  Student({
    required this.studentId,
    required this.dpmId,
    required this.campusId,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.birthday,
    this.studentImg,
    this.point,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        studentId: json["student_id"],
        dpmId: json["dpm_id"],
        campusId: json["campus_id"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        email: json["email"],
        birthday: json['birthday'] != null
            ? DateTime.parse(json['birthday'])
            : DateTime.now(),
        studentImg: json["student_img"],
        point: int.tryParse(json["point"]) ?? 0,
      );
}
