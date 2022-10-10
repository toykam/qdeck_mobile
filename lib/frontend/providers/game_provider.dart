

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:khoot/backend/models/entities/kahoot_session.dart';
import 'package:khoot/backend/models/entities/question_model.dart';
import 'package:khoot/frontend/interactions/toast_alerts.dart';
import 'package:khoot/frontend/providers/base_provider.dart';
import 'package:khoot/utils/endpoints.dart';
import 'package:khoot/utils/socket.events.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class GameProvider extends BaseProvider {

  bool kahootExists = false;
  bool joinedKahoot = false;
  bool kahootStarted = false;
  bool kahootEnded = false;
  bool waitingForOthers = false;
  bool showLeaderboard = false;

  String _code = "";
  String _username = "";
  late KahootSession kahootSession;
  late IO.Socket socket;
  late QuestionModel question;
  late int qn;
  late int totalQuestions;
  dynamic participant;
  Timer? _timer;
  num seconds = 0;

  List participants = [];

  void setKahootExist() {
    kahootExists = true;
  }

  void initialize() {
    try {
      print("Connecting...");
      socket = IO.io(AppEndpoints.baseUrl, IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect()  // disable auto-connection
          .setExtraHeaders({'foo': 'bar'}) // optional
          .build());
      socket.connect();
      socket.onConnect((data) {
        print("Connected");
        backToLoaded();
      });
      socket.onDisconnect((data) {
        print("Disconnected");
        kahootExists = false;
        joinedKahoot = false;
        _code = "";
        _username = "";
        participants = [];
        participant = null;
        backToLoading();
        socket.dispose();
        initialize();
      });

      socket.onError((data) {
        print("Error ::: $data");
        backToError("Error $data");
      });

      socket.on(AppSocketEvents.kahootError, (data) {
        ToastAlert.showErrorAlert(data['message']);
      });

      socket.on(AppSocketEvents.participantJoined, (data) {
        participants = data['participants'];
        notifyListeners();
      });

      socket.on(AppSocketEvents.startKahoot, (data) {
        kahootStarted = true;
        _setQuestion(data);
        notifyListeners();
      });

      socket.on(AppSocketEvents.joinKahoot, (data) {
        participant = data['participant'];
        notifyListeners();
      });

      socket.on(AppSocketEvents.nextQuestion, (data) {
        _setQuestion(data);
        notifyListeners();
      });

      socket.on(AppSocketEvents.answerQuestion, (data) {
        participant = data['participant'];
        notifyListeners();
      });

      socket.on(AppSocketEvents.timeUp, (data) {
        participants = data['participants'];
        showLeaderboard = true;
        notifyListeners();
      });

      socket.on(AppSocketEvents.kahootEnded, (data) {
        print("Kahoot Ended $data");
        participants = data['participants'];
        kahootEnded = true;
        _timer?.cancel();
        notifyListeners();
      });
      // backToLoaded();
    } catch (error) {
      print("CatchError ::: $error");
      backToError("Error: $error");
    }
  }

  void _setQuestion(data) {
    waitingForOthers = false;
    showLeaderboard = false;
    question = QuestionModel.fromJson(data['question']);
    qn = data['qn'];
    totalQuestions = data['total'];
    seconds = question.questionTime!;
    _resetTime();
  }

  void _resetTime() {
    seconds = question.questionTime!;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      seconds--;
      if (seconds == 0) {
        _timer?.cancel();
        waitingForOthers = true;
      }
      notifyListeners();
    });
  }

  GameProvider() {
    initialize();
  }

  @override
  void dispose() {
    socket.close();
    socket.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void checkKahoot(BuildContext context, String sessionCode) async {
    try {
      if (sessionCode.isEmpty) {
        ToastAlert.showErrorAlert("Please provide game code");
      } else {
        ToastAlert.showLoadingAlert("");
        final dio = Dio();

        final res = await dio.get(AppEndpoints.getKahootSession(sessionCode));
        kahootSession = KahootSession.fromJson(res.data['data']);
        kahootExists = true;
        _code = sessionCode;
        ToastAlert.closeAlert();
        notifyListeners();
      }
    } on DioError catch (error) {
      ToastAlert.closeAlert();
      print(error.response!.data);
      ToastAlert.showErrorAlert(error.response!.data['message']);
    } catch (error) {
      ToastAlert.closeAlert();
      ToastAlert.showErrorAlert("$error");
    }
  }

  void joinKahootSession(BuildContext context, String userName) async {
    try {
      if (userName.isEmpty) {
        ToastAlert.showErrorAlert("Please provide a username");
      } else {
        socket.emit(AppSocketEvents.joinKahoot, {
          "code": _code,
          "name": userName
        });
        _username = userName;
        joinedKahoot = true;
        notifyListeners();
      }
    } catch (error) {
      ToastAlert.showErrorAlert("An error occurred while joining the kahoot");
    }
  }

  void answerQuestion(BuildContext context, String answer) {
    try {
      socket.emit(AppSocketEvents.answerQuestion, {
        "code": _code,
        "answer": answer,
        "id": participant['id']
      });
      waitingForOthers = true;
      notifyListeners();
    } catch (error) {
      ToastAlert.showErrorAlert("An error occurred answering question.");
    }
  }

}