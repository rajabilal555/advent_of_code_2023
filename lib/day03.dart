import 'package:advent_of_code_2023/common/helpers.dart';

typedef Gear = (int, int);

List<Gear> getGearRatios(List<String> rawInput) {
  final List<List<String>> input = rawInput.map((e) => e.split('')).toList();
  final List<Gear> output = [];

  for (var i = 0; i < input.length; i++) {
    final line = input[i];

    for (var j = 0; j < line.length; j++) {
      final char = line[j];
      if (char == '*') {
        Set<int> ratios = {}; // Set to avoid duplicates

        // Check for two adjacent numbers. which will be the gear ratio.
        // then add them to the output.

        bool iNotLast = i + 1 < input.length;
        bool iNotFirst = i - 1 >= 0;
        bool jNotLast = j + 1 < line.length;
        bool jNotFirst = j - 1 >= 0;

        // horizontal check / search
        if (jNotLast && isNumeric(line[j + 1])) {
          final lexer = Lexer(line);

          final token = lexer.getTokenAtIndex(j + 1);
          if (token != null) {
            ratios.add(int.parse(token.value));
          }
        }

        if (jNotFirst && isNumeric(line[j - 1])) {
          final lexer = Lexer(line);

          final token = lexer.getTokenAtIndex(j - 1);
          if (token != null) {
            ratios.add(int.parse(token.value));
          }
        }

        // vertical check / search
        if (iNotLast && isNumeric(input[i + 1][j])) {
          final lexer = Lexer(input[i + 1]);

          final token = lexer.getTokenAtIndex(j);
          if (token != null) {
            ratios.add(int.parse(token.value));
          }
        }

        if (iNotFirst && isNumeric(input[i - 1][j])) {
          final lexer = Lexer(input[i - 1]);

          final token = lexer.getTokenAtIndex(j);
          if (token != null) {
            ratios.add(int.parse(token.value));
          }
        }

        // diagonal check / search

        if (iNotLast && jNotLast && isNumeric(input[i + 1][j + 1])) {
          final lexer = Lexer(input[i + 1]);

          final token = lexer.getTokenAtIndex(j + 1);
          if (token != null) {
            ratios.add(int.parse(token.value));
          }
        }

        if (iNotFirst && jNotFirst && isNumeric(input[i - 1][j - 1])) {
          final lexer = Lexer(input[i - 1]);

          final token = lexer.getTokenAtIndex(j - 1);
          if (token != null) {
            ratios.add(int.parse(token.value));
          }
        }

        if (iNotLast && jNotFirst && isNumeric(input[i + 1][j - 1])) {
          final lexer = Lexer(input[i + 1]);

          final token = lexer.getTokenAtIndex(j - 1);
          if (token != null) {
            ratios.add(int.parse(token.value));
          }
        }

        if (iNotFirst && jNotLast && isNumeric(input[i - 1][j + 1])) {
          final lexer = Lexer(input[i - 1]);

          final token = lexer.getTokenAtIndex(j + 1);
          if (token != null) {
            ratios.add(int.parse(token.value));
          }
        }

        print(ratios);
        if (ratios.length == 2) {
          output.add((ratios.first, ratios.last));
        }
      }
    }
  }

  return output;
}

List<int> getPartNumbers(List<String> rawInput) {
  // Divide each line of input into a list of characters in the line.
  final List<List<String>> input = rawInput.map((e) => e.split('')).toList();
  final List<int> output = [];

  for (var i = 0; i < input.length; i++) {
    final line = input[i];
    final lexer = Lexer(line);

    for (var j = 0; j < line.length; j++) {
      // check if adjacent tokens are numbers or symbols
      final char = line[j];

      if (isNumeric(char)) {
        bool iNotLast = i + 1 < input.length;
        bool iNotFirst = i - 1 >= 0;
        bool jNotLast = j + 1 < line.length;
        bool jNotFirst = j - 1 >= 0;

        // checks for if adjacent to a symbol
        bool verticalCheck = (jNotLast && isSymbol(line[j + 1])) ||
            (jNotFirst && isSymbol(line[j - 1]));

        bool horizontalCheck = (iNotLast && isSymbol(input[i + 1][j])) ||
            (iNotFirst && isSymbol(input[i - 1][j]));

        bool diagonalCheck =
            (iNotLast && jNotLast && isSymbol(input[i + 1][j + 1])) ||
                (iNotFirst && jNotFirst && isSymbol(input[i - 1][j - 1])) ||
                (iNotLast && jNotFirst && isSymbol(input[i + 1][j - 1])) ||
                (iNotFirst && jNotLast && isSymbol(input[i - 1][j + 1]));

        if (verticalCheck || horizontalCheck || diagonalCheck) {
          final token = lexer.getTokenAtIndex(j);
          print('i: $i, j: $j => ${token?.value} on ${line.join('')}');

          if (token != null) {
            final value = int.parse(token.value);

            // check if the value is already in the output and we are still on the same token
            if (output.isEmpty || output.last != int.parse(token.value)) {
              output.add(value);
            }
          }
        }
      }
    }
  }

  return output;
}

/// A modified Lexer class that returns a token at the specific index.
class Lexer {
  final List<String> input;
  int index = 0;
  Lexer(this.input);

  String get currentChar => input.elementAtOrNull(index) ?? '';

  /// Returns current character and advances to character.
  String advance() {
    String current = currentChar;
    index++;
    return current;
  }

  void reset() {
    index = 0;
  }

  void skipWhitespace() {
    while (currentChar == '.' || currentChar == ' ') {
      advance();
    }
  }

  String getNumber() {
    String result = '';
    while (isNumeric(currentChar)) {
      result += advance();
    }
    return result;
  }

  /// Returns a token at the specific index.
  /// resets the index every time so no need to create a new instance.
  Token? getTokenAtIndex(int i) {
    reset();
    while (index < input.length) {
      if (currentChar == '.' || currentChar == ' ') {
        int startIndex = index;
        skipWhitespace();
        int endIndex = index - 1;
        if (startIndex <= i && i <= endIndex) {
          return null;
        }
        continue;
      }

      if (isNumeric(currentChar)) {
        int startIndex = index;
        final token = Token(TokenType.number, getNumber());
        int endIndex = index - 1;
        // print('$i => startIndex: $startIndex, endIndex: $endIndex');
        if (startIndex <= i && i <= endIndex) {
          return token;
        }
        continue;
      }

      if (isSymbol(currentChar)) {
        if (index == i) {
          return Token(TokenType.symbol, advance());
        }
        advance();
        continue;
      }

      throw Exception(
          'Invalid character: $currentChar at :$index , on line: $input');
    }
    return null;
  }
}

class Token {
  final TokenType type;
  final String value;
  Token(this.type, this.value);

  @override
  String toString() {
    return 'T(${type.name}, $value)';
  }
}

enum TokenType { number, symbol }
