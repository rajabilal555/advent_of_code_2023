import 'dart:io';

import 'package:advent_of_code_2023/day04.dart';

void main(List<String> arguments) {
  final data = File('data/day04_input.txt').readAsLinesSync();

  final scratchCards = data.map((e) => ScratchCard.parse(e)).toList();

  final scratchCardPoints = scratchCards.map((e) => e.points).toList();

  final totalPoints =
      scratchCardPoints.reduce((value, element) => value + element);

  final totalCards = totalScratchCards(scratchCards);

  print('Part 01: $totalPoints');
  print('Part 02: $totalCards');
}
