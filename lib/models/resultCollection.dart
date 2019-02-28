import 'package:weplayball/models/result.dart';

class ResultCollection {
  final List<ResultModel>firstDivision;
  final List<ResultModel>secondDivision;
  final List<ResultModel>thirdDivision;
  final DateTime timeStamp;

  ResultCollection({
    this.firstDivision,
    this.secondDivision,
    this.thirdDivision,
    this.timeStamp
  });
}