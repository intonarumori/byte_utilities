import 'package:byte_utilities/byte_utilities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test', () {
    for (int i = -1000; i < 1000; i += 100) {
      final writer = ByteWriter();
      writer.writeInt16(i);

      final data = writer.toBytes();

      final reader1 = ByteReader(data);
      final v1 = reader1.readSigned16BitInt();
      final reader2 = ByteReader(data);
      final v2 = reader2.readInt16();

      print('V $i $v1 $v2');
    }
  });
}
