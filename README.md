# 📚 BookSpinner

**Spin. Pick. Read.**

BookSpinner is a Flutter web application that helps you decide what to read next with an interactive book spin wheel.

Instead of spending time deciding which book to pick, let the wheel choose one for you. 🎡📖

> **Version 1.0** — The first stable version of BookSpinner, currently powered by Firebase and populated with a curated set of test books.

---

## ✨ Features

- 🎡 **Interactive book spin wheel** — spin the wheel and let it choose your next book
- 🎲 **Random book selection** — get a book recommendation from the available collection
- 📚 **Book categories** — explore books by genre
- 📖 **Book details** — view the selected book's information
- 📱 **Responsive design** — designed for both desktop and mobile-sized screens
- ☁️ **Firebase backend** — book data is stored in Cloud Firestore
- 🎨 **Custom UI/UX** — designed with the Kata-App visual style

---

## 🖼️ Preview

<!-- Add screenshots or a demo GIF here -->

---

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| **Flutter** | Web application |
| **Dart** | Application development |
| **Firebase** | Backend services |
| **Cloud Firestore** | Book data storage |

---

## 🏗️ Project Structure

The application follows a feature-oriented Flutter architecture with separated presentation, models, repositories and core application functionality.

```text
lib/
├── core/
│   ├── navigation/
│   └── theme/
│
├── features/
│   ├── about/
│   ├── home/
│   ├── library/
│   └── spinner/
│
├── models/
├── repositories/
└── main.dart
```

---

## 🚀 Getting Started

### Prerequisites

Before running the project, make sure you have:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Dart SDK
- A Firebase project configured for the application

### Installation

Clone the repository:

```bash
git clone https://github.com/kata017/BookSpinner.git
```

Navigate to the project:

```bash
cd BookSpinner
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run -d chrome
```

---

## 🎯 How It Works

1. Browse the available book categories.
2. Select a category or start with the full collection.
3. Spin the wheel. 🎡
4. BookSpinner randomly selects a book.
5. Explore the selected book and decide if it is your next read.

---

## 🗺️ Roadmap

BookSpinner 1.0 focuses on the core book-selection experience.

Future versions will expand the application into a more personal reading companion.

### Planned for future versions

- 👤 User accounts and authentication
- 📚 Personal book library
- ➕ Add your own books
- 🔗 Connect books with individual users
- ✅ Track whether a user has read a book
- 🚫 Exclude already-read books from the spinner
- 🔄 Personalised book selection
- 📊 Reading progress and statistics

The long-term goal is to allow users to build their own library and let BookSpinner choose their next unread book.

---

## 🎨 Design

BookSpinner is a **Kata-App portfolio project** created to explore:

- Flutter web development
- Firebase integration
- UI/UX design
- Responsive layouts
- Interactive animations
- Feature-oriented application architecture

The visual design follows the **Kata-App design system**, with a focus on a playful, modern and technology-oriented experience.

---

## 📌 Version

**Current version: 1.0.0**

BookSpinner 1.0 represents the first stable milestone of the project.

---

## 👩‍💻 About

BookSpinner is developed by **Kata-App** as a portfolio and learning project.

The project is continuously evolving, with future versions planned around personal libraries, user-specific book data and reading tracking.

---

⭐ If you like the project, feel free to follow its development!
