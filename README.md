# coffee_journal

If you like coffee, you probably spend some time dialing in a new roast you've just picked up. This is a vibecoded mobile app that provides an interface for organizing your recipes. 

## Flutter setup

This repo is pinned to `Flutter 3.41.2` using `fvm`.

1. [Install `fvm`](https://fvm.app/documentation/getting-started/installation).
2. Run `fvm use 3.41.2`.
3. Run project commands through `fvm flutter`.

Common commands:

```bash
fvm flutter pub get
fvm flutter analyze
fvm flutter test
fvm flutter run
```

## Clone and run on Android

This is the simplest path for running the app on an Android phone or emulator.

Prerequisites:
- Android Studio installed
- Android SDK installed
- an Android emulator or an Android phone with USB debugging enabled
- `fvm` installed

Steps:

```bash
git clone <your-repo-url>
cd covfefe
fvm use 3.41.2
fvm flutter pub get
fvm flutter devices
fvm flutter run
```

Notes:
- If you are using a physical Android device, enable Developer Options and USB debugging first.
- If no device appears in `fvm flutter devices`, open Android Studio and verify the SDK and emulator setup there.

## Clone and run on iPhone

This is the simplest path for running the app on your own iPhone.

Prerequisites:
- a Mac
- Xcode installed
- an Apple ID signed into Xcode
- an iPhone connected by cable for first-time setup
- `fvm` installed
- iOS 14 or newer on the target device/simulator

Steps:

```bash
git clone <your-repo-url>
cd covfefe
fvm use 3.41.2
fvm flutter pub get
open ios/Runner.xcworkspace
```

Then in Xcode:
1. Select the `Runner` target.
2. Open `Signing & Capabilities`.
3. Choose your Apple development team.
4. Select your iPhone as the run destination.
5. Press Run once in Xcode.

After signing is configured, you can also run from the terminal:

```bash
fvm flutter devices
fvm flutter run
```

Notes:
- The first iPhone run usually has to start from Xcode so signing can be configured.
- On the phone, you may need to trust the developer certificate in `Settings > General > VPN & Device Management`.
