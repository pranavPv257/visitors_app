// To parse this JSON data, do
//
//     final fetchVisitorEmployees = fetchVisitorEmployeesFromJson(jsonString);

import 'dart:convert';

FetchVisitorEmployees fetchVisitorEmployeesFromJson(String str) => FetchVisitorEmployees.fromJson(json.decode(str));

class FetchVisitorEmployees {
  bool? status;
  String? message;
  VisitorData? data;

  FetchVisitorEmployees({this.status, this.message, this.data});

  factory FetchVisitorEmployees.fromJson(Map<String, dynamic> json) =>
      FetchVisitorEmployees(status: json["status"], message: json["message"], data: VisitorData.fromJson(json["data"]));
}

class VisitorData {
  VisitorResult? result;

  VisitorData({this.result});

  factory VisitorData.fromJson(Map<String, dynamic> json) =>
      VisitorData(result: VisitorResult.fromJson(json["result"]));
}

class VisitorResult {
  int? id;
  String? name;
  String? email;
  String? phone;
  bool? whatzapp;
  bool? verified;

  VisitorsVisit? visitorsVisit;

  VisitorResult({this.id, this.name, this.email, this.phone, this.whatzapp, this.verified, this.visitorsVisit});

  factory VisitorResult.fromJson(Map<String, dynamic> json) => VisitorResult(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    whatzapp: json["whatzapp"],
    verified: json["verified"],

    visitorsVisit: VisitorsVisit.fromJson(json["visitorsVisit"]),
  );
}

class VisitorsVisit {
  int? id;
  int? whoToMeet;
  int? visitorsId;
  String? type;
  String? reason;
  int? durationMins;
  bool? verified;
  String? verifiedMethod;
  DateTime? checkOutTime;
  dynamic approved;
  String? hash;
  dynamic rejectReason;
  DateTime? created;
  DateTime? updated;

  VisitorsVisit({
    this.id,
    this.whoToMeet,
    this.visitorsId,
    this.type,
    this.reason,
    this.durationMins,
    this.verified,
    this.verifiedMethod,
    this.checkOutTime,
    this.approved,
    this.hash,
    this.rejectReason,
    this.created,
    this.updated,
  });

  factory VisitorsVisit.fromJson(Map<String, dynamic> json) => VisitorsVisit(
    id: json["id"],
    whoToMeet: json["who_to_meet"],
    visitorsId: json["visitors_id"],
    type: json["type"],
    reason: json["reason"],
    durationMins: json["duration_mins"],
    verified: json["verified"],
    verifiedMethod: json["verified_method"],
    checkOutTime: DateTime.parse(json["check_out_time"]),
    approved: json["approved"],
    hash: json["hash"],
    rejectReason: json["reject_reason"],
    created: DateTime.parse(json["created"]),
    updated: DateTime.parse(json["updated"]),
  );
}
