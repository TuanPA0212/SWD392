class Student {
  final int studentId;
  final int? dpmId;
  final int? campusId;
  final String name;
  final String? address;
  final String? phone;
  final String email;
  final DateTime birthday;
  final String? studentImg;
  final int point;

  Student({
    required this.studentId,
    required this.dpmId,
    required this.campusId,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.birthday,
    required this.studentImg,
    required this.point,
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
        point: int.parse(json["point"] ?? "0"),
      );
}
