import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:solution_challenge_project/models/user.dart';

class AuthForm extends StatefulWidget {
  final void Function(
          UserAccount user, String password, bool isLogin, BuildContext ctx)
      submitFn;
  final bool _isLoading;
  AuthForm(this.submitFn, this._isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin;
  String _password;
  UserAccount user;

  @override
  void initState() {
    super.initState();
    user = UserAccount();
    _password = '';
    _isLogin = true;
  }

  void _submit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      user.status = 'away';
      widget.submitFn(user, _password.trim(), _isLogin, context);
    }
  }

  void handleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      /// [Important] add your sha1 fingerprint to firebase before building the apk.
      /// [sha1 command] keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
      await googleSignIn.signIn();
      print('signed in');
      print(googleSignIn.currentUser.email);
      print(googleSignIn.currentUser.displayName);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ///for email
                TextFormField(
                  key: ValueKey('email'),
                  validator: (val) {
                    if (!EmailValidator.validate(val))
                      return 'Please Enter a valid Email!';
                    return null;
                  },
                  onSaved: (val) => user.email = val,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Email Address"),
                ),

                ///if not login ,for username
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    validator: (val) {
                      if (val.isEmpty || val.length < 6)
                        return "Please enter at least 6 characters";
                      return null;
                    },
                    onSaved: (val) => user.name = val,
                    decoration: InputDecoration(labelText: "Username"),
                  ),
                if (!_isLogin)

                  ///for city
                  TextFormField(
                    key: ValueKey('city'),
                    validator: (val) {
                      if (val.isEmpty) return 'Please Enter a your City!';
                      return null;
                    },
                    onSaved: (val) => user.city = val,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: "City"),
                  ),
                if (!_isLogin)

                  ///for country
                  TextFormField(
                    key: ValueKey('country'),
                    validator: (val) {
                      if (val.isEmpty) return 'Please Enter a your Country!';
                      return null;
                    },
                    onSaved: (val) => user.country = val,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: "Country"),
                  ),
                if (!_isLogin)

                  ///for phone number
                  TextFormField(
                    key: ValueKey('phone'),
                    validator: (val) {
                      if (val.isEmpty)
                        return 'Please Enter a your Phone Number!';
                      return null;
                    },
                    onSaved: (val) => user.phone = val,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(labelText: "Phone Number"),
                  ),

                ///for password
                TextFormField(
                  key: ValueKey('password'),
                  onSaved: (val) => _password = val,
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
                SizedBox(
                  height: 12,
                ),

                ///for password
                TextFormField(
                  key: ValueKey('password'),
                  onSaved: (val) => _password = val,
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
                if (widget._isLoading) CircularProgressIndicator(),
                if (!widget._isLoading)
                  RaisedButton(
                    child: Text(_isLogin ? 'Login' : 'Sign Up'),
                    onPressed: _submit,
                  ),
                if (!widget._isLoading)
                  RaisedButton(
                    child: Text('sign in with google'),
                    onPressed: handleSignIn,
                  ),
                if (!widget._isLoading)
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(_isLogin
                        ? "Create New account"
                        : "i already have an account"),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
