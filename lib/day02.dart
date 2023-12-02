import 'dart:math';

import 'package:equatable/equatable.dart';

class GameData extends Equatable {
  final int gameId;
  final List<CubesData> cubesData;

  const GameData({required this.gameId, required this.cubesData});

  factory GameData.parse(String line) {
    final parts = line.split(':');
    final int gameId = int.parse(parts[0].split(' ')[1]);
    return GameData(
      gameId: gameId,
      cubesData: parts[1].split(';').map((e) => CubesData.parse(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [gameId, cubesData];

  @override
  bool? get stringify => true;
}

class CubesData extends Equatable {
  final int redCubes;
  final int greenCubes;
  final int blueCubes;

  const CubesData({this.redCubes = 0, this.greenCubes = 0, this.blueCubes = 0});

  factory CubesData.parse(String line) {
    final parts = line.trim().split(', ');

    int redCubes = 0;
    int greenCubes = 0;
    int blueCubes = 0;

    for (var part in parts) {
      final cubeParts = part.split(' ');
      final String color = cubeParts[1];
      final int count = int.parse(cubeParts[0]);

      switch (color) {
        case 'red':
          redCubes = count;
          break;
        case 'green':
          greenCubes = count;
          break;
        case 'blue':
          blueCubes = count;
          break;
      }
    }

    return CubesData(
      redCubes: redCubes,
      greenCubes: greenCubes,
      blueCubes: blueCubes,
    );
  }

  @override
  List<Object?> get props => [redCubes, greenCubes, blueCubes];

  @override
  bool? get stringify => true;
}

bool isGamePossible({required CubesData bag, required CubesData game}) {
  return bag.redCubes >= game.redCubes &&
      bag.greenCubes >= game.greenCubes &&
      bag.blueCubes >= game.blueCubes;
}

/// Part 01
/// Check all games and return the sum of the game ids
int checkAllGames(List<String> lines) {
  final CubesData bag = CubesData(redCubes: 12, greenCubes: 13, blueCubes: 14);
  int sum = 0;
  for (String line in lines) {
    GameData game = GameData.parse(line);
    //? test each of the sub games
    bool isPossible = true;
    for (var cubesData in game.cubesData) {
      if (!isGamePossible(bag: bag, game: cubesData)) {
        isPossible = false;
        break;
      }
    }
    //? only add the game id if all sub games are possible
    if (isPossible) {
      sum += game.gameId;
    }
  }
  return sum;
}

CubesData getMinimunPossible(GameData game) {
  int minRedCubes = 0;
  int minGreenCubes = 0;
  int minBlueCubes = 0;

  for (var cubes in game.cubesData) {
    minRedCubes = max(minRedCubes, cubes.redCubes);
    minGreenCubes = max(minGreenCubes, cubes.greenCubes);
    minBlueCubes = max(minBlueCubes, cubes.blueCubes);
  }

  return CubesData(
    redCubes: minRedCubes,
    greenCubes: minGreenCubes,
    blueCubes: minBlueCubes,
  );
}

/// Part 02
/// Check all games and return the sum of the minimum possible powers
int getSumOfMinimumPossiblePowers(List<String> lines) {
  int power = 0;

  for (String line in lines) {
    GameData game = GameData.parse(line);
    CubesData minPossible = getMinimunPossible(game);
    power +=
        (minPossible.redCubes * minPossible.greenCubes * minPossible.blueCubes);
  }

  return power;
}
