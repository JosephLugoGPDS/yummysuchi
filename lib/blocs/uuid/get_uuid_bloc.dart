import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_uuid_event.dart';
part 'get_uuid_state.dart';

class GetUuidBloc extends Bloc<GetUuidEvent, GetUuidState> {
  GetUuidBloc() : super(GetUuidInitial()) {
    on<FetchUuidEvent>(_onFetchUuidEvent);
  }
}

void _onFetchUuidEvent(
  FetchUuidEvent event,
  Emitter<GetUuidState> emit,
) async {
  emit(GetUuidLoading());
  try {
    String deviceName = await _getDeviceUuid();
    await _saveDeviceUuid(deviceName);
    emit(GetUuidSuccess(deviceName));
  } catch (error) {
    emit(GetUuidFailure(error.toString()));
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
