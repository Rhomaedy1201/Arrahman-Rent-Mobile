import 'package:intl/intl.dart';

class ConvertOriginalDate {
  String dateFormat(String tanggal) {
    // convert to original date
    final inputFormat = DateFormat('yyyy-MM-dd');
    final outputFormat = DateFormat('dd/MM/yyyy');
    final dateTime = inputFormat.parseStrict(tanggal);
    // String originalDate = outputFormat.format(dateTime);
    return outputFormat.format(dateTime);
  }

  String dateFormatNameMont(String tanggal) {
    // convert to original date
    final inputFormat = DateFormat('yyyy-MM-dd');
    final outputFormat = DateFormat('dd MMMM yyyy');
    final dateTime = inputFormat.parseStrict(tanggal);
    return outputFormat.format(dateTime);
  }
}
