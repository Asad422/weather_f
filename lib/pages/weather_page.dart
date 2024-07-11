import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_f/pages/selected_weather_page.dart';
import 'package:weather_f/weather_bloc/weather_bloc.dart';
import 'package:weather_f/weather_bloc/weather_event_bloc.dart';
import 'package:weather_f/weather_bloc/weather_state_bloc.dart';

import '../domain/weather_data_provider.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WeatherBloc(provider: WeatherDataProvider())..add(GetWeatherInfo()),
      child: WetherWidget(),
    );
  }
}

class WetherWidget extends StatelessWidget {
  const WetherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
          switch (state.status) {
            case WeatherStatus.failure:
              return Text('error');
            case WeatherStatus.initial:
              return CircularProgressIndicator();
            case WeatherStatus.success:
              return ListView.separated(
                itemCount: state.weatherBroadcasts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectedWeatherPage(
                                  date: state.weatherBroadcasts[index].date)));
                    },
                    child: ListTile(
                      title: Text(state.weatherBroadcasts[index].weather),
                      leading: Image.network(
                          'http:${state.weatherBroadcasts[index].icon}'),
                      subtitle: Text(state.weatherBroadcasts[index].date),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  if (state.weatherBroadcasts[index].date[9] !=
                      state.weatherBroadcasts[index + 1].date[9]) {
                    return Divider(
                      thickness: 3,
                    );
                  } else {
                    return Container();
                  }
                },
              );
          }
        }),
      ),
    );
  }
}
