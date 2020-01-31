import 'dart:convert';
import 'dart:io';
import 'package:nutrition/models/meal_plan_model.dart';
import 'package:http/http.dart' as http;

class APIService{

  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  final String _baseUrl = 'api.spoonacular.com';
  static const String  API_KEY = 'c1b19c9e5872409e91be89ab00ce7e8c';
}