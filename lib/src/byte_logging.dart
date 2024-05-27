class ByteLogging {
  static String toHexString(List<int> bytes) {
    return bytes.map((e) => e.toRadixString(16).padLeft(2, '0').toUpperCase()).join(' ');
  }

  static String toHexList(List<int> data) {
    return '[${data.map((e) => '0x${e.toRadixString(16).padLeft(2, '0').toUpperCase()}').join(', ')}]';
  }
}
