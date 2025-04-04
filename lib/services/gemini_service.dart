import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:steadypunpipi_vhack/common/constants.dart';

class GeminiService {
  // final String _apiKey = AppConstants.GEMINI_API_KEY;
  final String _apiKey = "AIzaSyCIWb3At_0Q-QyZccNX0zlujY8KVCYc2ns";
  final String _endpoint =
      "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-pro:generateContent"; 

  // Generate AI Insights & Tips
  Future<Map<String, dynamic>> generateInsightsAndTips(
      List<Map<String, dynamic>> transactions, String dateRange) async {
    final prompt = '''
        Analyze the transactions within the provided date range. Identify significant spending trends, categorize expenses, and provide insights into the user's financial behaviors and habits. Additionally, based on the transaction data, provide at least two concise financial tips and two environmental tips aimed at reducing the user's carbon footprint. If applicable, you may provide more than two tips.
        
        The transaction currency is in RM. The unit for carbon footprint is kg.

        Ensure the insights is a short narrative paragraph that user can quickly know what is happening in summary section of the dashboard

        Ensure the financial tips are based on spending behavior, and the environmental tips should be informed by the carbon footprint data tied to each transaction.

        Each tip should be concise (max 20 words) and easily actionable.

        If no transactions are provided, return default suggestions or insights indicating the lack of data.

        Date Range: $dateRange 
        Transactions: ${jsonEncode(transactions)}

        Please return the response in the following structured JSON format without any markdown:

        {
          "insights": [""],
          "financeTips": ["...", "...", "..."],
          "environmentTips": ["...", "...", "..."]
        }

            ''';

    print("❤️PROMPT❤️: $prompt");
    try {
      final response = await http.post(
        Uri.parse("$_endpoint?key=$_apiKey"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": prompt}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return _parseGeminiResponse(data);
      } else {
        print("❌ Gemini API Error: ${response.body}");
        return {"insights": [], "financeTips": [], "environmentTips": []};
      }
    } catch (e) {
      print("🚨 Error fetching AI insights: $e");
      return {"insights": [], "financeTips": [], "environmentTips": []};
    }
  }

  // Extract insights & tips from Gemini response
  Map<String, dynamic> _parseGeminiResponse(Map<String, dynamic> response) {
    try {
      String? textResponse =
          response["candidates"]?[0]["content"]?["parts"]?[0]["text"];

      if (textResponse == null || textResponse.isEmpty) {
        print("⚠️ Empty or null response from Gemini.");
        return {"insights": [], "financeTips": [], "environmentTips": []};
      }

      print("🔍 Gemini raw response: $textResponse");

      // Remove triple backticks and possible markdown formatting
      textResponse =
          textResponse.replaceAll("```json", "").replaceAll("```", "").trim();

      // Ensure it's valid JSON before decoding
      if (!textResponse.startsWith("{") || !textResponse.endsWith("}")) {
        print("⚠️ Gemini response is not valid JSON.");
        return {"insights": [], "financeTips": [], "environmentTips": []};
      }

      Map<String, dynamic> parsedData = jsonDecode(textResponse);

      // Convert lists properly
      List<String> insights = (parsedData["insights"] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [];
      List<String> financeTips = (parsedData["financeTips"] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [];
      List<String> environmentTips =
          (parsedData["environmentTips"] as List<dynamic>?)
                  ?.map((e) => e.toString())
                  .toList() ??
              [];

      return {
        "insights": insights,
        "financeTips": financeTips,
        "environmentTips": environmentTips,
      };
    } catch (e) {
      print("❌ Failed to parse Gemini response: $e");
      return {"insights": [], "financeTips": [], "environmentTips": []};
    }
  }
}
