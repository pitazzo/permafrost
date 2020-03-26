String dateToString(DateTime date) {
  return date.day.toString().padLeft(2, '0') +
      '/' +
      date.month.toString().padLeft(2, '0') +
      '/' +
      date.year.toString();
}

String amountToString(double amount, String units) {
  String output = amount.truncate() == amount
      ? amount.truncate().toString()
      : amount.toStringAsFixed(1);
  output += ' ' + units;
  return output;
}
