import 'dart:typed_data';

class ByteReader {
  final Endian _endian;
  final Uint8List _bytes;
  
  int _position = 0;


  ByteReader(Uint8List bytes, [endian = Endian.big])
      : _bytes = bytes,
        _endian = endian;

  void skip(int count) {
    _position += count;
    if (_position > _bytes.length) {
      throw const FormatException('End of bytes reached');
    }
  }

  void reset() {
    _position = 0;
  }

  int get remainingData => _bytes.length - _position;

  int readByte() {
    final value = _bytes[_position];
    _position += 1;
    return value;
  }

  ByteData _read(int n) {
    final p0 = _position;
    skip(n);
    return ByteData.sublistView(_bytes, p0, _position);
  }

  int readUint8() => _read(1).getUint8(0);
  int readUint16() => _read(2).getUint16(0, _endian);
  int readUint24() => _endian == Endian.little
      ? readUint8() + 0x100 * readUint16()
      : readUint16() + 0x100 * readUint8();
  int readUint32() => _read(4).getUint32(0, _endian);

  int readInt16() => _read(2).getInt16(0, _endian);
  int readInt32() => _read(4).getInt32(0, _endian);

  double readFloat32() => _read(4).getFloat32(0, _endian);
  double readFloat64() => _read(8).getFloat64(0, _endian);

  int readSigned16BitInt() {
    final index = _position;

    // Make sure there are enough bytes in the list
    if (index < 0 || index + 1 >= _bytes.length) {
      throw RangeError('Index out of bounds');
    }

    skip(2);

    // Combine the two bytes into a 16-bit integer
    int combinedValue = _bytes[index + 1] << 8 | _bytes[index];
    // Interpret the 16-bit integer as a signed value
    return (combinedValue & 0x8000) != 0 ? combinedValue - 0x10000 : combinedValue;
  }

  Uint8List readBytes(int length) => Uint8List.sublistView(_read(length));

  String readString(int length) => String.fromCharCodes(Uint8List.sublistView(_read(length)));

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
