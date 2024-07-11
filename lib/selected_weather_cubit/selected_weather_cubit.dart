import 'package:bloc/bloc.dart';
import 'package:weather_f/entity/weather_model.dart';
import 'package:weather_f/selected_weather_cubit/selected_weather_state.dart';

import '../domain/weather_data_provider.dart';

class SelectedWeatherCubit extends Cubit<SelectedWeatherState> {
  final WeatherDataProvider provider;
  SelectedWeatherCubit(this.provider) : super(SelectedWeatherState());
  void getData(String date) async {
    try {
      final toReturn = await provider.getDataForSelectedDay(date);
      emit(state.copyWith(
          weatherBroadcasts: toReturn, status: SelectedWeatherStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SelectedWeatherStatus.failed));
    }
  }
}
