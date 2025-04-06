


import 'package:flutter/material.dart';
import 'package:flutter_dashboard/firebase/firebase_service.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/splesh_screen.dart';
import 'package:flutter_dashboard/widget/button.dart';
import 'package:flutter_dashboard/widget/input.dart';
import 'package:flutter_dashboard/widget/input_form.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController(
    text: globalAuthModel.name
  );
  TextEditingController emailController = TextEditingController(
    text: globalAuthModel.email
  );
  TextEditingController mobileController = TextEditingController(
    text: globalAuthModel.mobile
  );
  TextEditingController passwordController = TextEditingController(

  );
  TextEditingController securityAnswerController = TextEditingController();

  // Dummy data for profile picture
  String profilePictureUrl = 'https://www.example.com/default_profile_pic.jpg';


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(IconlyLight.arrowLeft)),
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Picture
              GestureDetector(
                onTap: () {
                  // Implement image picker functionality here
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(profilePictureUrl),
                  child: Icon(Icons.camera_alt, size: 50, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              // Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Name Field
                    InputFormField(
                      controller: nameController,
                      hint: "Name",
                      prefix: Icon(Icons.person),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    // TextFormField(
                    //   controller: nameController,
                    //   decoration: InputDecoration(
                    //     labelText: 'Name',
                    //     border: OutlineInputBorder(),
                    //     prefixIcon: Icon(Icons.person),
                    //   ),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter your name';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    SizedBox(height: 20),
                    // Email Field
                    InputFormField(
                      controller: emailController,
                      hint: "Email Address",
                      prefix: Icon(Icons.email),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    // TextFormField(
                    //   controller: emailController,
                    //   decoration: InputDecoration(
                    //     labelText: 'Email',
                    //     border: OutlineInputBorder(),
                    //     prefixIcon: Icon(Icons.email),
                    //   ),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter your email';
                    //     }
                    //     if (!RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(value)) {
                    //       return 'Please enter a valid email';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    SizedBox(height: 20),
                    // Mobile Number Field

                    InputFormField(
                      controller: mobileController,
                      hint: "Mobile Number",
                      prefix: Icon(Icons.call),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mobile number';
                        }
                        if (value.length != 10) {
                          return 'Mobile number must be 10 digits';
                        }
                        return null;
                      },
                    ),

                    // TextFormField(
                    //   controller: mobileController,
                    //   decoration: InputDecoration(
                    //     labelText: 'Mobile Number',
                    //     border: OutlineInputBorder(),
                    //     prefixIcon: Icon(Icons.phone),
                    //   ),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter your mobile number';
                    //     }
                    //     if (value.length != 10) {
                    //       return 'Mobile number must be 10 digits';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    SizedBox(height: 20),
                    // Password Field
                    // TextFormField(
                    //   controller: passwordController,
                    //   decoration: InputDecoration(
                    //     labelText: 'Password',
                    //     border: OutlineInputBorder(),
                    //     prefixIcon: Icon(Icons.lock),
                    //   ),
                    //   obscureText: true,
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter your password';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // SizedBox(height: 20),
                    // // Security Answer Field
                    // TextFormField(
                    //   controller: securityAnswerController,
                    //   decoration: InputDecoration(
                    //     labelText: 'Security Question Answer',
                    //     border: OutlineInputBorder(),
                    //     prefixIcon: Icon(Icons.security),
                    //   ),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please answer the security question';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    SizedBox(height: 20),
                    // Update Button
                    Button(
                      width: maxW-40,
                      height: 50,
                      text: "Update",
                      prefixIcon: Icon(IconlyBold.upload,color: Colors.white,),
                      onTap: ()  {
                        if (_formKey.currentState?.validate() ?? false) {

                          globalAuthModel.name = nameController.text;
                          globalAuthModel.email = emailController.text;
                          globalAuthModel.mobile = mobileController.text;
                          FirebaseService.service.updateProfile();
                          // Implement update functionality here
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Profile Updated')),
                          );
                        }
                      },
                    ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     if (_formKey.currentState?.validate() ?? false) {
                    //       // Implement update functionality here
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //         SnackBar(content: Text('Profile Updated')),
                    //       );
                    //     }
                    //   },
                    //   child: Text('Update'),
                    //   style: ElevatedButton.styleFrom(
                    //     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    //     textStyle: TextStyle(fontSize: 16),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
