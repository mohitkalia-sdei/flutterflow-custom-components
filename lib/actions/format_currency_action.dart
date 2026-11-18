/// Custom FlutterFlow Action: formatCurrency
/// Returns a formatted currency string e.g. "$1,234.50"
String formatCurrency(double amount, String currencySymbol) {
  final parts = amount.toStringAsFixed(2).split('.');
  final integerPart = parts[0];
  final decimalPart = parts[1];

  final regExp = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  final formattedInt = integerPart.replaceAllMapped(regExp, (Match m) => '${m[1]},');

  return '$currencySymbol$formattedInt.$decimalPart';
}
