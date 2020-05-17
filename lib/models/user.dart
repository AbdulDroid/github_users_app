class User {
  String _id;
  String _image;
  String _name;
  String _location;
  String _htmlUrl;
  String _url;

  User(
    this._id,
    this._image,
    this._name,
    this._location,
    this._htmlUrl,
    this._url,
  );

  User.fromJson(Map<String, dynamic> json) {
      this._id = json['id'].toString();
      this._image = json['avatar_url'].toString();
      this._name = json['name'] == null ? json['login'].toString() : json['name'].toString();
      this._location = json['location'] == null ? 'Lagos' : json['location'].toString();
      this._htmlUrl = json['html_url'].toString();
      this._url = json['url'].toString();
  }


  
  @override
  String toString() {
    return '{\"id\":\"$_id\",\"avatar_url\":\"$_image\",\"name\":\"$_name\",' +
    '\"location\":\"$_location\",\"html_url\":\"$_htmlUrl\",\"url\":\"$_url\"}';
  }

  String get name {
    return _name == null ? 'Name' : _name;
  }

  set name(String value) {
    _name = value;
  }

  String get location => _location;

  set location(String value) {
    _location = value == null ? 'Lagos' : value;
  }

  String get htmlUrl => _htmlUrl;

  String get image => _image;

  String get url => _url;

  String get id => _id;
}
