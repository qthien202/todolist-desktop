# 🚀 Release Flutter Desktop App

Hướng dẫn build ứng dụng Flutter trên **Windows, macOS và Linux**.

---

## 📦 Build ứng dụng

### 🔹 Windows

```sh
flutter build windows
```

File .exe tại: "build\windows\runner\Release\"

### 🍎 macos

```sh
flutter build macos
```

Sau khi build xong, ứng dụng .app sẽ nằm trong thư mục: "build/macos/Build/Products/Release/MyApp.app"

<br>Cài đặt create-dmg</br>
```sh
npm install -g create-dmg
```
Chạy lệnh sau để tạo file .dmg
```sh
create-dmg \
  "build/macos/Build/Products/Release/MyApp.app" \
  --dmg-title="MyApp" \
  --overwrite \
  --output "build/macos/Build/Products/Release/"
```
output: là nơi lưu trữ file .dmg
### 🐧 Linux

```sh
flutter build linux
```

Ứng dụng sau khi build nằm tại: "build/linux/x64/release/bundle/"
