# Dac-Notes
This is simple note taking application

## Overview

Dac-Notes using Firebase realtime database that allow user to save a note and retrieve notes.
The Dac-Notes can see all the notes from other users

## Requirements

- iOS 16 or above
- Xcode 14 or above

## 🛠 Installation

- In Xcode: Using Swift Package Manager support requires 13.3.1 or higher and add packages: https://github.com/firebase/firebase-ios-sdk.git
- In Firebase: Create a realtime database in firebase and replace GoogleService-Info.plist

## 🏃‍♂️ Getting Started with Dac-Notes

## Overview
App route:
- Root = MainTabbarView => 2 tab items( HomeView, OtherUserView ) => detail note(NoteDetailView)
- Check "userId" which is stored in userdefault to display sheet InputNameView() if empty
- HomeView will observe "notes" note when view appear to add new note, can see detail and edit user name. Remove observers when view disapear.
- OtherUserView will observe "users" note when view appear to fetch all user, can see detail a note. Remove observers when view disapear.

### Development time
Dac-Apps developed within 16 hours

### Conclusion
Dac-Notes is a simple note taking app. It easy to use but still limited in functionality, only for text notes. Can listen for changes of db but Depends completely on realtime firebase database, so it is difficult to error handling.
