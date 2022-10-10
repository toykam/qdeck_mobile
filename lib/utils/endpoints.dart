
class AppEndpoints {
  // static String baseUrl = "https://ae04-102-89-23-188.eu.ngrok.io";
  static String baseUrl = "http://34.207.69.51:3000";
  static String getKahootSession(String code) => "$baseUrl${"/kahoot_session/"}$code";
  static String getDeck(String deckId) => "$baseUrl${"/decks/"}$deckId";
  static String getDecks = "$baseUrl${"/decks"}";
  static String myDeck = "$baseUrl${"/user/qdeck"}";
  static String createQuestionDeck = "$baseUrl${"/user/qdeck"}";
  static String getUserDeck(String id) => "$baseUrl${"/user/qdeck/$id"}";
  static String deleteUserDeck(String id) => "$baseUrl${"/user/qdeck/$id"}";
  static String addQuestion(String id) => "$baseUrl${"/user/qdeck/$id/questions"}";

  static String updateQuestion(String id, String qid) => "$baseUrl${"/user/qdeck/$id/questions/$qid"}";
  static String deleteQuestion(String id, String qid) => "$baseUrl${"/user/qdeck/$id/questions/$qid"}";


  static String login = "$baseUrl${"/user/auth/login"}";
  static String register = "$baseUrl${"/user/auth/register"}";
}