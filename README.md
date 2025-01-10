# Flutter Portfolio Website

A modern, responsive portfolio website built with Flutter Web and Firebase. This portfolio showcases my projects, skills, and provides a way for visitors to contact me.

## 🌟 Features

- **Responsive Design**: Works seamlessly on desktop, tablet, and mobile devices
- **Dark/Light Theme**: Built-in theme switching capability
- **Smooth Animations**: Custom animations and transitions throughout the site
- **Firebase Integration**: Backend support for contact form and analytics

### Key Sections:
- 🏠 Home Page with animated name and rotating titles
- 👨‍💻 About Me with skills display
- 🚀 Projects showcase with filtering and categories
- 💼 Services section with detailed offerings
- 📝 Blog section with commenting system
- 📬 Contact Form with Firebase integration

### New Features:
- **Dynamic Blog**: Full-featured blog with commenting system
- **Animated Titles**: Home page rotating professional titles
- **Services Showcase**: Detailed services section with cards
- **SEO Optimization**: Metadata and SEO improvements
- **Enhanced Email Integration**: Robust contact form handling

## 📧 Email & Form Features
- Contact form with email service
- Form response handling
- Success/Error notifications
- Rate limiting
- Spam protection

## 🔍 SEO Implementation
- Meta tags configuration
- Sitemap generation
- robots.txt setup
- Prerender service integration

## 🛠️ Built With

- **Frontend**:
    - Flutter Web
    - Dart
    - Custom animations
    - Responsive layouts

- **Backend**:
    - Firebase Firestore
    - Firebase Analytics
    - Firebase Hosting

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest version)
- Dart SDK
- Firebase account
- IDE (VS Code, Android Studio, etc.)

### Installation

1. Clone the repository
```bash
git clone https://github.com/stont/portfolio.git
```

2. Navigate to project directory
```bash
cd portfolio
```

3. Install dependencies
```bash
flutter pub get
```

4. Configure Firebase:
    - Create a new Firebase project
    - Add your Firebase configuration in `lib/core/config/firebase_config.dart`
    - Enable Firestore in your Firebase Console

5. Run the project
```bash
flutter run -d chrome
```

## 📱 Project Structure

```
lib/
├── core/
│   ├── config/
│   │   └── firebase_config.dart
│   ├── responsive/
│   │   └── responsive_layout.dart
│   ├── theme/
│   │   └── theme_provider.dart
│   └── services/
│       ├── firebase_service.dart
│       └── email_service.dart
├── screens/
│   ├── home/
│   ├── about/
│   ├── projects/
│   ├── services/
│   ├── blog/
│   │   ├── models/
│   │   ├── widgets/
│   │   └── screens/
│   └── contact/
└── main.dart
```

## 🎨 Features in Detail

### Home Screen
- Animated navigation icons
- Responsive layout
- Smooth transitions

### About Screen
- Typewriter effect for text
- Skills visualization
- Professional timeline
- Responsive layout

### Projects Screen
- Project filtering
- Search functionality
- Project cards with hover effects
- Detailed project view

### Contact Screen
- Form validation
- Firebase integration
- Social media links
- Success/error handling

### Services Screen
- Service cards with hover effects
- Detailed service descriptions
- Call-to-action buttons
- Responsive grid layout

### Blog Screen
- Blog post listings
- Post categories and filtering
- Commenting system
- Rich text content support
- Responsive layout for all devices

## 🚀 Deployment

1. Build the web version:
```bash
flutter build web
```

2. Deploy to Firebase Hosting:
- Through Firebase Console
- Manual deployment of build/web folder

## 📝 Customization

1. Theme Customization:
    - Update colors in `lib/core/theme/theme_provider.dart`
    - Modify text styles and component themes

2. Content Update:
    - Update project data in projects screen
    - Modify about me content
    - Update contact information

## 🤝 Contributing

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


## 📬 Contact

David Oluwabusayo - (https://twitter.com/david_stont)
Project Link: [https://github.com/stont/portfolio