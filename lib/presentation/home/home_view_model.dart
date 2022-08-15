import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:orderbook/domain/models.dart';
import 'package:orderbook/presentation/base/base_view_model.dart';

class HomeViewModel extends BaseViewModel  with HomeViewModelOutputs,HomeViewModelInputs{
  StreamController _streamStory = StreamController<StoryObject>();
  StreamController _StreamTemp = StreamController<bool>();
  late final List<Offers> _listOffers;
  int indexOffer=0;

  @override
  void dispose() {
    // TODO: implement dispose
  }
  @override
  void start() {
    // TODO: implement start

  }
  @override
  Sink get inputStoryViewObject => _streamStory.sink;
  @override
  Stream<StoryObject> get outPutStoryViewObject => _streamStory.stream.map((event) => event);
  @override
  void search(String text) {
    // TODO: implement search
  }
  @override
  void onStoryChanged(int index){
    indexOffer=index;
    _postDataToView();
  }
  void _postDataToView(){
    inputStoryViewObject.add(
        StoryObject(
            offers: _listOffers[indexOffer],
            numberOfStory: _listOffers.length,
            currentIndex: indexOffer
        )
    );
  }

  @override
  Stream<int> temp() {
    // TODO: implement temp
    throw UnimplementedError();
  }

}

abstract class HomeViewModelInputs{
  void onStoryChanged(int index);
  Sink get inputStoryViewObject;
  Stream<int> temp();
}
abstract class HomeViewModelOutputs{
  Stream<StoryObject> get outPutStoryViewObject;
}