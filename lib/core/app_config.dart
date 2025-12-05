import 'package:flutter/material.dart';

// --- 1. App Colors ---
class AppColors {
  static const Color backgroundDark = Color(0xFF091428); // Deep Navy/Indigo
  static const Color secondaryDark = Color(0xFF112240); // Slightly lighter for sections
  static const Color primaryGreen = Color(0xFF64FFDA); // Accent color
  static const Color secondaryBlue = Color(0xFF49A7CC);
  static const Color textLight = Color(0xFFCCD6F6); // Main light text
  static const Color textGray = Color(0xFF8892B0); // Secondary gray text
  static const Color highlightDark = Color(0xFF233554); // Hover/Highlight background
}

// --- 2. Responsive Breakpoints ---
class AppDimens {
  static const double desktopBreakpoint = 1200.0;
  static const double tabletBreakpoint = 768.0;
  static const double mobileBreakpoint = 480.0;
  
  static const double desktopMaxContentWidth = 1000.0;
  static const double mobilePadding = 24.0;
}

// --- 3. Data Models ---
class ExperienceModel {
  final String company;
  final String title;
  final String duration;
  final String description;

  ExperienceModel({
    required this.company,
    required this.title,
    required this.duration,
    required this.description,
  });
}

class ProjectModel {
  final String title;
  final String subtitle;
  final String description;
  final List<String> techStack;
  final String imageUrl; // Mock image URL

  ProjectModel({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.techStack,
    required this.imageUrl,
  });
}

// --- 4. Mock Repository Data ---
class PortfolioRepository {
  static List<String> get sections => ['Hello', 'About', 'Experience', 'Portfolio', 'Contact'];

  static List<ExperienceModel> get experienceList => [
    ExperienceModel(
      company: 'IB Arts',
      title: 'Flutter Developer',
      duration: 'November 2024 - Present',
      description: 'Developed and maintained cross-platform mobile applications using Flutter and native technologies.',
    ),
    ExperienceModel(
      company: 'Sukanya Classes',
      title: 'Computer Teacher',
      duration: 'March 2024 - November 2024',
      description: 'Taught core CS Concepts to High School Students',
    ),
    ExperienceModel(
      company: 'CodeSense 360',
      title: 'Flutter Flow Developer Intern',
      duration: 'August 2023 - November 2023',
      description: 'Interned to maintain and create flutter flow applications',
    ),
  ];

  static List<ProjectModel> get projectList => [
    ProjectModel(
      title: 'Mafa',
      subtitle: 'Featured Project',
      description: 'Mafatih Ul Jinan ( Keys to Heavens ), multiple languages: Arabic, English, Gujarati, and Francais. 14 Masoomeen Daily Dua Salat And Ziyarat Event Aamaal Listen and Reading Daily Dua in your Pocket Never Forget Dua Salat And Ziyarat and Event Aamaal One-Click Google Login: Get started in seconds. No need to remember another password—just sign in with your Google account or Apple Account.',
      techStack: ['Riverpod', 'Realm', 'Isolates'],
      imageUrl: 'https://play-lh.googleusercontent.com/jozURWe1UvmFiGFlazdCPlKS0dqE-ddMz8eXrRy_5QoHFAeHHEetFJeIMdXeENFtZUG-=s96-rw',
    ),
    ProjectModel(
      title: 'Flutter ECommerce',
      subtitle: 'Featured Project',
      description: 'E-Commerce UI kit can be used for e-commerce applications in android and ios devices...',
      techStack: ['Dart', 'Android', 'iOS'],
      imageUrl: 'https://placehold.co/1200x600/112240/64FFDA?text=ECommerce+UI+Preview',
    ),
  ];
}