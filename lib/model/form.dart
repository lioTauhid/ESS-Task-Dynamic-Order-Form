class FormModel {
  String? formName;
  List<Sections>? sections;
  List<ValueMapping>? valueMapping;

  FormModel({this.formName, this.sections, this.valueMapping});

  FormModel.fromJson(Map<String, dynamic> json) {
    formName = json['formName'];
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(Sections.fromJson(v));
      });
    }
    if (json['valueMapping'] != null) {
      valueMapping = <ValueMapping>[];
      json['valueMapping'].forEach((v) {
        valueMapping!.add(ValueMapping.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['formName'] = formName;
    if (sections != null) {
      data['sections'] = sections!.map((v) => v.toJson()).toList();
    }
    if (valueMapping != null) {
      data['valueMapping'] = valueMapping!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sections {
  String? name;
  String? key;
  List<Fields>? fields;

  Sections({this.name, this.key, this.fields});

  Sections.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    key = json['key'];
    if (json['fields'] != null) {
      fields = <Fields>[];
      json['fields'].forEach((v) {
        fields!.add(Fields.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['key'] = key;
    if (fields != null) {
      data['fields'] = fields!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Fields {
  int? id;
  String? key;
  Properties? properties;

  Fields({this.id, this.key, this.properties});

  Fields.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    properties = json['properties'] != null
        ? Properties.fromJson(json['properties'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    if (properties != null) {
      data['properties'] = properties!.toJson();
    }
    return data;
  }
}

class Properties {
  String? type;
  dynamic defaultValue;
  String? hintText;
  int? minLength;
  int? maxLength;
  String? label;
  String? listItems;

  Properties(
      {this.type,
      this.defaultValue,
      this.hintText,
      this.minLength,
      this.maxLength,
      this.label,
      this.listItems});

  Properties.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    defaultValue = json['defaultValue'];
    hintText = json['hintText'];
    minLength = json['minLength'];
    maxLength = json['maxLength'];
    label = json['label'];
    listItems = json['listItems'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['defaultValue'] = defaultValue;
    data['hintText'] = hintText;
    data['minLength'] = minLength;
    data['maxLength'] = maxLength;
    data['label'] = label;
    data['listItems'] = listItems;
    return data;
  }
}

class ValueMapping {
  List<SearchList>? searchList;
  List<DisplayList>? displayList;

  ValueMapping({this.searchList, this.displayList});

  ValueMapping.fromJson(Map<String, dynamic> json) {
    if (json['searchList'] != null) {
      searchList = <SearchList>[];
      json['searchList'].forEach((v) {
        searchList!.add(SearchList.fromJson(v));
      });
    }
    if (json['displayList'] != null) {
      displayList = <DisplayList>[];
      json['displayList'].forEach((v) {
        displayList!.add(DisplayList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (searchList != null) {
      data['searchList'] = searchList!.map((v) => v.toJson()).toList();
    }
    if (displayList != null) {
      data['displayList'] = displayList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchList {
  String? fieldKey;
  String? dataColumn;

  SearchList({this.fieldKey, this.dataColumn});

  SearchList.fromJson(Map<String, dynamic> json) {
    fieldKey = json['fieldKey'];
    dataColumn = json['dataColumn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fieldKey'] = fieldKey;
    data['dataColumn'] = dataColumn;
    return data;
  }
}

class DisplayList {
  String? fieldKey;
  String? dataColumn;

  DisplayList({this.fieldKey, this.dataColumn});

  DisplayList.fromJson(Map<String, dynamic> json) {
    fieldKey = json['fieldKey'];
    dataColumn = json['dataColumn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fieldKey'] = fieldKey;
    data['dataColumn'] = dataColumn;
    return data;
  }
}
