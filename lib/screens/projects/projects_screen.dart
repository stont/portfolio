// lib/screens/projects/projects_screen.dart
import 'package:flutter/material.dart';
import '../../core/widgets/custom_app_bar.dart';
import 'widgets/project_card.dart';
import 'models/project.dart';
import 'data/sample_projects.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Project> _filteredProjects = [];

  String _selectedCategory = 'All';
  String _selectedTechStack = 'All';
  final List<String> _categories = ['All', 'Mobile', 'Web', 'UI/UX', 'Backend'];
  List<String> _techStacks = ['All']; // Will be populated from projects

  @override
  void initState() {
    super.initState();
    _filteredProjects = sampleProjects;
    // Extract unique tech stacks from all projects
    _techStacks.addAll(
        sampleProjects
            .expand((project) => project.technologies)
            .toSet()
            .toList()
    );
  }
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterProjects(String query) {
    setState(() {
      _filteredProjects = sampleProjects.where((project) {
        bool matchesQuery = project.title.toLowerCase().contains(
            query.toLowerCase()) ||
            project.description.toLowerCase().contains(query.toLowerCase());

        bool matchesCategory = _selectedCategory == 'All' ||
            project.categories.contains(_selectedCategory);

        bool matchesTech = _selectedTechStack == 'All' ||
            project.technologies.contains(_selectedTechStack);

        return matchesQuery && matchesCategory && matchesTech;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery
        .of(context)
        .size
        .width < 600;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Projects'),
      body: Column(
        children: [
          _buildSearchAndFilter(),
          Expanded(
            child: _filteredProjects.isEmpty
                ? const Center(child: Text('No projects found'))
                : Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isSmallScreen ? 1 : 2,
                  childAspectRatio: isSmallScreen ? 0.8 : 1.1,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _filteredProjects.length,
                itemBuilder: (context, index) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return ProjectCard(
                        project: _filteredProjects[index],
                        index: index,
                      );
                    },
                  );
                },
              ),
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
        color: Theme
            .of(context)
            .cardColor,
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
          Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
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
              ),
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: _selectedTechStack,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedTechStack = newValue;
                      _filterProjects(_searchController.text);
                    });
                  }
                },
                items: _techStacks.map<DropdownMenuItem<String>>((
                    String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}