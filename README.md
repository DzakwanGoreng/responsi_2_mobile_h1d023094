# Responsi 2 Mobile Programming - Aplikasi Inventaris Bahan Makanan Nopalmart

## 📋 Identitas 

- **Nama**: Muhammad Naufal Dzakwan
- **NIM**: H1D023094
- **Shift Baru**: Shift B
- **Shift Asal**: Shift B

---

## 📱 Deskripsi Aplikasi

Aplikasi mobile untuk sistem inventaris bahan makanan supermarket "Nopalmart" yang dibangun menggunakan Flutter dengan REST API CodeIgniter 4. Aplikasi ini memungkinkan pengelolaan data inventaris bahan makanan meliputi nama, harga, jumlah stok, tanggal masuk, dan tanggal kedaluwarsa.

**Fitur Utama:**
- ✅ Autentikasi (Login & Registrasi)
- ✅ CRUD Inventaris Bahan Makanan
- ✅ Tema warna hijau
- ✅ Integrasi dengan REST API

---

## 📱 Demo Aplikasi

https://youtube.com/shorts/5bV11xAjRmE?feature=share

---

## 🔌 Spesifikasi API

### Jika perli
```
http://[IP_ADDRESS]:8080](https://github.com/DzakwanGoreng/supermarket-api)
```

### Base URL
```
http://[IP_ADDRESS]:8080
```

### A. Registrasi
**Endpoint:** `/registrasi`  
**Method:** `POST`  
**Header:**
- Content-Type: application/json

**Body:**
```json
{
  "nama": "string",
  "email": "string, unique",
  "password": "string"
}
```

**Response:**
```json
{
  "code": "integer",
  "status": "boolean",
  "data": "string"
}
```

---

### B. Login
**Endpoint:** `/login`  
**Method:** `POST`  
**Header:**
- Content-Type: application/json

**Body:**
```json
{
  "email": "string",
  "password": "string"
}
```

**Response:**
```json
{
  "code": "integer",
  "status": "boolean",
  "data": {
    "token": "string",
    "user": {
      "id": "integer",
      "email": "string"
    }
  }
}
```

---

### C. Inventaris

#### 1. List Inventaris
**Endpoint:** `/inventaris`  
**Method:** `GET`  
**Header:**
- Content-Type: application/json

**Response:**
```json
{
  "code": "integer",
  "status": "boolean",
  "data": [
    {
      "id": "integer",
      "nama": "string",
      "harga": "integer",
      "jumlah": "integer",
      "tanggal_masuk": "string",
      "tanggal_kedaluwarsa": "string"
    }
  ]
}
```

#### 2. Create Inventaris
**Endpoint:** `/inventaris`  
**Method:** `POST`  
**Header:**
- Content-Type: application/json

**Body:**
```json
{
  "nama": "string",
  "harga": "integer",
  "jumlah": "integer",
  "tanggal_masuk": "string",
  "tanggal_kedaluwarsa": "string"
}
```

**Response:**
```json
{
  "code": "integer",
  "status": "boolean",
  "data": {
    "id": "integer",
    "nama": "string",
    "harga": "integer",
    "jumlah": "integer",
    "tanggal_masuk": "string",
    "tanggal_kedaluwarsa": "string"
  }
}
```

#### 3. Update Inventaris
**Endpoint:** `/inventaris/{id}`  
**Method:** `PUT`  
**Header:**
- Content-Type: application/json

**Body:**
```json
{
  "nama": "string",
  "harga": "integer",
  "jumlah": "integer",
  "tanggal_masuk": "string",
  "tanggal_kedaluwarsa": "string"
}
```

**Response:**
```json
{
  "code": "integer",
  "status": "boolean",
  "data": "boolean"
}
```

#### 4. Show Inventaris
**Endpoint:** `/inventaris/{id}`  
**Method:** `GET`  
**Header:**
- Content-Type: application/json

**Response:**
```json
{
  "code": "integer",
  "status": "boolean",
  "data": {
    "id": "integer",
    "nama": "string",
    "harga": "integer",
    "jumlah": "integer",
    "tanggal_masuk": "string",
    "tanggal_kedaluwarsa": "string"
  }
}
```

#### 5. Delete Inventaris
**Endpoint:** `/inventaris/{id}`  
**Method:** `DELETE`  
**Header:**
- Content-Type: application/json

**Response:**
```json
{
  "code": "integer",
  "status": "boolean",
  "data": "boolean"
}
```

---

## 🗂️ Struktur Database

### Tabel: member
```sql
CREATE TABLE member (
    id INT NOT NULL AUTO_INCREMENT,
    nama VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);
```

