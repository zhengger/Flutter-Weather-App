import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import 'package:weather/provider/hive_db_provider.dart';
import 'package:weather/provider/weather_provider.dart';
import 'package:weather/screens/main_page.dart';
import 'package:weather/widgets/custom_search_delegate.dart';

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final wProvider = Provider.of<WeatherProvider>(context);
    final hProvider = Provider.of<HiveDbProvider>(context);
    final future = useMemoized(() => wProvider.fetchWeatherData());

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () =>
                showSearch(context: context, delegate: CustomSearchDelegate()),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "ERROR: ${snapshot.error}",
              ),
            );
            // _showErrorDialog(snapshot.error.toString());
          }
          return Scaffold(
            body: SafeArea(
              child: PageView.builder(
                itemCount: hProvider.items.length,
                itemBuilder: (context, index) => MainPage(index: index),
              ),
            ),
          );
        },
      ),
    );
  }
}
