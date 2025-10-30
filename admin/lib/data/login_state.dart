class LoginState {
  final bool isLoading;
  final bool isLoggedIn;
  final String? error;

  LoginState({this.error, this.isLoading = false, this.isLoggedIn = false});

  LoginState copyWith({bool? isLoading, bool? isLoggedIn, String? error}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      error: error ?? this.error,
    );
  }
}
