part of 'session_cubit.dart';

class SessionState extends Equatable {
  const SessionState({this.loggedUser});

  final User? loggedUser;

  @override
  List<Object?> get props => [loggedUser];

  SessionState copyWith({
    User? loggedUser,
  }) {
    return SessionState(
      loggedUser: loggedUser ?? this.loggedUser,
    );
  }

}
