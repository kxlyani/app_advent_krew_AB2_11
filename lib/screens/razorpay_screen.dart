import 'package:flutter/material.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

class CampaignDonationPage extends StatefulWidget {
  final String campaignId;

  CampaignDonationPage({required this.campaignId});

  @override
  _CampaignDonationPageState createState() => _CampaignDonationPageState();
}

class _CampaignDonationPageState extends State<CampaignDonationPage> {
  Razorpay _razorpay = Razorpay();
  Map<String, dynamic>? campaignData;
  String? razorpayAccountId;
  TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCampaignDetails();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  // Fetch campaign details from Firebase RTDB
  void _fetchCampaignDetails() async {
    _fetchNGOMerchantID("aghoradway@gmail.com");
    // final url = Uri.parse(
    //     'https://irproject2-460e3-default-rtdb.firebaseio.com//ngos/-OKHpqKcd8WNUZpYHqdG.json');
    // final response = await http.get(url);

    // if (response.statusCode == 200) {
    //   print("Campaign Data Response: ${response.body}"); // Debugging

    //   final campaign = json.decode(response.body);
    //   if (campaign != null && campaign.containsKey("ngo_email")) {
    //     setState(() {
    //       campaignData = campaign;
    //     });

    //     _fetchNGOMerchantID("aghoradway@gmail.com");
    //   } else {
    //     _fetchNGOMerchantID("aghoradway@gmail.com");
    //     print("Error: Campaign data is null or missing `ngo_email`.");
    //   }
    // } else {
    //   _fetchNGOMerchantID("aghoradway@gmail.com");
    //   print("Error fetching campaign details: ${response.statusCode}");
    // }
  }

  // Fetch NGO merchant ID from Firebase RTDB
  void _fetchNGOMerchantID(String ngoEmail) async {
    razorpayAccountId = "Q1bmw59ctgh9Vd";
    // print("Fetching Merchant ID for NGO Email: $ngoEmail");

    // final url = Uri.parse(
    //     'https://irproject2-460e3-default-rtdb.firebaseio.com/ngos.json');
    // final response = await http.get(url);

    // if (response.statusCode == 200) {
    //   print("NGO Data Response: ${response.body}"); // Debugging

    //   final ngosData = json.decode(response.body) as Map<String, dynamic>?;
    //   if (ngosData != null) {
    //     ngosData.forEach((key, ngo) {
    //       if (ngo["email"] == ngoEmail) {
    //         setState(() {
    //           razorpayAccountId = "Q1bmw59ctgh9Vd";
    //         });
    //         print("Merchant ID Found: $razorpayAccountId"); // Debugging
    //       }
    //     });
    //   } else {
    //     print("Error: NGO data is null or not formatted correctly.");
    //   }
    // } else {
    //   print("Error fetching NGO merchant ID: ${response.statusCode}");
    // }
  }

  // Initiate payment
  void _makeDonation() {
    if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter an amount and ensure details are loaded")),
      );
      print("Error: campaignData is null or amount is empty.");
      return;
    }

    int? amount = int.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid amount")),
      );
      return;
    }

    amount *= 100; // Convert ₹ to paise

    var options = {
      "key": "rzp_test_6xSEgZDHbzAWKN", // Replace with your Razorpay API key
      "amount": amount,
      "currency": "INR",
      "name": "Donation to ${campaignData?["name"] ?? "Unknown"}",
      "description": campaignData?["description"] ?? "",
      "prefill": {"contact": "9876543210", "email": "donor@example.com"},
      "theme": {"color": "#3399cc"},
      if (razorpayAccountId != null) "account": razorpayAccountId, // Merchant ID
    };

    print("Opening Razorpay Payment with options: $options"); // Debugging
    _razorpay.open(options);
  }

  // Razorpay Handlers
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Successful: ${response.paymentId}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Successful: ${response.paymentId}")),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Failed: Code ${response.code}, Message: ${response.message}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Failed: ${response.message}")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet Selected: ${response.walletName}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("External Wallet Selected: ${response.walletName}")),
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Donate to Campaign")),
      body:Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    campaignData?["name"] ?? "Unknown",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    campaignData?["description"] ?? "No description available",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Goal: ₹${campaignData?["goal_amount"] ?? "N/A"}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Amount in ₹",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _makeDonation,
                    child: Text("Donate Now"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
