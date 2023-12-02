import 'package:advent_of_code_2023/day02.dart';
import 'package:test/test.dart';

void main() {
  test('test isGamePossible', () {
    expect(
      false,
      isGamePossible(
        bag: CubesData(),
        game: CubesData(redCubes: 1, greenCubes: 2, blueCubes: 3),
      ),
    );
    expect(
      true,
      isGamePossible(
        bag: CubesData(redCubes: 5, greenCubes: 5, blueCubes: 5),
        game: CubesData(redCubes: 1, greenCubes: 2, blueCubes: 3),
      ),
    );
  });

  test('test GameData.parse', () {
    expect(
      GameData(
        gameId: 1,
        cubesData: [
          CubesData(redCubes: 4, greenCubes: 0, blueCubes: 3),
          CubesData(redCubes: 1, greenCubes: 2, blueCubes: 6),
          CubesData(greenCubes: 2)
        ],
      ),
      GameData.parse('Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green'),
    );
  });

  test('test Part 01 (checkAllGames)', () {
    expect(
      8,
      checkAllGames([
        'Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green',
        'Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue',
        'Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red',
        'Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red',
        'Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green',
      ]),
    );
  });

  test('test getMinimumPossible', () {
    expect(
      CubesData(redCubes: 4, greenCubes: 2, blueCubes: 6),
      getMinimunPossible(GameData.parse(
          'Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green')),
    );
  });

  test('test Part 02 (getMinimumPossiblePower)', () {
    expect(
        2286,
        getSumOfMinimumPossiblePowers([
          'Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green',
          'Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue',
          'Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red',
          'Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red',
          'Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green',
        ]));
  });
}
