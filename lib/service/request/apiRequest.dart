import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weplayball/models/fixture.dart';
import 'package:weplayball/models/fixtureCollection.dart';
import 'package:weplayball/models/instaFav.dart';
import 'package:weplayball/models/result.dart';
import 'package:weplayball/models/resultCollection.dart';
import 'package:weplayball/models/standings.dart';
import 'package:weplayball/models/teamDetails.dart';
import 'package:weplayball/service/response/parsedResponse.dart';


final int NO_INTERNET = 404;
const String baseUrl = "https://weplayball.azurewebsites.net/api/";

abstract class BaseApiRequest {
  Future<ParsedResponse<FixtureCollection>> getFixtures();
  Future<ParsedResponse<ResultCollection>> getResults();
  Future<ParsedResponse<TeamDetailsModel>> getTeamDetails(String teamCode);
  Future<ParsedResponse<List<StandingsModel>>> getTeamStandings();
}

class ApiRequest implements BaseApiRequest {

  /// Fetches fixture data and returns a collection grouped by divisions
  Future<ParsedResponse<FixtureCollection>> getFixtures() async {
    final url = "$baseUrl/fixtures";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = await preferences.get("LastToken");

    //http request, catching error like no internet connection.
    //If no internet is available for example response is
    http.Response response = await http.get(
      url,
      // Send authorization headers to your backend
      headers: {HttpHeaders.authorizationHeader: 'bearer $token'},
    ).catchError((resp) {});

    if (response == null) {
      return new ParsedResponse(NO_INTERNET, new FixtureCollection());
    }

    //If there was an error return an empty list
    if (response.statusCode < 200 || response.statusCode >= 300) {
      return new ParsedResponse(response.statusCode, new FixtureCollection());
    }

    //  https://stackoverflow.com/questions/52886683/getting-type-listdynamic-is-not-a-subtype-of-type-list-error-in-json
    List<FixtureModel> fixtures1 = List<FixtureModel>.from(json.decode(response.body)
    ['firstDivision'].map((i) => FixtureModel.fromJson(i)));

    List<FixtureModel> fixtures2 = List<FixtureModel>.from(json.decode(response.body)
    ['secondDivision'].map((i) => FixtureModel.fromJson(i)));

    List<FixtureModel> fixtures3 = List<FixtureModel>.from(json.decode(response.body)
    ['thirdDivision'].map((i) => FixtureModel.fromJson(i)));


    var timeStamp = DateTime.now();
    //var fixtureCollection = new FixtureCollection(firstDivision: fixtures1, fixtures2, fixtures3, timeStamp);
    var fixtureCollection = FixtureCollection(
        firstDivision: fixtures1,
        secondDivision: fixtures2,
        thirdDivision: fixtures3,
        timeStamp: timeStamp);

    return new ParsedResponse(response.statusCode, fixtureCollection);
  }

  /// Fetches fixture data and retuns a collection grouped by divisions
  Future<ParsedResponse<ResultCollection>> getResults() async {
    final url = "$baseUrl/results";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = await preferences.get("LastToken");

    //http request, catching error like no internet connection.
    //If no internet is available for example response is
    http.Response response = await http.get(
      url,
      // Send authorization headers to your backend
      headers: {HttpHeaders.authorizationHeader: 'bearer $token'},
    ).catchError((resp) {});

    if (response == null) {
      return new ParsedResponse(NO_INTERNET, new ResultCollection());
    }

    //If there was an error return an empty list
    if (response.statusCode < 200 || response.statusCode >= 300) {
      return new ParsedResponse(response.statusCode, new ResultCollection());
    }

    //  https://stackoverflow.com/questions/52886683/getting-type-listdynamic-is-not-a-subtype-of-type-list-error-in-json
    List<ResultModel> matchResults1 = List<ResultModel>.from(json.decode(response.body)
    ['firstDivision'].map((i) => ResultModel.fromJson(i)));

    List<ResultModel> matchResults2 = List<ResultModel>.from(json.decode(response.body)
    ['secondDivision'].map((i) => ResultModel.fromJson(i)));

    List<ResultModel> matchResults3 = List<ResultModel>.from(json.decode(response.body)
    ['thirdDivision'].map((i) => ResultModel.fromJson(i)));

    var timeStamp = DateTime.now();

    var resultCollection = ResultCollection(
        firstDivision: matchResults1,
        secondDivision: matchResults2,
        thirdDivision: matchResults3,
        timeStamp: timeStamp);

    return new ParsedResponse(response.statusCode, resultCollection);
  }

  /// Fetches instagram favorites data and returns a collection
  Future<ParsedResponse<List<InstaFavoriteModel>>> getInstaFavs() async {
    final url = "$baseUrl/Instafavs";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = await preferences.get("LastToken");

    //http request, catching error like no internet connection.
    //If no internet is available for example response is
    http.Response response = await http.get(
      url,
      // Send authorization headers to your backend
      headers: {HttpHeaders.authorizationHeader: 'bearer $token'},
    ).catchError((resp) {});

    if (response == null) {
      return new ParsedResponse(NO_INTERNET, null);
    }

    //If there was an error return an empty list
    if (response.statusCode < 200 || response.statusCode >= 300) {
      return new ParsedResponse(response.statusCode, null);
    }

    var parsed = json.decode(response.body);
    List<InstaFavoriteModel> favorites = List<InstaFavoriteModel>.from(parsed.map((i) => InstaFavoriteModel.fromJson(i)));


    //print("lenght of array is: ${favorites.length}");

    return new ParsedResponse(response.statusCode, favorites);
  }

  /// Fetches instagram favorites data and returns a collection
  Future<ParsedResponse<TeamDetailsModel>> getTeamDetails(String teamCode) async {
    final url = "$baseUrl/teams/$teamCode";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = await preferences.get("LastToken");

    //http request, catching error like no internet connection.
    //If no internet is available for example response is
    http.Response response = await http.get(
      url,
      // Send authorization headers to your backend
      headers: {HttpHeaders.authorizationHeader: 'bearer $token'},
    ).catchError((resp) {});

    if (response == null) {
      return new ParsedResponse(NO_INTERNET, null);
    }

    //If there was an error return an empty list
    if (response.statusCode < 200 || response.statusCode >= 300) {
      return new ParsedResponse(response.statusCode, null);
    }

    var parsed = json.decode(response.body);
    TeamDetailsModel teamDetails = new TeamDetailsModel.fromJson(parsed);


    return new ParsedResponse(response.statusCode, teamDetails);
  }

  Future<ParsedResponse<List<StandingsModel>>> getTeamStandings() async {
    final url = "https://weplayball.azurewebsites.net/results/standings";

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = await preferences.get("LastToken");

    //http request, catching error like no internet connection.
    //If no internet is available for example response is
    http.Response response = await http.get(
      url,
      // Send authorization headers to your backend
      headers: {HttpHeaders.authorizationHeader: 'bearer $token'},
    ).catchError((resp) {});

    if (response == null) {
      return new ParsedResponse(NO_INTERNET, null);
    }

    //If there was an error return an empty list
    if (response.statusCode < 200 || response.statusCode >= 300) {
      return new ParsedResponse(response.statusCode, null);
    }

    var parsed = json.decode(response.body);
    List<StandingsModel> standings = new List<StandingsModel>.from(parsed.map((i) => StandingsModel.fromJson(i)));

    return new ParsedResponse(response.statusCode, standings);
  }
}