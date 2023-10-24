class SocialMediaPost {
  String username;
  String content;
  DateTime timestamp;
  String timeAgo = 'void';

  SocialMediaPost(this.username, this.content, this.timestamp) {
    timeAgo = formatTimeAgo(timestamp);
  }

  String formatTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = time.isBefore(now) ? now.difference(time) : Duration();

    if (difference.inMinutes < 60) {
      return 'Posted ${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      final remainingMinutes = difference.inMinutes % 60;
      final hoursDecimal = hours + (remainingMinutes / 60);
      return 'Posted ${hoursDecimal.toStringAsFixed(1)}h ago';
    } else {
      final days = difference.inDays;
      final remainingHours = difference.inHours % 24;
      final daysDecimal = days + (remainingHours / 24);
      return 'Posted ${daysDecimal.toStringAsFixed(1)}d ago';
    }
  }

}