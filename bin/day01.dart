import 'dart:io';

import 'package:advent_of_code_2023/day01.dart';

void main(List<String> arguments) {
  final data = File('data/day01_input.txt').readAsLinesSync();

  int part1 = sumCalibrations(data);
  int part2 = wordedSumCalibrations(data);

  print("Part1: $part1");
  print("Part2: $part2");
}
