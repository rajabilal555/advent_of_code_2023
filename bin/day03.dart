import 'dart:io';

import 'package:advent_of_code_2023/day03.dart';

void main(List<String> arguments) {
  final data = File('data/day03_input.txt').readAsLinesSync();

  int part01 = getPartNumbers(data).reduce((value, element) => value + element);
  int part02 = getGearRatios(data)
      .fold(0, (value, element) => value + (element.$1 * element.$2));

  print('Part 01: $part01');
  print('Part 02: $part02');
}
