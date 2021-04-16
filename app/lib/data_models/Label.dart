import 'package:flutter/cupertino.dart';

class Label {
  final String labelName;
  final String labelDescription;
  final String labelImage;
  final String labelId;

  Label(
      {@required this.labelName,
      @required this.labelDescription,
      @required this.labelImage,
      @required this.labelId});

  Label.fromJSON(Map<String, dynamic> json, String _labelId)
      : labelName = json['labelName'],
        labelDescription = json['labelDescription'],
        labelImage = json['labelImage'],
        labelId = _labelId;

  Map<String, dynamic> toJSON() => {
        'labelName': labelName,
        'labelDescription': labelDescription,
        'labelImage': labelImage
      };
}
