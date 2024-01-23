class Podcast {
  String? title;
  String? host;
  List<String>? contributors;
  int? durationInSeconds;
  String? genre;
  String? podcastUri; // Added property for URI/location
  bool? isFavorite;

  // Constructor
  Podcast({
    required this.title,
    this.host,
    this.contributors,
    this.durationInSeconds,
    this.genre,
    this.podcastUri, // Added parameter for URI/location
    this.isFavorite = false,
  });

  // Helper method to format duration in hh:mm:ss format
  String formatDuration(int seconds) {
    Duration duration = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }
}
