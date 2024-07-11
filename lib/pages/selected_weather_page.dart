import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_f/domain/weather_data_provider.dart';
import 'package:weather_f/selected_weather_cubit/selected_weather_cubit.dart';
import 'package:weather_f/selected_weather_cubit/selected_weather_state.dart';

class SelectedWeatherPage extends StatelessWidget {
  final String date;
  const SelectedWeatherPage({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SelectedWeatherCubit(WeatherDataProvider()),
      child: SelectedWeatherView(
        date: date,
      ),
    );
  }
}

class SelectedWeatherView extends StatelessWidget {
  final String date;
  const SelectedWeatherView({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    context.read<SelectedWeatherCubit>().getData(date);
    return Scaffold(
      appBar: AppBar(
        title: Text(date),
      ),
      body: Center(
        child: BlocBuilder<SelectedWeatherCubit, SelectedWeatherState>(
            builder: (context, state) {
          switch (state.status) {
            case SelectedWeatherStatus.failed:
              return Text('error');
            case SelectedWeatherStatus.initial:
              return CircularProgressIndicator();
            case SelectedWeatherStatus.success:
              return ListView.builder(
                itemCount: state.weatherBroadcasts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.weatherBroadcasts[index].weather),
                    leading: Image.network(
                        'http:${state.weatherBroadcasts[index].icon}'),
                    subtitle: Text(state.weatherBroadcasts[index].date),
                  );
                },
              );
          }
        }),
      ),
    );
  }
}
