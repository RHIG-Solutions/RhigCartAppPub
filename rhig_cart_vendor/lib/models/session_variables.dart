// model containing any variables that must be available session wide

// Creates the object
SessionVariables mySession = SessionVariables();

class SessionVariables {
  String _loggedInUser = '';

  // Sets user after successful login
  setUser({required String loggedInUser}) {
    _loggedInUser = loggedInUser;
  }

  // Returns user
  String getUser() {
    return _loggedInUser;
  }

  logOutUser() {
    _loggedInUser = '';
  }
}
