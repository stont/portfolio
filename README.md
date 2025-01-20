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

## 🔥 Firebase Setup

### 1. Firebase Project Setup
1. Create a new Firebase project at (https://console.firebase.google.com)
2. Enable Firebase Hosting and Firestore
3. Add a web app to your Firebase project
4. Note down your Firebase configuration details

### 2. Firebase Configuration
1. Update your Firebase configuration in `lib/core/config/firebase_config.dart`:
```dart
class FirebaseConfig {
  static const String projectId = 'your-project-id';
  static const String storageBucket = 'your-project-id.firebasestorage.app';
}
```

2. Configure Firebase CLI:
```bash
# Install Firebase CLI globally
npm install -g firebase-tools

# Login to Firebase
firebase login

# Initialize Firebase in your project
firebase init
```

3. Select the following Firebase features when prompted:
    - Hosting
    - Firestore
    - Functions

### 3. Firebase Functions Setup

1. Create Functions directory structure:
```bash
# Navigate to functions directory
cd functions

# Initialize npm project
npm init

# Install required dependencies
npm install firebase-admin firebase-functions
```

2. Functions directory structure:
```
functions/
├── node_modules/
├── src/
│   └── index.js
├── package.json
├── package-lock.json
└── tsconfig.json
```

3. Configure package.json in functions directory:
```json
{
  "name": "functions",
  "scripts": {
    "build": "tsc",
    "serve": "npm run build && firebase emulators:start --only functions",
    "shell": "npm run build && firebase functions:shell",
    "start": "npm run shell",
    "deploy": "firebase deploy --only functions",
    "logs": "firebase functions:log"
  },
  "engines": {
    "node": "18"
  },
  "main": "lib/index.js",
  "dependencies": {
    "firebase-admin": "^11.8.0",
    "firebase-functions": "^4.3.1"
  },
  "devDependencies": {
    "typescript": "^4.9.0"
  },
  "private": true
}
```

4. Initialize Functions emulator (optional):
```bash
firebase init emulators
```

### 4. Deploy Firebase Configuration

1. Deploy Hosting and Functions:
```bash
# Deploy everything
firebase deploy

# Deploy only specific features
firebase deploy --only hosting
firebase deploy --only functions
```

2. Update firebase.json configuration:
```json
{
  "hosting": {
    "public": "build/web",
    "site": "your-site-name",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]
  },
  "functions": [
    {
      "source": "functions",
      "codebase": "default",
      "ignore": [
        "node_modules",
        ".git",
        "firebase-debug.log",
        "firebase-debug.*.log",
        "*.local"
      ]
    }
  ]
}
```

### Important Notes:
- Ensure you have Node.js installed (version 14 or later)
- Firebase Functions require Blaze (pay-as-you-go) plan
- Keep your Firebase configuration details secure
- Don't commit sensitive information to version control

[Rest of the README remains the same]

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
