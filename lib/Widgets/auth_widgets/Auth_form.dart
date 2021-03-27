import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String username,
      bool isLogin, BuildContext ctx) submitFn;
  final bool _isLoading;
  AuthForm(this.submitFn ,this._isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _email = '';
  String _password = '';
  String _username = '';

  get googleSignIn => null;
  void _submit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
          _email.trim(), _password.trim(), _username.trim(), _isLogin, context);
    }
  }
  void handleSignIn()async{
    final GoogleSignIn googleSignIn =GoogleSignIn();
    try{
      await googleSignIn.signIn();
      print('signed in');
    }catch(e){
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
                  onSaved: (val) => _email = val,
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
                    onSaved: (val) => _username = val,
                    decoration: InputDecoration(labelText: "Username"),
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
                if(widget._isLoading)
                  CircularProgressIndicator(),
                if(!widget._isLoading)
                ElevatedButton(
                  child: Text(_isLogin ? 'Login' : 'Sign Up'),
                  onPressed: _submit,
                ),
                if(!widget._isLoading)
                  ElevatedButton(
                    child: Text('sign in with google'),
                    onPressed: handleSignIn,
                  ),
                if(!widget._isLoading)
                TextButton(
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
