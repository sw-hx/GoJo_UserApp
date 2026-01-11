# GoJo User App 

![Flutter](https://img.shields.io/badge/built%20with-Flutter-blue)
![Dart](https://img.shields.io/badge/lang-Dart-blue)

A cross-platform **Flutter application** for GoJo users that interacts with the **GoJo Backend**.  
This app allows users to browse places, view details, check weather info, submit reviews, and interact with other GoJo features.  
Developed as part of the **GoJo Platform Graduation Project** at **Hashemite University (HU)**.

---

##  Project Overview

GoJo User App is one of the client applications built for the GoJo project.  
It provides the **mobile user experience** for the GoJo platform and communicates directly with the GoJo backend API to fetch and display:

- Places and tourism destinations  
- Weather forecasts  
- User profiles and favorites  
- Reviews and ratings  
- Authentication
- and more !

🔥For backend API documentation , see the GoJo backend repository:  
https://github.com/sw-hx/go_jo_backend

---

## 🧱 Tech Stack

- **Flutter** — UI framework (iOS & Android)  
- **Dart** — Programming language  
- **GoJo Backend API** — REST services  
- **Bloc** - For state management   
- **Supabase** — Cloud storage for user profile images and media files
- **Stripe** — Secure online payment processing

---

## 🌟 Getting Started

### Prerequisites

Make sure you have:

- Flutter SDK v3.x+ installed  
- Android Studio  installed for emulators  
- A connected or emulator device  
- The **GoJo Backend API** must be running and accessible  
  👉 Repository: https://github.com/sw-hx/go_jo_backend

### ☁️ Supabase
- A Supabase project configured for:
  - File storage (user profile images, media)
- Supabase credentials:
  - Project URL
  - Public Key

### 💳 Stripe
- A Stripe account
- Stripe **test keys** (Publishable Key)


Check your Flutter installation:

```bash
flutter doctor
```

## ▶️ Installation & Run
- 1 Clone this repository
```
git clone https://github.com/sw-hx/GoJo_UserApp.git
cd GoJo_UserApp
```

- 2 Install dependencies
```
flutter pub get
```

### -3 Configuration (Required)
Before running the application, you must update the constants configuration file with your own environment values.

📁 Constants File

Update the constants file (for example: lib/core/constants.dart) with the following values:

```
const String userDataKey = 'userData';
const String baseApiUrl = 'https://your-backend-domain/api';
const String supabaseUrl = 'https://your-project-id.supabase.co';
const String supabaseKey = 'your supabase key';

const String stripeSecretKey='sk_test_example';
const String stripePublishableKey='pk_test_example';
```

- 4 Run the application
```
flutter run
```

## 🔑 Authentication

This app uses JWT Authentication provided by the GoJo backend.

- 1 Register / Login via the app UI
- 2 The app stores a JWT token securely
- 3 Token is sent with each request in the Authorization: Bearer <token> header

This allows access to user specific and protected endpoints.

## 🙏 Special Thanks
**Suhaib jad fathi samaneh**
For leading the UI engineering and overall design architecture including:

- User Interface (UI) structure and layout

- User experience flows and screen design

- Animations and visual interactions

His work played a major role in shaping the visual identity and usability of the platform.

**Zain eddin mohammad Ibrahim alsheikh**
For integrating the backend services with the frontend application and making significant contributions to:

- Backend–Frontend communication

- API integration and data handling

- Application testing and validation

- Fixing and reports a lot of bugs for UI and backend logic

His efforts were essential in ensuring system stability and correct functionality.
