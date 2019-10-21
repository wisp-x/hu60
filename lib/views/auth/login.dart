import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// import './register.dart';
import '../../api/http.dart';
import '../../store/user.dart';
import '../../component/loading_dialog.dart';
import '../../model/user.dart' as UserModel;
import '../../model/login.dart' as LoginModel;
import '../home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _mobile, _password;
  bool _isObscure = true;
  Color _eyeColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Consumer<User>(
          builder: (context, User user, _) => Form(
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
                      padding:
                          EdgeInsets.only(left: 0, top: 15.0, bottom: 30.0),
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
                      onSaved: (String value) => _mobile = value,
                      decoration: InputDecoration(
                        labelText: '手机号',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return '请输入手机号';
                        }
                        /*var emailReg = RegExp(
                    r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
                if (!emailReg.hasMatch(value)) {
                  return '请输入正确的邮箱地址';
                }*/
                        _mobile = value;
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
                        _password = value;
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
                        child: Builder(
                          builder: (BuildContext context) {
                            return RaisedButton(
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
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  _login(context);
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    /*SizedBox(height: 30.0),
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
            ),*/
                  ],
                ),
              )),
    );
  }

  // ignore: missing_return
  Future<Widget> _login(context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new LoadingDialog(
          text: '登录中...',
        );
      },
    );
    Http.request(
      'user.login.json',
      data: {"type": 3, "name": _mobile, "pass": _password, "go": '登录'},
      method: Http.POST,
    ).then((result) {
      Navigator.of(context).pop();

      LoginModel.Login data = LoginModel.Login.fromJson(result.data);
      if (data.sid != null) {
        preferences.setString('sid', data.sid);

        /// 根据sid获取用户数据
        String sid = preferences.get("sid");
        if (sid != null) {
          Http.request('user.index.json').then((response) {
            /// preferences.setString('user', response.data.toString());
            UserModel.User user = UserModel.User.fromJson(response.data);
            if (user.name != null) {
              Provider.of<User>(context, listen: false).setUserInfo(user);
              /// 回到首页
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 160),
                  pageBuilder: (
                      BuildContext context,
                      Animation animation,
                      Animation secondaryAnimation,
                      ) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -1),
                        end: Offset.zero,
                      ).animate(animation),
                      child: Home(),
                    );
                  },
                ),
                    (route) => route == null,
              );
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("发生异常"),
                    content: Text("接口异常, 请稍后重试"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("确认"),
                      ),
                    ],
                  );
                },
              );
            }
          });
        }
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(data.notice),
            action: SnackBarAction(
              label: "好的",
              onPressed: () {},
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
