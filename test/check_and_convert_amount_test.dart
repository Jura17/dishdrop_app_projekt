import 'package:dishdrop_app_projekt/core/utils/check_and_convert_amount.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should return ["10", ""] when given 10.0', () {
    final result = checkAndconvertAmount(10.0);
    expect(result, ['10', '']);
  });

  test('should return ["10", "1/2"] when given 10.5', () {
    final result = checkAndconvertAmount(10.5);
    expect(result, ['10', '1/2']);
  });

  test('should return ["", "3/4"] when given 0.75', () {
    final result = checkAndconvertAmount(0.75);
    expect(result, ['', '3/4']);
  });
}
