import 'package:flutter/material.dart';
import 'package:flutter_portfolio_site/core/app_config.dart';
import 'package:flutter_portfolio_site/presentation/views/portfolio_view.dart';
import 'package:flutter_portfolio_site/presentation/viewmodels/portfolio_viewmodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Setup Provider for MVVM
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PortfolioViewModel()),
      ],
      // 2. Setup MaterialApp with dark theme
      child: MaterialApp(
        title: 'Chittadeep - Portfolio',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primaryGreen,
          scaffoldBackgroundColor: AppColors.backgroundDark,
          brightness: Brightness.dark,
          // Use GoogleFonts for a clean, modern look
          textTheme: GoogleFonts.interTextTheme(
            ThemeData.dark().textTheme,
          ).apply(
            bodyColor: AppColors.textLight,
            displayColor: AppColors.textLight,
          ),
          colorScheme: const ColorScheme.dark(
            primary: AppColors.primaryGreen,
            secondary: AppColors.secondaryBlue,
          ),
        ),
        home: const PortfolioView(),
      ),
    );
  }
}