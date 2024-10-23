import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pesantren_app/pesantren.dart';

Future<List<Pesantren>> fetchPesantren() async {
  final response = await http.get(
    Uri.parse('https://api-pesantren-indonesia.vercel.app/pesantren/3206.json'),
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Pesantren.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load pesantren data');
  }
}
