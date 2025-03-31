import 'dart:convert';

import 'package:admin_panel_app_web/global_variable.dart';
import 'package:admin_panel_app_web/models/vendor.dart';
import 'package:http/http.dart' as http;

class VendorController {
  Future<List<Vendor>> loadVendors() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/vendors'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8'
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<Vendor> vendors = data.map((vendor) {
          return Vendor.fromMap(vendor);
        }).toList();

        return vendors;
      } else {
        throw Exception(
            'Failed to load Vendor. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception("Error loading Buyers: ${e.toString()}");
    }
  }
}
