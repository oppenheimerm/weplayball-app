import 'package:weplayball/models/fixture.dart';

class FixtureCollection {
  final List<FixtureModel>firstDivision;
  final List<FixtureModel>secondDivision;
  final List<FixtureModel>thirdDivision;
  final DateTime timeStamp;

  FixtureCollection({
    this.firstDivision,
    this.secondDivision,
    this.thirdDivision,
    this.timeStamp
  });
}