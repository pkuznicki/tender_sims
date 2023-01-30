class Sort {
  static List<MapEntry<String, dynamic>> sortMapByValue(
      Map<String, dynamic> map) {
    // turn the map into a list of entries
    List<MapEntry<String, dynamic>> mapEntries = map.entries.toList();

    // sort the list
    mapEntries.sort((a, b) => a.value.compareTo(b.value));

    // turn the list back into a map
    final Map<String, dynamic> sortedMapAsc = Map.fromEntries(mapEntries);

    // print the result
    return mapEntries;
  }
}
