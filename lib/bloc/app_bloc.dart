import 'package:bloc/bloc.dart';
import 'package:notes_bloc_app/apis/login_api.dart';
import 'package:notes_bloc_app/apis/notes_api.dart';
import 'package:notes_bloc_app/bloc/actions.dart';
import 'package:notes_bloc_app/bloc/app_state.dart';
import 'package:notes_bloc_app/models.dart';

class AppBloc extends Bloc<AppAction, AppState> {
  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesApi;

  AppBloc({
    required this.loginApi,
    required this.notesApi,
    // AppState.empty() is the initial state for AppBloc
  }) : super(const AppState.empty()) {
    on<LoginAction>((event, emit) async {
      // emits loading state
      emit(
        const AppState(
          isLoading: true,
          loginError: null,
          loginHandle: null,
          fetchedNotes: null,
        ),
      );

      // log the user in
      final loginHandle = await loginApi.login(
        email: event.email,
        password: event.password,
      );

      // emits login state
      emit(
        AppState(
          isLoading: false,
          loginError: loginHandle == null ? LoginErrors.invaildHandle : null,
          loginHandle: loginHandle,
          fetchedNotes: null,
        ),
      );
    });

    on<LoadNotesAction>(
      (event, emit) async {
        // emits loading state with loginHandle
        emit(
          AppState(
            isLoading: true,
            loginError: null,
            loginHandle: state.loginHandle, //previous state
            fetchedNotes: null,
          ),
        );
        // get login handle
        final loginHandle = state.loginHandle;
        if (loginHandle != const LoginHandle.foobar()) {
          // invalid login handle, cannot fetch notes
          emit(
            AppState(
              isLoading: false,
              loginError: LoginErrors.invaildHandle,
              loginHandle: loginHandle,
              fetchedNotes: null,
            ),
          );
          return;
        }
        // we have a valid login handle and want to fetch notes
        final notes = await notesApi.getNotes(loginHandle: loginHandle!);
        emit(
          AppState(
            isLoading: false,
            loginError: null,
            loginHandle: loginHandle,
            fetchedNotes: notes,
          ),
        );
      },
    );
  }
}
