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
  final String liveUrl;
  final String imageUrl; // Mock image URL

  ProjectModel({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.techStack,
    required this.liveUrl,
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
      title: 'Mafatih Ul Jinan',
      subtitle: 'Featured Project',
      description: 'Mafatih Ul Jinan ( Keys to Heavens ), multiple languages: Arabic, English, Gujarati, and Francais. 14 Masoomeen Daily Dua Salat And Ziyarat Event Aamaal Listen and Reading Daily Dua in your Pocket Never Forget Dua Salat And Ziyarat and Event Aamaal One-Click Google Login: Get started in seconds. No need to remember another password—just sign in with your Google account or Apple Account.',
      techStack: ['Riverpod', 'Realm', 'Isolates'],
      liveUrl: 'https://play.google.com/store/apps/details?id=com.mafatihuljinan.org&hl=en',
      imageUrl: 'https://play-lh.googleusercontent.com/jozURWe1UvmFiGFlazdCPlKS0dqE-ddMz8eXrRy_5QoHFAeHHEetFJeIMdXeENFtZUG-=s96-rw',
    ),
    ProjectModel(
      title: 'SOOOM.net',
      subtitle: 'E-Commerce',
      description: 'Find the spare part that suits you on the SOOOM.net platform',
      techStack: ['Provider', 'REST API', 'MVC'],
      liveUrl: 'https://play.google.com/store/apps/details?id=com.itdivers.sooom&hl=en',
      imageUrl: 'https://play-lh.googleusercontent.com/m0zl-Y6wlleWbcECyX9AlL7Hc8fb02CRtwmcKdlFIVrBdNYuUUPTIrYZRD6e_9m1vA=w480-h960-rw',
    ),
    ProjectModel(
      title: 'Stepwhere',
      subtitle: 'E-Commerce',
      description: 'GPS tracking solutions in the form of smart shoes',
      techStack: ['MobX', 'Dio'],
      liveUrl: 'https://play.google.com/store/apps/details?id=com.stepwhere&hl=en',
      imageUrl: 'https://play-lh.googleusercontent.com/9Ov6feDeyxsx5lGDoctEjpe-K05f6m2rQCoRmIKvBSGBCUI16dDxltaAIRf7CvmMK3U=w480-h960-rw',
    ),
    ProjectModel(
      title: 'Yaad Plug',
      subtitle: 'E-Commerce',
      description: 'YaadPlug is a logistics and shipping company specializing in transporting parcels and packages from the USA to Jamaica.',
      techStack: ['GetX', 'RetroFit', 'MVVM'],
      liveUrl: 'https://apps.apple.com/us/app/yaadplug-lcs/id6749933885',
      imageUrl: 'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/53/2c/5b/532c5b7a-61e9-5cdd-42a2-23b4491bf122/AppIcon-1x_U007emarketing-0-11-0-85-220-0.png/400x400ia-75.webp',
    ),
    ProjectModel(
      title: 'Good Channel',
      subtitle: 'Entertainment',
      description: 'GoodChannel is one of the simplest and most reliable media players available. Built with ease of use in mind, it allows you to securely log in, browse categories, and enjoy a smooth playback experience on your device.',
      techStack: ['Provider', 'Dio'],
      liveUrl: 'https://apps.apple.com/us/app/good-channel/id6746419594',
      imageUrl: 'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/84/99/1b/84991b89-ef98-c62a-30a8-1d549c592b44/AppIcon-0-0-1x_U007emarketing-0-11-0-85-220.png/400x400ia-75.webp',
    ),
  ];
}