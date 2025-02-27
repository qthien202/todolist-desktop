# 🚀 Release Flutter Desktop App

Hướng dẫn build ứng dụng Flutter trên **Windows, macOS và Linux**.

---

## 📦 Build ứng dụng

### 🔹 Windows

```sh
flutter build windows
```

Sau khi build xong, ứng dụng .exe sẽ nằm trong thư mục: **"build\windows\x64\runner\Release\MyApp.exe"**

![image](assets/preview_1.png)

Tiếp theo cài đặt Inno setup để đóng gói ứng dụng windows:

```sh
https://jrsoftware.org/isdl.php
```

Giao diện ứng dụng như này:

![image](assets/preview_2.png)

Ở phần new file chọn **create a new script file using the Script Wizard**, sau đó chọn OK để tiếp tục.

![image](assets/preview_3.png)

Một vài màn hình tiếp theo sẽ yêu cầu nhập thông tin ứng dụng cơ bản chỉ cần điền vào, không có gì nhiều kỹ thuật ở đó. Nhưng chỉ để tham khảo, đây là một vài ảnh chụp màn hình nhanh:

![image](assets/preview_4.png)

![image](assets/preview_5.png)

Bây giờ màn hình tiếp theo, đây là điều quan trọng nhất. Phải Chọn **tệp exe của ứng dụng** ở mục **Application main executable file**.

![image](assets/preview_6.png)

![image](assets/preview_7.png)

Tiếp theo ở mục **Add files** chọn add tất cả file .dll ở cùng với file .exe sau khi đã build lúc nãy.

![image](assets/preview_8.png)

Hình ảnh sau khi add file .dll.

![image](assets/preview_9.png)

Tiếp theo ở mục **Add folder** chọn thư mục data ở: **"\build\windows\x64\runner\Release\data"**.
<br>Hình ảnh sau khi add folder data vào</br>

![image](assets/preview_10.png)

Chọn vào đường dẫn thư mục data vừa thêm vào như hình.

![image](assets/preview_11.png)

ở popup hiển thị lên nhập **data** ở mục **Destination subfolder** và chọn ok, chọn next để tiếp tục.

![image](assets/preview_12.png)

Bỏ tick ở mục như hình, tiếp tục nhấn next.

![image](assets/preview_13.png)

ở màn hình sau chỉ cần nhấn next để tiếp tục. Cho đến màn hình **Compiler Settings**

![image](assets/preview_14.png)

![image](assets/preview_15.png)

![image](assets/preview_16.png)

![image](assets/preview_17.png)

![image](assets/preview_18.png)

Ở màn hình **Compiler Settings**:

- Custom compiler output folder: để chọn nơi lưu trữ ứng dụng sau khi đã đóng gói.
- Compiler output base file name: Tên file ứng dụng .exe
- Custom setup icon file: icon file ứng dụng (.ico)

![image](assets/preview_19.png)

Sau khi hoàn thành các thông tin trên chọn next để tiếp tục
Ở những màn hình tiếp theo nhấn next và finish để hoàn tất quá trình.

![image](assets/preview_20.png)

![image](assets/preview_21.png)

Sau khi hoàn tất cửa số popup hiện lên chọn **Yes** để tạo file script.

![image](assets/preview_22.png)

![image](assets/preview_23.png)

Đặt tên file và nơi lưu trữ file script.

![image](assets/preview_24.png)

Sau khi nhấn save Inno setup sẽ tạo script và đóng gói ứng dụng.

![image](assets/preview_25.png)

Sau khi đóng gói xong File ứng dụng .exe được lưu trữ theo như đường dẫn lúc nãy đã config.

![image](assets/preview_26.png)

Giờ chỉ cần chạy file .exe để cài đặt ứng dụng.

### 🍎 macos

```sh
flutter build macos
```

Sau khi build xong, ứng dụng .app sẽ nằm trong thư mục: **"build/macos/Build/Products/Release/MyApp.app"**

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

Ứng dụng sau khi build nằm tại: **"build/linux/x64/release/bundle/"**
