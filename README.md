<div align="center">

  <!-- APP LOGO -->
  <img src="assets/icons/app_logo.png" alt="Noor Al-Quran Logo" width="160" height="160" />

  # NOOR AL-QURAN — القرآن الكريم
  ***A Light for Every Heart***

  [![Flutter](https://img.shields.io/badge/Flutter-3.19+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
  [![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
  [![Android](https://img.shields.io/badge/Android-APK-3DDC84?style=for-the-badge&logo=android&logoColor=white)](https://developer.android.com)
  [![License](https://img.shields.io/badge/License-MIT-gold?style=for-the-badge)](LICENSE)
  [![Offline First](https://img.shields.io/badge/Offline-100%25%20Ready-075E46?style=for-the-badge)](#-key-features)

  <p align="center">
    A peaceful, offline-first, trustworthy, and beautifully designed Android Holy Quran application built with Flutter.
    <br />
    <i>Codsiga Qur'aanka Kariimka ah oo bilaash ah, aan lahayn xayeysiis, una shaqeeya hab offline ah.</i>
  </p>

  ---

  [Features](#-key-features) •
  [Architecture](#%EF%B8%8F-technology-stack) •
  [Database](#-database-schema) •
  [Installation](#-installation--setup) •
  [CI/CD](#-github-actions-cicd)

</div>

---

## 🌟 Overview (Sharaxaadda Mashruuca)

**NOOR AL-QURAN (نور القرآن)** waa app casri ah oo loogu talagalay akhrinta, dhagaysiga, iyo barashada Qur'aanka Kariimka ah. Mashruucan waxaa loo sameeyay inuu noqdo **100% Offline-First**, isagoo aan u baahnayn internet marka aad akhrinayso Qur'aanka ama aad isticmaalayso astaantiisa.

### 🎨 Visual Identity & Color Palette

| Color | Hex Code | Purpose |
| :--- | :--- | :--- |
| **Primary Emerald** | `#075E46` | Main Brand Color & App Bars |
| **Deep Emerald** | `#043D30` | Dark Gradient Backgrounds & Cards |
| **Premium Gold** | `#D6B56D` | Highlights & Badges |
| **Warm White** | `#FFFDF7` | Comfortable Typography & Backgrounds |
| **Dark Surface** | `#102720` | Dark Mode Aesthetic |

---

## ✨ Key Features (Astaamaha Waaweyn)

- 📖 **114 Surahs Complete Quran**:
  - Dhammaan 114 Suradood oo ka xaqiijisan kaydka xogta ee **Tanzil Uthmani**.
  - Qoraal Carabi ah oo wata Aayado, calaamadaha tajwiidka, iyo farta **Amiri Quran**.
- 🌍 **Multi-Language Translations**:
  - Turjumaada **Af-Somali** (Soomaali) iyo **English**.
  - Waxaa loo kala saaray interface-ka app-ka iyo Turjumaada Qur'aanka.
- 🔊 **Offline Audio Playback**:
  - Dhagaysiga Qur'aanka oo offline ah kadib markaad soo dejiso faylasha codka.
  - Controls-ka Background Playback iyo Lock-screen integration.
- 🔖 **Bookmarks & Reading Progress**:
  - Kaydinta Aayadaha aad dhowaan akhrisay (Last Read).
  - Bookmark-yo gaar ah oo aad ku darsan karto qoraal (Notes).
- 📿 **Digital Tasbih Counter**:
  - Tasbiix elegtaroonig ah oo leh bartilmaameed (33, 99, 100) iyo gariir (haptic feedback).
- 🔍 **Local Quran Search**:
  - Raadinta magacyada Suradaha, lambarada Aayadaha, iyo nuxurka qoraalka.
- 🌙 **Dark & Light Mode Support**:
  - Habka habeenkii iyo maalintii ee u sahlan indhaha.

---

## 🛠️ Technology Stack (Tignoolajiyada La Isticmaalay)

* **Framework:** [Flutter](https://flutter.dev) (UI Framework)
* **Language:** [Dart](https://dart.dev) (Clean Code Architecture)
* **Local Database:** `sqflite` (SQLite storage for Ayahs & Bookmarks)
* **Key-Value Storage:** `shared_preferences` (Settings & User Progress)
* **Audio Engine:** `just_audio` & `audio_service` (Background media player)
* **Typography:** `AmiriQuran` (Arabic Uthmani Font) & `Inter` (Latin Font)
* **CI/CD:** GitHub Actions (Automated APK build runner)

---

## 📐 Database Schema (Qaabdhismeedka Data-da)

Mashruucu wuxuu adeegsadaa SQLite database gudaha ah (`noor_alquran.db`):

```mermaid
erDiagram
    SURAHS ||--o{ AYAHS : contains
    AYAHS ||--o{ TRANSLATIONS : translated_in
    AYAHS ||--o{ BOOKMARKS : bookmarked_as

    SURAHS {
        int number PK
        string arabic_name
        string english_name
        int ayah_count
        string revelation_type
    }

    AYAHS {
        int id PK
        int surah_number FK
        int ayah_number
        string arabic_text
        int juz_number
    }

    BOOKMARKS {
        int id PK
        int surah_number
        int ayah_number
        string note
        string created_at
    }
