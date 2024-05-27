import 'dart:math';

class ByteLogging {
  static String toHexString(List<int> bytes, {int columns = 0, bool header = false}) {
    if (columns == 0) {
      return bytes.map((e) => e.toRadixString(16).padLeft(2, '0').toUpperCase()).join(' ');
    } else {
      int position = 0;
      int row = 0;
      final buffer = StringBuffer();
      while (position < bytes.length) {
        final len = min(bytes.length - position, columns);
        final chunk = bytes.sublist(position, position + len);
        if (header) {
          buffer.write(row.toRadixString(10).padLeft(4, ' '));
          buffer.write(' | ');
        }
        buffer.write(toHexString(chunk));
        buffer.write('\n');

        row += 1;
        position += columns;
      }
      return buffer.toString();
    }
  }

  static String toHexList(List<int> data) {
    return '[${data.map((e) => '0x${e.toRadixString(16).padLeft(2, '0').toUpperCase()}').join(', ')}]';
  }
}
