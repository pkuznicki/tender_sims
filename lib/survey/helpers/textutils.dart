class textutils {
  static String format_double(double integer) {
    String result = 'no_integer';

    result = integer.toString();
    for (int i = result.length; i > 0; i--) {
      print(result[i]);
    }

    return result;
  }
}
