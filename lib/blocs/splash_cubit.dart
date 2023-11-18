
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<int> {
  SplashCubit() : super(0);

  void incrementIndexEvidence() => emit(state + 1);
}
