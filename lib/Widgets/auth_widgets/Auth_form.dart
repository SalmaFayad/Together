import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey =GlobalKey <FormState>();
  bool _islogin=true;
  String _email='';
  String _password='';
  String _username='';
  void _submit(){
    final isValid =_formkey.currentState.validate();
    FocusScope.of(context).unfocus();
    if(isValid){
      _formkey.currentState.save();
      print(_email);
      print(_username);
      print(_password);
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
            key: _formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ///for email
                TextFormField(
                  key: ValueKey('email'),
                  validator: (val){
                    if(!EmailValidator.validate(val))
                      return 'Please Enter a valid Email!';
                    return null;
                  },
                  onSaved: (val)=> _email=val,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Email Address"),
                ),
                ///if not login ,for username
                if(!_islogin)
                TextFormField(
                  key: ValueKey('username'),
                  validator: (val){
                    if(val.isEmpty || val.length<6)
                      return "Please enter al least 6 characters";
                    return null;
                  },
                  onSaved: (val) => _username=val,
                  decoration: InputDecoration(labelText: "Username"),
                ),
                ///for password
                TextFormField(
                  key: ValueKey('password'),
                  validator: (val){
                    if(val.isEmpty || val.length<8)
                      return "Password must be al least 8 characters";
                    return null;
                  },
                  onSaved: (val)=> _password=val,
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
                SizedBox( height: 12,),
                RaisedButton(
                  child: Text(_islogin ? 'Login': 'Sign Up'),
                    onPressed: _submit,
                ),
                FlatButton(
                  child: Text(_islogin?
                  "Create New account"
                  :"i already have an account"),
                  onPressed:(){
                    setState(() {
                      _islogin=!_islogin;
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