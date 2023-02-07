class tnConstants {
  static List<double> get_cogs_pars({required String team_id}) {
    Map<String, List<double>> result = {
      'polaris': [0, 11, 2100, 7.68],
      'river': [0, 10, 2100, 6.98],
      'beach': [0, 9, 2100, 6.29],
      'sunset': [0, 8, 1800, 5.88],
      'centerfield': [0, 7, 1800, 5.15],
      'admin': [0, 15, 2100, 14],
    };

    return result[team_id] ?? [-1, -1, -1, -1];
  }

  static double get_cogs({required String team_id, required int volume}) {
    double result = -1;

    double x1 = get_cogs_pars(team_id: team_id)[0];
    double y1 = get_cogs_pars(team_id: team_id)[1];
    double x2 = get_cogs_pars(team_id: team_id)[2];
    double y2 = get_cogs_pars(team_id: team_id)[3];

    double a = (y2 - y1) / (x2 - x1);
    result = y1 + a * x2;

    return result;
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
