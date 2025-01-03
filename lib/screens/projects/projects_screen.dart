// lib/screens/projects/projects_screen.dart
import 'package:flutter/material.dart';
import '../../core/widgets/custom_app_bar.dart';
import 'widgets/project_card.dart';
import 'models/project.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Mobile', 'Web', 'UI/UX', 'Backend'];
  final TextEditingController _searchController = TextEditingController();
  List<Project> _filteredProjects = [];

  final List<Project> _projects = [
    Project(
      title: 'E-Commerce App',
      description: 'Delivery App - On Demand Delivery System with bidding system | Courier App and order tracking.',
      imageUrl: 'assets/images/projects/logistics.png',
      categories: ['Mobile', 'UI/UX', 'Web'],
      technologies: ['Flutter', 'Firebase', 'Stripe'],
      githubUrl: 'https://github.com/yourusername/ecommerce',
      liveUrl: 'https://play.google.com/store/apps/details?id=com.example',
    ),
    // Add more projects here
  ];

  @override
  void initState() {
    super.initState();
    _filteredProjects = _projects;
  }

  void _filterProjects(String query) {
    setState(() {
      if (_selectedCategory == 'All') {
        _filteredProjects = _projects
            .where((project) =>
        project.title.toLowerCase().contains(query.toLowerCase()) ||
            project.description.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        _filteredProjects = _projects
            .where((project) =>
        project.categories.contains(_selectedCategory) &&
            (project.title.toLowerCase().contains(query.toLowerCase()) ||
                project.description.toLowerCase().contains(query.toLowerCase())))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Projects'),
      body: Column(
        children: [
          _buildSearchAndFilter(),
          Expanded(
            child: _filteredProjects.isEmpty
                ? const Center(child: Text('No projects found'))
                : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isSmallScreen ? 1 : 2,
                childAspectRatio: isSmallScreen ? 1.2 : 1.5,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _filteredProjects.length,
              itemBuilder: (context, index) {
                return ProjectCard(
                  project: _filteredProjects[index],
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            onChanged: _filterProjects,
            decoration: InputDecoration(
              hintText: 'Search projects...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.map((category) {
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                        _filterProjects(_searchController.text);
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}