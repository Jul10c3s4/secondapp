class CharactersModel {
  int? _code;
  String? _status;
  String? _copyright;
  String? _attributionText;
  String? _attributionHTML;
  String? _etag;
  Data? _data;

  CharactersModel(
      {int? code,
      String? status,
      String? copyright,
      String? attributionText,
      String? attributionHTML,
      String? etag,
      Data? data}) {
    if (code != null) {
      _code = code;
    }
    if (status != null) {
      _status = status;
    }
    if (copyright != null) {
      _copyright = copyright;
    }
    if (attributionText != null) {
      _attributionText = attributionText;
    }
    if (attributionHTML != null) {
      _attributionHTML = attributionHTML;
    }
    if (etag != null) {
      _etag = etag;
    }
    if (data != null) {
      _data = data;
    }
  }

  int? get code => _code;
  set code(int? code) => _code = code;
  String? get status => _status;
  set status(String? status) => _status = status;
  String? get copyright => _copyright;
  set copyright(String? copyright) => _copyright = copyright;
  String? get attributionText => _attributionText;
  set attributionText(String? attributionText) =>
      _attributionText = attributionText;
  String? get attributionHTML => _attributionHTML;
  set attributionHTML(String? attributionHTML) =>
      _attributionHTML = attributionHTML;
  String? get etag => _etag;
  set etag(String? etag) => _etag = etag;
  Data? get data => _data;
  set data(Data? data) => _data = data;

  CharactersModel.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _status = json['status'];
    _copyright = json['copyright'];
    _attributionText = json['attributionText'];
    _attributionHTML = json['attributionHTML'];
    _etag = json['etag'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = _code;
    data['status'] = _status;
    data['copyright'] = _copyright;
    data['attributionText'] = _attributionText;
    data['attributionHTML'] = _attributionHTML;
    data['etag'] = _etag;
    if (_data != null) {
      data['data'] = _data!.toJson();
    }
    return data;
  }
}

class Data {
  int? _offset;
  int? _limit;
  int? _total;
  int? _count;
  List<Results>? _results;

  Data(
      {int? offset,
      int? limit,
      int? total,
      int? count,
      List<Results>? results}) {
    if (offset != null) {
      _offset = offset;
    }
    if (limit != null) {
      _limit = limit;
    }
    if (total != null) {
      _total = total;
    }
    if (count != null) {
      _count = count;
    }
    if (results != null) {
      _results = results;
    }
  }

  int? get offset => _offset;
  set offset(int? offset) => _offset = offset;
  int? get limit => _limit;
  set limit(int? limit) => _limit = limit;
  int? get total => _total;
  set total(int? total) => _total = total;
  int? get count => _count;
  set count(int? count) => _count = count;
  List<Results>? get results => _results;
  set results(List<Results>? results) => _results = results;

  Data.fromJson(Map<String, dynamic> json) {
    _offset = json['offset'];
    _limit = json['limit'];
    _total = json['total'];
    _count = json['count'];
    if (json['results'] != null) {
      _results = <Results>[];
      json['results'].forEach((v) {
        _results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['offset'] = _offset;
    data['limit'] = _limit;
    data['total'] = _total;
    data['count'] = _count;
    if (_results != null) {
      data['results'] = _results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? _id;
  String? _name;
  String? _description;
  Thumbnail? _thumbnail;

  Results({
    int? id,
    String? name,
    String? description,
    Thumbnail? thumbnail,
  }) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (description != null) {
      _description = description;
    }
    if (thumbnail != null) {
      _thumbnail = thumbnail;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get description => _description;
  set description(String? description) => _description = description;
  Thumbnail? get thumbnail => _thumbnail;
  set thumbnail(Thumbnail? thumbnail) => _thumbnail = thumbnail;

  Results.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _thumbnail = json['thumbnail'] != null
        ? Thumbnail.fromJson(json['thumbnail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['description'] = _description;
    if (_thumbnail != null) {
      data['thumbnail'] = _thumbnail!.toJson();
    }
    return data;
  }
}

class Thumbnail {
  String? _path;
  String? _extension;

  Thumbnail({String? path, String? extension}) {
    if (path != null) {
      _path = path;
    }
    if (extension != null) {
      _extension = extension;
    }
  }

  String? get path => _path;
  set path(String? path) => _path = path;
  String? get extension => _extension;
  set extension(String? extension) => _extension = extension;

  Thumbnail.fromJson(Map<String, dynamic> json) {
    _path = json['path'];
    _extension = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path'] = _path;
    data['extension'] = _extension;
    return data;
  }
}
