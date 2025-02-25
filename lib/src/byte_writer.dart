import 'dart:typed_data';

class ByteWriter {
  final Endian _endian;
  final _bytes = BytesBuilder();

  ByteWriter([Endian endian = Endian.big]) : _endian = endian;

  void writeBytes(Uint8List bytes) => _bytes.add(bytes);
  void _writeBytes(ByteData b, int n) => _bytes.add(b.buffer.asUint8List(0, n));

  static final _fbuf = ByteData(8);

  void writeFloat32(double x) => _writeBytes(_fbuf..setFloat32(0, x, _endian), 4);
  void writeFloat64(double x) => _writeBytes(_fbuf..setFloat64(0, x, _endian), 8);

  void writeInt8(int x) => _writeBytes(_fbuf..setInt8(0, x), 1);
  void writeUint8(int x) => _writeBytes(_fbuf..setUint8(0, x), 1);
  void writeUint16(int x) => _writeBytes(_fbuf..setUint16(0, x, _endian), 2);
  void writeUint32(int x) => _writeBytes(_fbuf..setUint32(0, x, _endian), 4);
  void writeUint64(int x) => _writeBytes(_fbuf..setUint64(0, x, _endian), 8);

  void writeInt16(int x) => _writeBytes(_fbuf..setInt16(0, x, _endian), 2);
  void writeInt32(int x) => _writeBytes(_fbuf..setInt32(0, x, _endian), 4);
  void writeInt64(int x) => _writeBytes(_fbuf..setInt64(0, x, _endian), 8);

  // TODO: does endianness matter here?
  void writeString(String s) => s.codeUnits.map((c) => _bytes.addByte(c));

  Uint8List toBytes() => _bytes.toBytes();
}
