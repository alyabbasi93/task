import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'info_blok_event.dart';

part 'info_blok_state.dart';

class InfoBlokBloc extends Bloc<InfoBlokEvent, InfoBlokState> {
  InfoBlokBloc(InfoBlokState initialState) : super(initialState);

  @override
  InfoBlokState get initialState => InitialInfoBlokState();

  @override
  Stream<InfoBlokState> mapEventToState(InfoBlokEvent event) async* {
    // TODO: Add your event logic
  }
}
