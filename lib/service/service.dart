import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class JobService {
  final String apiUrl = 'https://remotive.com/api/remote-jobs';
  Future<Map<String, dynamic>> fetchJobs() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List jobjson = data["jobs"];

      return {'jobs': jobjson.map((job) => Job.fromJson(job)).toList()};
    } else {
      throw Exception('Failed to load jobs');
    }
  }
}
