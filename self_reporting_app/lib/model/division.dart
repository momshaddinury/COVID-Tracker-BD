class Division {
  final bool isActive;
  final String id;
  final String name;
  final String nameBn;
  final double latitude;
  final double longitude;
  final int code;

  Division({this.isActive, this.id, this.name, this.nameBn, this.latitude, this.longitude, this.code});

  factory Division.fromJson(Map<String, dynamic> json) {
    return Division(
      isActive: json['is_active'],
      id: json['_id'],
      name: json['name'],
      nameBn: json['name_bn'],
      latitude: checkDouble(json['latitude']),
      longitude: checkDouble(json['longitude']),
      code: json['code'],
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