class Division {
  final bool isActive;
  final String id;
  final String name;
  final String nameBn;
  final double latitude;
  final double longitude;
  final String code;

  Division({this.isActive, this.id, this.name, this.nameBn, this.latitude, this.longitude, this.code});

  factory Division.fromJson(Map<String, dynamic> json) {
    return Division(
      isActive: json['is_active'] != null
          ? json['is_active'] : null,
      id: json['_id'] != null
          ? json['_id'] : null,
      name: json['name'] != null
          ? json['name'] : null,
      nameBn: json['name_bn'] != null
          ? json['name_bn'] : null,
      latitude: json['latitude'] != null
          ? checkDouble(json['latitude']) : null,
      longitude: json['longitude'] != null
          ? checkDouble(json['longitude']) : null,
      code: json['code'] != null
          ? json['code'] : null,
    );
  }

  static double checkDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else {
      return value;
    }
  }
}