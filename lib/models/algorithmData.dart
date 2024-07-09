class InsightsCache {
  List<Map<String, dynamic>> blood;
  List<Map<String, dynamic>> backpain;
  List<Map<String, dynamic>> menstruation;
  List<Map<String, dynamic>> luteal;
  List<Map<String, dynamic>> temperature;

  InsightsCache({
    List<Map<String, dynamic>>? blood,
    List<Map<String, dynamic>>? backpain,
    List<Map<String, dynamic>>? menstruation,
    List<Map<String, dynamic>>? luteal,
    List<Map<String, dynamic>>? temperature,
  })  : blood = blood ?? [],
        backpain = backpain ?? [],
        menstruation = menstruation ?? [],
        luteal = luteal ?? [],
        temperature = temperature ?? [];

  // Convert InsightsCache instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'blood': blood,
      'backpain': backpain,
      'menstruation': menstruation,
      'luteal': luteal,
      'temperature': temperature,
    };
  }

  // Create an InsightsCache instance from a Map
  factory InsightsCache.fromMap(Map<String, dynamic> map) {
    return InsightsCache(
      blood: List<Map<String, dynamic>>.from(map['blood'] ?? []),
      backpain: List<Map<String, dynamic>>.from(map['backpain'] ?? []),
      menstruation: List<Map<String, dynamic>>.from(map['menstruation'] ?? []),
      luteal: List<Map<String, dynamic>>.from(map['luteal'] ?? []),
      temperature: List<Map<String, dynamic>>.from(map['temperature'] ?? []),
    );
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

void main() {
  // Creating an instance of InsightsCache
  InsightsCache cache = InsightsCache();

  // Adding insights
  cache.blood.add({'insightId': 'insight1', 'seenCounter': 5});
  cache.backpain.add({'insightId': 'insight2', 'seenCounter': 3});
  cache.temperature.add({'insightId': 'insight3', 'seenCounter': 7});

  // Printing the cache
  print('Initial cache:');
  print(cache);

  // Converting to map
  Map<String, dynamic> cacheMap = cache.toMap();
  print('Cache as Map:');
  print(cacheMap);

  // Creating a new instance from the map
  InsightsCache newCache = InsightsCache.fromMap(cacheMap);
  print('New Cache from Map:');
  print(newCache);
}
