class Car {
  String name;
  double mileage;
  double maxSpeed;

  Car({
    required this.name,
    this.mileage = 10000,
    this.maxSpeed = 180,
  });

  double convertKmToMiles() {
    return mileage * 0.621371;
  }

  double convertMaxSpeedToMiles() {
    return maxSpeed * 0.621371;
  }
}
