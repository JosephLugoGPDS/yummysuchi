import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_uuid_event.dart';
part 'get_uuid_state.dart';

class GetUuidBloc extends Bloc<GetUuidEvent, GetUuidState> {
  GetUuidBloc() : super(GetUuidInitial());
}

  @override
  Stream<GetUuidState> mapEventToState(GetUuidEvent event) async* {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (event is FetchUuidEvent) {
      yield GetUuidLoading();
      if (sharedPreferences.containsKey('uuid')) {
        yield GetUuidSuccess(sharedPreferences.getString('uuid')!);
        return;
      }

      try {
        String deviceName = await _getDeviceUuid();
        await _saveDeviceUuid(deviceName);
        await _saveUserData(deviceName, event.userName);
        yield GetUuidSuccess(deviceName);
      } catch (error) {
        yield GetUuidFailure(error.toString());
      }
    }
  }

  Future<String> _getDeviceUuid() async {

      AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
      return androidInfo.id;
    
  }

  Future<void> _saveDeviceUuid(String uuid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('uuid', uuid);
  }


  Future<void> _saveUserData(String uuid, String username) async {
    try {
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
      await usersCollection.doc(uuid).set({
        'name': username,
        'uuid': uuid,
      });
      debugPrint('User data saved successfully');
    } catch (error) {
      debugPrint('Failed to save user data: $error');
    }
  }

