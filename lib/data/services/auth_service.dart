import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Send OTP to phone number
  Future<void> verifyPhone({
    required String phoneNumber,
    required Function(String verificationId) codeSent,
    required Function(String error) failed,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91$phoneNumber",

      // Automatic verification on supported Android devices
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },

      // Verification failed
      verificationFailed: (FirebaseAuthException e) {
        failed(e.message ?? "Verification failed");
      },

      // OTP successfully sent
      codeSent: (String verificationId, int? resendToken) {
        codeSent(verificationId);
      },

      // OTP timeout
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  // Verify OTP
  Future<UserCredential> verifyOTP({
    required String verificationId,
    required String otp,
  }) async {
    final PhoneAuthCredential credential =
        PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );

    return await _auth.signInWithCredential(credential);
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Currently logged-in user
  User? get currentUser => _auth.currentUser;
}