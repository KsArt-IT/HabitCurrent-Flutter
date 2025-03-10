import 'package:flutter/material.dart';
import 'package:habit_current/app/habit_current_app.dart';
import 'package:habit_current/core/di/service_locator.dart';

void main() {
  setupServiceLocator();    
  runApp(const HabitCurrentApp());
}
