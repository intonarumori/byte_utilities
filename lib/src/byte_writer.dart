import 'dart:typed_data';

class ByteWriter {
  //
  final _bytes = BytesBuilder();

  void writeByte(int byte) {
    _bytes.addByte(byte);
  }
}
