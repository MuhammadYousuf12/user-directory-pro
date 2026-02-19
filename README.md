# User Directory Pro

A clean and simple way to manage user contacts, built with Flutter. This project focuses on making form handling and data storage easy and reliable.

---

### Why I Built This
I created **User Directory Pro** to get a better grip on how Flutter handles real-world data. Instead of just making a pretty UI, I wanted to focus on things that actually matter in professional apps like making sure the user enters the right data, formatting phone numbers as they type, and saving everything locally so it doesn't disappear when the app closes.

The goal was to move away from messy code and use a proper **Model-based structure** that keeps everything organized.

---

### Key Features

* **Smart Forms:** I used the `email_validator` package to make sure email addresses are real and added custom logic to catch errors before they happen.

* **Smart Phone Masking:** No one likes typing symbols in phone numbers. I built a `PhoneFormatter` class that automatically formats the number to `#### #######` while the user types.

* **One-Tap Calling:** Inside the user details, you can tap a button to call the person directly using the `url_launcher` setup.

* **Solid Data Handling:** All user info is handled through a `UserModel`, so the data stays consistent as you move from screen to screen.

* **Local Storage:** I used `Shared Preferences` so that any user you add stays saved on your phone's memory.

---

### Technical Details

| **Framework** | Flutter (Material 3) |
| **Language** | Dart |
| **Packages** | `email_validator`, `mask_text_input_formatter`, `url_launcher` |

---

### Project Status & Roadmap

Currently, the app handles local user directories efficiently. The next phases of development include:

1.  **Firebase Integration:** Moving from local storage to a cloud-based backend for real-time sync.
2.  **Quick Search:** Adding a search bar to find users instantly.

---

### Getting Started

1.  **Clone the repository:** `git clone https://github.com/MuhammadYousuf12/user-directory-pro.git`

2.  **Install dependencies:** `flutter pub get`

3.  **Run the application:** `flutter run`