import 'package:advent_of_code_2023/day01.dart';
import 'package:test/test.dart';

void main() {
  test('test Single Calibrations', () {
    expect(convertCalibrationLine('1abc2'), '12');
    expect(convertCalibrationLine('pqr3stu8vwx'), '38');
    expect(convertCalibrationLine('a1b2c3d4e5f'), '15');
    expect(convertCalibrationLine('treb7uchet'), '77');
  });

  test('test Multiple Calibrations', () {
    expect(
        sumCalibrations([
          '1abc2',
          'pqr3stu8vwx',
          'a1b2c3d4e5f',
          'treb7uchet',
        ]),
        142);
  });

  test('test Single Calibrations with words', () {
    expect(convertCalibrationLine(wordToNumberConverter('two1nine')), '29');

    expect(convertCalibrationLine(wordToNumberConverter('eightwothree')), '83');

    expect(
        convertCalibrationLine(wordToNumberConverter('abcone2threexyz')), '13');

    expect(convertCalibrationLine(wordToNumberConverter('xtwone3four')), '24');

    expect(convertCalibrationLine(wordToNumberConverter('4nineeightseven2')),
        '42');

    expect(convertCalibrationLine(wordToNumberConverter('zoneight234')), '14');

    expect(
        convertCalibrationLine(wordToNumberConverter('7pqrstsixteen')), '76');
  });

  test('test Multiple Calibrations with words', () {
    expect(
        wordedSumCalibrations([
          'two1nine',
          'eightwothree',
          'abcone2threexyz',
          'xtwone3four',
          '4nineeightseven2',
          'zoneight234',
          '7pqrstsixteen',
        ]),
        281);
  });
}
