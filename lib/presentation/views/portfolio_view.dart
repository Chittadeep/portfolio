import 'package:flutter/material.dart';
import 'package:flutter_portfolio_site/core/app_config.dart';
import 'package:flutter_portfolio_site/presentation/viewmodels/portfolio_viewmodel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:url_launcher/url_launcher_string.dart';


// The main view (V in MVVM)
class PortfolioView extends StatelessWidget {
  const PortfolioView({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine screen size for responsiveness
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= AppDimens.desktopBreakpoint;
    final isMobile = size.width < AppDimens.tabletBreakpoint;
    
    // Watch the ViewModel for state changes
    final viewModel = Provider.of<PortfolioViewModel>(context);
    
    // List of all sections that will be scrolled
    final List<Widget> sectionWidgets = [
      _buildHeroSection(isDesktop),
      _buildAboutSection(isDesktop),
      _buildExperienceSection(isDesktop, viewModel.experiences),
      _buildPortfolioSection(isDesktop, viewModel.projects),
      _buildContactSection(isDesktop),
    ];
    
    // A single-page application using ScrollablePositionedList for smooth section navigation
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: _NavBar(isDesktop: isDesktop, isMobile: isMobile),
      ),
      drawer: isMobile ? const _MobileDrawer() : null,
      body: Stack(
        children: [
          // 1. Main Content - ScrollablePositionedList handles all sections
          Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: isDesktop ? AppDimens.desktopMaxContentWidth : double.infinity),
              child: ScrollablePositionedList.builder(
                itemCount: sectionWidgets.length,
                itemScrollController: viewModel.itemScrollController,
                itemBuilder: (context, index) {
                  return sectionWidgets[index];
                },
                // Listener to update the ViewModel when the user scrolls
                itemPositionsListener: ItemPositionsListener.create()..itemPositions.addListener(() {
                  final positions = ItemPositionsListener.create().itemPositions.value;
                  if (positions.isNotEmpty) {
                    final firstVisible = positions.where((item) => item.itemLeadingEdge < 0.5).last.index;
                    viewModel.updateActiveSection(firstVisible);
                  }
                }),
              ),
            ),
          ),
          
