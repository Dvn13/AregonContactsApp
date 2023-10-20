import '../../model/city_model.dart';

abstract class CityState {}

class CityInitial extends CityState {}

class CityLoadingState extends CityState {
  final bool isLoading;

  CityLoadingState(this.isLoading);
}

class CityListItemState extends CityState {
  final List<Iller> items;

  CityListItemState(this.items);
}

class CityItemsErrorState extends CityState {
  CityItemsErrorState();
}