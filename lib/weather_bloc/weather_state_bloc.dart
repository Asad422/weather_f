import 'package:equatable/equatable.dart';

import '../entity/weather_model.dart';

enum WeatherStatus { initial, success, failure }

final class WeatherState extends Equatable {
  final WeatherStatus status;
  final List<WeatherModel> weatherBroadcasts;
  WeatherState(
      {this.status = WeatherStatus.initial,
      this.weatherBroadcasts = const <WeatherModel>[]});
  @override
  List<Object?> get props => [status, weatherBroadcasts];

  WeatherState copyWith({
    WeatherStatus? status,
    List<WeatherModel>? weatherBroadcasts,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weatherBroadcasts: weatherBroadcasts ?? this.weatherBroadcasts,
    );
  }
}
