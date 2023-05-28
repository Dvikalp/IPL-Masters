import 'dart:convert';
import 'package:http/http.dart'as http;

class Prediction{
  double? lose;
  double? win;

  Prediction({
    double? lose,
    double? win,
  });

  Prediction.fromJson(Map json){
    lose=json["lose"];
    win=json["win"];
  }

}

class PredictionApi{
  Future<Prediction>? getPrediction(String? battingTeam,String? bowlingTeam,String? city,int? runsLeft,int? ballsLeft,int? wicket,int? totalRuns)async{
    double crr=6*(totalRuns!-runsLeft!)/(120-ballsLeft!);
    double rrr=6*(runsLeft)/ballsLeft;
    final url=Uri.parse('http://127.0.0.1:8000/ipl_prediction');
    final inputData={
      "Batting_team": battingTeam,
      "Bowling_team": bowlingTeam,
      "City": city,
      "Runs_left": runsLeft,
      "Balls_left": ballsLeft,
      "Wicket": wicket,
      "Total_runs": totalRuns,
      "Crr": crr,
      "Rrr":rrr,
    };
    print("Sending request ${inputData}");
    final response= await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'server':'uvicorn',
      },
      body: jsonEncode({
        "Batting_team": battingTeam,
        "Bowling_team": bowlingTeam,
        "City": city,
        "Runs_left": runsLeft,
        "Balls_left": ballsLeft,
        "Wicket": wicket,
        "Total_runs": totalRuns,
        "Crr": crr,
        "Rrr":rrr,
      }),
    );
    Map data= jsonDecode(response.body);
    return Prediction.fromJson(data);
  }
}