import 'dart:convert';

OCPPServerModel ocppServerModelFromJson(String str) =>
    OCPPServerModel.fromMap(json.decode(str));

class OCPPServerModel {
  OCPPServerModel(
    this._id,
    this._name,
    this._domain,
    this._port,
    this._type,
    this._version,
    this._tls,
    this._execute,
    this._certId,
    this._passphrase,
    this._passSupprot,
    this._aliasNumber,
    this._location,
    this._applyVersion,
    this._code,
    this._url,
    this._isSelected,
  );
  late String _id;
  late String _name;
  late String _domain;
  late String _port;
  late String _type;
  late String _version;
  late String _tls;
  late String _execute;
  late String _certId;
  late String _passphrase;
  late String _passSupprot;
  late String _aliasNumber;
  late String _location;
  late String _applyVersion;
  late String _code;
  late String _url;
  late String _isSelected;

  String get id => _id;
  String get name => _name;
  String get domain => _domain;
  String get port => _port;
  String get type => _type;
  String get version => _version;
  String get tls => _tls;
  String get execute => _execute;
  String get certId => _certId;
  String get passphrase => _passphrase;
  String get passSupprot => _passSupprot;
  String get aliasNumber => _aliasNumber;
  String get location => _location;
  String get applyVersion => _applyVersion;
  String get code => _code;
  String get url => _url;
  String get isSelected => _isSelected;

  set isSelected(value) {
    _isSelected = value;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['domain'] = domain;
    map['port'] = port;
    map['type'] = type;
    map['version'] = version;
    map['tls'] = tls;
    map['execute'] = execute;
    map['certId'] = certId;
    map['passphrase'] = passphrase;
    map['passSupprot'] = passSupprot;
    map['aliasNumber'] = aliasNumber;
    map['location'] = location;
    map['applyVersion'] = applyVersion;
    map['code'] = code;
    map['url'] = url;
    map['isSelected'] = isSelected;
    return map;
  }

  OCPPServerModel.fromMap(Map<String, dynamic> map) {
    _id = map["id"];
    _name = map["name"];
    _domain = map["domain"];
    _port = map["port"];
    _type = map["type"];
    _version = map["version"];
    _tls = map["tls"];
    _execute = map["execute"];
    _certId = map["certId"];
    _passphrase = map["passphrase"];
    _passSupprot = map["passSupprot"];
    _aliasNumber = map["aliasNumber"];
    _location = map["location"];
    _applyVersion = map["applyVersion"];
    _code = map["code"];
    _url = map["url"];
    _isSelected = map["isSelected"];
  }
}
