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

// List<String> checkAmountAndConvert(double? amount) {
//   List<String> result = [];
//   if (amount != null) {
//     if (amount % 1 == 0) {
//       result.add(amount.toInt().toString());
//     } else {
//       double decimalValue = amount - amount.toInt();
//       if (decimalValue == 0.25) {
//         result.add((amount - decimalValue).toInt().toString());
//         result.add('${(amount - decimalValue).toInt()}1/4');
//       } else if (decimalValue == 0.5) {
//         result.add((amount - decimalValue).toInt().toString());
//         result.add('${(amount - decimalValue).toInt()}1/2');
//       } else if (decimalValue == 0.75) {
//         result.add((amount - decimalValue).toInt().toString());
//         result.add('${(amount - decimalValue).toInt()}3/4');
//       } else {
//         result.add(amount.toString());
//       }
//     }
//   }
//   return result;
// }
