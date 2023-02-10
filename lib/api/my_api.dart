import 'dart:convert';

import 'package:http/http.dart' as httpmethod;
import '../models/api_model.dart';

Future<List<ApiModels>> getAll() async {
  final response = await httpmethod.get(
    Uri.https(
      "restcountries.com",
      "/v2/all",
    ),
  );

  if (response.statusCode == 200) {
    List<ApiModels> countries;
    countries = List<ApiModels>.from(
      jsonDecode(response.body).map(
        (value) => ApiModels.fromJson(value),
      ),
    );
    return countries;
  } else {
    throw Exception("Can't show the response!!!");
  }
}

Future<List<ApiModels>> getOne(String? nameCountry) async {
  final response = await httpmethod.get(
    Uri.https(
      "restcountries.com",
      "/v2/name/$nameCountry",
    ),
  );

  if (response.statusCode == 200) {
    List<ApiModels> countries;
    countries = List<ApiModels>.from(
      jsonDecode(response.body).map(
        (value) => ApiModels.fromJson(value),
      ),
    );
    return countries;
  } else {
    throw Exception("Can't show the country");
  }
}
