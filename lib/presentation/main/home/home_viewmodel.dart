import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../../domain/model/model.dart';
import '../../../domain/usecase/home_usecase.dart';
import '../../base/baseviewmodel.dart';

class HomeViewModel extends BaseViewModel {
  final HomeUseCase _homeUseCase;

  final StreamController _bannersStreamController =
      BehaviorSubject<List<BannerAd>>();
  final StreamController _servicesStreamController =
      BehaviorSubject<List<Service>>();
  final StreamController _storesStreamController =
      BehaviorSubject<List<Store>>();

  HomeViewModel(this._homeUseCase);

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    _bannersStreamController.close();
    _servicesStreamController.close();
    _storesStreamController.close();
    super.dispose();
  }
}
