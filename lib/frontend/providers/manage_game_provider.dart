
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:khoot/backend/models/entities/kahoot_session.dart';
import 'package:khoot/backend/models/entities/qdeck.dart';
import 'package:khoot/backend/models/entities/question_model.dart';
import 'package:khoot/frontend/interactions/toast_alerts.dart';
import 'package:khoot/frontend/providers/base_provider.dart';
import 'package:khoot/utils/endpoints.dart';
import 'package:khoot/utils/socket.events.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


const token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzNDFmMWUwNmEyMGEyN2ZjNjY0OTBlZCIsImVtYWlsIjoiZW1haWxAZW1haWwuY29tIiwiaWF0IjoxNjY1Mjc4ODE4fQ.I2Qk1kANITBuvDVfhY4XMG8WQCHgUm7vx3qMnNZkCLE";
class ManageGameProvider extends BaseProvider {

  late String id;
  Qdeck? qDeck;
  KahootSession? kahootSession;

  QuestionModel? question;

  bool creatingGame = true;
  bool waitingForParticipants = false;
  bool gameStarted = false;
  bool gameEnded = false;
  bool showLeaderboard = false;

  late IO.Socket socket;
  num seconds = 0;
  num totalQuestion = 0;
  num qn = 0;

  List participants = [];

  Timer? _timer;

  void initialize() async {
    try {
      print("Connecting...");
      socket = IO.io(AppEndpoints.baseUrl, IO.OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        .disableAutoConnect() // optional
        .setAuth({"authorization": token})
        .setExtraHeaders({
          "authorization": token
        })
        .build());
      socket.connect();
      socket.onConnect((data) {
        print("Connected");
        backToLoaded();
      });
      socket.onDisconnect((data) {
        print("Disconnected");
      });

      socket.onError((data) {
        print("Error ::: $data");
        backToError("Error $data");
      });
      socket.on(AppSocketEvents.participantJoined, (data) {
        participants.add(data['participant']);
        notifyListeners();
      });

      socket.on(AppSocketEvents.createKahootSession, (data) {
        print("Kahoot session created");
        kahootSession = KahootSession.fromJson(data['activeSession']);
        waitingForParticipants = true;
        backToLoaded();
        notifyListeners();
      });

      socket.on(AppSocketEvents.nextQuestion, (data) {
        showLeaderboard = false;
        _setQuestion(data);
        notifyListeners();
      });

      socket.on(AppSocketEvents.startKahoot, (data) {
        gameStarted = true;
        waitingForParticipants = false;
        _setQuestion(data);
        backToLoaded();
        notifyListeners();
      });

      socket.on(AppSocketEvents.timeUp, (data) {
        showLeaderboard = true;
        participants = data['participants'];
        notifyListeners();
      });

      socket.on(AppSocketEvents.kahootEnded, (data) {
        gameEnded = true;
        participants = data['participants'];
        notifyListeners();
      });

    } catch (error) {
      ToastAlert.showErrorAlert("Error: $error");
    }
  }

  void _setQuestion(data) {
    // waitingForOthers = false;
    question = QuestionModel.fromJson(data['question']);
    qn = data['qn'];
    totalQuestion = data['total'];
    seconds = question!.questionTime!;
    _resetTime();
  }

  void _resetTime() {
    seconds = question!.questionTime!;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      seconds--;
      if (seconds == 0) {
        _timer?.cancel();
        timeUp();
      }
      notifyListeners();
    });
  }

  void _loadQDeck() async {
    try {
      final dio = Dio();
      final response = await dio.get(AppEndpoints.getDeck(id));

      qDeck = Qdeck.fromJson(response.data['data']);
      notifyListeners();
    } catch (error) {
      ToastAlert.showErrorAlert("Error: $error");
      backToError('Error: $error');
    }
  }

  void start() {
    socket.emit(AppSocketEvents.startKahoot, {
      "code": kahootSession!.code!
    });
  }

  void nextQuestion() {
    socket.emit(AppSocketEvents.nextQuestion, {
      "code": kahootSession!.code!
    });
  }

  void create() {
    backToLoading();
    print("Creating session: $id");
    socket.emit(AppSocketEvents.createKahootSession, {
      "kahootId": id
    });
  }

  void timeUp() {
    socket.emit(AppSocketEvents.timeUp, {
      "code": kahootSession!.code
    });
  }

  @override
  void dispose() {
    socket.close();
    socket.dispose();
    super.dispose();
  }

  ManageGameProvider(this.id) {
    _loadQDeck();
    initialize();
  }

}