import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_waether_app/additional_data.dart';
import 'package:my_waether_app/hourly_forecast.dart';
import 'package:http/http.dart' as http;

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});
  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  double temp = 0;
  @override
  void initState() {
    super.initState();
    getCurrentweather();
  }

  Future getCurrentweather() async {
    try {
      final result = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=islamabad,pk&APPID=0fd67d28e0facf61b26a9d5e9c8b28ca&units=metric",
        ),
      );
      final data = jsonDecode(result.body);
      if (int.parse(data["cod"]) != 200) {
        throw "an unexpected error occur";
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: getCurrentweather, icon: Icon(Icons.refresh)),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentweather(),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          final data = snapshot.data;
          final currentTemp = data['list'][0]['main']['temp'];
          final currentSky = data['list'][0]['weather'][0]['main'];
          final Humidity = data['list'][0]['main']['humidity'].toString();
          final windSpeed = data['list'][0]['wind']['speed'].toString();
          final Pressure = data['list'][0]['main']['pressure'].toString();
          final hf1 = data['list'][1]['main']['temp'].toString();
          final hf2 = data['list'][2]['main']['temp'].toString();
          final hf3 = data['list'][3]['main']['temp'].toString();
          final hf4 = data['list'][4]['main']['temp'].toString();
          final hf5 = data['list'][5]['main']['temp'].toString();
          final time1 = data['list'][1]['dt_txt'].substring(11, 16);
          final time2 = data['list'][2]['dt_txt'].substring(11, 16);
          final time3 = data['list'][3]['dt_txt'].substring(11, 16);
          final time4 = data['list'][4]['dt_txt'].substring(11, 16);
          final time5 = data['list'][5]['dt_txt'].substring(11, 16);

          ;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    child: Card(
                      elevation: 25,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            "$currentTemp °C",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            currentSky == "Cloud" || currentSky == "Rain"
                                ? Icons.cloud
                                : Icons.sunny,
                            size: 100,
                          ),
                          Text(currentSky, style: TextStyle(fontSize: 20)),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
                Text(
                  "  Weather Forecast",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      HourlyForecast(
                        time: time1,
                        icon: hf1 == "Cloud" || hf1 == "Rain"
                            ? Icons.cloud
                            : Icons.sunny,
                        temperature: hf1,
                      ),
                      HourlyForecast(
                        time: time2,
                        icon: hf2 == "Cloud" || hf2 == "Rain"
                            ? Icons.cloud
                            : Icons.sunny,
                        temperature: hf2,
                      ),
                      HourlyForecast(
                        time: time3,
                        icon: hf3 == "Cloud" || hf3 == "Rain"
                            ? Icons.cloud
                            : Icons.sunny,
                        temperature: hf3,
                      ),
                      HourlyForecast(
                        time: time4,
                        icon: hf4 == "Cloud" || hf4 == "Rain"
                            ? Icons.cloud
                            : Icons.sunny,
                        temperature: hf4,
                      ),
                      HourlyForecast(
                        time: time5,
                        icon: hf5 == "Cloud" || hf5 == "Rain"
                            ? Icons.cloud
                            : Icons.sunny,
                        temperature: hf5,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "  Additional Information",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      additionalData(
                        icon: Icons.water_drop,
                        label: "Humidity",
                        value: Humidity,
                      ),
                      additionalData(
                        icon: Icons.air,
                        label: "Wind speed",
                        value: windSpeed,
                      ),
                      additionalData(
                        icon: Icons.beach_access,
                        label: "Pressure",
                        value: Pressure,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}

void onpressed() {
  //getweath
}
