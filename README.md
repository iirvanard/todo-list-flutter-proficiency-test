
# Todo list flutter proficiency test

## Kesulitan yang dihadapi
pada pembuatan project ini kesulitan yang di hadapi adalah penggunaan flutter pada versi os yang saya install (lubuntu 25.04) sehingga flutter walaupun sudah terinstall dengan benar saat menggunakan command taking too long to executed. sehingga membuat pengerjan tugas ini mengalami hambatan.
## Analisa Kekurangan aplikasi yang di buat 
karena pada implementasi autentifikasi hanya menggunakan basic auth, sehingga masih banyak error / bug yang tidak di handling dengan baik yang bisa dimanfaatkan oleh attacker untuk mencuri data dalam aplikasi ,jika aplikasi memuat data sensitif (bukan best scenario penggunaan autentifikasi)
## Analisa Kekuatan aplikasi yang di buat
karena hanya menggunakan kode yang sederhana aplikasi bisa berjalan dengan cepat. dan implementasi mvc pada kode ini mudah untuk di kembangkan;

## strategy dan dasar pemilihan arsitektur 
dengan menggunakan model arsitektur model view controll, pengembangan untuk skala kecil saya pilih karena memiliki kecepatan dan efektifitas pengembangan perangkat lunak, karena komponen-komponen didalamnya dibuat dengan struktur yang mduah dipahami dan cepat untuk di implementasikan sehingga tidak memerlukan waktu lebih untuk melakukan proses development, namun kekurangan dari model arsitektur ini adalah ketika komponen yang ditambahkan semakin kompleks, kode yang dihasilkan lebih sulit untuk di tracking dan di kembangkan karena folder dan kode yang dibuat akan lebih banyak (menurut pendapat saya) 

## langkah pengembangan aplikasi
Langkah-langkah utama pengerjaan aplikasi 
1. memahami case yang akan diselesaikan
2. analisa kebutuhan & alur aplikasi atau aliran data yang akan diibuat
3. implementasikan model dan folder yang terstructure agar membantu pengembangan perangkat lunak
4. pembuatan basis data dan relasi yang digunakan
5. pembuatan instance/service yang akan digunakan sebagai jembatan antara model view dan controll
6. membuat fitur-fitur yang akan menjadi penilaian
7. refactoring kode sehingga kode tidak ada redundansi atau smellcode yang significan dan membantu readablitity pada kode yang dibuat
8. testing manual fitur fitur yang sudah dibuat

## Penggunaan aplikasi
Aplikasi Flutter ini menyediakan fitur autentikasi, manajemen tugas, dan integrasi dengan SQLite untuk penyimpanan lokal. Dokumentasi ini akan memandu Anda untuk membangun dan menjalankan aplikasi dalam mode **Development** dan **Production**.

## Prasyarat

Pastikan Anda sudah menginstal Flutter dan semua dependensi yang diperlukan. Jika belum, ikuti langkah-langkah di [Flutter Installation Guide](https://flutter.dev/docs/get-started/install).

Pastikan juga Anda memiliki Android Studio atau Xcode yang terinstal untuk membangun aplikasi Android dan iOS.

---

## 1. Menyiapkan Proyek

Setelah meng-clone repository ini, jalankan perintah berikut untuk menginstal dependensi proyek:

```bash
flutter pub get
```

---

## 2. Menjalankan Aplikasi dalam Mode Development

Mode **Development** digunakan untuk pengembangan aplikasi dengan **hot reload** dan **debugging**.

### Menjalankan Aplikasi

Untuk menjalankan aplikasi di emulator atau perangkat fisik, gunakan perintah:

```bash
flutter run
```

Jika Anda ingin menjalankan aplikasi di platform tertentu, seperti Android atau iOS, gunakan perintah berikut:

```bash
flutter run -d android
flutter run -d ios
```

### Debug Mode

Jika Anda ingin menjalankan aplikasi dalam **debug mode**, gunakan perintah:

```bash
flutter run --debug
```

### Hot Reload & Hot Restart

- **Hot Reload**: Memperbarui UI tanpa kehilangan state. Tekan `r` saat aplikasi berjalan.
- **Hot Restart**: Memulai ulang aplikasi dari awal. Tekan `R` saat aplikasi berjalan.

---

## 3. Mode Production (Release Build)

Mode **Production** digunakan untuk membangun aplikasi yang siap untuk dipublikasikan ke Google Play Store atau Apple App Store.

### Build APK (Android)

Untuk membangun APK **release** yang siap distribusi, jalankan perintah:

```bash
flutter build apk --release
```

Hasil APK akan berada di folder:

```
build/app/outputs/flutter-apk/app-release.apk
```

## video demo 

[Google drive link demo](https://drive.google.com/file/d/1o1OEGXgFgpBZ2128qiRFRRY0DRzKk1WO/view?usp=sharing) - note pada video demo untuk searching melakukan query di database sqflite bukan regex saya salah menyebutkan
