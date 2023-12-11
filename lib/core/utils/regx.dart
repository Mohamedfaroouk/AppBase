class AppRegx {
  AppRegx._internal();
  static final AppRegx _instance = AppRegx._internal();
  factory AppRegx() => _instance;

  RegExp doubleNumRegEx = RegExp(r'(^\d*\.?\d*)');
  RegExp intNumRegEx = RegExp(r'(^\d*)');
  RegExp arabicRegEx = RegExp(r'[\u0600-\u06FF]');
  RegExp phoneRegex =
      RegExp(r"^(?:\966)?(5|50|53|56|54|59|51|58|57)([0-9]{8})$");

  RegExp emailReg = RegExp(
      r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"); // email validation
  //english letter reg
  RegExp englishReg = RegExp(r"^[a-zA-Z]+$");
//email must have one letter a-z regex
}
