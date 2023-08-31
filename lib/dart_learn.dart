import 'dart:io';
import 'dart:math';

void main() {
  // stringCount();
  // int result = factorial(5);
  // print("Factorial of $num is $result");
  String input = "ssSSSsureshss";
  countCharacters(input.toLowerCase());

  List<Map<String, int>> inMax = [
    {"age": 2},
    {"age": 89},
    {"age": 23},
    {"age": 98},
    {"age": 23},
    {"age": 3},
    {"age": 9},
    {"age": 14},
    {"age": 3},
    {"age": 12},
    {"age": 12},
    {"age": 2},
    {"age": 3},
    {"age": 25},
    {"age": 2},
    {"age": 3},
    {"age": 2},
    {"age": 2},
  ];

  inMax.sort((a, b) => a["age"]!.compareTo(b["age"]!));

  for (var map in inMax) {
    print("Age: ${map["age"]}");
  }

}

countCharacters(String input) {
  Map<String, int> charCount = {};
  String finalOutput = "";
  for (int i = 0; i < input.length; i++) {
    String char = input[i];
    charCount[char] = (charCount[char] ?? 0) + 1;
  }
  Map<String, int> charOccurrences = charCount;
  charOccurrences.forEach((char, count) {
    finalOutput += '$char$count ';
  });
  print('$finalOutput');
}

int factorial(int n) {
  // stdout.write("What's your name? ");
  // int n = int.parse(stdin.readLineSync() ?? "");
  if (n == 0 || n == 1) {
    return 1;
  } else {
    return n * factorial(n - 1);
  }
}

askingNameAndAge() {
  stdout.write("What's your name? ");
  String name = stdin.readLineSync() ?? "";

  print("Hi, $name! What is your age?");
  int age = int.parse(stdin.readLineSync() ?? "");

  int yearsToHunderd = 100 - age;
  print("$name, You have $yearsToHunderd years to be 100");
}

askingNumber() {
  stdout.write("write any Number?");
  int number = int.parse(stdin.readLineSync() ?? "");
  if (number % 2 == 0) {
    print("Chosen number is even");
  } else {
    print("Chosen number is odd ");
  }
}

palindrome() {
  // palindrome means a given string is equal to its reverse string
  stdout.write("Please give a word: ");
  String input = "${stdin.readLineSync()?.toLowerCase()}";
  String revInput = input.split('').reversed.join('');

  // Ternary operator
  input == revInput
      ? print("The word is palindrome")
      : print("The word is not a palindrome");
}

showingEvenList() {
  List<int> a = [1, 4, 9, 16, 25, 36, 49, 64, 81, 100];
  List<int> b = [];

  for (int i = 0; i < a.length; i++) {
    if (a[i] % 2 == 0) {
      b.add(a[i]);
    }
  }
  print(b);
  //or
  // int i = 0;
  // print([
  //   for (var e in a)
  //     if (++i % 2 == 0) e
  // ]);
}

guessingGame() {
  final random = Random();
  int randNumber = random.nextInt(100);
  int attempt = 0;
  print("randNumber...$randNumber");
  while (true) {
    attempt += 1;
    stdout.write("Please choose a number between 0 and 100: ");
    String chosenNumber = stdin.readLineSync() ?? "";

    // Make sure user does not go out of limits
    if (chosenNumber.toLowerCase() == "exit") {
      print("\nBye");
      break;
    } else if (int.parse(chosenNumber) > 100) {
      print("Please do not go over 100");
      continue;
    }

    // Main logic
    if (int.parse(chosenNumber) == randNumber) {
      print("Bingo! You tried $randNumber times\n");
      continue;
    } else if (int.parse(chosenNumber) > randNumber) {
      print("You are higher");
      continue;
    } else {
      print("You are lower");
      continue;
    }
  }
}

bool checkStringFormat() {
  stdout.write("provide  a word : ");
  String input = stdin.readLineSync()?.trim() ?? "";
  final letterRegex = RegExp(r'[a-zA-Z]');
  final specialCharRegex = RegExp(r'[!@#\$%^&*()_\-+=<>?/[\]{},.:;]');
  final numberRegex = RegExp(r'[0-9]');

  int letterCount = 0;
  int specialCharCount = 0;
  int numberCount = 0;

  for (int i = 0; i < input.length; i++) {
    String char = input[i];

    if (letterRegex.hasMatch(char)) {
      letterCount++;
    } else if (specialCharRegex.hasMatch(char)) {
      specialCharCount++;
    } else if (numberRegex.hasMatch(char)) {
      numberCount++;
    }
  }
  if (letterCount >= 2 && specialCharCount >= 2 && numberCount >= 2) {
    print("correct password");
  } else {
    print(
        "Password contains at least 2 letters 2 specialCharacters and 2 numbers");
  }

  return letterCount == 2 && specialCharCount == 2 && numberCount == 2;
}

generateRandomString() {
  const letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const specialChars = '!@#\$%^&*()_-+=<>?/[]{},.:;';
  const numbers = '0123456789';

  String getRandomChars(String chars, int length) {
    final rand = Random();
    return String.fromCharCodes(
      List.generate(
          length, (_) => chars.codeUnitAt(rand.nextInt(chars.length))),
    );
  }

  String randomLetters = getRandomChars(letters, 2);
  String randomSpecialChars = getRandomChars(specialChars, 2);
  String randomNumbers = getRandomChars(numbers, 2);
  String randomString = '$randomLetters$randomSpecialChars$randomNumbers';
  print(randomString);
}

stringCount() {
  stdout.write("provide  a word : ");
  String input = stdin.readLineSync()?.trim() ?? "";

  List<String> inputList = input.split("");
  print("inputList is ..$inputList");
  String char = inputList[0];
  String finalString = "";

  int letterCount = 0;

  for (int i = 0; i < inputList.length; i++) {
    if (char == inputList[i]) {
      letterCount++;
    } else {
      finalString += "${letterCount} ${char}";
      letterCount = 0;
      char = input[i];
    }
  }

  print("finalString... $finalString");
}
