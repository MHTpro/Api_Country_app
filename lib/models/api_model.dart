class ApiModels {
  String? name;
  List<dynamic>? borders;
  String? region;
  String? capital;
  ApiFlags? flags;
  ApiModels({this.name, this.borders, this.region, this.capital, this.flags});

  factory ApiModels.fromJson(Map<String, dynamic> json) {
    return ApiModels(
      name: json["name"],
      borders: json["borders"],
      region: json["region"],
      capital: json["capital"],
      flags: ApiFlags.fromJson(json["flags"]),
    );
  }
}

class ApiFlags {
  String? png;

  ApiFlags({this.png});

  factory ApiFlags.fromJson(Map<String, dynamic> json) {
    return ApiFlags(
      png: json["png"],
    );
  }
}
