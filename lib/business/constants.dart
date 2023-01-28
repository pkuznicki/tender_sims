class Constants {
  static get_cogs({required String team_id}) {
    Map<String, double> result = {
      'polaris': 11,
      'river': 10,
      'beach': 9,
      'sunset': 8,
      'centerfield': 7
    };
    return result[team_id];
  }

  static get_points_map({required String team_id}) {
    Map<String, Map<String, double>> result = {
      'polaris': {
        'product_packaging': 5,
        'delivery_time': 4,
        'payment_terms': 3,
        'customer_support': 2,
        'patient_support': 1,
      },
      'river': {
        'product_packaging': 1,
        'delivery_time': 5,
        'payment_terms': 4,
        'customer_support': 3,
        'patient_support': 2,
      },
      'beach': {
        'product_packaging': 2,
        'delivery_time': 1,
        'payment_terms': 5,
        'customer_support': 4,
        'patient_support': 3,
      },
      'sunset': {
        'product_packaging': 3,
        'delivery_time': 2,
        'payment_terms': 1,
        'customer_support': 5,
        'patient_support': 4,
      },
      'centerfield': {
        'product_packaging': 4,
        'delivery_time': 3,
        'payment_terms': 2,
        'customer_support': 1,
        'patient_support': 5,
      },
    };

    return result[team_id];
  }
}
