import 'dart:async';

import 'package:get_storage/get_storage.dart';

abstract class BaseViewModel extends BaseViewModelsInputs with BaseViewModelsOutputs{
  //shared variables & functions used in hole app

}

abstract class BaseViewModelsInputs{
  void start();


  void dispose();
}
abstract class BaseViewModelsOutputs{

}