          // 2. Left and Right Sidebar Widgets (Desktop/Tablet Only)
          if (!isMobile) ...[
            const Positioned(
              left: 0,
              bottom: 0,
              child: _LeftSocialSidebar(),
            ),
            const Positioned(
              right: 0,
              bottom: 0,
              child: _RightEmailSidebar(),
            ),
          ],
        ],
      ),
    );
  }

  // --- SECTION WIDGETS (Simplified for example) ---
  
  Widget _buildSectionTitle(String number, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$number. ',
            style: const TextStyle(color: AppColors.primaryGreen, fontSize: 18.0),
          ),
          Text(
            title,
            style: const TextStyle(color: AppColors.textLight, fontSize: 28.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 20),
          const Expanded(child: Divider(color: AppColors.secondaryDark, thickness: 1)),
        ],
      ),
    );
  }

  Widget _buildHeroSection(bool isDesktop) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 0 : AppDimens.mobilePadding),
      constraints: BoxConstraints(minHeight: isDesktop ? 600 : 400),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Hi, my name is', style: TextStyle(color: AppColors.primaryGreen, fontSize: 16)),
          const SizedBox(height: 8),
          const Text(
            'Chittadeep',
            style: TextStyle(color: AppColors.textLight, fontSize: 72, fontWeight: FontWeight.bold),
          ),
          const Text(
            'I build apps for mobile.',
            style: TextStyle(color: AppColors.textGray, fontSize: 72, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: isDesktop ? 500 : null,
            child: const Text(
              "I'm software engineer specializing in building and designing exceptional digital experiences. Currently, I'm focused on building accessible, human-centered product about mobile application.",
              style: TextStyle(color: AppColors.textGray, fontSize: 18),
            ),
          ),
          const SizedBox(height: 50),
          _CustomButton(
            text: 'Check out my github',
            onPressed: () => launchUrlString('https://github.com/chittadeep'), // Replace with actual link
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(bool isDesktop) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 0 : AppDimens.mobilePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('01', 'About Me'),
          isDesktop ? _aboutDesktopLayout() : _aboutMobileLayout(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
  
  Widget _aboutDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hello! My name is Chittadeep and I enjoy creating things that live on the internet. My interest in mobile app development started back in 2021 when I decided to try create awesome mobile application.",
                style: TextStyle(color: AppColors.textGray, fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 20),
              const Text(
                "Fast-forward to today, and I've had the privilege of working at a tech agency, a start-up. My main focus to create awesome mobile application with design and powerfull application.",
                style: TextStyle(color: AppColors.textGray, fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 20),
              const Text(
                "Here are a few technologies I've been working with recently:",
                style: TextStyle(color: AppColors.textGray, fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 20),
              // Skills Grid
              Wrap(
                spacing: 40,
                runSpacing: 10,
                children: [
                  ...['Flutter', 'Spring Boot', 'Data Structures and Algorithms', 'SQL'].map((e) => _buildSkillItem(e)),
                  
                ],
              ),
            ],
          ),
        ),
        const Expanded(
          flex: 2,
          child: Center(child: _ProfilePicture(size: 300.0)),
        ),
      ],
    );
  }
  
  Widget _aboutMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(child: _ProfilePicture(size: 200.0)),
        const SizedBox(height: 40),
        const Text(
          "Hello! My name is Chittadeep and I enjoy creating things that live on the internet...",
          style: TextStyle(color: AppColors.textGray, fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 20),
        const Text(
          "Here are a few technologies I've been working with recently:",
          style: TextStyle(color: AppColors.textGray, fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 20,
          runSpacing: 10,
          children: [
            ...['Flutter', 'Spring Boot', 'Data Structures and Algorithms', 'SQL'].map((e) => _buildSkillItem(e)),
          ],
        ),
      ],
    );
  }
  
  Widget _buildSkillItem(String skill) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.play_arrow_rounded, size: 12, color: AppColors.primaryGreen),
        const SizedBox(width: 8),
        Text(skill, style: const TextStyle(color: AppColors.textGray)),
      ],
    );
  }

  Widget _buildExperienceSection(bool isDesktop, List<ExperienceModel> experiences) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 0 : AppDimens.mobilePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('02', "Where I've Worked"),
          // A simple implementation of the job timeline
          _ExperienceTimeline(experiences: experiences),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildPortfolioSection(bool isDesktop, List<ProjectModel> projects) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 0 : AppDimens.mobilePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('03', "Some Things I've Build"),
          ...projects.map((project) => _ProjectCard(project: project, isDesktop: isDesktop)),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildContactSection(bool isDesktop) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 0 : AppDimens.mobilePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildSectionTitle('04', "What's Next?"),
          const SizedBox(height: 40),
          const Text(
            'Get In Touch',
            style: TextStyle(color: AppColors.textLight, fontSize: 48, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: isDesktop ? 500 : null,
            child: const Text(
              "Although I'm not currently looking for any new opportunities, my inbox is always open. Whether you have a question or just want to say hi, I'll try my best to get to you as soon as possible",
              style: TextStyle(color: AppColors.textGray, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 50),
          _CustomButton(
            text: 'Say Hello',
            onPressed: () => launchUrlString('mailto:mailchittadeep@gmail.com'),
          ),
          const SizedBox(height: 150),
          const Text(
            'Built with Flutter Web',
            style: TextStyle(color: AppColors.textGray, fontSize: 14),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// --- REUSABLE COMPONENTS ---

class _NavBar extends StatelessWidget {
  final bool isDesktop;
  final bool isMobile;
  const _NavBar({required this.isDesktop, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PortfolioViewModel>(context);

    final logo = Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryGreen, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Text(
        'CB',
        style: TextStyle(
          color: AppColors.primaryGreen,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    final hamburger = IconButton(
      icon: const Icon(Icons.menu, color: AppColors.primaryGreen),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );

    final navItems = Row(
      children: [
        ...viewModel.sections.asMap().entries.map((entry) {
          int index = entry.key;
          String text = entry.value;
          return _NavItem(
            number: '0${index}.',
            title: text,
            isActive: index == viewModel.activeSectionIndex,
            onTap: () => viewModel.scrollToSection(index),
          );
        }),
        const SizedBox(width: 20),
        _CustomButton(
          text: 'Contact',
          onPressed: () => viewModel.scrollToSection(4), // Contact is index 4
        ),
      ],
    );
    
    return Container(
      color: AppColors.backgroundDark.withAlpha(242), // Semi-transparent effect
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: isDesktop 
          ? [logo, navItems] 
          : (isMobile ? [hamburger, logo] : [logo, hamburger]),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String number;
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.number,
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextButton(
        onPressed: onTap,
        child: Row(
          children: [
            Text(
              number,
              style: const TextStyle(color: AppColors.primaryGreen, fontSize: 14),
            ),
            Text(
              title,
              style: TextStyle(
                color: isActive ? AppColors.primaryGreen : AppColors.textLight,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryGreen,
        side: const BorderSide(color: AppColors.primaryGreen, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Text(text, style: const TextStyle(fontSize: 14)),
    );
  }
}

class _LeftSocialSidebar extends StatelessWidget {
  const _LeftSocialSidebar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Social Icons (using placeholders)
          _SocialIcon(icon: EvaIcons.github_outline, onPressed: () {
            launchUrlString('https://github.com/chittadeep');
          }),
          _SocialIcon(icon: FontAwesomeIcons.instagram, onPressed: () {
            launchUrlString('https://www.instagram.com/chittadeep_biswas01/');
          }),
          _SocialIcon(icon: EvaIcons.linkedin_outline, onPressed: () {
            launchUrlString('https://in.linkedin.com/in/chittadeep-biswas');
          }),
          const SizedBox(height: 20),
          // Vertical Divider line
          Container(
            height: 90,
            width: 1,
            color: AppColors.textGray,
          ),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _SocialIcon({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: 20, color: AppColors.textGray),
      onPressed: onPressed,
      hoverColor: AppColors.primaryGreen.withAlpha(26),
    );
  }
}

class _RightEmailSidebar extends StatelessWidget {
  const _RightEmailSidebar();

  @override
  Widget build(BuildContext context) {
    const String email = 'mailchittadeep@gmail.com';
    return Container(
      width: 80,
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Rotated Email Text
          RotatedBox(
            quarterTurns: 1,
            child: TextButton(
              onPressed: () => launchUrlString('mailto:$email'),
              child: const Text(
                email,
                style: TextStyle(
                  color: AppColors.textGray,
                  fontSize: 14,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Vertical Divider line
          Container(
            height: 90,
            width: 1,
            color: AppColors.textGray,
          ),
        ],
      ),
    );
  }
}

class _MobileDrawer extends StatelessWidget {
  const _MobileDrawer();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PortfolioViewModel>(context, listen: false);
    return Drawer(
      backgroundColor: AppColors.backgroundDark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...viewModel.sections.asMap().entries.map((entry) {
            int index = entry.key;
            String text = entry.value;
            return ListTile(
              title: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textLight, fontSize: 18),
              ),
              onTap: () {
                viewModel.scrollToSection(index);
                Navigator.of(context).pop(); // Close the drawer
              },
            );
          }),
          const SizedBox(height: 20),
          _CustomButton(
            text: 'Contact',
            onPressed: () {
              viewModel.scrollToSection(4);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}


class _ProfilePicture extends StatelessWidget {
  final double size;
  const _ProfilePicture({this.size = 300.0});

  @override
  Widget build(BuildContext context) {
    // Mimics the photo frame design from the screenshot
    return Container(
      margin: const EdgeInsets.all(20),
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryGreen, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: /*ColorFiltered(
          colorFilter: const ColorFilter.mode(
            AppColors.primaryGreen,
            BlendMode.screen,
          ),
          child: Image.network(
            'https://placehold.co/300x300/112240/64FFDA?text=Profile',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: AppColors.secondaryDark,
              child: const Center(
                child: Text('Profile Image', style: TextStyle(color: AppColors.textGray)),
              ),
            ),
          ),
        ),*/
        Image.asset('assets/profile.png')
        )
    );
  }
}

class _ExperienceTimeline extends StatefulWidget {
  final List<ExperienceModel> experiences;
  const _ExperienceTimeline({required this.experiences});

  @override
  State<_ExperienceTimeline> createState() => _ExperienceTimelineState();
}

class _ExperienceTimelineState extends State<_ExperienceTimeline> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < AppDimens.tabletBreakpoint;
    
    if (widget.experiences.isEmpty) return const SizedBox();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tab Selector (Left)
        if (!isMobile)
          SizedBox(
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.experiences.asMap().entries.map((entry) {
                int index = entry.key;
                ExperienceModel exp = entry.value;
                bool isSelected = index == _selectedIndex;

                return InkWell(
                  onTap: () => setState(() => _selectedIndex = index),
                  child: Container(
                    height: 42,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.highlightDark : null,
                      border: Border(
                        left: BorderSide(
                          color: isSelected ? AppColors.primaryGreen : AppColors.secondaryDark,
                          width: 2,
                        ),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      exp.company,
                      style: TextStyle(
                        color: isSelected ? AppColors.primaryGreen : AppColors.textGray,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

        // Content Display (Right)
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: isMobile ? 0 : 20.0),
            child: _ExperienceDetails(
              experience: widget.experiences[_selectedIndex],
              isMobile: isMobile,
            ),
          ),
        ),
      ],
    );
  }
}

class _ExperienceDetails extends StatelessWidget {
  final ExperienceModel experience;
  final bool isMobile;
  const _ExperienceDetails({required this.experience, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isMobile) 
          // Show title on mobile to indicate which tab is active
          Text(
            experience.company,
            style: const TextStyle(
              color: AppColors.primaryGreen,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        
        Text(
          '${experience.title} @ ${experience.company}',
          style: const TextStyle(color: AppColors.textLight, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          experience.duration,
          style: const TextStyle(color: AppColors.textGray, fontSize: 14),
        ),
        const SizedBox(height: 20),
        Text(
          experience.description,
          style: const TextStyle(color: AppColors.textGray, fontSize: 16, height: 1.5),
        ),
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final bool isDesktop;

  const _ProjectCard({required this.project, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: isDesktop ? _desktopLayout(context) : _mobileLayout(),
    );
  }

  Widget _buildProjectText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          project.subtitle,
          style: const TextStyle(color: AppColors.primaryGreen, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Text(
          project.title,
          style: const TextStyle(
              color: AppColors.textLight,
              fontSize: 28,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Text(
          project.description,
          style: const TextStyle(color: AppColors.textGray, fontSize: 16),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 10),
        Text(
          project.techStack.join(' • '),
          style: const TextStyle(color: AppColors.textGray, fontSize: 14),
        ),
        const SizedBox(height: 10),
        GestureDetector(
            onTap: () => launchUrlString(project.liveUrl),
            child: const Icon(Icons.link, color: AppColors.textGray, size: 20)),
      ],
    );
  }

  Widget _buildProjectImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        project.imageUrl,
        height: 128,
        width: 128,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 128,
          width: 128,
          color: AppColors.secondaryDark,
          child: Center(
              child: Text(project.imageUrl,
                  style: const TextStyle(color: AppColors.primaryGreen))),
        ),
      ),
    );
  }

  Widget _desktopLayout(BuildContext context) {

    final Widget imageWidget = Expanded(
      flex: 0,
      child: _buildProjectImage(context),
    );

    final Widget textWidget = Expanded(
        flex: 9,
        child: Container(
          alignment:
              Alignment.centerLeft ,
          child: _buildProjectText(),
        ));

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: 
          [imageWidget, const SizedBox(width: 20), textWidget],
    );
  }

  Widget _mobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text Content
        Text(
          project.subtitle,
          style: const TextStyle(color: AppColors.primaryGreen, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Text(
          project.title,
          style: const TextStyle(
              color: AppColors.textLight,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        // Image
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            project.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 200,
              width: double.infinity,
              color: AppColors.secondaryDark,
              child: Center(
                  child: Text(project.imageUrl.split('=').last,
                      style:
                          const TextStyle(color: AppColors.primaryGreen))),
            ),
          ),
        ),
        const SizedBox(height: 15),
        // Description
        Text(
          project.description,
          style: const TextStyle(color: AppColors.textGray, fontSize: 16),
        ),
        const SizedBox(height: 10),
        // Tech Stack
        Text(
          project.techStack.join(' • '),
          style: const TextStyle(color: AppColors.textGray, fontSize: 14),
        ),
        const SizedBox(height: 10),
        GestureDetector(
            onTap: () => launchUrlString(project.liveUrl),
            child: const Icon(Icons.link, color: AppColors.textGray, size: 20)),
      ],
    );
  }
}