import 'package:logger/logger.dart';

var logger = Logger(printer: PrettyPrinter(printEmojis: true));

void log(d) => logger.d(d);
