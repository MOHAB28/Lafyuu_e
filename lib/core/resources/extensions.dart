extension StringValidation on String? {
  bool isEmailValid() => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this!);
  
  bool isPasswordValid() => this!.length >= 6;
}
