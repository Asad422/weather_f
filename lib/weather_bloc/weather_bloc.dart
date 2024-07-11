import 'package:bloc/bloc.dart';
import 'package:weather_f/domain/weather_data_provider.dart';
import 'package:weather_f/entity/weather_model.dart';
import 'package:weather_f/weather_bloc/weather_event_bloc.dart';
import 'package:weather_f/weather_bloc/weather_state_bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({required this.provider}) : super(WeatherState()) {
    on<GetWeatherInfo>(_onGetWeatherInfo);
  }
  _onGetWeatherInfo(
    GetWeatherInfo event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      final List<WeatherModel> broadcasts = await provider.getData();
      emit(state.copyWith(
        status: WeatherStatus.success,
        weatherBroadcasts: broadcasts,
      ));
    } catch (e) {
      state.copyWith(status: WeatherStatus.failure);
    }
  }

  final WeatherDataProvider provider;
}
