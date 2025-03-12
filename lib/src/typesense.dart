import 'dart:io';
import 'package:typesense/typesense.dart';

void main() async {
  print("Attempting typesense");
  await typesense();
}

Future<void> typesense() async {
  // Replace with your configuration
  final host = "velwu7fhs6c8bajqp-1.a1.typesense.net",
      protocol = Protocol.https;
  final config = Configuration(
    // Api key
    "",
    nodes: {
      Node(
        protocol,
        host,
        port: 443,
      )
    },
    numRetries: 3, // A total of 4 tries (1 original try + 3 retries)
    connectionTimeout: const Duration(seconds: 2),
  );

  final client = Client(config);

  final searchParameters = {
    'q': 'commercial',
    'query_by': 'name,description',
    'filter_by': '',
    'sort_by': '',

  };

  try {
    var response = await client
        .collection('service_categories')
        .documents
        .search(searchParameters);
    var results = response['hits'].map((e) => e['document']).toList();
    print(results);
    // final jsonResponse = json.encode(response['hits'][0]['document']);
    // final file = File('typesense_response.json');
    // await file.writeAsString(jsonResponse);
    // print('Response written to typesense_response.json');
    exit(0);
  } catch (e) {
    print("Error: $e");
    exit(1);
  }
}
