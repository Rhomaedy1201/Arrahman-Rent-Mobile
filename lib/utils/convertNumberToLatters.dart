import 'package:intl/intl.dart';

class ConvertNumberToLatters {
  String numberToLetters(int number) {
    final formatter = NumberFormat('#');
    final String formattedNumber = formatter.format(number);
    final List<String> units = [
      '',
      'satu',
      'dua',
      'tiga',
      'empat',
      'lima',
      'enam',
      'tujuh',
      'delapan',
      'sembilan'
    ];
    final List<String> tens = [
      '',
      'sepuluh',
      'dua puluh',
      'tiga puluh',
      'empat puluh',
      'lima puluh',
      'enam puluh',
      'tujuh puluh',
      'delapan puluh',
      'sembilan puluh'
    ];
    final List<String> teens = [
      'sepuluh',
      'sebelas',
      'dua belas',
      'tiga belas',
      'empat belas',
      'lima belas',
      'enam belas',
      'tujuh belas',
      'delapan belas',
      'sembilan belas',
    ];
    final List<String> places = [
      '',
      'ribu',
      'juta',
      'miliar',
      'triliun',
      'milion lipat empat',
      'triliun'
    ];

    if (number == 0) {
      return 'nol';
    }

    String convertChunk(int chunk) {
      final List<String> chunkParts = [];
      final int hundredsDigit = chunk ~/ 100;
      final int tensDigit = (chunk % 100) ~/ 10;
      final int unitsDigit = chunk % 10;

      if (hundredsDigit > 0) {
        chunkParts.add('${units[hundredsDigit]} ratus');
      }

      if (tensDigit > 0) {
        if (tensDigit == 1 && unitsDigit > 0) {
          chunkParts.add(teens[unitsDigit]);
        } else {
          chunkParts.add(tens[tensDigit]);
          if (unitsDigit > 0) {
            chunkParts.add(units[unitsDigit]);
          }
        }
      } else if (unitsDigit > 0) {
        chunkParts.add(units[unitsDigit]);
      }

      return chunkParts.join(' ');
    }

    final String numberStr =
        formattedNumber.padLeft(3 * ((formattedNumber.length + 2) ~/ 3), '0');
    final List<String> chunks = [];
    for (int i = 0; i < numberStr.length; i += 3) {
      chunks.add(convertChunk(int.parse(numberStr.substring(i, i + 3))));
    }

    final List<String> convertedParts = [];
    for (int i = 0; i < chunks.length; i++) {
      if (chunks[i] != '') {
        convertedParts.add('${chunks[i]} ${places[chunks.length - 1 - i]}');
      }
    }

    return convertedParts.join(', ');
  }
}
