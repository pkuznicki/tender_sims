class tnConstants {
  static double get_cogs({required String team_id}) {
    Map<String, double> result = {
      'polaris': 11,
      'river': 10,
      'beach': 9,
      'sunset': 8,
      'centerfield': 7,
      'admin': 8
    };

    return result[team_id] ?? 0;
  }

  static Map<String, double> get_qc_weight_map() {
    Map<String, double> result = {
      'product_packaging': 0.2,
      'delivery_time': 0.16,
      'payment_terms': 0.1,
      'customer_support': 0.24,
      'patient_support': 0.3
    };
    return result;
  }

  static Map<String, String> get_team_names() {
    Map<String, String> result = {
      'polaris': 'Polaris',
      'river': 'River',
      'beach': 'Beach',
      'sunset': 'Sunset Pharma',
      'centerfield': 'Centerfield',
      'admin': 'Admin Pharma'
    };

    return result;
  }

  static Map<String, Map<String, double>> get_points_map() {
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
      'admin': {
        'product_packaging': 4,
        'delivery_time': 3,
        'payment_terms': 2,
        'customer_support': 1,
        'patient_support': 5,
      },
    };

    return result;
  }
}
