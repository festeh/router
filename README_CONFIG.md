# Button Configuration System

This app uses compile-time button configuration injection. Buttons can be configured at build time without modifying the source code.

## Default Configuration

By default, the app uses the configuration defined in `lib/config/button_config.dart` with buttons X, Y, Z, F.

## Custom Configuration

To use a custom button configuration:

1. Create a JSON file with your button configuration:
```json
[
  {
    "label": "A",
    "color": "0xFFE91E63",
    "title": "Alpha Screen"
  },
  {
    "label": "B",
    "color": "0xFF9C27B0",
    "title": "Beta Screen"
  }
]
```

2. Build/run with the configuration:

### Using the build script:
```bash
# Run on Linux with custom config
./build_with_config.sh button_configs/default.json linux

# Build APK with custom config
./build_with_config.sh button_configs/default.json apk
```

### Using Flutter directly:
```bash
# Run with custom configuration
flutter run -d linux --dart-define="BUTTONS_CONFIG=[{\"label\":\"A\",\"color\":\"0xFFE91E63\",\"title\":\"Alpha Screen\"}]"

# Build with custom configuration
flutter build apk --dart-define="BUTTONS_CONFIG=[{\"label\":\"A\",\"color\":\"0xFFE91E63\",\"title\":\"Alpha Screen\"}]"
```

## Configuration Format

Each button in the JSON array must have:
- `label`: The text displayed on the button (String)
- `color`: The button color in hex format (String, e.g., "0xFFRRGGBB")
- `title`: The title displayed on the button's screen (String)

## Color Reference
- Red: 0xFFFF0000
- Green: 0xFF4CAF50
- Blue: 0xFF2196F3
- Orange: 0xFFFF9800
- Pink: 0xFFE91E63
- Purple: 0xFF9C27B0
- Deep Purple: 0xFF673AB7
- Indigo: 0xFF3F51B5