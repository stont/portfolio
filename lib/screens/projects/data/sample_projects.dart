// lib/screens/projects/data/sample_projects.dart

import '../models/project.dart';

final List<Project> sampleProjects = [
  Project(
    title: 'Flutter E-Commerce',
    description: 'A complete e-commerce solution with shopping cart, payment integration, and order tracking.',
    imageUrl: 'assets/images/projects/logistics.png',  // Use a placeholder image for now
    categories: ['Mobile', 'UI/UX'],
    technologies: ['Flutter', 'Firebase', 'Stripe'],
    githubUrl: 'https://github.com/yourusername/project',
    liveUrl: 'https://play.google.com/store/apps',
  ),
  Project(
    title: 'Task Management App',
    description: 'A productivity app for managing tasks, projects, and team collaboration.',
    imageUrl: 'assets/images/projects/logistics.png',
    categories: ['Mobile', 'Productivity'],
    technologies: ['Flutter', 'SQLite', 'Provider'],
    githubUrl: 'https://github.com/yourusername/project',
    liveUrl: 'https://play.google.com/store/apps',
  ),
  // Add more projects as needed
];