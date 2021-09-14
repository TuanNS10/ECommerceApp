import 'dart:io';

import 'package:ecommerce_app/consts/colors.dart';
import 'package:ecommerce_app/services/global_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/SignupScreen';

  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  bool _obscureText = true;
  String _fullName = '';
  String _emailAddress = '';
  String _password = '';
  String _phoneNumber = '';
  File? _pickedImage;
  String url = '';
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalMethods _globalMethods = GlobalMethods();
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    var date = DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formatDate =
        '${dateParse.day} - ${dateParse.month} - ${dateParse.year}';
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();
      try {
        if (_pickedImage == null) {
          _globalMethods.authErrorHandle('Please pick an image', context);
          print('Please pick an image');
        } else {
          final ref = FirebaseStorage.instance
              .ref()
              .child('usersImages')
              .child(_fullName + '.jpg');
          await ref.putFile(_pickedImage!);
          url = await ref.getDownloadURL();

          await _auth.createUserWithEmailAndPassword(
              email: _emailAddress.toLowerCase().trim(),
              password: _password.trim());
          final User? user = _auth.currentUser;
          final _uid = user!.uid;
          await FirebaseFirestore.instance.collection('users').doc(_uid).set({
            'id': _uid,
            'name': _fullName,
            'email': _emailAddress,
            'phoneNumber': _phoneNumber,
            'imageUrl': url,
            'joinedAt': formatDate,
            'createAt': Timestamp.now(),
          });
        }
        Navigator.canPop(context) ? Navigator.pop(context) : null;
      } catch (error) {
        _globalMethods.authErrorHandle(error.toString(), context);
        print('Error occurred $error');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _remove() {
    setState(() {
      _pickedImage = null;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            /*******Region wave *********/
            Container(
              height: MediaQuery.of(context).size.height * 0.95,
              child: RotatedBox(
                quarterTurns: 2,
                child: WaveWidget(
                  config: CustomConfig(
                      gradients: [
                        [
                          ColorsConsts.gradiendFStart,
                          ColorsConsts.gradiendLStart
                        ],
                        [ColorsConsts.gradiendFEnd, ColorsConsts.gradiendLEnd]
                      ],
                      durations: [
                        19440,
                        10800
                      ],
                      heightPercentages: [
                        0.20,
                        0.25
                      ],
                      blur: MaskFilter.blur(BlurStyle.solid, 10),
                      gradientBegin: Alignment.bottomLeft,
                      gradientEnd: Alignment.topRight),
                  waveAmplitude: 0,
                  size: Size(double.infinity, double.infinity),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 30),
                Stack(
                  children: [
                    /*****Region Image avatar**********/
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                      child: CircleAvatar(
                        radius: 71,
                        backgroundColor: ColorsConsts.gradiendLEnd,
                        child: CircleAvatar(
                          radius: 71,
                          backgroundColor: ColorsConsts.gradiendFEnd,
                          backgroundImage: _pickedImage == null
                              ? null
                              : FileImage(_pickedImage!),
                        ),
                      ),
                    ),
                    /******Region process upload image************/
                    Positioned(
                        top: 120,
                        left: 110,
                        child: RawMaterialButton(
                          elevation: 0,
                          fillColor: ColorsConsts.gradiendLEnd,
                          child: Icon(Icons.add_a_photo),
                          padding: EdgeInsets.all(15.0),
                          shape: CircleBorder(),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Choose option',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: ColorsConsts.gradiendLStart),
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
                                          InkWell(
                                            onTap: _pickImageCamera,
                                            splashColor: Colors.purple,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.camera,
                                                    color: Colors.purpleAccent,
                                                  ),
                                                ),
                                                Text(
                                                  'Camera',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          ColorsConsts.title),
                                                )
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: _pickImageGallery,
                                            splashColor: Colors.purple,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.image,
                                                    color: Colors.purpleAccent,
                                                  ),
                                                ),
                                                Text(
                                                  'Gallery',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          ColorsConsts.title),
                                                )
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: _remove,
                                            splashColor: Colors.purple,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.remove_circle,
                                                    color: Colors.purpleAccent,
                                                  ),
                                                ),
                                                Text(
                                                  'Remove',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.red),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                        ))
                  ],
                ),
                /*****TextFiled Register*******/
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            key: ValueKey('FullName'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Name cannot be null';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_emailFocusNode),
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                filled: true,
                                prefixIcon: Icon(Icons.person),
                                labelText: 'Full Name',
                                fillColor: Theme.of(context).backgroundColor),
                            onSaved: (value) {
                              _fullName = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            key: ValueKey('email'),
                            focusNode: _emailFocusNode,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_passwordFocusNode),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                filled: true,
                                prefixIcon: Icon(Icons.email),
                                labelText: 'Email Address',
                                fillColor: Theme.of(context).backgroundColor),
                            onSaved: (value) {
                              _emailAddress = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            key: ValueKey('password'),
                            focusNode: _passwordFocusNode,
                            validator: (value) {
                              String pattern =
                                  r'(^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$)';
                              RegExp regExp = new RegExp(pattern);
                              if (value!.length == 0) {
                                return 'Please enter your password';
                              } else if (!regExp.hasMatch(value)) {
                                return 'Please enter valid minimum eight characters';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                filled: true,
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(_obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                                labelText: 'Password',
                                fillColor: Theme.of(context).backgroundColor),
                            onSaved: (value) {
                              _password = value!;
                            },
                            obscureText: _obscureText,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_phoneNumberFocusNode),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            key: ValueKey('phoneNumber'),
                            focusNode: _phoneNumberFocusNode,
                            validator: (value) {
                              String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                              RegExp regExp = new RegExp(pattern);
                              if (value!.length == 0) {
                                return 'Please enter mobile number';
                              } else if (!regExp.hasMatch(value)) {
                                return 'Please enter valid mobile number';
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textInputAction: TextInputAction.next,
                            onEditingComplete: _submitForm,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                filled: true,
                                prefixIcon: Icon(Icons.email),
                                labelText: 'Phone Number',
                                fillColor: Theme.of(context).backgroundColor),
                            onSaved: (value) {
                              _phoneNumber = value!;
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            _isLoading
                                ? CircularProgressIndicator()
                                : ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color:
                                                ColorsConsts.backgroundColor),
                                      ),
                                    )),
                                    onPressed: _submitForm,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Sign up',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Feather.user_plus,
                                          size: 18,
                                        )
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              width: 20,
                            )
                          ],
                        )
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
