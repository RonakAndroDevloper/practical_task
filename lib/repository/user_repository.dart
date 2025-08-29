import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/UserListModel.dart';
import '../models/UserProfileModel.dart';

class UserRepository {
  static const String baseUrl = "https://dummyapi.io/data/v1";
  static const String appId = "6112dc7c3f812e0d9b6679dd";

  Future<List<Data>> fetchUsers() async {
    final response = await http.get(
      Uri.parse("$baseUrl/user?limit=20"),
      headers: {"app-id": appId},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data["data"] as List).map((e) => Data.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load users");
    }
  }

  Future<UserProfileModel> fetchUserDetail(String id) async {
    final response = await http.get(
      Uri.parse("$baseUrl/user/$id"),
      headers: {"app-id": appId},
    );

    if (response.statusCode == 200) {
      return UserProfileModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load user detail");
    }
  }
}