### Tabel: member_token
```sql
CREATE TABLE member_token (
    id INT NOT NULL AUTO_INCREMENT,
    member_id INT NOT NULL,
    auth_key VARCHAR(255) NOT NULL,
    FOREIGN KEY (member_id) REFERENCES member(id) ON UPDATE CASCADE ON DELETE NO ACTION,
    PRIMARY KEY(id)
);
```

### Tabel: inventaris
```sql
CREATE TABLE inventaris (
    id INT NOT NULL AUTO_INCREMENT,
    nama VARCHAR(255) NOT NULL,
    harga INT NOT NULL,
    jumlah INT NOT NULL,
    tanggal_masuk VARCHAR(50) NOT NULL,
    tanggal_kedaluwarsa VARCHAR(50) NOT NULL,
    PRIMARY KEY(id)
);
```

---

## 📂 Struktur Project Flutter

```
lib/
├── bloc/
│   ├── inventaris_bloc.dart    # Logic CRUD inventaris
│   ├── login_bloc.dart          # Logic login
│   ├── logout_bloc.dart         # Logic logout
│   └── registrasi_bloc.dart     # Logic registrasi
├── helpers/
│   ├── api.dart                 # HTTP request handler
│   ├── api_url.dart             # Endpoint URL
│   ├── app_exception.dart       # Exception handling
│   └── user_info.dart           # Session management
├── models/
│   ├── inventaris.dart          # Model data inventaris
│   ├── login.dart               # Model data login
│   └── registrasi.dart          # Model data registrasi
├── ui/
│   ├── inventaris_detail.dart   # Halaman detail inventaris
│   ├── inventaris_form.dart     # Form tambah/edit inventaris
│   ├── inventaris_page.dart     # Halaman list inventaris
│   ├── login_page.dart          # Halaman login
│   └── registrasi_page.dart     # Halaman registrasi
├── widget/
│   ├── success_dialog.dart      # Dialog notifikasi sukses
│   └── warning_dialog.dart      # Dialog notifikasi gagal
└── main.dart                    # Entry point aplikasi
```

---

## 💻 Penjelasan Kode per Fungsi

### 1. **Helpers**

#### `api.dart`
**Fungsi:** Mengelola HTTP request (GET, POST, PUT, DELETE) ke REST API

**Method Utama:**
- `post()` - Mengirim data ke server (untuk create dan login/registrasi)
- `get()` - Mengambil data dari server (untuk read/list)
- `put()` - Mengupdate data di server (untuk update)
- `delete()` - Menghapus data di server (untuk delete)
- `_returnResponse()` - Menangani response dan status code dari API

#### `api_url.dart`
**Fungsi:** Menyimpan semua endpoint URL API secara terpusat

**Konstanta:**
- `baseUrl` - Base URL API
- `registrasi` - Endpoint registrasi
- `login` - Endpoint login
- `listInventaris` - Endpoint list inventaris
- `createInventaris` - Endpoint create inventaris
- `updateInventaris(id)` - Endpoint update berdasarkan ID
- `showInventaris(id)` - Endpoint detail berdasarkan ID
- `deleteInventaris(id)` - Endpoint delete berdasarkan ID

#### `user_info.dart`
**Fungsi:** Mengelola session dan token user menggunakan SharedPreferences

**Method:**
- `setToken()` - Menyimpan token autentikasi
- `getToken()` - Mengambil token autentikasi
- `setUserID()` - Menyimpan ID user
- `getUserID()` - Mengambil ID user
- `logout()` - Menghapus semua data session

#### `app_exception.dart`
**Fungsi:** Menangani berbagai jenis exception/error dari API

**Exception Types:**
- `FetchDataException` - Error saat komunikasi dengan server
- `BadRequestException` - Error request tidak valid (400)
- `UnauthorisedException` - Error tidak terautentikasi (401/403)
- `InvalidInputException` - Error input tidak valid (422)

---

### 2. **Models**

#### `inventaris.dart`
**Fungsi:** Model data inventaris bahan makanan

**Atribut:**
- `id` - ID inventaris
- `nama` - Nama bahan makanan
- `harga` - Harga bahan
- `jumlah` - Jumlah stok
- `tanggalMasuk` - Tanggal masuk bahan
- `tanggalKedaluwarsa` - Tanggal kedaluwarsa

**Method:**
- `fromJson()` - Konversi JSON dari API menjadi object Inventaris

#### `login.dart`
**Fungsi:** Model data response login

**Atribut:**
- `code` - Status code response
- `status` - Status berhasil/gagal
- `token` - Token autentikasi
- `userID` - ID user
- `userEmail` - Email user

**Method:**
- `fromJson()` - Parsing response JSON login

#### `registrasi.dart`
**Fungsi:** Model data response registrasi

**Atribut:**
- `code` - Status code response
- `status` - Status berhasil/gagal
- `data` - Pesan response

**Method:**
- `fromJson()` - Parsing response JSON registrasi

