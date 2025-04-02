import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;
import 'package:steadypunpipi_vhack/common/constants.dart';
import 'package:steadypunpipi_vhack/models/expense.dart';
import 'package:steadypunpipi_vhack/models/expense_item.dart';

class CarbonService {
  final _model = GenerativeModel(
      model: "gemini-1.5-pro", apiKey: AppConstants.TRANSACTION_GEMINI_API_KEY);

//   Future<Expense> generateCarbonApiJson(Expense expense) async {
//     List<Map<String, dynamic>> transactions = [];
//     for (ExpenseItem item in expense.items) {
//       final prompt = """
// Given this item: "${item.name}" under the category "${item.category}", classify it into a Merchant Category Code (MCC) and generate a JSON payload for the Connect Earth API.

// Return only the raw JSON object. Do not wrap it in triple backticks (```) or any markdown formatting

// The format should be:

// {
//     "price": ${item.price * item.quantity},
//     "geo": "MY",
//     "categoryType": "mcc",
//     "categoryValue": "MCC_CODE",
//     "currencyISO": "MYR",
//     "transactionDate": "${expense.dateTime.toIso8601String().split('T')[0]}"
// }

// Example response:

// {
//     "price": 15.0,
//     "geo": "MY",
//     "categoryType": "mcc",
//     "categoryValue": "5814",
//     "currencyISO": "MYR",
//     "transactionDate": "2025-04-02"
// }

// """;
//       final response = await _model.generateContent([Content.text(prompt)]);
//       try {
//         final generatedText = response.text ?? "";
//         print(generatedText);
//         final structuredJson = jsonDecode(generatedText);
//         transactions.add(structuredJson);
//       } catch (e) {
//         return expense;
//       }
//     }
//     print("Transactions Json List: $transactions");
//     return await sendToCarbonApi(transactions, expense);
//   }

  Future<Expense> sendToCarbonApi(Expense expense) async {
    print("Enter send to carbon api method");
    print(AppConstants.CARBON_API_KEY);
    // print("Total transactions: ${transactions.length}");

    // for (int i = 0; i < transactions.length; i++) {
    //   print("Sending transaction ${i + 1} out of ${transactions.length}");

    try {
      final response = await http
          .post(
        Uri.parse('https://api.connect.earth/transaction'),
        headers: {
          "x-api-key": AppConstants.CARBON_API_KEY,
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "price": 30.0,
          "geo": "MY",
          "categoryType": "mcc",
          "categoryValue": "5499",
          "currencyISO": "MYR",
          "transactionDate": "2025-04-02"
        }),
      )
          .timeout(Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            "⏳ API request timed out! Server might not be responding.");
      });

      // Check if the response is empty or not
      if (response.body.isNotEmpty) {
        print("Response Body: ${response.body}");
      } else {
        print("Empty Response Body");
      }

      print("Status Code: ${response.statusCode}");

      // Check if the response code is 200 (Success)
      if (response.statusCode == 200) {
        try {
          // Try parsing the response body to JSON
          final carbonData = jsonDecode(response.body);
          print("Parsed JSON Response: $carbonData");

          // Extract carbon footprint from the response
          double carbonFootprint =
              (carbonData["kg_of_CO2e_emissions"] ?? 0.0).toDouble();
          print("Carbon Footprint: $carbonFootprint");

          // Assign carbon footprint to the corresponding item in expense
          // if (i < expense.items.length) {
          expense.items[0].carbon_footprint = carbonFootprint;
          // }
        } catch (e) {
          print("Error parsing response body: $e");
          print("Response Body: ${response.body}");
        }
      } else {
        print("Request failed with status: ${response.statusCode}");
        print("Response Body: ${response.body}");
      }
    } on TimeoutException catch (e) {
      print("TimeoutException: The request timed out: $e");
    } on SocketException catch (e) {
      print("SocketException: Network issue: $e");
    } on HttpException catch (e) {
      print("HttpException: HTTP error: $e");
    } on FormatException catch (e) {
      print("FormatException: Invalid JSON: $e");
    } catch (e) {
      print("Unknown error: $e");
    }
    // }
    return expense;
  }
}
