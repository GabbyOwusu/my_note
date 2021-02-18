import 'dart:io';
import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  LocalAuthentication auth = LocalAuthentication();

  Future runBoimetric() async {
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    if (Platform.isAndroid) {
      try {
        if (availableBiometrics.contains(BiometricType.fingerprint)) {
          auth.authenticateWithBiometrics(
            localizedReason: 'Use biometrics to unlock note',
            useErrorDialogs: true,
            stickyAuth: true,
          );
        }
      } catch (e) {
        print('Authentication failed because $e');
      }
    }
    if (Platform.isIOS) {}
  }
}
