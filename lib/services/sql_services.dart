import 'dart:convert';

import 'package:http/http.dart' as http;

import 'sqlconnection.dart';

class Services {
  static const root = "http://localhost/flutter/foldercreation.php";
  static const String _GET_ACTION = 'GET_ALL';
  static const String _CREATE_TABLE = 'CREATE_TABLE';
  static const String _ADD_COVER_ACTION = 'ADD_COVER';
  static const String _UPDATE_COVER_ACTION = 'UPDATE_COVER';
  static const String _DELETE_EMP_ACTION = 'DELETE_EMP';

  // Method to create the table Employees.
  static Future<String> createTable() async {
    try {
      // add the parameters to pass to the request.
      var map = <String, dynamic>{};
      map['action'] = _CREATE_TABLE;
      final response = await http.post(Uri.parse(root), body: map);
      print('Create Table Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<List<FolderSettings>> getEmployees() async {
    try {
      var map = <String, dynamic>{};
      map["action"] = _GET_ACTION;
      final response = await http.post(Uri.parse(root), body: map);
      // print("getEmployees >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<FolderSettings> list = parsePhotos(response.body);
        return list;
      } else {
        throw List.generate;
      }
    } catch (e) {
      return parsePhotos(root);
    }
  }

  static List<FolderSettings> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<FolderSettings>((json) => FolderSettings.fromJson(json))
        .toList();
  }

  static Future<String> addfolder(String folderName, String covername) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = _ADD_COVER_ACTION;
      map["folder_name"] = folderName;
      map["covername"] = covername;
      final response = await http.post(Uri.parse(root), body: map);
      print("addEmployee >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> updateEmployee(
      String folderid, String folderName, String covername) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = _UPDATE_COVER_ACTION;
      map["folderid"] = folderid;
      map["folder_name"] = folderName;
      map["covername"] = covername;
      final response = await http.post(Uri.parse(root), body: map);
      print("deleteEmployee >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> deleteEmployee(String folderid) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = _DELETE_EMP_ACTION;
      map["folderid"] = folderid;
      final response = await http.post(Uri.parse(root), body: map);
      print("deleteEmployee >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }
}
