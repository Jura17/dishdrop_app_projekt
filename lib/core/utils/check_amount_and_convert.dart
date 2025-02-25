String checkAmountAndConvert(double? amount) {
  String result = '';
  if (amount != null) {
    if (amount % 1 == 0) {
      result = amount.toInt().toString();
    } else {
      result = amount.toString();
    }
  }
  return result;
}

String getWholeNumberOfAmount(double? amount) {
  String result = '';
  if (amount != null) {
    if (amount.toInt() > 0) {
      result = amount.toInt().toString();
    }
  }
  return result;
}

String getFractionalPartOfAmount(double? amount) {
  String result = '';
  if (amount != null) {
    double decimalValue = amount - amount.toInt();
    if (decimalValue == 0.25) {
      result = '1/4';
    } else if (decimalValue == 0.5) {
      result = '1/2';
    } else if (decimalValue == 0.75) {
      result = '3/4';
    } else {
      result = '';
    }
  }

  return result;
}
