# Tugas 8

---

Tentu, berikut adalah ringkasan dari empat poin tersebut:

### 1. `Navigator.push` vs `pushReplacement`

* **`push` (Dorong):** Menumpuk halaman baru **di atas** halaman lama. Pengguna bisa menekan "kembali" untuk kembali ke halaman lama.
    * **Kapan dipakai:** Saat saya ingin pengguna kembali, seperti dari Menu Utama $\rightarrow$ Form Tambah Produk.

* **`pushReplacement` (Ganti):** **Mengganti** halaman saat ini dengan halaman baru. Halaman lama dibuang, jadi pengguna **tidak bisa** kembali ke sana.
    * **Kapan dipakai:** Untuk alur satu arah, seperti dari Halaman Login $\rightarrow$ Menu Utama (saya tidak ingin pengguna kembali ke login).

---

### 2. Struktur Halaman (Scaffold, AppBar, Drawer)

* **`Scaffold`** adalah kerangka dasar halaman.
* **`AppBar`** adalah bilah judul di bagian atas.
* **`Drawer`** adalah menu samping.

Saya membuat widget `LeftDrawer` kustom. Dengan meletakkan `LeftDrawer` yang sama di properti `drawer` pada setiap `Scaffold` (di halaman Home dan halaman Form), saya memastikan menu navigasi **konsisten** dan identik di seluruh aplikasi.

---

### 3. Kelebihan Layout Widget pada Form

* **`Padding`:** Memberi "ruang bernapas" agar elemen (seperti `TextFormField`) tidak saling menempel dan tidak menempel di tepi layar.
* **`SingleChildScrollView`:** Sangat penting untuk form. Ini membuat halaman bisa di-*scroll* saat *keyboard* muncul, sehingga *field* di bagian bawah atau tombol "Simpan" tidak tertutup oleh *keyboard*.
* **`ListView`:** Juga menyediakan *scroll*, tetapi lebih dioptimalkan untuk menampilkan daftar item yang jumlahnya banyak atau dinamis (seperti di *drawer* atau daftar produk).

---

### 4. Konsistensi Warna Tema

Untuk membuat *brand* yang konsisten, definisikan warna **satu kali** di `ThemeData` dalam file `main.dart`.

Kemudian, di dalam widget (seperti `AppBar`), gunakan warna dari tema tersebut (`Theme.of(context).colorScheme.primary`) alih-alih *hard-code* (`Colors.blue` atau `Colors.purple`).

Dengan cara ini, jika saya mengubah tema di `main.dart` (misalnya dari ungu ke hijau), semua `AppBar` dan tombol di seluruh aplikasi akan **otomatis ikut berubah**.