List<String> checkAndconvertAmount(double? amount) {
  List<String> result = [];
  String firstPart = '';
  String secondPart = '';

  // if amount is integer -> convert double value to int
  // if decimal points of amount are .25, .5 or .75 convert them to fractions,
  // otherwise just show normal double value, like 1.8
  if (amount != null) {
    double decimalValue = amount - amount.toInt();
    switch (decimalValue) {
      case 0.0:
        firstPart = amount.toInt().toString();
        secondPart = '';
      case 0.25:
        firstPart = amount.toInt() == 0 ? '' : amount.toInt().toString();
        secondPart = '1/4';
      case 0.5:
        firstPart = amount.toInt() == 0 ? '' : amount.toInt().toString();
        secondPart = '1/2';
      case 0.75:
        firstPart = amount.toInt() == 0 ? '' : amount.toInt().toString();
        secondPart = '3/4';
      default:
        firstPart = amount.toString();
        secondPart = '';
    }
  }

  result.add(firstPart);
  result.add(secondPart);

  return result;
}
