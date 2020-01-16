import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_twitter/flutter_twitter.dart';

class FireAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> signInTwitter() async {
    final twitterLoggedIn = new TwitterLogin(
      consumerKey: DotEnv().env['TWITTER_API_KEY'],
      consumerSecret: DotEnv().env['TWITTER_API_SECRET_KEY'],
    );

    final TwitterLoginResult result = await twitterLoggedIn.authorize();

    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        //var session = result.session;
        FirebaseUser twUser = await _signInWithTwitter(
            result.session.token, result.session.secret);
        return twUser;
        break;
      case TwitterLoginStatus.cancelledByUser:
        debugPrint('Canceled');
        return null;
        break;
      case TwitterLoginStatus.error:
        debugPrint('Error!');
        return null;
        break;
    }
  }

// サインイン
  Future<FirebaseUser> _signInWithTwitter(String token, String secret) async {
    final AuthCredential credential = TwitterAuthProvider.getCredential(
        authToken: token, authTokenSecret: secret);
    // Twitterユーザー情報取得
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    if(user.uid == currentUser.uid){
      return user;
    }
  }
}