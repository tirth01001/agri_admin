


import 'package:flutter/material.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/widget/button.dart';
import 'package:flutter_dashboard/widget/input_form.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class EditLocationScreen extends StatefulWidget {
  
  const EditLocationScreen({super.key});

  @override
  _EditLocationScreenState createState() => _EditLocationScreenState();
}

class _EditLocationScreenState extends State<EditLocationScreen> {
  // Controllers for each form field
  final _formKey = GlobalKey<FormState>();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _countryController = TextEditingController();

  // Method to handle form submission
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Process form data
      print('Street: ${_streetController.text}');
      print('City: ${_cityController.text}');
      print('State: ${_stateController.text}');
      print('Zip Code: ${_zipCodeController.text}');
      print('Country: ${_countryController.text}');
      // You can now save this data or update it to a database
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Location Updated!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address'),
        // backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Street Name TextField
                InputFormField(
                  controller: _streetController,
                  hint: 'Street Address',
                  prefix: const Icon(IconlyLight.location),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the street address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // City TextField
                InputFormField(
                  controller: _cityController,
                  hint: 'City',
                  prefix: const Icon(Icons.location_city),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the city';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // State TextField
                InputFormField(
                  controller: _stateController,
                  hint: 'State',
                  prefix: const Icon(Icons.flag),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the state';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Zip Code TextField
                InputFormField(
                  controller: _zipCodeController,
                  hint: 'Zip Code',
                  prefix: const Icon(Icons.code),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the zip code';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Country TextField
                InputFormField(
                  controller: _countryController,
                  hint: 'Country',
                  prefix: const Icon(Icons.public),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the country';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40),

                // Submit Button
                Button(
                  width: maxW-40,
                  height: 50,
                  prefixIcon: const Icon(IconlyBold.upload,color: Colors.white,),
                  onTap: _submitForm,
                  text: 'Update Location',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EditLocationScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
