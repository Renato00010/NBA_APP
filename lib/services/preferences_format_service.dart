import 'package:intl/intl.dart';

class PreferencesFormatService {
  static const Map<String, double> _ratesFromEur = {
    'EUR': 1,
    'USD': 1.08,
    'GBP': 0.86,
    'BRL': 5.54,
  };

  static const Map<String, String> _locales = {
    'EUR': 'pt_PT',
    'USD': 'en_US',
    'GBP': 'en_GB',
    'BRL': 'pt_BR',
  };

  static String formatCurrency(num eurValue, {String currencyCode = 'EUR'}) {
    final normalizedCode = _ratesFromEur.containsKey(currencyCode)
        ? currencyCode
        : 'EUR';
    final value = eurValue * _ratesFromEur[normalizedCode]!;
    return NumberFormat.simpleCurrency(
      locale: _locales[normalizedCode],
      name: normalizedCode,
    ).format(value);
  }

  static String orderId(DateTime date) {
    final suffix = date.millisecondsSinceEpoch.toString().substring(7);
    return 'NBA-$suffix';
  }
}
