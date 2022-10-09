import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier {

  String _message = 'Loading...';

  GeneralPageState _pageState = GeneralPageState.Loading;
  bool _formIsValid = false;

  bool get formIsValid => _formIsValid;

  set setFormIsValid(bool isValid) {
    _formIsValid = isValid;
    notifyListeners();
  }

  void backToLoading({String msg = 'Loading...'}) {
    _pageState = GeneralPageState.Loading;
    _message = msg;
    notifyListeners();
  }

  void backToLoaded({String msg = 'Loading...'}) {
    _pageState = GeneralPageState.Loaded;
    _message = msg;
    notifyListeners();
  }

  void backToError(String msg) {
    _pageState = GeneralPageState.Error;
    _message = msg;
    notifyListeners();
  }

  bool get isLoading => _pageState == GeneralPageState.Loading;
  bool get isLoaded => _pageState == GeneralPageState.Loaded;
  bool get isError => _pageState == GeneralPageState.Error;
  String get message => _message;

}

enum GeneralPageState {Loading, Loaded, Error}