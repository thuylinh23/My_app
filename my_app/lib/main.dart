import 'package:flutter/material.dart';
import 'package:my_app/buttons.dart';
// import 'package:flutter_math/flutter_math.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Caculator',
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer='';
  final List<String> buttons = [
    'C','DEL','%','/',
    '9','8','7','x',
    '6','5','4','-',
    '3','2','1','+',
    '0','00','.','='
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: <Widget>[
          Expanded(
              child:Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:<Widget> [
                    SizedBox(
                      height:50,
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                        child: Text(userQuestion,style: TextStyle(fontSize: 20),)
                    ),
                    Container(
                        padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                        child: Text(userAnswer)
                    ),
                  ],
                ),
              ),
          ),
          Expanded(
            flex: 2,
           child: Container(
             child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
               itemCount: buttons.length,
               itemBuilder: (BuildContext context, int index){
                if(index == 0){//clear buttons
                  return MyButton(
                      Colors.amber,
                      Colors.white,
                      buttons[index],
                          (){
                        setState(() {
                          userQuestion = '';
                          userAnswer = '';
                        });
                      }
                  );
                }else if(index == 1){//delete button
                  return MyButton(
                    Colors.red,
                    Colors.white,
                      buttons[index],
                          (){
                        setState(() {
                          userQuestion = userQuestion.substring(0,userQuestion.length-1);
                        });
                      }
                  );
                }
                else if(index== buttons.length-1){//equal Button
                  return MyButton(
                      isOperator(buttons[index]) ? Colors.deepPurple : Colors.deepPurple[50],
                      isOperator(buttons[index]) ? Colors.white : Colors.deepPurple,
                      buttons[index],
                          (){
                        setState(() {
                          equalPressed();
                        });
                      }
                  );
                }
                else{//rest of the buttons
                  return MyButton(
                      isOperator(buttons[index]) ? Colors.deepPurple : Colors.deepPurple[50],
                      isOperator(buttons[index]) ? Colors.white : Colors.deepPurple,
                      buttons[index],
                     (){
                        setState(() {
                          userQuestion += buttons[index];
                        });
                      }
                  );
                }
               }),
           ),
          ),
        ],
      ),
    );
  }
  bool isOperator(String x){
    if(x=='%' || x=='/' || x=='x'|| x=='-' || x=='+' || x=='='){
      return true;
    }
    return false;
  }
  void equalPressed(){
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}

