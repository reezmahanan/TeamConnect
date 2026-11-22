# TeamConnect

TeamConnect is a responsive Flutter group profile application for nine NDT Information Technology students at the Institute of Technology, University of Moratuwa. It uses Firebase Authentication and provides a shared home screen plus individual profile pages.

## Features

- Email/password login with Firebase Authentication
- Persistent authentication session and automatic AuthGate navigation
- Responsive nine-member card grid with search
- Logout confirmation
- Reezma Hanan's complete developer portfolio profile
- Eight separate placeholder profile pages
- Material 3 UI for Android and web

## Technology stack

- Flutter and Dart
- Firebase Core and Firebase Authentication
- Material 3
- url_launcher

## Group members and profile files

| Registration number | Name | Profile file |
|---|---|---|
| 23IT0480 | Ms M R Hanan (Reezma Hanan) | `lib/screens/members/member1_screen.dart` |
| 23IT0481 | Ms W R K W Hansamali | `lib/screens/members/member2_screen.dart` |
| 23IT0482 | Ms H M C B Herath | `lib/screens/members/member3_screen.dart` |
| 23IT0485 | Ms V Inthumathy | `lib/screens/members/member4_screen.dart` |
| 23IT0486 | Ms R V P A Jayamali | `lib/screens/members/member5_screen.dart` |
| 23IT0487 | Ms G W T Jayampathi | `lib/screens/members/member6_screen.dart` |
| 23IT0488 | Ms W D C G Jayarathna | `lib/screens/members/member7_screen.dart` |
| 23IT0490 | Mr K A S K Kapuhenthuduwa | `lib/screens/members/member8_screen.dart` |
| 23IT0491 | Ms W K Y Y Karunaratna | `lib/screens/members/member9_screen.dart` |

## Installation

1. Install Flutter and enable an Android emulator or Chrome.
2. Clone the repository and open it in VS Code or Android Studio.
3. Run `flutter pub get`.
4. Run `flutter run -d chrome` or `flutter run`.

## Firebase setup

The existing `lib/firebase_options.dart` and Android `google-services.json` configuration must be preserved.

1. Enable Email/Password authentication in Firebase Console.
2. Create a test account for the lecturer in Firebase Authentication.
3. Do not hardcode credentials in source code.
4. Add the test account email and password here for submission only in a private local README copy if needed.

## Profile photographs

Place Reezma Hanan's photograph at `assets/images/reezma.jpg`. The profile shows a fallback avatar when the image is missing. Other members may add photographs to the same folder and replace their placeholder screen.

## Git collaboration

```bash
git checkout -b feature/member-profile
# Edit only the assigned member file
git add lib/screens/members/memberX_screen.dart
git commit -m "Add member X profile"
git push origin feature/member-profile
```

Open a pull request and ask a teammate to review it before merging. Never commit passwords or private credentials.
