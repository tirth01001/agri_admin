

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/widget/input.dart';

class AdminSecuritySettings extends StatefulWidget {
  @override
  _AdminSecuritySettingsState createState() => _AdminSecuritySettingsState();
}

class _AdminSecuritySettingsState extends State<AdminSecuritySettings> {
  bool is2FAEnabled = false;
  bool sessionTimeoutEnabled = false;
  TextEditingController timeoutController = TextEditingController();
  TextEditingController ipController = TextEditingController();

  @override
  void dispose() {
    timeoutController.dispose();
    ipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Security Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Two-Factor Authentication
            SwitchListTile(
              title: Text("Enable Two-Factor Authentication (2FA)"),
              subtitle: Text("Increase security by requiring a second factor."),
              value: is2FAEnabled,
              onChanged: (bool value) {
                setState(() {
                  is2FAEnabled = value;
                });
              },
            ),
            
            // Session Timeout
            SwitchListTile(
              title: Text("Enable Session Timeout"),
              subtitle: Text("Auto logout after inactivity."),
              value: sessionTimeoutEnabled,
              onChanged: (bool value) {
                setState(() {
                  sessionTimeoutEnabled = value;
                });
              },
            ),
            const SizedBox(height: 10,),
            if (sessionTimeoutEnabled)
              InputField(
                controller: timeoutController,
                hint: "Timeout Duration (minutes)",
              ),
          ],
        ),
      ),
    );
  }
}
