class ValidationMixin {
  String? validateID(String? value) {
    if (int.tryParse(value!) == null || int.parse(value) < 1) {
      return 'Invalid ID';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value!.contains(RegExp(r'[0-9]'))) {
      return 'Name cannot contain digits';
    }
    return null;
  }

  String? validateBalance(String? value) {
    if (int.tryParse(value!) == null || int.parse(value) < 0) {
      return 'Check amount to be transferred again';
    }
    return null;
  }
}
