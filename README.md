# 🛒 MiniMart — Flutter E-Commerce & Offline-First Caching

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![BLoC](https://img.shields.io/badge/BLoC%20%2F%20Cubit-1565C0?style=for-the-badge&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Hive](https://img.shields.io/badge/Hive%20NoSQL-FFC107?style=for-the-badge&logoColor=black)
![Dio](https://img.shields.io/badge/Dio-0A7EA4?style=for-the-badge&logoColor=white)

A full-fledged Flutter E-Commerce application with **Authentication**, **Product Catalog**, **Cart & Checkout Management**, **Light/Dark Themes**, and **Offline-First Caching** using Hive & Dio.

</div>

---

## 🚀 Key Features

- 🔐 **Authentication & Security**: Secure User registration & login with Firebase Authentication and input validation.
- 🛍️ **Product Catalog & Details**: Grid product listing with search, category filtering, and item detail views.
- 🛒 **Cart & Real-Time Calculations**: Add, update quantity, and remove items with instant total & discount computation.
- 💳 **Checkout Flow**: Multi-step checkout with delivery address management and order confirmation.
- 🌓 **Dynamic Theme Switching**: Seamless switching between Light and Dark themes via `ThemeCubit`.
- 💾 **Offline-First Caching**: Fast local persistence of cart data and user session via `Hive`.
- 🛡️ **Crash Reporting & Analytics**: Real-time error monitoring with `Firebase Crashlytics`.

---

## 🏛️ Project Architecture

```
lib/
├── core/                         # Shared utilities, caching & foundation
│   ├── cach_helper/              # Hive caching boxes, keys & storage helpers
│   ├── constant/                 # App Colors, Typography & Dimensions
│   ├── errors/                   # Custom Failure & Exception handlers
│   ├── models/                   # Product & Cart data models
│   ├── themes/                   # Light & Dark theme definitions and ThemeCubit
│   └── widgets/                  # Atomic components (Buttons, Fields, ProductCard)
│
├── features/                     # Feature-First Modular Structure
│   ├── auth/                     # Authentication (Login, Register, AuthCubit)
│   ├── home/                     # Home Screen, Banners, Categories & HomeCubit
│   ├── prodact/                  # Product Listing & Details
│   ├── cart/                     # Cart Management & CartCubit
│   └── checkout/                 # Order Placement & Checkout Screens
│
├── firebase_options.dart         # Generated Firebase configuration
└── service_locator.dart          # Dependency Injection (GetIt) setup
```

---

## 📦 Core Dependencies

| Library | Functionality |
| :--- | :--- |
| **`flutter_bloc`** | State management across Auth, Cart, Home, and Theme modules |
| **`firebase_auth` & `firestore`** | Cloud authentication and data synchronization |
| **`hive` / `hive_flutter`** | Fast NoSQL local caching for offline persistence |
| **`dio`** | HTTP network client with error handling |
| **`firebase_crashlytics`** | Real-time crash monitoring in production |
| **`animate_do`** | Smooth interactive animations and micro-interactions |

---

## ⚙️ Setup & Run

### Prerequisites
- Flutter SDK `>= 3.0.0`
- Firebase CLI (for custom backend connection)

### Steps

1. **Clone the repo:**
   ```bash
   git clone https://github.com/khaledarman22/serv5-minimart-assignment.git
   cd serv5-minimart-assignment
   ```

2. **Install packages:**
   ```bash
   flutter pub get
   ```

3. **Run application:**
   ```bash
   flutter run
   ```

---

## 👨‍💻 Author

**Khaled Waleed** — Senior Flutter Engineer & Team Lead
- 💼 LinkedIn: [khaled-waleed](https://linkedin.com/in/khaled-waleed-a95b70208)
- 🐙 GitHub: [@khaledarman22](https://github.com/khaledarman22)
- 📧 Email: Khaled.waleed.dev@gmail.com
