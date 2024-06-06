class ConfiguracoesModel {
  String _userName = "";
  double _height = 0;
  bool _receiverNotifications = false;
  bool _darkTheme = false;

  ConfiguracoesModel.empty() {
    _userName = "";
    _height = 0;
    _receiverNotifications = false;
    _darkTheme = false;
  }

  ConfiguracoesModel(this._userName, this._height, this._receiverNotifications,
      this._darkTheme);

  String get userName => _userName;
  double get height => _height;
  bool get receiverNotifications => _receiverNotifications;
  bool get darkTheme => _darkTheme;

  set userName(String userName) {
    _userName = userName;
  }

  set height(double height) {
    _height = height;
  }

  set receiverNotifications(bool receiverNotifications) {
    _receiverNotifications = receiverNotifications;
  }

  set darkTheme(bool darkTheme) {
    _darkTheme = darkTheme;
  }
}
