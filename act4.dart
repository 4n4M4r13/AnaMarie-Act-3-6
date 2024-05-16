import 'dart:convert';
import 'dart:io';
import 'dart:async';

void main() {
  fetchChuckNorrisFact().then((fact) {
    print('Chuck Norris Fact:');
    print(fact);
  }).catchError((error) {
    print('Error fetching Chuck Norris fact: $error');
  });
}

Future<String> fetchChuckNorrisFact() async {
  final String apiUrl = 'https://youtube138.p.rapidapi.com/auto-complete/';

  HttpClient httpClient = HttpClient();

  try {
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(apiUrl));
    HttpClientResponse response = await request.close();

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }

    String responseBody = await response.transform(utf8.decoder).join();
    Map<String, dynamic> jsonData = json.decode(responseBody);

    httpClient.close();

    return jsonData['value'];
  } catch (error) {
    httpClient.close();
    throw Exception('Failed to fetch data: $error');
  }
}
