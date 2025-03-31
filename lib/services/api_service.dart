import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:steadypunpipi_vhack/common/constants.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:steadypunpipi_vhack/models/transaction.dart';

class ApiService {
  final _model = GenerativeModel(
      model: 'gemini-1.5-pro', apiKey: AppConstants.TRANSACTION_GEMINI_API_KEY);

  Future<Transaction> generateContent(String imgPath) async {
    try {
      // final image = File(imgPath);
      // final bytes = await image.readAsBytes();
      // final String mimeType = 'image/jpeg';

      print("Continue 1");

      // Get google vision result
      final visionResult = await classifyImage(imgPath);
      print(visionResult);
      String visionLabels = "";

      if (visionResult != null) {
        final labels = visionResult['responses'][0]['labelAnnotations'] ?? [];
        visionLabels =
            labels.map((label) => label['description']).take(5).join(", ");
        print(visionLabels);
      }

      final String prompt = '''
You are a financial assistant AI. I will give you the receipt's OCR result. Your job is to analyze both and return a **pure JSON** response with **no explanation or extra text**.

Use the following JSON schema:

{
  "transactionName": String, // If there are multiple items, generate a smart name like "McDonald's Lunch" or "Grocery Shopping"; if only one item, set this to "none"
  "isMultipleItem": Boolean, // true if more than 1 item
  "paymentMethod": String, // choose one from: "Cash", "E-Wallet", "Online Banking"
  "location": String, // Extract location from receipt if available (e.g. merchant address or shop name)
  "dateTime": DateTime, // Extracted from the receipt if available
  "items": [
    {
      "name": String, // name of the item purchased
      "category": String, // choose from: "Food", "Housing", "Debt Repayment", "Medical", "Transport", "Utilities", "Shopping", "Tax"
      "quantity": String, // quantity of this item
      "price": Double, // price per unit
    }
  ],
  "receiptImagePath": $imgPath,
}

Instructions:
- Include tax (if shown on receipt) as a separate transaction item named "Tax", with "carbon_footprint": 0.0
- Use the OCR result as the main source, but validate/augment from the image if needed
- Infer category intelligently based on item names (e.g. "Latte" = Food, "Sofa" = Housing, "Shoes" = Shopping)
- Estimate carbon_footprint as realistically as possible based on your knowledge of the item type
- If more than one item, set "isMultipleItem": true and generate a meaningful "transactionName"
- If only one item, set "isMultipleItem": false and "transactionName": "none"
- Detect payment method from any mention of "Cash", "GrabPay", "TNG", "FPX", etc., and normalize to one of the five options: "Cash", "E-Wallet", "Online Banking","Credit", or "Debit"

Important:
Return only the raw JSON object. Do not wrap it in triple backticks (```) or any markdown formatting.
Do not prefix with json or any other label.
Do not include any explanation, comments, or surrounding text — just output the JSON itself so it can be parsed directly.

Inputs:
1. This OCR text: $visionResult
''';

      // final response = await _model.generateContent([
      //   Content.multi([TextPart("$prompt"), DataPart(mimeType, bytes)])
      // ]);

      final response = await _model.generateContent([
        Content.text(prompt),
      ]);

      print("Response");
      print(response.text);

      final jsonResponse = jsonDecode(response.text ?? '{}');
      print(jsonResponse);
      return Transaction.fromJson(jsonResponse);
    } catch (e) {
      throw Exception('Error generating content: $e');
    }
  }

  Future<Map<String, dynamic>?> classifyImage(String imagePath) async {
    try {
      final bytes = File(imagePath).readAsBytesSync();
      final String base64Image = base64Encode(bytes);
      print("Continue 2");
      final response = await http.post(
        Uri.parse(
            "https://vision.googleapis.com/v1/images:annotate?key=${AppConstants.GOOGLE_VISION_API_KEY}"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'requests': [
            {
              'image': {'content': base64Image},
              'features': [
                {'type': 'TEXT_DETECTION'},
              ]
            }
          ]
        }),
      );

      print("Continue 3");
      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
}
