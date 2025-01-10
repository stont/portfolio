// lib/screens/projects/data/sample_projects.dart
import '../models/project.dart';

final List<Project> sampleProjects = [
  Project(
    title: 'Hospital Management System',
    description: 'A comprehensive Flutter-based Hospital Management System designed to streamline healthcare operations. The app features patient records management, appointment scheduling, inventory tracking, and billing management. It incorporates role-based access control for different staff members and real-time updates using Firebase.\n\n'
        'Key Features:\n'
        '• Secure authentication and role-based access\n'
        '• Patient records and medical history management\n'
        '• Appointment scheduling and reminders\n'
        '• Inventory and medicine stock management\n'
        '• Billing and payment processing\n'
        '• Real-time updates and notifications',
    imageUrl: 'assets/images/projects/hms.png',
    categories: ['Mobile', 'Healthcare'],
    technologies: ['Flutter', 'Firebase', 'Provider', 'REST API'],
    githubUrl: 'https://hospital.paperlessenv.app',
    liveUrl: 'https://play.google.com/store/apps/details?id=app.paperlessenv.hms',
  ),
  Project(
    title: 'Logistics Delivery App',
    description: 'A mobile application for managing logistics and delivery operations. This app helps businesses track shipments, manage inventory, and optimize delivery routes in real-time.\n\n'
        'Features:\n'
        '• Real-time shipment tracking\n'
        '• Route optimization\n'
        '• Inventory management\n'
        '• Delivery scheduling\n'
        '• Driver assignment\n'
        '• Proof of delivery capture',
    imageUrl: 'assets/images/projects/logistics.png',
    categories: ['Mobile', 'Enterprise'],
    technologies: ['Flutter', 'Google Maps API', 'SQLite', 'BLoC'],
    githubUrl: '#',
    liveUrl: 'https://bx.bubblehousebiz.com/',
  ),
  Project(
    title: 'Portfolio Website',
    description: 'A responsive portfolio website built with Flutter Web, showcasing my projects and skills. The website features a modern design with smooth animations, dark mode support, and responsive layouts for all screen sizes.\n\n'
        'Features:\n'
        '• Responsive design\n'
        '• Dark/Light mode\n'
        '• Project showcase\n'
        '• Blog section\n'
        '• Contact form\n'
        '• Smooth animations',
    imageUrl: 'assets/images/projects/portfolio.png',
    categories: ['Web', 'UI/UX'],
    technologies: ['Flutter Web', 'Firebase', 'GitHub Actions'],
    githubUrl: 'https://github.com/stont/portfolio',
    liveUrl: 'https://stont.web.com',
  ),
  Project(
    title: 'Digital Business Card',
    description: 'A modern take on business cards with this digital vCard application. Users can create, share, and manage their digital business cards with integrated QR codes and social media links.\n\n'
        'Features:\n'
        '• Custom card design\n'
        '• QR code generation\n'
        '• Social media integration\n'
        '• Contact sharing\n'
        '• Analytics tracking\n'
        '• Offline support',
    imageUrl: 'assets/images/projects/vcard.jpg',
    categories: ['Mobile', 'Business'],
    technologies: ['Flutter', 'Hive', 'Provider'],
    githubUrl: 'https://card.paperlessenv.app/',
    liveUrl: 'https://play.google.com/store/apps/details?id=card.paperlessenv.app',
  ),
  Project(
    title: 'Memopad by Paperless - A note taking app',
    description: 'Memopad by Paperless is more than just a note-taking app. Its a comprehensive digital workspace designed to help you capture, organize, and enhance your ideas effortlessly.\n\n'
        'Features:\n'
        '• Note taking\n'
        '• Audio recording\n'
        '• Image note\n'
        '• Draw/Sketch your idea\n'
        '• Schedule\n'
        '• Pin note\n'
        '• Local backup and restore\n'
        '• Cross-device sync\n'
        '• Guest user\n'
        '• Account management\n'
        '• Recycle bin\n'
        '• Todo',
    imageUrl: 'assets/images/projects/memodpad.png',
    categories: ['Mobile', 'Productivity', 'Android'],
    technologies: ['Flutter', 'Hive', 'Provider'],
    githubUrl: '#',
    liveUrl: 'https://play.google.com/store/apps/details?id=com.paperless.memopad',
  ),
  Project(
    title: 'Birthday Surprise Mobile App',
    description: 'This Flutter-powered mobile app is designed to deliver a personalized and unforgettable birthday surprise. Upon installation, the app prompts the user to enter their first and last name. If the input matches a predefined name, it reveals a delightful surprise: a photo of the birthday celebrant accompanied by vibrant balloon animations and a heartfelt "Happy Birthday" message. The experience concludes with a custom-written note from the sender, making it a unique and memorable gift.\n\n'
        'Features:\n'
        '• Name Verification\n'
        '• Lightweight and Offline\n'
        '• Engaging Animations\n'
        '• Heartfelt Message\n'
        '• Personalized Birthday Greeting\n',
    imageUrl: 'assets/images/projects/birthday.jpg',
    categories: ['Mobile',],
    technologies: ['Flutter', 'C++', 'CMake'],
    githubUrl: 'https://github.com/stont/happy-birthday',
  ),
];