class UtilServices {
  static bool validateRegistration(
      String username, String email, String password, String prePassword) {
    return username.isNotEmpty &&
        email.length >= 6 &&
        password.isNotEmpty &&
        password == prePassword;
  }

  static bool validateSingIn(String email, String password) {
    return email.length >= 6 && password.length >= 4;
  }

  String formatDateTime(String dateTimeString) {
    DateTime parsedDateTime = DateTime.parse(dateTimeString).toLocal();
    String formattedDateTime =
        "${parsedDateTime.year}-${parsedDateTime.month.toString().padLeft(2, '0')}-${parsedDateTime.day.toString().padLeft(2, '0')} "
        "\t${parsedDateTime.hour.toString().padLeft(2, '0')}:${parsedDateTime.minute.toString().padLeft(2, '0')} da";

    return formattedDateTime;
  }

  String formatDateHistory(String dateTimeString) {
    DateTime parsedDateTime = DateTime.parse(dateTimeString).toLocal();
    String formattedDateTime =
        "${parsedDateTime.year}-${parsedDateTime.month.toString().padLeft(2, '0')}-${parsedDateTime.day.toString().padLeft(2, '0')} ";
    return formattedDateTime;
  }
}
