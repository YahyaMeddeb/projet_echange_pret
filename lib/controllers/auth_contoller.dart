import 'package:firebase_auth/firebase_auth.dart';

/// Contrôleur responsable de la gestion de l'authentification
/// via Firebase Authentication.
/// 
/// Ce controller regroupe toutes les opérations :
/* connexion
- inscription
- déconnexion
- gestion des erreurs*/
class AuthController {
  /// Instance principale de FirebaseAuth utilisée pour toutes
  /// les opérations d'authentification.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ------------------------------------------------------------------
  //   Connexion Email / Mot de passe
  // ------------------------------------------------------------------
  /// Tente de connecter un utilisateur via email et mot de passe.
  ///
  /// Retourne :
  ///   • null  → si la connexion réussit
  ///   • String → si une erreur doit être affichée dans l'UI
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      // Nettoie les champs (supprime espaces au début/fin)
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      return null; // aucune erreur → succès
    } on FirebaseAuthException catch (e) {
      // Conversion du code d'erreur Firebase en message lisible
      return getErrorMessage(e);
    }
  }

  // ------------------------------------------------------------------
  //   Inscription Email / Mot de passe
  // ------------------------------------------------------------------
  /// Crée un nouveau compte utilisateur avec email et mot de passe.
  ///
  /// Retourne :
  ///   • null  → si l'inscription réussit
  ///   • String → si une erreur doit être affichée
  Future<String?> register({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      return null; // succès
    } on FirebaseAuthException catch (e) {
      return getErrorMessage(e); // message d'erreur lisible
    }
  }

  // ------------------------------------------------------------------
  //   Déconnexion
  // ------------------------------------------------------------------
  /// Déconnecte l'utilisateur actuellement connecté.
  Future<void> logout() async {
    await _auth.signOut();
  }

  // ------------------------------------------------------------------
  //   Vérifier l'utilisateur connecté
  // ------------------------------------------------------------------
  /// Renvoie l'utilisateur actuellement connecté, ou null
  /// s'il n'y a personne.
  User? get currentUser => _auth.currentUser;

  /// Émet un flux indiquant en temps réel si un utilisateur
  /// se connecte / se déconnecte.
  ///
  /// Très utile pour gérer la navigation automatique.
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  // ------------------------------------------------------------------
  //   Gestion des erreurs Firebase
  // ------------------------------------------------------------------
  /// Convertit un code d'erreur Firebase en message plus lisible
  /// pour l'utilisateur final.
  ///
  /// Exemple : "user-not-found" → "Aucun utilisateur trouvé avec cet email."
  String getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case "user-not-found":
        return "Aucun utilisateur trouvé avec cet email.";
      case "wrong-password":
        return "Mot de passe incorrect.";
      case "invalid-email":
        return "L'email n'est pas valide.";
      case "email-already-in-use":
        return "Cet email est déjà utilisé.";
      case "weak-password":
        return "Le mot de passe est trop faible.";
      case "user-disabled":
        return "Ce compte est désactivé.";
      default:
        return "Erreur : ${e.message}";
    }
  }
}