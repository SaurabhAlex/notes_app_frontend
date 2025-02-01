import 'dart:convert';
import 'dart:developer';

import 'package:notes_app/models/note.dart';
import 'package:http/http.dart' as http;

class APIServices {
  static String baseUrl = "https://your-backend-url.com/";

  static Future<void> addNote(Note note) async {
    Uri requestUri = Uri.parse('$baseUrl/add');

    try {
      var response = await http.post(requestUri, body: note.toMap());

      // Print the raw response for debugging
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      // Ensure the response is JSON before decoding
      if (response.statusCode == 200) {
        try {
          var decoded = jsonDecode(response.body);
          log(decoded.toString());
        } catch (e) {
          print("JSON Parsing Error: $e");
        }
      } else {
        print("Server returned an error: ${response.statusCode}");
      }
    } catch (e) {
      print("Request Error: $e");
    }
  }

  static Future<void> deleteNote(Note note) async {
    Uri requestUri = Uri.parse('$baseUrl/delete');

    try {
      var response = await http.post(requestUri, body: note.toMap());

      // Print the raw response for debugging
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      // Ensure the response is JSON before decoding
      if (response.statusCode == 200) {
        try {
          var decoded = jsonDecode(response.body);
          log(decoded.toString());
        } catch (e) {
          print("JSON Parsing Error: $e");
        }
      } else {
        print("Server returned an error: ${response.statusCode}");
      }
    } catch (e) {
      print("Request Error: $e");
    }
  }

  static Future<List<Note>> fetchNote(String userId) async {
    Uri requestUri = Uri.parse('$baseUrl/list');
    try {
      var response = await http.post(requestUri, body: {'userId': userId});

      // Print the raw response for debugging
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      // Ensure the response is JSON before decoding

      if(response.statusCode ==200){
        try{
          var decoded = jsonDecode(response.body);
          List<Note> note = [];
          for(var newMap in decoded){
            Note newNote = Note.fromMap(newMap);
            note.add(newNote);
          }
          return note;
        }catch(e){
          print("JSON Parsing Error: $e");
        }
      }else{
        print("Server return an error: ${response.statusCode}");
      }
    } catch (e) {
      print("Request Error: $e");
    }
    return [];
  }
}
