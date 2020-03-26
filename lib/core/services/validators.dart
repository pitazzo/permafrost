class FormValidators {
  static String lengthValidator(value) {
    if (value.trim().length < 3) {
      return 'Nombre demasiado corto';
    } else {
      return null;
    }
  }

  static String doubleAmountValidator(value) {
    if (value.trim().length < 1) {
      return 'Especifica una cantidad';
    } else {
      try {
        double.parse(value);
        return null;
      } catch (e) {
        return 'La cantidad debe ser un número';
      }
    }
  }

  static String intAmountValidator(value) {
    if (value.trim().length < 1) {
      return 'Especifica una cantidad';
    } else {
      try {
        int.parse(value);
        return null;
      } catch (e) {
        return 'La cantidad debe ser un número entero';
      }
    }
  }
}
