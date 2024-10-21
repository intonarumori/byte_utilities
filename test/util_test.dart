import 'package:byte_utilities/src/util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Uint to sample matches sample to uint', () {
    const bitDepths = [8, 16, 24];

    for (final bits in bitDepths) {
      final max = (1 << bits) - 1;

      for (int i = 0; i <= max; i++) {
        final sample = uintToSample(i, bits);
        final result = sampleToUint(sample, bits);
        expect(i, equals(result));
      }
    }
  });

  test('Sample to uint matches uint to sample', () {
    const eps = 1e-12;
    const bitDepths = [8, 16, 24];

    for (final bits in bitDepths) {
      final max = (1 << bits) - 1;
      for (int i = 0; i <= max; i++) {
        final x = 2.0 * i / max - 1.0;
        expect(uintToSample(sampleToUint(x, bits), bits), closeTo(x, eps));
      }
    }
  });
}
