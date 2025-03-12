// import 'package:dart_prototype/src/typesense.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:dart_dotenv/dart_dotenv.dart';

void main() async {
  final dotEnv = DotEnv(filePath: '../.env');
  print('.env value of "someSpecificKey" ? - ${dotEnv.get("TYPESENSE_SEARCH_KEY")}');
  print("Hello world");
}
