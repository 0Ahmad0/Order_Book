import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:orderbook/domain/models.dart';
import 'package:orderbook/presentation/base/base_view_model.dart';

class LoginViewModel extends BaseViewModel  with LoginViewModelsOutputs,LoginViewModelsInputs{
  StreamController _streamController = StreamController<Restaurant>();
  final TextEditingController phoneNumber = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
  }
  @override
  void start() {
    // TODO: implement start

  }
  @override
  void search(String text) {
    // TODO: implement search
  }
}

abstract class LoginViewModelsInputs{
  void search(String text);
}
abstract class LoginViewModelsOutputs{

}