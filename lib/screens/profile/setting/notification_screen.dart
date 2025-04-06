


import 'package:flutter/material.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/widget/button.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class AdminNotificationSettings extends StatefulWidget {
  
  const AdminNotificationSettings({super.key});

  @override
  _AdminNotificationSettingsState createState() => _AdminNotificationSettingsState();
}

class _AdminNotificationSettingsState extends State<AdminNotificationSettings> {
  bool pushNotifications = false;
  bool emailNotifications = false;
  bool smsAlerts = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Notification Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Push Notifications
            SwitchListTile(
              title: Text("Enable Push Notifications"),
              subtitle: Text("Receive push notifications for important updates."),
              value: pushNotifications,
              onChanged: (bool value) {
                setState(() {
                  pushNotifications = value;
                });
              },
            ),
            
            // Email Notifications
            SwitchListTile(
              title: Text("Enable Email Notifications"),
              subtitle: Text("Get email alerts for user registration, purchases, etc."),
              value: emailNotifications,
              onChanged: (bool value) {
                setState(() {
                  emailNotifications = value;
                });
              },
            ),
            
            // SMS Alerts
            SwitchListTile(
              title: Text("Enable SMS Alerts"),
              subtitle: Text("Receive SMS notifications for specific events."),
              value: smsAlerts,
              onChanged: (bool value) {
                setState(() {
                  smsAlerts = value;
                });
              },
            ),
            
            SizedBox(height: 20),
            
            // Save Button
            Button(
              width: maxW-40,
              height: 40,
              prefixIcon: Icon(IconlyBold.notification,color: Colors.white,),
              text: "Save Setting",
              onTap: (){},
            ),
          ],
        ),
      ),
    );
  }
}

