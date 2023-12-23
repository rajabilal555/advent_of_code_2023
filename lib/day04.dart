import 'package:advent_of_code_2023/common/helpers.dart';

class ScratchCard {
  final int id;
  final List<int> haveNumbers;
  final List<int> winningNumbers;

  ScratchCard(this.id, this.haveNumbers, this.winningNumbers);

  /// parses a string into a [ScratchCard]
  ///
  /// example input: 'Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53'
  factory ScratchCard.parse(String input) {
    final cardSplit = input.split(':');
    final id = int.parse(cardSplit.first.split(' ').last);

    final numbersSplit = cardSplit[1].split('|');

    final winningNumbers = numbersSplit[0]
        .trim()
        .split(' ')
        .removeEmpty() // from CustomIterables extension in helpers
        .map(int.parse)
        .toList();

    final haveNumbers = numbersSplit[1]
        .trim()
        .split(' ')
        .removeEmpty() //
        .map(int.parse)
        .toList();

    return ScratchCard(id, haveNumbers, winningNumbers);
  }

  /// returns the number of matches between [haveNumbers] and [winningNumbers]
  int get matches {
    var matches = 0;
    for (final number in haveNumbers) {
      if (winningNumbers.contains(number)) {
        matches += 1;
      }
    }
    return matches;
  }

  /// returns the points for this card (Part 01)
  int get points {
    var points = 0;
    for (final number in haveNumbers) {
      if (winningNumbers.contains(number)) {
        //? 1 point for first match. Then double the points for each match.
        if (points >= 1) {
          points = points * 2;
        } else {
          points = 1;
        }
      }
    }
    return points;
  }

  @override
  String toString() {
    return 'ScratchCard{id: $id, haveNumbers: $haveNumbers, winningNumbers: $winningNumbers}';
  }
}

/// returns the total scratch cards. After calulating the copies from the winning cards
int totalScratchCards(List<ScratchCard> cards) {
  /// key is the card id, value is the number of copies we have.
  /// Note: this does not include the original card
  Map<int, int> copyData = {};
  int totalCards = 0;

  for (final card in cards) {
    totalCards += 1; // add the original card

    for (var i = 0; i < copyData.getOrZero(card.id) + 1; i++) {
      final copies =
          getWinningCopies(card); // get the copies won from this card
      for (var copy in copies) {
        // add the copies to the copyData map
        copyData[copy] = copyData.getOrZero(copy) + 1;
      }
      totalCards += copies.length; // add the copies count to the totalCards
    }
  }

  return totalCards;
}

/// returns the card ids of the cards that will be copied
List<int> getWinningCopies(ScratchCard card) {
  final copies = <int>[];
  for (var i = 1; i <= card.matches; i++) {
    copies.add(card.id + i);
  }
  return copies;
}
