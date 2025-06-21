import 'package:flutter/material.dart';

class HourlyForecast extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temperature;
  const HourlyForecast({
    super.key,
    required this.temperature,
    required this.icon,
    required this.time,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Card(
        elevation: 25,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(
                time,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Icon(icon, size: 50),
              Text(temperature, style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
