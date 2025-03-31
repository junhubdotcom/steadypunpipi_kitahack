import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  final String _apiKey = "AIzaSyCIWb3At_0Q-QyZccNX0zlujY8KVCYc2ns";
  final String _endpoint =
      "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-pro:generateContent"; // Updated API version

  // Generate AI Insights & Tips
  Future<Map<String, dynamic>> generateInsightsAndTips(
      List<Map<String, dynamic>> transactions, String dateRange) async {
    final prompt = '''
      Analyze the following transactions from $dateRange.
      Identify spending trends, categorize expenses, and provide insights into the user's financial habits.
      
      Also, based on the transactions, provide at least 2 financial tips and 2 environmental tips to reduce carbon footprint. If you have relevant tips can provide more than 2. Each tip should be **concise (max 20 words)** and **easy to understand**. 
      
      Transactions:
      ${jsonEncode(transactions)}

      Please return the response in this structured JSON format:
      {
        "insights": ["...", "...", "..."],
        "financeTips": ["...", "...", "..."],
        "environmentTips": ["...", "...", "..."]
      }

      no markdown
    ''';

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
