class Upazila {
  final bool isActive;
  final String id;
  final String name;
  final String nameBn;
  final double latitude;
  final double longitude;
  final String code;
  final String divisionId;
  final String districtId;
  final UnderDistrict district;

  Upazila({this.isActive, this.id, this.name, this.nameBn, this.latitude, this.longitude, this.code, this.divisionId, this.districtId, this.district});


  factory Upazila.fromJson(Map<String, dynamic> json) {
    return Upazila(
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
      divisionId: json['division_id'] != null
          ? json['division_id'] : null,
      districtId: json['district_id'] != null
          ? json['district_id'] : null,
      district: json['district'] != null
          ? UnderDistrict.fromJson(json['district']) : null,
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

class UnderDistrict {
  final String id;
  final String name;
  final String nameBn;

  UnderDistrict({this.id, this.name, this.nameBn});

  factory UnderDistrict.fromJson(Map<String, dynamic> json) {
    return UnderDistrict(
      id: json['_id'],
      name: json['name'],
      nameBn: json['name_bn'],
    );
  }
}