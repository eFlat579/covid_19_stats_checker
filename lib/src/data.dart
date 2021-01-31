import 'dart:convert';
import 'package:http/http.dart' as http;

/*
  A class which grabs the data by postcode/areacode.
  Gets the data from the goverment website and then traverses the json to update the values.
*/
class DataByPostcode {
  /// The location on which to base data
  final String areacode;

  DateTime date;

  /// The na e of the area
  String areaName;

  /// New cases in the given area
  int newLocalCases;

  /// Overall cases in the given area
  int overallLocalCases;

  /// New deaths in the given area
  int newLocalDeaths;

  /// Overall deaths in the given area
  int overallLocalDeaths;

  /// Collating the cumulative cases data nicely so it can be presented in a graph
  Map<String, double> cumCasesGraphData;

  /// Collating the new cases data nicely so it can be presented in a graph
  Map<String, double> newCasesGraphData;

  DataByPostcode(this.areacode);

  /// Fetch the data from the data store.
  void updateData() async {
    List<dynamic> data = await fetchData();
    //print(data);
    Map<String, dynamic> dataToday = data[0];

    // Traverse the json data to get the data.
    areaName = dataToday['areaName'];
    date = DateTime.parse(dataToday['date']);
    newLocalCases = dataToday['newCasesBySpecimenDate'];
    overallLocalCases = dataToday['cumCasesBySpecimenDate'];
    newLocalDeaths = dataToday['newDeathsByDeathDate'];
    overallLocalDeaths = dataToday['cumDeathsByDeathDate'];
    newCasesGraphData = Map<String, double>();
    cumCasesGraphData = Map<String, double>();

    // Put the graph data nicely into the Maps
    for (Map<String, dynamic> entry in data) {
      String date = entry['date'];
      double casesRate =
          double.parse(entry['cumCasesBySpecimenDateRate'].toString());
      cumCasesGraphData[date] = casesRate;

      double newCases =
          double.parse(entry['newCasesBySpecimenDate'].toString());
      newCasesGraphData[date] = newCases;
    }
  }

  /// Fetches the data from the goverment website.
  Future<List<dynamic>> fetchData() async {
    var url = 'https://api.coronavirus.data.gov.uk/v1/data?' +
        'filters=areaType=ltla;areaCode=$areacode&structure={"date":"date",' +
        '"areaName":"areaName","areaCode":"areaCode","newCasesBySpecimenDate":' +
        '"newCasesBySpecimenDate","cumCasesBySpecimenDate":"cumCasesBySpecimenDate"' +
        ',"newDeathsByDeathDate":"newDeathsByDeathDate","cumDeathsByDeathDate":"cumDeathsByDeathDate",' +
        '"cumCasesBySpecimenDateRate":"cumCasesBySpecimenDateRate"}';

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);

    Map<String, dynamic> json = jsonDecode(response.body);
    return json['data'];
  }
}
