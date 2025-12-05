import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio_site/core/app_config.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';


class PortfolioViewModel extends ChangeNotifier {
  // Use ItemScrollController to control scrolling between sections
  final ItemScrollController itemScrollController = ItemScrollController();
  // Keep track of the currently active section for highlighting in the navbar
  int _activeSectionIndex = 0;
  
  int get activeSectionIndex => _activeSectionIndex;

  // Data loaded from the repository
  List<String> get sections => PortfolioRepository.sections;
  List<ExperienceModel> get experiences => PortfolioRepository.experienceList;
  List<ProjectModel> get projects => PortfolioRepository.projectList;

  // Updates the active section based on scroll events (called by the view)
  void updateActiveSection(int index) {
    if (_activeSectionIndex != index) {
      _activeSectionIndex = index;
      notifyListeners();
    }
  }

  // Handles navigation when a Navbar item is clicked
  void scrollToSection(int index) {
    if (itemScrollController.isAttached) {
      itemScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      updateActiveSection(index);
    }
  }
}