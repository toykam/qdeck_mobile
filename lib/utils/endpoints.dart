
class AppEndpoints {
  static String baseUrl = "https://3981-102-89-45-236.eu.ngrok.io";
  static String getKahootSession(String code) => "$baseUrl${"/kahoot_session/"}$code";
  static String getDeck(String deckId) => "$baseUrl${"/decks/"}$deckId";
  static String getDecks = "$baseUrl${"/decks"}";
}