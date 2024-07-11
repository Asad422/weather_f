import '../entity/weather_model.dart';

enum SelectedWeatherStatus { initial, success, failed }

class SelectedWeatherState {
  final SelectedWeatherStatus status;
  final List<WeatherModel> weatherBroadcasts;
  SelectedWeatherState(
      {this.status = SelectedWeatherStatus.initial,
      this.weatherBroadcasts = const <WeatherModel>[]});
  SelectedWeatherState copyWith({
    SelectedWeatherStatus? status,
    List<WeatherModel>? weatherBroadcasts,
  }) {
    return SelectedWeatherState(
      status: status ?? this.status,
      weatherBroadcasts: weatherBroadcasts ?? this.weatherBroadcasts,
    );
  }
}
