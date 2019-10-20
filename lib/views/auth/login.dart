import 'package:flutter/material.dart';
import './register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool _isObscure = true;
  bool _isLoading = false;
  Color _eyeColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 22.0),
          children: <Widget>[
            SizedBox(
              height: kToolbarHeight,
            ),
            Padding(
              padding: EdgeInsets.only(left: 0, top: 20.0),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 42.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 0, top: 15.0, bottom: 30.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  color: Colors.black,
                  width: 40.0,
                  height: 2.0,
                ),
              ),
            ),
            TextFormField(
              onSaved: (String value) => _email = value,
              decoration: InputDecoration(
                labelText: '邮箱',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return '请输入邮箱';
                }
                var emailReg = RegExp(
                    r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
                if (!emailReg.hasMatch(value)) {
                  return '请输入正确的邮箱地址';
                }
                return null;
              },
            ),
            SizedBox(height: 30.0),
            TextFormField(
              onSaved: (String value) => _password = value,
              obscureText: _isObscure,
              validator: (value) {
                if (value.isEmpty) {
                  return '请输入密码';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: '密码',
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: _eyeColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                      _eyeColor = _isObscure
                          ? Colors.grey
                          : Theme.of(context).iconTheme.color;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 60.0),
            Align(
              child: SizedBox(
                height: 45.0,
                width: 270.0,
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  child: Text(
                    '登录',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('没有账号？'),
                    GestureDetector(
                      child: Text(
                        '点击注册',
                        style: TextStyle(color: Colors.green),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => Register(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
