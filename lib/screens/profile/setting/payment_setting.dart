import 'package:flutter/material.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/widget/button.dart';
import 'package:flutter_dashboard/widget/input.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class AdminPaymentSettings extends StatefulWidget {
  @override
  _AdminPaymentSettingsState createState() => _AdminPaymentSettingsState();
}

class _AdminPaymentSettingsState extends State<AdminPaymentSettings> {
  String selectedGateway = 'Stripe';
  TextEditingController minTransactionController = TextEditingController();
  TextEditingController maxTransactionController = TextEditingController();
  String selectedCurrency = 'USD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment & Billing Settings", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCard(
              title: "Payment Gateway",
              icon: Icons.card_giftcard,
              child: DropdownButtonFormField(
                value: selectedGateway,
                items: ["Stripe", "PayPal", "Razorpay"].map((gateway) {
                  return DropdownMenuItem(value: gateway, child: Text(gateway));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGateway = value.toString();
                  });
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  // enabled: !isDisable,
                  enabledBorder: InputBorder.none,
                  // hintText: hint,
                  // prefixIcon: prefix,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFBDBDBD),
                  ),
                  labelStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF212121),
                  ),
                ),
              ),
            ),
            
            _buildCard(
              title: "Transaction Limits",
              icon: Icons.change_circle,
              child: Row(
                children: [
                  Expanded(
                    child: InputField(
                      hint: "Min Transaction",
                      controller: minTransactionController,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InputField(
                      hint: "Max Transaction",
                      controller: maxTransactionController,
                    ),
                  ),
                ],
              ),
            ),
            
            _buildCard(
              title: "Currency Settings",
              icon: Icons.money,
              child: DropdownButtonFormField(
                value: selectedCurrency,
                items: ["USD", "EUR", "INR", "GBP"].map((currency) {
                  return DropdownMenuItem(value: currency, child: Text(currency));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCurrency = value.toString();
                  });
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  // enabled: !isDisable,
                  enabledBorder: InputBorder.none,
                  // hintText: hint,
                  // prefixIcon: prefix,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFBDBDBD),
                  ),
                  labelStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF212121),
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 30),
            Button(
              width: maxW-40,
              height: 40,
              prefixIcon: const Icon(IconlyBold.setting,color: Colors.white,),
              text: "Save Setting",
              onTap: (){},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required IconData icon, required Widget child}) {
    return Card(
      color: Colors.grey.shade100,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.black, size: 22),
                SizedBox(width: 10),
                Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}
