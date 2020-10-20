import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

//enum state
enum ClassifyState {
  Idle,
  Scanning,
  Complete,
}

class ClassifyProvider extends ChangeNotifier {
  /// Result tflite
  String _result;
  String get result => _result;

  /// Classify State
  ClassifyState _state = ClassifyState.Idle;
  ClassifyState get state => _state;
  void changeState(ClassifyState state) {
    _state = state;
    notifyListeners();
  }

  void scanOnImage(File image) async {
    _result = null;
    //* scanning
    changeState(ClassifyState.Scanning);

    _runScanner(image);
    await Future.delayed(Duration(seconds: 2));

    changeState(ClassifyState.Complete);

    notifyListeners();
  }

  void _runScanner(File image) async {
    await Tflite.loadModel(
      model: 'assets/models/fruitAndVegetableModels.tflite',
      labels: 'assets/models/fruitAndVegetableLabels.txt',
    );

    var _output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    if (_output.length > 0) {
      _result = _output[0]['label'];
    }

    notifyListeners();
  }
}
