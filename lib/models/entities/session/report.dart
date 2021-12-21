import 'package:enum_to_string/enum_to_string.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report.g.dart';

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

@JsonSerializable()
class ReportItemV1 {
  String name;
  String? value;
  String? comments;
  String format;
  String type;
  String category;

  ReportItemV1(this.name, this.value, this.comments, this.format, this.type, this.category);

  factory ReportItemV1.fromJson(Map<String, dynamic> json) =>
      _$ReportItemV1FromJson(json);

  Map<String, dynamic> toJson() => _$ReportItemV1ToJson(this);
}

@JsonSerializable()
class ReportV1 {
  List<String> categories;
  List<ReportItemV1> reportItems;

  ReportV1(this.categories, this.reportItems);

  factory ReportV1.fromJson(Map<String, dynamic> json) =>
      _$ReportV1FromJson(json);

  Map<String, dynamic> toJson() => _$ReportV1ToJson(this);
}

@JsonSerializable()
class GetReportResponse {
  String indexContents;
  ReportV1 report;

  GetReportResponse(this.indexContents, this.report);

  factory GetReportResponse.fromJson(Map<String, dynamic> json) =>
      _$GetReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetReportResponseToJson(this);
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

extension ResponseFormatExt on ResponseFormat {
  String prettyString() {
    return toString().substring(toString().lastIndexOf(".") + 1);
  }

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
