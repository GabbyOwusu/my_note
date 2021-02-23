import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  LocalAuthentication auth = LocalAuthentication();

  Future runBoimetric() async {
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    try {
      if (availableBiometrics.contains(BiometricType.fingerprint)) {
        return auth.authenticateWithBiometrics(
          localizedReason: 'Use biometrics to unlock note',
          useErrorDialogs: true,
          stickyAuth: true,
          sensitiveTransaction: true,
        );
      }
    } catch (e) {
      print('Authentication failed because $e');
    }
  }
}
