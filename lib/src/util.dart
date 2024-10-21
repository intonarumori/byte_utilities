/// Returns the closest number to [x] in the range [min, max].
int clamp(int x, [int min = 0, int max = 0]) => x < min
    ? min
    : x > max
        ? max
        : x;

/// Shifts int [x] of bit width [bits] up by half the total range, then wraps
/// any overflowing values around to maintain the bit width. This is used to
/// convert between signed and unsigned PCM.
int fold(int x, int bits) => (x + (1 << (bits - 1))) % (1 << bits);

/// Rounds [x] up to the nearest even number.
int roundUpToEven(int x) => x + (x % 2);

/// Calculates the half of the total range of a signed PCM value with [bits] as a double.
double _writeScale(int bits) => (1 << (bits - 1)) * 1.0;

///
double _readScale(int bits) => _writeScale(bits) - 0.5;

/// Converts an audio sample [x] in the range [-1, 1] to an unsigned integer of
/// bit width [bits].
int sampleToUint(double x, int bits) =>
    clamp(((x + 1) * _writeScale(bits)).floor(), 0, (1 << bits) - 1);

/// Converts an unsigned int [x] of bit width [bits] to an audio sample in the range
/// [-1, 1].
double uintToSample(int x, int bits) => (x / _readScale(bits)) - 1;
