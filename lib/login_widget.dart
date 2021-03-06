import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madar_booking/MainButton.dart';
import 'package:madar_booking/auth_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/models/user.dart';
import 'feedback.dart';

class LoginWidget extends StatefulWidget {
  @override
  LoginWidgetState createState() => LoginWidgetState();
}

class LoginWidgetState extends State<LoginWidget> with UserFeedback {
  final FocusNode myFocusNodeEmailLogin = FocusNode();

  final FocusNode myFocusNodePasswordLogin = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();

  TextEditingController loginPasswordController = new TextEditingController();

  AuthBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: bloc.submitLoginStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showInSnackBar(snapshot.data.userName, context);
          });
        }
        return Container(
          padding: EdgeInsets.only(top: 23.0),
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                overflow: Overflow.visible,
                children: <Widget>[
                  Card(
                    elevation: 2.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      width: 300.0,
                      height: 180.0,
                      child: Column(
                        children: <Widget>[
                          phoneTextField(),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          passwordTextField(),
                        ],
                      ),
                    ),
                  ),
                  loginBtn(),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                          fontSize: 16.0,
                          fontFamily: "WorkSansMedium"),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        gradient: new LinearGradient(
                            colors: [
                              Colors.white10,
                              Colors.white,
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 1.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      width: 100.0,
                      height: 1.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Text(
                        "Or",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily: "WorkSansMedium"),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: new LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white10,
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 1.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      width: 100.0,
                      height: 1.0,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, right: 40.0),
                    child: GestureDetector(
//                  onTap: () => showInSnackBar("Facebook button pressed"),
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: new Icon(
                          FontAwesomeIcons.facebookF,
                          color: Color(0xFF0084ff),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: GestureDetector(
//                  onTap: () => showInSnackBar("Google button pressed"),
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: new Icon(
                          FontAwesomeIcons.google,
                          color: Color(0xFF0084ff),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget phoneTextField() {
    return StreamBuilder<String>(
      stream: bloc.phoneLoginStream,
      builder: (context, snapshot) {
        return Padding(
          padding:
              EdgeInsets.only(top: 20.0, bottom: 8.0, left: 25.0, right: 25.0),
          child: Container(
            height: 60,
            child: TextField(
              focusNode: myFocusNodeEmailLogin,
              controller: loginEmailController,
              keyboardType: TextInputType.emailAddress,
              onChanged: bloc.changePhoneEmail,
              style: TextStyle(
                  fontFamily: "WorkSansSemiBold",
                  fontSize: 16.0,
                  color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                errorText: snapshot.error,
                icon: Icon(
                  FontAwesomeIcons.mobile,
                  color: Colors.black,
                  size: 22.0,
                ),
                hintText: "Phone Number",
                hintStyle:
                    TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 17.0),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget passwordTextField() {
    return StreamBuilder<String>(
      stream: bloc.passwordLoginStream,
      builder: (context, passwordSnapshot) {
        return StreamBuilder<bool>(
          initialData: true,
          stream: bloc.obscureLoginPasswordStream,
          builder: (context, snapshot) {
            return Padding(
              padding: EdgeInsets.only(top: 8.0, left: 25.0, right: 25.0),
              child: Container(
                height: 60,
                child: TextField(
                  focusNode: myFocusNodePasswordLogin,
                  controller: loginPasswordController,
                  obscureText: snapshot.data,
                  onChanged: bloc.changeLoginPassword,
                  style: TextStyle(
                      fontFamily: "WorkSansSemiBold",
                      fontSize: 16.0,
                      color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(
                      FontAwesomeIcons.lock,
                      size: 22.0,
                      color: Colors.black,
                    ),
                    errorText: passwordSnapshot.error,
                    hintText: "Password",
                    hintStyle: TextStyle(
                        fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                    suffixIcon: GestureDetector(
                      onTap: () => bloc.pushObscureLoginPassword,
                      child: Icon(
                        FontAwesomeIcons.eye,
                        size: 15.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget loginBtn() {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MainButton(
            text: 'Submit',
            onPressed: () {
              bloc.pushStartLoading;
            },
            width: 150,
            height: 50,
            loading: false,
          );
        }
          return MainButton(
            text: 'Submit',
            onPressed: () {
//              bloc.pushStopLoading;
            },
            width: 150,
            height: 50,
            loading: true,
          );
      },
    );
  }
}
