class ExceptionExample {
  ExceptionExample({
    required this.url,
  }) : assert(url.isNotEmpty);

  final String url;
}
