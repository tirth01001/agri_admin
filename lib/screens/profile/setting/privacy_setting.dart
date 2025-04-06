

import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Effective Date: March 29, 2025',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 20),
              Text(
                '''We value your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and disclose information when you use our services.

1. **Information We Collect**  
   We collect personal information when you register for our services, use our app, or interact with us in other ways. This may include:
   - Personal information such as your name, email address, and contact details.
   - Usage data including how you interact with our app.

2. **How We Use Your Information**  
   We use the information we collect to:
   - Provide, improve, and personalize our services.
   - Respond to customer service inquiries.
   - Comply with legal obligations.

3. **Sharing Your Information**  
   We do not share your personal data with third parties except in the following cases:
   - With service providers who assist us in operating our services.
   - If required by law or to protect our rights.

4. **GDPR Compliance**  
   If you are located in the European Union (EU), you have rights under the General Data Protection Regulation (GDPR), including the right to access, correct, and delete your personal data. You can also withdraw your consent to process your data at any time.

5. **Data Security**  
   We take reasonable measures to protect your personal information from unauthorized access, alteration, disclosure, or destruction. However, no security system is completely secure, and we cannot guarantee the absolute security of your data.

6. **Cookies and Tracking Technologies**  
   We may use cookies to improve the functionality of our services and to analyze how our services are used.

7. **Changes to This Policy**  
   We may update our Privacy Policy from time to time. Any changes will be posted on this page with an updated effective date.

8. **Contact Us**  
   If you have any questions about this Privacy Policy or wish to exercise your rights, please contact us at:
   - Email: privacy@yourcompany.com
   - Address: 123 Privacy St., Privacy City, Country

By using our app, you consent to our Privacy Policy and agree to our terms of service.
''',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
