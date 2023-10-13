import 'package:agendai/core/device/app_location.dart';
import 'package:agendai/core/device/app_preferences.dart';
import 'package:agendai/core/di/di.dart';
import 'package:agendai/core/firebase/messaging/app_messaging.dart';
import 'package:agendai/features/intro/pages/onboarding/onboarding_page_actions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'onboarding_page_state.dart';

class OnboardingPageCubit extends Cubit<OnboardingPageState> {
  OnboardingPageCubit(
    this._actions, {
    AppLocation? appLocation,
    AppMessaging? appMessaging,
    AppPreferences? appPreferences,
  })  : _appLocation = appLocation ?? getIt(),
        _appMessaging = appMessaging ?? getIt(),
        _appPreferences = appPreferences ?? getIt(),
        super(const OnboardingPageState.initial());

  OnboardingPageActions? _actions;

  final AppLocation _appLocation;
  final AppMessaging _appMessaging;
  final AppPreferences _appPreferences;

  Future<void> initialize() async {
    final locationStatus = await _appLocation.checkStatus();
    final messagingStatus = await _appMessaging.checkStatus();

    emit(OnboardingPageState(
      showNotificationPage: [
        AppMessagingStatus.notDetermined,
        AppMessagingStatus.denied
      ].contains(messagingStatus),
      showLocationPage: [
        AppLocationStatus.denied,
        AppLocationStatus.deniedForever,
      ].contains(locationStatus),
    ));
  }

  Future<void> requestLocationPermission() async {
    final locationStatus = await _appLocation.requestPermission();
    if (locationStatus == AppLocationStatus.deniedForever) {
      await _actions?.showDeniedForeverDialog();
    }
  }

  Future<void> requestNotificationPermission() async {
    final messagingStatus = await _appMessaging.requestPermission();
    if (messagingStatus == AppMessagingStatus.denied) {
      await _actions?.showDeniedForeverDialog();
    }
  }

  void finish() {
    _appPreferences.setOnboardingDone();
    _actions?.navToAuth();
  }

  void dispose() {
    _actions = null;
  }
}
