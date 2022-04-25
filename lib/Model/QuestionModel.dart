// ignore: file_names
class Question {
  late String question;
  late String answer1;
  late String answer2;
  late int trueAnswer;
  late String imageAddress;

  Question(this.question, this.answer1, this.answer2, this.trueAnswer,
      this.imageAddress);
  bool isRight(int num) {
    if (num == 1 || num == 2) {
      if (trueAnswer == 1) {
        if (num == 1) {
          return true;
        } else {
          return false;
        }
      } else {
        if (num == 2) {
          return true;
        } else {
          return false;
        }
      }
    } else {
      print('error');
      return false;
    }
  }
}

List<Question> questionList = [
  Question(
      "What is your favorite pet?", "Dog", "Cup", 1, "assets/Images/pet3.png"),
  Question("If you were president, what was the first thing you did? ", "War",
      "Peace", 2, "assets/Images/president.png"),
  Question("What is my job? ", "Developer", "The pilot", 1,
      "assets/Images/Developer.png"),
  Question("Is the color of this bag blue? ", "Yes", "No", 1,
      "assets/Images/back-to-school.png"),
  Question("Do you have a goal that you are disappointed to achieve? ", "Yes",
      "No", 2, "assets/Images/Disappointed.png"),
  Question("Do you think I'm arrogant or kind? ", "arrogant", "kind", 1,
      "assets/Images/arrogant.png"),
  Question("Would you like to be invisible forever but no one can hear you? ",
      "Yes", "No", 1, "assets/Images/invisible.png"),
  Question(
      "If I give you my Instagram page password, will you read my direct? ",
      "Yes",
      "No",
      1,
      "assets/Images/instagram.png"),
  Question(
      "Do you think I will help you if you have a problem one day or not? ",
      "Yes",
      "No",
      1,
      "assets/Images/Problem.png"),
  Question("Is the color of this bag blue? ", "Yes", "asdas", 1,
      "assets/Images/back-to-school.png"),
];
