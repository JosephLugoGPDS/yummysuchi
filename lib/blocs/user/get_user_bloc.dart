import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_yummy_sushi/model/user.dart';

part 'get_user_event.dart';
part 'get_user_state.dart';

class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  GetUserBloc() : super(GetUserInitial()) {
    on<GetUserEvent>((event, emit) async {
      if (event is FetchUserEvent) {
        emit(GetUserLoading());
        try {
          User? user = await _getUserData(event.uuid, event.name);
          if (user == null) {
            emit(GetUserFailure('User not found'));
            return;
          }
          emit(GetUserSuccess(user));
        } catch (error) {
          emit(GetUserFailure(error.toString()));
        }
      }
    });
  }
}

Future<User?> _getUserData(String uuid, String? userName) async {
  try {
    if (userName != null) {
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');
      await usersCollection.doc(uuid).set({
        'name': userName,
        'uuid': uuid,
      });
    User user = User(
      uuid: uuid,
      name: userName,
    );
    return user;
    } else {
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');
      DocumentSnapshot userSnapshot = await usersCollection.doc(uuid).get();
      if (userSnapshot.exists) {
        User user = User(
          uuid: userSnapshot.get('uuid'),
          name: userSnapshot.get('name'),
        );
        return user;
      } else {
        return null;
      }

    }
  } catch (error) {
    debugPrint(error.toString());
    return null;
  }
}
