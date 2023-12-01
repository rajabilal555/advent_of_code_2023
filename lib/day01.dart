//? Because overlapping is possible, we need to make sure that after replacing the words we add the same letters again.
//? For example, if we have the `eightwothree`, we make sure that the `eight` and `two` both can be recognized and replaced,
//? by adding the number and also keeping the words too.
Map<String, String> numbersMap = {
  'one': 'one1one',
  'two': 'two2two',
  'three': 'three3three',
  'four': 'four4four',
  'five': 'five5five',
  'six': 'six6six',
  'seven': 'seven7seven',
  'eight': 'eight8eight',
  'nine': 'nine9nine',
};

String wordToNumberConverter(String input) {
  String output = input;
  for (var num in numbersMap.entries) {
    output = output.replaceAll(num.key, num.value);
  }
  return output;
}

String convertCalibrationLine(String input) {
  final numbers =
      input.replaceAll(RegExp(r'[a-zA-Z]'), ''); // Get the numbers only

  String first = numbers.substring(0, 1);
  String last = first;
  if (numbers.length > 1) {
    last = numbers.substring(numbers.length - 1);
  }

  int digits = int.parse('$first$last');
  return digits.toString();
}

int wordedSumCalibrations(List<String> lines) =>
    sumCalibrations(lines.map(wordToNumberConverter).toList());

int sumCalibrations(List<String> lines) {
  int sum = 0;
  for (var line in lines) {
    sum += int.parse(convertCalibrationLine(line));
  }
  return sum;
}
