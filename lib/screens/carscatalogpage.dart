import 'package:flutter/material.dart';

import '../models/car.dart';

class CarsCatalogPage extends StatefulWidget {
  static const route = '/carscatalog';

  const CarsCatalogPage({super.key});

  @override
  _CarsCatalogPageState createState() => _CarsCatalogPageState();
}

class _CarsCatalogPageState extends State<CarsCatalogPage> {
  bool isKm = true;

  @override
  Widget build(BuildContext context) {
    List<Car> cars = [
      Car(name: "lamborghini hurakan", mileage: 12000, maxSpeed: 220),
      Car(name: "matiz", mileage: 15000, maxSpeed: 200),
      Car(name: "mercedes S class ", mileage: 8000, maxSpeed: 250),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cars'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 30, 40, 50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Km to Ml:",
                  style: TextStyle(fontSize: 16),
                ),
                Switch(
                  value: isKm,
                  onChanged: (value) {
                    setState(() {
                      isKm = value;
                    });
                  },
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  final car = cars[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(car.name),
                      subtitle: Text(
                        'Passed: ${isKm ? car.mileage : car.convertKmToMiles()} ${isKm ? "km" : "ml"}\n'
                        'Max. Speed: ${isKm ? car.maxSpeed : car.convertMaxSpeedToMiles()} ${isKm ? "km/h" : "мml/h"}',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
