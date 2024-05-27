class ByteReader {
  final List<int> _bytes;
  int _position = 0;

  ByteReader(List<int> bytes) : _bytes = bytes;

  void skip(int count) {
    _position += count;
  }

  int readByte() {
    final value = _bytes[_position];
    _position += 1;
    return value;
  }

  bool get isAtEnd => _position == _bytes.length;
}

extension AkaiByteReader on ByteReader {
  int readSW() {
    // Based on: AkaiS900SysExSpec.pdf -> SW type
    // K-excess offset binary: K = 2^(12-1)
    // https://en.wikipedia.org/wiki/Offset_binary
    return ((readByte() & 0x7F) << 5 | (readByte() >> 2) & 0x1F) - 0x800;
  }
}
