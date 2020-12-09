import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'VerifyPhone.dart';

class FireBaseAuthentication {
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            print("ssssssssss");
            print(snapshot.hasData);
            print(snapshot);
            print(context);
            // var phone = snapshot.hasData;
            // print(phone);
            return VerifyPhone();
          } else {
            return VerifyPhone();
          }
        });
  }

  signIn(AuthCredential authCredential) {
    print("uuuuu");
    print(authCredential);
    FirebaseAuth.instance.signInWithCredential(authCredential);
  }

  signInWithOTP(smsCode, verId) {
    print("aaaaaa" + smsCode);
    print("bbbbbbbbb" + verId);
    AuthCredential authCredential =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    signIn(authCredential);
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
