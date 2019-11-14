import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' show Client;
import 'package:share/share.dart';

List<CameraDescription> cameras;
GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class PluginTest extends StatefulWidget {
  @override
  PluginTestState createState() => PluginTestState();
}

class PluginTestState extends State<PluginTest> {
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  Client client = Client();

  CameraController controller;

  File _image;

  @override
  void initState() {
    super.initState();
    print(cameras);
    // controller = CameraController(cameras[0], ResolutionPreset.medium);
    // controller.initialize().then((_) {
    //   if (!mounted) {
    //     return;
    //   }
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future fetchProfileDate(token) async {
    var graphResponse = await client.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');

    var profile = json.decode(graphResponse.body);
    print(profile.toString());
  }

  Future<Null> _facebookLogin() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        print(accessToken.token);
        fetchProfileDate(accessToken.token);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  void _share() {
    Share.share('check out my website https://example.com');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plugin Test List'),
      ),
      // body: Center(
      //   child: _image == null ? Text('No image selected.') : Image.file(_image),
      // ),
      body: Column(
        children: <Widget>[
          Container(
            child: GestureDetector(
              child: Text(
                "GOOGLE SIGN IN",
                style: TextStyle(fontSize: 20),
              ),
              onTap: _handleSignIn,
            ),
            margin: EdgeInsets.all(16),
          ),
          Container(
            child: GestureDetector(
              child: Text(
                "FACEBOOK SIGN IN",
                style: TextStyle(fontSize: 20),
              ),
              onTap: _facebookLogin,
            ),
            margin: EdgeInsets.all(16),
          ),
          Container(
            child: GestureDetector(
              child: Text(
                "SHARE",
                style: TextStyle(fontSize: 20),
              ),
              onTap: _share,
            ),
            margin: EdgeInsets.all(16),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   if (!controller.value.isInitialized) {
  //     return Container();
  //   }
  //   return AspectRatio(
  //       aspectRatio: controller.value.aspectRatio,
  //       child: CameraPreview(controller));
  // }
}
