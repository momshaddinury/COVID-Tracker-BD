class District {
  final bool isActive;
  final String id;
  final String name;
  final String nameBn;
  final double latitude;
  final double longitude;
  final String divisionId;
  final UnderDivision division;

  District({this.isActive, this.id, this.name, this.nameBn, this.latitude, this.longitude, this.divisionId, this.division});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      isActive: json['is_active'],
      id: json['_id'],
      name: json['name'],
      nameBn: json['name_bn'],
      latitude: checkDouble(json['latitude']),
      longitude: checkDouble(json['longitude']),
      divisionId: json['division_id'],
      division: UnderDivision.fromJson(json['division']),
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

class UnderDivision {
  final String id;
  final String name;
  final String nameBn;

  UnderDivision({this.id, this.name, this.nameBn});

  factory UnderDivision.fromJson(Map<String, dynamic> json) {
    return UnderDivision(
      id: json['_id'],
      name: json['name'],
      nameBn: json['name_bn'],
    );
  }
}