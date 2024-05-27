int calculateChecksum(List<int> data) {
  if (data.isEmpty) return 0;

  var value = data.first;
  for (var i = 1; i < data.length; i++) {
    value ^= data[i];
  }
  return value;
}

bool validateChecksum(List<int> data, int checksum) {
  return calculateChecksum(data) == checksum;
}
