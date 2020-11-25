import 'package:flutter/material.dart';
import 'package:SportsInfo/models/sports_model.dart';
import 'package:flutter/foundation.dart';
import 'package:SportsInfo/models/sports_league_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:SportsInfo/constants/api_list.dart';

class SportsProvider extends ChangeNotifier {
  List<SportsModel> _sportsmodel;
  List<SportsModel> get listsportsmodel => _sportsmodel;
  set listsportsmodel(List<SportsModel> val) {
    _sportsmodel = val;
    notifyListeners();
  }

  String _name="Soccer";
  String get sportName => _name;
  set sportName(String val) {
    _name = val;
    notifyListeners();
  }

  Future<List<SportsModel>> fetchsports() async {
    final response = await http
        .get('https://www.thesportsdb.com/api/v1/json/1/all_sports.php');

    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> res = map["sports"];
    List<SportsModel> data = [];

    for (var i = 0; i < res.length; i++) {
      var sportsmodel = SportsModel.fromJson(res[i]);
      data.add(sportsmodel);
    }
    listsportsmodel = data;
    return listsportsmodel;
  }

  Future<SportsLeague> getsportsleaguecountry(String name) async {
    var sportsLeague = null;
    var client = http.Client();
    print(APILIST.sports_league_url+name);
    try {
      var response = await client.get(APILIST.sports_league_url+name);
      //if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonmap = json.decode(jsonString);
        sportsLeague = SportsLeague.fromJson(jsonmap);
      //}
    } catch (Exception) {
      return sportsLeague;
    }
    return sportsLeague;
  }
}
