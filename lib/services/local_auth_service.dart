import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  LocalAuthentication auth = LocalAuthentication();

  Future runBoimetric() async {
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    try {
      if (availableBiometrics.contains(BiometricType.fingerprint)) {
        return auth.authenticate(
          localizedReason: 'Use biometrics to unlock note',
          options: AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
            sensitiveTransaction: true,
          ),
        );
      }
    } catch (e) {
      print('Authentication failed because $e');
    }
  }
}
