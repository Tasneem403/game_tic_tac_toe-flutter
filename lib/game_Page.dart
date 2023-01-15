import 'package:flutter/material.dart';
import 'package:game_tic_tac_toe/ui/theme/color.dart';
import 'package:game_tic_tac_toe/utils/game_logic.dart';

class GamePage extends StatefulWidget {
  GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  String lastValue = "X";
  bool gameOver = false;
  int turn = 0;
  String result = "";
  List<int> scoreboard = [0,0,0,0,0,0,0,0];

  Game game = Game();

  @override
  void initState() {
    game.board = Game.initGameBoard();
    print(game.board);
  }
  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("It's ${lastValue} turn".toUpperCase(),
          style:const TextStyle(
            color: Colors.white,
            fontSize: 50
          ),
        ),
          const SizedBox(height: 20,),
          Container(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
              crossAxisCount: Game.boardlenth ~/3,
              padding:const EdgeInsets.all(16),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: List.generate(Game.boardlenth, (index) {
                return InkWell(
                  onTap: gameOver ? null
                  : (){
                    if(game.board![index] == ""){
                      setState(() {
                        game.board![index] = lastValue;
                        turn++;
                        gameOver = game.winnerCheck(
                          lastValue, index, scoreboard, 3
                          );
                        if(gameOver){
                          result = "$lastValue is Winner";
                        } else if(!gameOver && turn ==9) {
                          result = "It's a Draw!";
                          gameOver = true;
                        }
                      if(lastValue == "X")
                       lastValue = "O";
                      else 
                        lastValue = "X";
                    });
                    };
                  },
                  child: Container(
                    width: Game.blocsize,
                    height: Game.blocsize,
                    decoration: BoxDecoration(
                      color: MainColor.secondaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        game.board![index],
                        style: TextStyle(
                          color: game.board![index] == "X"
                          ? Colors.blue 
                          : Colors.pink,
                          fontSize: 64,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 25,),
          Text(result, style:const TextStyle(color: Colors.white , fontSize: 54),),
          ElevatedButton.icon(
            onPressed:(){
              setState(() {
                game.board = Game.initGameBoard();
                lastValue = "X";
                gameOver = false;
                turn = 0;
                result = "";
                scoreboard = [0 , 0 , 0 , 0 , 0 , 0 , 0 , 0];
              });
            },
            icon: const Icon(Icons.replay),
            label: const Text(
              "Repeat the Game",
              )
            )
       ],
      ),
    );
  }
}