---

### 3. **Bloc (Business Logic Component)**

#### `registrasi_bloc.dart`
**Fungsi:** Mengelola proses registrasi user baru

**Method:**
- `registrasi()` - Mengirim data registrasi ke API, menerima nama, email, password sebagai parameter

#### `login_bloc.dart`
**Fungsi:** Mengelola proses autentikasi login

**Method:**
- `login()` - Mengirim kredensial login ke API, mengembalikan token dan data user

#### `logout_bloc.dart`
**Fungsi:** Mengelola proses logout

**Method:**
- `logout()` - Menghapus session dan token user dari storage

#### `inventaris_bloc.dart`
**Fungsi:** Mengelola semua operasi CRUD inventaris

**Method:**
- `getInventaris()` - Mengambil list semua data inventaris dari API
- `addInventaris()` - Menambah data inventaris baru ke API
- `updateInventaris()` - Mengupdate data inventaris yang sudah ada
- `deleteInventaris()` - Menghapus data inventaris berdasarkan ID

---

### 4. **UI (User Interface)**

#### `main.dart`
**Fungsi:** Entry point aplikasi, menentukan halaman awal berdasarkan status login

**Widget:**
- `MyApp` - Root widget aplikasi
- `isLogin()` - Mengecek token, jika ada menampilkan InventarisPage, jika tidak menampilkan LoginPage

#### `registrasi_page.dart`
**Fungsi:** Halaman form registrasi user baru

**Widget:**
- `_namaTextField()` - Input nama (min 3 karakter)
- `_emailTextField()` - Input email dengan validasi format
- `_passwordTextField()` - Input password (min 6 karakter)
- `_passwordKonfirmasiTextField()` - Input konfirmasi password
- `_buttonRegistrasi()` - Tombol submit registrasi
- `_submit()` - Proses registrasi menggunakan RegistrasiBloc

#### `login_page.dart`
**Fungsi:** Halaman form login user

**Widget:**
- `_emailTextField()` - Input email
- `_passwordTextField()` - Input password
- `_buttonLogin()` - Tombol submit login
- `_menuRegistrasi()` - Link ke halaman registrasi
- `_submit()` - Proses login, menyimpan token, redirect ke InventarisPage

#### `inventaris_page.dart`
**Fungsi:** Halaman menampilkan list semua inventaris bahan makanan

**Widget:**
- `ListInventaris` - ListView builder untuk menampilkan list
- `ItemInventaris` - Card untuk setiap item inventaris
- **AppBar Actions:** Tombol (+) untuk tambah inventaris baru
- **Drawer:** Menu logout

**Fitur:**
- FutureBuilder untuk loading data dari API
- Tap item untuk ke halaman detail

#### `inventaris_form.dart`
**Fungsi:** Form untuk tambah dan edit data inventaris

**Widget:**
- `_namaTextField()` - Input nama bahan makanan
- `_hargaTextField()` - Input harga (numeric)
- `_jumlahTextField()` - Input jumlah stok (numeric)
- `_tanggalMasukTextField()` - Input tanggal masuk (format YYYY-MM-DD)
- `_tanggalKedaluwarsaTextField()` - Input tanggal kedaluwarsa
- `_buttonSubmit()` - Tombol submit (text berubah sesuai mode)

**Method:**
- `isUpdate()` - Cek mode tambah/edit, populate field jika edit
- `simpan()` - Menyimpan data baru menggunakan InventarisBloc
- `ubah()` - Mengupdate data existing

#### `inventaris_detail.dart`
**Fungsi:** Halaman detail informasi inventaris

**Widget:**
- Menampilkan semua informasi inventaris (nama, harga, jumlah, tanggal)
- `_tombolHapusEdit()` - Row dengan tombol EDIT dan DELETE
- `confirmHapus()` - Dialog konfirmasi sebelum hapus

**Aksi:**
- Tombol EDIT → Navigate ke InventarisForm dengan data
- Tombol DELETE → Tampil dialog konfirmasi → Hapus via InventarisBloc

---

### 5. **Widget**

#### `success_dialog.dart`
**Fungsi:** Menampilkan dialog notifikasi ketika operasi berhasil

**Parameter:**
- `description` - Pesan yang ditampilkan
- `okClick` - Callback saat tombol OK diklik

**Styling:**
- Judul "SUKSES" berwarna hijau
- Rounded corner dialog
- Shadow effect

#### `warning_dialog.dart`
**Fungsi:** Menampilkan dialog notifikasi ketika operasi gagal

**Parameter:**
- `description` - Pesan error yang ditampilkan
- `okClick` - Callback saat tombol OK diklik (optional)

**Styling:**
- Judul "GAGAL" berwarna merah
- Design konsisten dengan SuccessDialog

---


