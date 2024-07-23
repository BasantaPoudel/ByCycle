class DailyDataInput {
  String blood;
  DateTime date;
  String discharge;
  String energyLevel;
  int hoursOfSleep;
  List<String> symptoms;
  double temperature;
  String phase;

  DailyDataInput({
    this.blood = '',
    required this.date,
    this.discharge = '',
    this.energyLevel = '',
    this.hoursOfSleep = 0,
    this.symptoms = const [],
    this.temperature = 0,
    this.phase =
        "", // Should be equal to "menstruation", "follicular", "ovulation" or "luteal"
  });

  Map<String, dynamic> toMap() {
    return {
      'blood': blood,
      'date': date,
      'discharge': discharge,
      'energy_level': energyLevel,
      'hours_of_sleep': hoursOfSleep,
      'symptoms': symptoms,
      'temperature': temperature,
      'phase': phase,
    };
  }

  factory DailyDataInput.fromMap(Map<String, dynamic> map) {
    return DailyDataInput(
      blood: map['blood'] ?? '',
      date: map['date']
          .toDate(), // Assuming 'date' is stored as Firestore Timestamp
      discharge: map['discharge'] ?? '',
      energyLevel: map['energy_level'] ?? '',
      hoursOfSleep: map['hours_of_sleep'] ??
          0, // Ensure this matches the stored data type
      symptoms: List<String>.from(map['symptoms'] ?? []),
      temperature: map['temperature'].toDouble() ?? 0,
      phase: map['phase'] ?? '',
    );
  }

  @override
  String toString() {
    return 'DailyDataInput(blood: $blood, date: $date, discharge: $discharge, energy_level: $energyLevel, hours_of_sleep: $hoursOfSleep, symptoms: $symptoms, temperature: $temperature, phase: $phase)';
  }
}
