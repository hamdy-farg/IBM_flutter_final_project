import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/routing/app_router.dart';
import 'package:ibm_flutter_final_project/desk_app.dart';


void main() {
  runApp(DeskApp(
    appRouter: AppRouter(),
  ));
}
