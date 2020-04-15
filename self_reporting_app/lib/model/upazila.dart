class Upazila {
  final bool isActive;
  final String id;
  final String name;
  final String nameBn;
  final double latitude;
  final double longitude;
  final String divisionId;
  final String districtId;
  final UnderDistrict district;

  Upazila({this.isActive, this.id, this.name, this.nameBn, this.latitude, this.longitude, this.divisionId, this.districtId, this.district});


  factory Upazila.fromJson(Map<String, dynamic> json) {
    return Upazila(
      isActive: json['is_active'],
      id: json['_id'],
      name: json['name'],
      nameBn: json['name_bn'],
      latitude: checkDouble(json['latitude']),
      longitude: checkDouble(json['longitude']),
      divisionId: json['division_id'],
      districtId: json['district_id'],
      district: UnderDistrict.fromJson(json['district']),
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