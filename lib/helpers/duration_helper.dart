extension DurationHelper on Duration {
  String toFormatString() {
    var seconds = inSeconds;
    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final List<String> tokens = [];
    if (tokens.isNotEmpty || hours != 0) {
      tokens.add(hours.toString());
    }
    tokens.add(minutes.toString().padLeft(2, '0'));

    tokens.add(seconds.toString().padLeft(2, '0'));

    return tokens.join(':');
  }
}
