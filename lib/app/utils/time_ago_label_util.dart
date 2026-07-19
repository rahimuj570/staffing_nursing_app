String timeAgoLabel(DateTime dateTime) {
  final now = DateTime.now().toUtc();
  final difference = now.difference(dateTime);

  if (difference.inMinutes < 1) {
    return "Just now";
  } else if (difference.inMinutes < 60) {
    return "${difference.inMinutes} minutes ago";
  } else if (difference.inHours < 24) {
    return "${difference.inHours} hours ago";
  } else if (difference.inDays == 1) {
    return "Yesterday";
  } else if (difference.inDays < 30) {
    return "${difference.inDays} days ago";
  } else if (difference.inDays < 365) {
    final months = (difference.inDays / 30).floor();
    return "$months month${months > 1 ? 's' : ''} ago";
  } else {
    final years = (difference.inDays / 365).floor();
    return "$years year${years > 1 ? 's' : ''} ago";
  }
}
