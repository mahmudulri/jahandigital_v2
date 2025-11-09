import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/country_list_model.dart';
import '../utils/api_endpoints.dart';

class CountryListApi {
  final box = GetStorage();
  Future<CountryListModel> fetchCountryList() async {
    final url = Uri.parse(
      "https://app-api-vpro-jd.milliekit.com/api/public/countries",
    );
    print(url);

    var response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${box.read("userToken")}'},
    );

    if (response.statusCode == 200) {
      final countryModel = CountryListModel.fromJson(
        json.decode(response.body),
      );

      Country? afghanistan;
      try {
        afghanistan = countryModel.data?.countries.firstWhere(
          (c) => c.countryName == "Afghanistan",
        );
      } catch (e) {
        afghanistan = null;
      }

      if (afghanistan != null) {
        // ✅ Save in GetStorage
        box.write("afghanistan_id", afghanistan.id);
        box.write("afghanistan_flag", afghanistan.countryFlagImageUrl);
        print(
          "Saved Afghanistan -> id: ${afghanistan.id}, flag: ${afghanistan.countryFlagImageUrl}",
        );
      } else {
        print("Afghanistan not found in country list");
      }

      return countryModel;
    } else {
      throw Exception('Failed to fetch gateway');
    }
  }
}
