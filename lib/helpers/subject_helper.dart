class SubjectHelper {
  static double percentage({int presentClasses,int totalClasses}) {
    if (totalClasses == 0) {
      return 0;
    }
    var percentage = (presentClasses / totalClasses) * 100;
    return percentage;
  }

  static String status({int presentClasses,int totalClasses,int goalPercentage}) {
    if (totalClasses <= 0) {
      return '';
    }
    double days;
    double truncateDays;
    String message;
    var percentage = (presentClasses / totalClasses) * 100;
    if (percentage <= goalPercentage) {
      days = ((goalPercentage * totalClasses) - (100 * presentClasses)) / (100 - goalPercentage);
      truncateDays = ((days * 1).truncateToDouble() / 1) + 1;
      if (truncateDays == 1) {
        return 'Attent next class to get back on track';
      }
      message = 'Attent next ${truncateDays.toStringAsFixed(0)} classes to get back on track';
    } else {
      days = ((100 * presentClasses) - (goalPercentage * totalClasses)) / goalPercentage;
      truncateDays = (days * 1).truncateToDouble() / 1;
      if (truncateDays == 1) {
        return 'You may leave the next class';
      }
      message = 'You may leave the next ${truncateDays.toStringAsFixed(0)} classes';
    }
    if (truncateDays == 0) {
      return 'You can\'t miss the next class';
    }
    return message;
  }

  static bool isSafe({int presentClasses,int totalClasses,int goalPercentage}) {
    if ((presentClasses / totalClasses) * 100 >= goalPercentage) {
      return true;
    } else {
      return false;
    }
  }
}
