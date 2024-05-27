import 'dart:typed_data';

import 'package:byte_utilities/src/byte_logging.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adds one to input values', () {
    Uint8List data = Uint8List.fromList(List.generate(100, (index) => index));

    final string = ByteLogging.toHexString(data);
    expect(string,
        '00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F 10 11 12 13 14 15 16 17 18 19 1A 1B 1C 1D 1E 1F 20 21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 63');
  });

  test('Hex columns', () {
    Uint8List data = Uint8List.fromList(List.generate(100, (index) => index));

    final string = ByteLogging.toHexString(data, columns: 8);
    expect(string, '''
00 01 02 03 04 05 06 07
08 09 0A 0B 0C 0D 0E 0F
10 11 12 13 14 15 16 17
18 19 1A 1B 1C 1D 1E 1F
20 21 22 23 24 25 26 27
28 29 2A 2B 2C 2D 2E 2F
30 31 32 33 34 35 36 37
38 39 3A 3B 3C 3D 3E 3F
40 41 42 43 44 45 46 47
48 49 4A 4B 4C 4D 4E 4F
50 51 52 53 54 55 56 57
58 59 5A 5B 5C 5D 5E 5F
60 61 62 63
''');
  });

  test('Hex columns with header', () {
    Uint8List data = Uint8List.fromList(List.generate(100, (index) => index));

    final string = ByteLogging.toHexString(data, columns: 8, header: true);
    expect(string, '''
   0 | 00 01 02 03 04 05 06 07
   1 | 08 09 0A 0B 0C 0D 0E 0F
   2 | 10 11 12 13 14 15 16 17
   3 | 18 19 1A 1B 1C 1D 1E 1F
   4 | 20 21 22 23 24 25 26 27
   5 | 28 29 2A 2B 2C 2D 2E 2F
   6 | 30 31 32 33 34 35 36 37
   7 | 38 39 3A 3B 3C 3D 3E 3F
   8 | 40 41 42 43 44 45 46 47
   9 | 48 49 4A 4B 4C 4D 4E 4F
  10 | 50 51 52 53 54 55 56 57
  11 | 58 59 5A 5B 5C 5D 5E 5F
  12 | 60 61 62 63
''');
  });
}
