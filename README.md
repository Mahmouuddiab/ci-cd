# flutter_ci_demo

A minimal Flutter counter app wired up with a working GitHub Actions
CI/CD pipeline. Use this as a template to drop into any real project.

## Structure

```
flutter_ci_demo/
├── lib/main.dart                  # the app (counter with increment/reset)
├── test/widget_test.dart          # widget test the CI pipeline runs
├── analysis_options.yaml          # lint rules used by `flutter analyze`
├── pubspec.yaml
└── .github/workflows/
    ├── ci.yml                     # runs on every push / PR
    └── deploy.yml                 # runs when you push a tag like v1.0.0
```

## How to use this

1. Run `flutter create .` inside this folder (or copy these files into an
   existing project) so the platform folders (`android/`, `ios/`, etc.)
   are generated — they're left out here since they're boilerplate.
2. Push the repo to GitHub.
3. Every push or pull request to `main`/`develop` triggers `ci.yml`:
   - `flutter pub get`
   - `dart format --set-exit-if-changed` (fails if code isn't formatted)
   - `flutter analyze` (static analysis / lint)
   - `flutter test --coverage`
   - a debug build, as a sanity check that it actually compiles
4. When you're ready to ship, tag a commit:
   ```
   git tag v1.0.0
   git push origin v1.0.0
   ```
   This triggers `deploy.yml`, which re-runs the tests, builds a release
   APK, and attaches it to a new GitHub Release automatically.

## Going further

- `deploy.yml` currently ships an **unsigned** release APK. To publish to
  the Play Store, add a signing step using `android/key.properties` fed
  from repo secrets (`KEYSTORE_BASE64`, `STORE_PASSWORD`, `KEY_PASSWORD`,
  `KEY_ALIAS`), then swap the last step for the Play Store publish action
  or a Fastlane lane.
- For iOS, add a macOS runner job (`runs-on: macos-latest`) using
  `flutter build ipa` plus Fastlane `match`/`gym` for signing — this
  can't be done on Ubuntu runners.
- Swap GitHub Releases for Firebase App Distribution if you want testers
  installing straight from a link instead of a GitHub release page.
