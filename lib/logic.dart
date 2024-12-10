class CalculatorLogic {
  static double evaluateExpression(String expression) {
    try {
      // Hisoblash logikasi
      List<String> tokens = expression.split(RegExp(r'([+\-])')); // Raqamlarni ajratish
      List<String> operators = expression.split(RegExp(r'[^+\-]')).where((e) => e.isNotEmpty).toList();

      double result = double.parse(tokens[0]);

      for (int i = 0; i < operators.length; i++) {
        String operator = operators[i];
        double nextNumber = double.parse(tokens[i + 1]);

        if (operator == '+') {
          result += nextNumber;
        } else if (operator == '-') {
          result -= nextNumber;
        }
      }

      return result;
    } catch (e) {
      throw Exception('Invalid Expression');
    }
  }
}
