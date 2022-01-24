
import 'package:flutter/material.dart';
class AuthForm extends StatefulWidget {

  final void  Function(String email, String password, String username,String phone, bool isLogin, BuildContext ctx) submitFn;
  final bool isLoading;
  AuthForm(this.submitFn,this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _email = '';
  String _password = '';
  String _username = '';
  String _phone = '';

  void _submit()
  {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();



    if(isValid)
    {
      _formKey.currentState!.save();
      widget.submitFn(
          _email.trim(),_password.trim(),_username.trim(),_phone.trim(),_isLogin,context
      );
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
                TextFormField(
                  key: ValueKey('email'),
                  validator: (val){
                    if(val!.isEmpty|| !val.contains('@')){
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onSaved: (val)=>_email=val!,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email Address'),
                ),
                if(!_isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    validator: (val){
                      if(val!.isEmpty||val.length<4){
                        return 'Please enter at least 4 characters';
                      }
                      return null;
                    },
                    onSaved: (val)=>_username=val!,
                    decoration: InputDecoration(labelText: 'Full Name'),
                  ),

                TextFormField(
                  key: ValueKey('phone'),
                  validator: (val){
                    if(val!.isEmpty|| val.length<11){
                      return 'Please enter a valid Phone Number';
                    }
                    return null;
                  },
                  onSaved: (val)=>_phone=val!,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                ),

                TextFormField(
                  key: ValueKey('password'),
                  validator: (val){
                    if(val!.isEmpty||val.length<7)
                    {
                      return 'password must be at least 7 characters';
                    }
                    return null;
                  },
                  onSaved: (val)=>_password=val!,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 12,),

                if(widget.isLoading)
                  CircularProgressIndicator(),
                if(!widget.isLoading)
                  ElevatedButton(child: Text(_isLogin?'Login':'Sign Up'),onPressed: _submit),
                //if(!widget.isLoading)
                TextButton(onPressed: (){

                  setState(() {
                    _isLogin=!_isLogin;
                  });
                }, child: Text(_isLogin?'Create new account':'I already have an account'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
