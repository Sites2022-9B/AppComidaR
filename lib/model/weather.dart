class Weather {
  final double temperatureC;
  final String condition;
  final String city;
  final String iconcond;

  Weather(
      {this.temperatureC = 0,
      this.condition = "Sunny",
      this.iconcond = "",
      this.city = "Ocosingo"});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperatureC: json['current']['temp_c'],
      condition: json['current']['condition']['text'],
      iconcond: json['current']['condition']['icon'],
      city: json['location']['name'],
    );
  }
}
