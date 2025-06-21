import 'package:flutter/material.dart';

class additionalData extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const additionalData({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
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
              Icon(icon, size: 50),
              Text(
                label,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(value, style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
