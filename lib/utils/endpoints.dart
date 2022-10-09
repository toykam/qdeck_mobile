
class AppEndpoints {
  static String baseUrl = "http://34.207.69.51:3000";
  static String getKahootSession(String code) => "$baseUrl${"/kahoot_session/"}$code";
  static String getDeck(String deckId) => "$baseUrl${"/decks/"}$deckId";
  static String getDecks = "$baseUrl${"/decks"}";
  static String myDeck = "$baseUrl${"/mydeck"}";


  static String login = "$baseUrl${"/user/auth/login"}";
}