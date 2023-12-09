import 'package:advent_of_code_2023/day03.dart';
import 'package:test/test.dart';

void main() {
  List<String> input = [
    '467..114..',
    '...*......',
    '..35..633.',
    '......#...',
    '617*......',
    '.....+.58.',
    '..592.....',
    '......755.',
    '...\$.*....',
    '.664.598..',
  ];
  print('Input:');
  print(input.join('\n'));

  test('test that Lexer Works', () {
    final lexer = Lexer(input[0].split(''));
    final token = lexer.getTokenAtIndex(0);

    expect(token, isNotNull);
    expect(token!.value, '467');
  });

  test('test part Numbers in Input', () {
    final output = getPartNumbers(input);
    expect(output, [467, 35, 633, 617, 592, 755, 664, 598]);
  });

  test('test Sum of part numbers', () {
    final sum = getPartNumbers(input).reduce((a, b) => a + b);
    expect(sum, 4361);
  });

  test('test getGearRatios', () {
    final output = getGearRatios(input);
    expect(output, [(35, 467), (598, 755)]);
  });
}
