import 'package:ipl_master/common/widgets/custom_button.dart';
import 'package:ipl_master/common/widgets/custom_textfield.dart';
import 'package:ipl_master/constants/global_variable.dart';
import 'package:ipl_master/features/home/services/fast_api.dart';
import 'package:ipl_master/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName='/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _batting_teams = [
    'Sunrisers Hyderabad',
    'Mumbai Indians',
    'Royal Challengers Bangalore',
    'Kolkata Knight Riders',
    'Kings XI Punjab',
    'Chennai Super Kings',
    'Rajasthan Royals',
    'Delhi Capitals'
  ];
  List<String> _bowling_teams = [
    'Sunrisers Hyderabad',
    'Mumbai Indians',
    'Royal Challengers Bangalore',
    'Kolkata Knight Riders',
    'Kings XI Punjab',
    'Chennai Super Kings',
    'Rajasthan Royals',
    'Delhi Capitals'
  ];
  List<String> _cities = [
    'Delhi',
    'Mumbai',
    'Mohali',
    'Kolkata',
    'Jaipur',
    'Hyderabad',
    'Bangalore',
    'Chennai'
  ];

  String? _batting_team;
  String? _bowling_team;
  String? _city;

  final TextEditingController _runs_left = TextEditingController();
  final TextEditingController _balls_left = TextEditingController();
  final TextEditingController _wickets = TextEditingController();
  final TextEditingController _total_runs = TextEditingController();

  int? rLeft;
  int? bLeft;
  int? wTaken;
  int? tRun;

  PredictionApi predict = PredictionApi();
  Prediction ?data;

  Future<void> getData()async{
    data=await predict.getPrediction(_batting_team, _bowling_team, _city, rLeft, bLeft, wTaken, tRun);
  }

  Widget _newWidget=Container();

  @override
  // void initState() {
  //   super.initState();
  //   _newWidget = Container(); // initialize the widget to an empty container
  // }

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserProvider>(context).user;

    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'IPL Masters',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ListTile(
                  tileColor: GlobalVariables.backgroundColor,
                  title: const Text(
                    'Predict win and lose percentage',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: null,
                  groupValue: null,
                  onChanged: (val){} ,
                ),),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Batting Team',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black38
                                )
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black38,
                                width: 0.5,
                              ),
                            )
                        ),
                        value: _batting_team,
                        onChanged: (String? value) {
                          setState(() {
                            _batting_team = value!;
                          });
                        },
                        items: _batting_teams.map((String team) {
                          return DropdownMenuItem<String>(
                            value: team,
                            child: Text(team),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 20,),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Bowling Team',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black38
                                )
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black38,
                                width: 0.5,
                              ),
                            )
                        ),
                        value: _bowling_team,
                        onChanged: (String? value) {
                          setState(() {
                            _bowling_team = value!;
                          });
                        },
                        items: _bowling_teams.map((String team) {
                          return DropdownMenuItem<String>(
                            value: team,
                            child: Text(team),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 20,),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Select a city',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black38
                                )
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black38,
                                width: 0.5,
                              ),
                            )
                        ),
                        value: _city,
                        onChanged: (String? value) {
                          setState(() {
                            _city = value!;
                          });
                        },
                        items: _cities.map((String city) {
                          return DropdownMenuItem<String>(
                            value: city,
                            child: Text(city),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Runs left',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black38,
                                  width: 0.5,
                                ),
                              )
                          ),
                          controller: _runs_left,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              rLeft = int.tryParse(value);
                            });
                          }),
                      SizedBox(height: 20,),
                      TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Balls left',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black38,
                                  width: 0.5,
                                ),
                              )
                          ),
                          controller: _balls_left,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              bLeft = int.tryParse(value);
                            });
                          }),
                      SizedBox(height: 20,),
                      TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Wickets left',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black38,
                                  width: 0.5,
                                ),
                              )
                          ),
                          controller: _wickets,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              wTaken = int.tryParse(value);
                            });
                          }),
                      SizedBox(height: 20,),
                      TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Total runs',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black38,
                                  width: 0.5,
                                ),
                              )
                          ),
                          controller: _total_runs,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              tRun = int.tryParse(value);
                            });
                          }),
                      SizedBox(height: 20,),
                      CustomButton(text: 'Submit',
                          onTap:() {
                            _newWidget=Container();
                            getData();
                            setState(() {
                              _newWidget = Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  Text("Bowling Team = ${data!.lose}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),),
                                  Text("Batting Team = ${data!.win}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),),
                                ]
                              );
                            });
                          }, ),
                      SizedBox(height: 20,),
                      _newWidget,
                    ],
                  ),
                ),

              ],
            )),
      ),
    );
  }
}
