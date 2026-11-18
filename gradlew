cd ~/powerhouse
cat > .github/workflows/android.yml <<'EOF'
name: build
on:
  push:
    branches: [ main ]
  pull_request:
  workflow_dispatch:
jobs:
  assemble:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-java@v4
        with:
          distribution: temurin
          java-version: '17'
      - uses: gradle/actions/setup-gradle@v3
        with:
          gradle-version: '8.9'
      - run: gradle assembleDebug --no-daemon
      - uses: actions/upload-artifact@v4
        with:
          name: powerhouse-debug
          path: app/build/outputs/apk/debug/*.apk
EOF

git add .github/workflows/android.yml
git commit -m "ci: build debug apk on push"
git push