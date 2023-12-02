import 'dart:io';

import 'package:advent_of_code_2023/day02.dart';

void main(List<String> arguments) {
  final data = File('data/day02_input.txt').readAsLinesSync();

  int part01 = checkAllGames(data);
  int part02 = getSumOfMinimumPossiblePowers(data);

  print('Part 01: $part01');
  print('Part 02: $part02');
}
