
import 'package:flutter/material.dart';
import 'package:khoot/frontend/providers/game_provider.dart';
import 'package:khoot/frontend/screens/game_screen/code_screen.dart';
import 'package:khoot/frontend/screens/game_screen/game_result_screen.dart';
import 'package:khoot/frontend/screens/game_screen/game_screen.dart';
import 'package:khoot/frontend/screens/game_screen/name_screen.dart';
import 'package:khoot/frontend/screens/game_screen/waiting_to_start_screen.dart';
import 'package:khoot/frontend/styles/colors.dart';
import 'package:provider/provider.dart';

class GameBaseScreen extends StatelessWidget {
  const GameBaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context);
    print((provider.joinedKahoot && !provider.kahootStarted));
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: provider.isLoading ? const Center(
        child: CircularProgressIndicator.adaptive(),
      ) : provider.isError ? Center(
        child: Text(provider.message, style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w200
        ),),
      ) :
        provider.kahootExists ?
            provider.kahootEnded ? GameResultScreen(
              last: true,
            ) :
                provider.showLeaderboard ? GameResultScreen(
                  last: false,
                ) :
        (provider.joinedKahoot && !provider.kahootStarted) ? WaitingToStartScreen() :
        provider.kahootStarted ? GameScreen() : GameUsernameScreen() :
        GameCodeScreen(),
    );
  }
}
