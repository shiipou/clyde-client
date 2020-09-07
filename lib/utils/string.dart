var rxUrl = RegExp(
    "^(http|https|ws):\\/\\/\\/?([A-Za-z0-9\\.])+(\\.[A-Za-z0-9]*)?(:[0-9]*)?\$",
    caseSensitive: false);

bool validateUrl(String url) {
  return rxUrl.hasMatch(url);
}
