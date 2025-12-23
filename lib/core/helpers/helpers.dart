String formatName(String? raw) {
  return raw!
      .replaceAll("_", " ")
      .split(" ")
      .map((word) => word.isEmpty ? "" : word[0].toUpperCase() + word.substring(1).toLowerCase())
      .join(" ");
}
