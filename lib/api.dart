import 'package:http/http.dart';
import 'dart:convert';

/// Fetches data from open data site. [fetchData]
Future<List<Map>> fetchData() async {
  final String url = 'http://data.coa.gov.tw/Service/OpenData/FromM/FarmTransData.aspx';
  final response = await get(url);
  final data = response.body;
  final List<Map> jsonData = List<Map>.from(json.decode(data));
  return jsonData;
}
