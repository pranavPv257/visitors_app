// To parse this JSON data, do
//
//     final fetchAllEmployees = fetchAllEmployeesFromJson(jsonString);

import 'dart:convert';

FetchAllEmployees fetchAllEmployeesFromJson(String str) => FetchAllEmployees.fromJson(json.decode(str));

class FetchAllEmployees {
  bool? status;
  String? message;
  Data? data;

  FetchAllEmployees({this.status, this.message, this.data});

  factory FetchAllEmployees.fromJson(Map<String, dynamic> json) =>
      FetchAllEmployees(status: json["status"], message: json["message"], data: Data.fromJson(json["data"]));
}

class Data {
  List<Result>? result;

  Data({this.result});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))));
}

class Result {
  int? id;
  String? name;

  Result({this.id, this.name});

  factory Result.fromJson(Map<String, dynamic> json) => Result(id: json["id"], name: json["name"]);
}
