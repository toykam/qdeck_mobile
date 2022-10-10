

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khoot/frontend/providers/auth_provider.dart';
import 'package:khoot/frontend/providers/deck_provider.dart';
import 'package:khoot/frontend/providers/game_provider.dart';
import 'package:khoot/frontend/providers/manage_game_provider.dart';
import 'package:khoot/frontend/providers/my_deck_provider.dart';
import 'package:khoot/frontend/providers/view_question_deck_provider.dart';
import 'package:khoot/frontend/route/route_names.dart';
import 'package:khoot/frontend/screens/auth_screen/login_screen.dart';
import 'package:khoot/frontend/screens/auth_screen/register_screen.dart';
import 'package:khoot/frontend/screens/game_screen/game_base_screen.dart';
import 'package:khoot/frontend/screens/home_screen/home_screen.dart';
import 'package:khoot/frontend/screens/host_game/host_game_screen.dart';
import 'package:khoot/frontend/screens/host_game/manage_game_screen.dart';
import 'package:khoot/frontend/screens/my_question_decks/create_question_deck.dart';
import 'package:khoot/frontend/screens/my_question_decks/my_deck_screen.dart';
import 'package:khoot/frontend/screens/my_question_decks/question_deck_screen.dart';
import 'package:khoot/frontend/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

final appRoutes = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => SplashScreen(),

      routes: [
        GoRoute(
          path: gameScreenRoute,
          builder: (context, state) => ChangeNotifierProvider(
            create: (context) => GameProvider(),
            child: const GameBaseScreen()
          ),
        ),

        GoRoute(
          path: homeScreenRoute,
          builder: (context, state) => const HomeScreen(),
        ),

        GoRoute(
          path: hostGameScreenRoute,
          builder: (context, state) => ChangeNotifierProvider(
            create: (context) => DeckProvider(),
            child: const HostGameScreen(),
          ),
          redirect: (context, state) {
            final isLoggedIn = Provider.of<AuthProvider>(context, listen: false).isLoggedIn;
            if (!isLoggedIn) {
              return "/auth/$loginScreenRoute";
            }
            return null;
          },
        ),

        GoRoute(
          path: "$manageGameScreenRoute/:deckId",
          builder: (context, state) => ChangeNotifierProvider(
            create: (context) => ManageGameProvider(state.params['deckId'].toString()),
            child: const ManageGameScreen(),
          ),
          redirect: (context, state) {
            final isLoggedIn = Provider.of<AuthProvider>(context, listen: false).isLoggedIn;
            if (!isLoggedIn) {
              return "/auth/$loginScreenRoute";
            }
            return null;
          },
        ),

        GoRoute(
          path: myDeckScreenRoute,
          builder: (context, state) => const MyDeckScreen(),
          redirect: (context, state) {
            final isLoggedIn = Provider.of<AuthProvider>(context, listen: false).isLoggedIn;
            if (!isLoggedIn) {
              return "/auth/$loginScreenRoute";
            }
            return null;
          },
          routes: [
            GoRoute(
              path: createQuestionDeckScreenRoute,
              builder: (context, state) => const CreateQuestionDeckScreen(),
            ),

            GoRoute(
              path: "$viewQuestionDeckScreenRoute/:qdeckId",
              builder: (context, state) {
                return ChangeNotifierProvider(
                  create: (context) => ViewQuestionDeckProvider(state.params['qdeckId'].toString()),
                  child: const ViewQuestionDeckScreen(),
                );
              },
            ),
          ]
        ),

      ]
    ),

    GoRoute(
      path: "/auth",
      builder: (context, state) => Container(),
      routes: [
        GoRoute(path: loginScreenRoute, builder: (context, state) => LoginScreen(),),
        GoRoute(path: registerScreenRoute, builder: (context, state) => RegisterScreen(),),
      ]
    )
  ]
);