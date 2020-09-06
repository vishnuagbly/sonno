import 'package:sonno/data/faqs.dart';

class QuestionObj {
  QuestionObj.raw(this.question, this.answer);

  factory QuestionObj.fromMap(Map<String, String> map){
    return QuestionObj.raw(map["question"], map['answer']);
  }

  final String question;
  final String answer;

  static List<QuestionObj> fromMaps(List<Map<String, String>> maps) {
    List<QuestionObj> res = [];
    for(var map in maps)
      res.add(QuestionObj.fromMap(map));
    return res;
  }
}

class Questions {
  static List<QuestionObj> _all;
  static List<QuestionObj> get all {
    if(_all == null || _all.length == 0){
      _all = QuestionObj.fromMaps(allQuestions['questions']);
    }
    return _all;
  }
}