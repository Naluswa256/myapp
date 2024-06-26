import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AuthForm extends StatefulWidget {
  const AuthForm(this.submitFn, this.isLoading, {Key? key}) : super(key: key);

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return _buildWideLayout();
        } else {
          return _buildNarrowLayout();
        }
      },
    );
  }

  Widget _buildWideLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildHeaderText(),
                  const SizedBox(height: 20),
                  _buildForm(),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Image.asset(
            'assets/images/background_2.jpg', // Replace with your image asset path
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
          ),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildHeaderText(),
            const SizedBox(height: 20),
            _buildForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(15.0, 50.0, 0.0, 0.0),
          child: const Text('Hi',
              style: TextStyle(
                  color: Color.fromRGBO(253, 111, 150, 1),
                  fontSize: 80.0,
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.bold)),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(15.0, 125.0, 0.0, 0.0),
          child: DefaultTextStyle(
            style: const TextStyle(
              fontFamily: "Raleway",
              fontSize: 80.0,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(111, 105, 172, 1),
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText("There"),
                WavyAnimatedText('Again'),
              ],
              isRepeatingAnimation: false,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(235.0, 125.0, 0.0, 0.0),
          child: const Text('.',
              style: TextStyle(
                  fontSize: 80.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(111, 105, 172, 1))),
        )
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.80,
            child: TextFormField(
              key: const ValueKey('email'),
              decoration: const InputDecoration(
                labelText: 'EMAIL',
                labelStyle: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              enableSuggestions: false,
              validator: (value) {
                if (value!.isEmpty || !value.contains('@')) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
              onSaved: (value) {
                _userEmail = value!;
              },
            ),
          ),
          if (!_isLogin) const SizedBox(height: 20.0),
          if (!_isLogin)
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.80,
              child: TextFormField(
                key: const ValueKey('username'),
                decoration: const InputDecoration(
                  labelText: 'USERNAME',
                  labelStyle: TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                autocorrect: true,
                textCapitalization: TextCapitalization.words,
                enableSuggestions: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
                onSaved: (value) {
                  _userName = value!;
                },
              ),
            ),
          SizedBox(height: 20.0),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.80,
            child: TextFormField(
              key: const ValueKey('password'),
              decoration: const InputDecoration(
                labelText: 'PASSWORD',
                labelStyle: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty || value.length < 7) {
                  return 'Please enter a long password';
                }
                return null;
              },
              onSaved: (value) {
                _userPassword = value!;
              },
            ),
          ),
          SizedBox(height: 35),
          if (widget.isLoading)
            const CircularProgressIndicator(),
          if (!widget.isLoading)
            Container(
              height: 57.0,
              width: MediaQuery.of(context).size.width * 0.80,
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.black,
                color: const Color.fromRGBO(111, 105, 172, 1),
                elevation: 10.0,
                child: TextButton(
                  onPressed: _trySubmit,
                  child: Center(
                    child: Text(
                      _isLogin ? "Login" : "Sign up",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          SizedBox(height: 25),
          if (!widget.isLoading)
            Container(
              height: 57.0,
              child: Material(
                borderRadius: BorderRadius.circular(40.0),
                color: Colors.white,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Center(
                    child: Text(
                      _isLogin
                          ? "Create new account"
                          : "I already have an account",
                      style: const TextStyle(
                        color: Color.fromRGBO(253, 111, 150, 1),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          SizedBox(height: 25),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
          ),
        ],
      ),
    );
  }
}
