// ignore_for_file: constant_identifier_names

import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/services.dart';

class ReportItem {
  String name;
  String placeholder;
  QuestionFormat questionFormat;
  List<dynamic> items;
  ResponseFormat responseFormat;
  String defaultValue;
  String value;
  String? comments;

  ReportItem(
      {required this.name,
      required this.placeholder,
      required this.questionFormat,
      this.items = const [],
      required this.responseFormat,
      required this.defaultValue,
      this.value = "",
      this.comments = ""});

  factory ReportItem.fromJson(Map<String, dynamic> jsonMap) {
    return ReportItem(
        name: jsonMap['name'],
        placeholder: jsonMap['placeholder'],
        questionFormat: EnumToString.fromString(
                QuestionFormat.values, jsonMap['questionFormat']) ??
            QuestionFormat.None,
        items: List<String>.from(jsonMap['items'] as List),
        responseFormat: EnumToString.fromString(
                ResponseFormat.values, jsonMap['responseFormat'] ?? "") ??
            ResponseFormat.Text,
        defaultValue: jsonMap['defaultValue'],
        value: jsonMap['value'] ?? jsonMap['defaultValue'],
        comments: jsonMap['comments']);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "placeholder": placeholder,
      "questionFormat": EnumToString.convertToString(questionFormat),
      "items": items
          .map((e) => e.runtimeType == ReportItem ? e.toJson() : e)
          .toList(),
      "responseFormat": EnumToString.convertToString(responseFormat),
      "defaultValue": defaultValue,
      "value": value,
      "comments": comments,
    };
  }
}

class Report {
  List<ReportItem> reportItems;
  String sessionId;

  Report(this.sessionId, {this.reportItems = const []});

  factory Report.fromJson(dynamic jsonMap) {
    return Report(jsonMap['sessionId'] ?? "NA",
        reportItems: jsonMap['reportItems']
            .map<ReportItem>((i) => ReportItem.fromJson(i))
            .toList());
  }
}

enum ReportType { inspection, purchase }

enum QuestionFormat {
  Category,
  Subcategory,
  PdfForms,
  HorizontalSwitch,
  ConditionalSwitch,
  QualityColorCoded,
  NumberField,
  TextField,
  ImageCapture,
  PdfCapture,
  None
}

enum ResponseFormat { Text, Image, Pdf }

extension on ResponseFormat {
  String getMIMEName() {
    switch (this) {
      case ResponseFormat.Text:
        return "text/plain";
      case ResponseFormat.Image:
        return "image/jpeg";
      case ResponseFormat.Pdf:
        return "application/pdf";
      default:
        return "";
    }
  }

  get isMedia {
    switch (this) {
      case ResponseFormat.Text:
        return false;
      case ResponseFormat.Image:
      case ResponseFormat.Pdf:
        return true;
    }
  }
}
