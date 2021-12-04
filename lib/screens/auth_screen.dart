// Flutter imports
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

// File imports
import '../widgets/auth/auth_form.dart';

//////////////////////////////////////////////////////////////////
// StateFUL widget which manages state. Simply initializes the
// state object.
//////////////////////////////////////////////////////////////////
class AuthScreen extends StatefulWidget {
  // Route name declaration
  static const routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

//////////////////////////////////////////////////////////////////
// THe actual STATE which is managed by the above widget.
//////////////////////////////////////////////////////////////////
class _AuthScreenState extends State<AuthScreen> {
  // The "instance variables" managed in this state
  var _isLoading = false;

  // Finals used in this widget
  final _auth = FirebaseAuth.instance;

  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////
  /// Helper Methods (for state object)
  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////
  // Attempts to either login to existing account or signup for
  // new account.
  ////////////////////////////////////////////////////////////////
  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) async {
    try {
      // Update screen to indicate loading spinner
      setState(() {
        _isLoading = true;
      });

      // If in "login mode", attempt to login with email/password...
      UserCredential authResult;
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        //...else, signup for new account with email/password
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Once account is created, send verification email
        User? user = _auth.currentUser;
        if (user != null && !user.emailVerified) {
          await user.sendEmailVerification();
          // var actionCodeSettings = ActionCodeSettings(
          //     url: 'https://www.globebiomedical.com/?email=${user.email}',
          //     androidPackageName: "com.globebiomedical.final_app",
          //     androidInstallApp: true,
          //     androidMinimumVersion: "12",
          //     iOSBundleId: "com.globebiomedical.final_app",
          //     handleCodeInApp: true);
          //await user.sendEmailVerification(actionCodeSettings);

          // ...and display to user as "Snack bar" pop-up at bottom of screen
          ScaffoldMessenger.of(ctx).showSnackBar(
            SnackBar(
                content: Text('Check ${user.email} for verification link.'),
                backgroundColor: Theme.of(ctx).accentColor),
          );
        }
      }
    } on PlatformException catch (err) {
      // If error occurs, gather error message...
      var message = 'An error occurred, pelase check your credentials!';
      if (err.message != null) message = err.message!;

      // ...and display to user as "Snack bar" pop-up at bottom of screen
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );

      // Dis-engage loading screen
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      // If other unknown error, log to console and dis-engage loading screen
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  ////////////////////////////////////////////////////////////////
  // Primary Flutter method overriden which describes the layout
  // and bindings for this widget.
  ////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: LayoutBuilder(
        builder: (ctx, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: constraints.maxWidth * 0.6,
                child: Image.asset('assets/images/globe_logo_black.png',
                    fit: BoxFit.cover),
              ),
              AuthForm(
                _submitAuthForm,
                _isLoading,
              ),
            ],
          );
        },
      ),
    );
  }
}
