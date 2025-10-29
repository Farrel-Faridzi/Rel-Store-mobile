# Tugas 7

---

### 1. Apa itu Widget Tree dan Hubungan Parent-Child?

**Widget Tree** (Pohon Widget) adalah "cetak biru" atau struktur dari seluruh antarmuka (UI). Bayangkan ini seperti pohon silsilah keluarga:

* Ada satu widget "akar" (root), biasanya `MaterialApp`.
* Widget tersebut memiliki "anak" (children), misalnya `Scaffold`.
* `Scaffold` memiliki "anak" lagi, seperti `AppBar` dan `Body`.
* `Body` (sebuah `Padding`) memiliki "anak" (`Column`), dan seterusnya.

**Hubungan Parent-Child (Induk-Anak) Bekerja Seperti Ini:**

* **Parent (Induk):** Adalah widget yang *mengandung* widget lain. Contoh: `Column` adalah *parent* dari `Text` and `GridView`.
* **Child (Anak):** Adalah widget yang *dikandung* di dalam widget lain. Contoh: `Icon` adalah *child* dari `Column` di dalam `ItemCard`.

Hubungan ini sangat penting karena:
1.  **Layout:** Parent *memberi tahu* child batasan ukurannya (misalnya, "kamu boleh selebar 300 piksel") dan posisinya.
2.  **Data:** Data sering mengalir *ke bawah* dari parent ke child (seperti saat `GridView` memberikan `item` ke `ItemCard`).
3.  **Konteks:** Child bisa "mencari" data dari parent-nya menggunakan `BuildContext` (dijelaskan di bawah).

---

### 2. Widget yang Digunakan Dalam Proyek Ini

Berikut adalah semua widget yang saya gunakan dalam kode di atas dan fungsinya:

* **`MyHomePage`**: (Widget kustom) Bertindak sebagai halaman utama, merupakan `StatelessWidget`.
* **`Scaffold`**: Menyediakan struktur halaman dasar (seperti app bar di atas dan area "body" untuk konten utama).
* **`AppBar`**: Widget untuk bilah judul di bagian atas layar.
* **`Text`**: Menampilkan string teks (Saya menggunakannya untuk judul "Rel Store", teks sambutan, dan nama item).
* **`Padding`**: Memberi ruang/jarak di sekitar *child*-nya (dalam kasus saya, memberi padding 16.0 di sekitar `Column`).
* **`Column`**: Menyusun *children*-nya (daftar widget) secara **vertikal** (dari atas ke bawah).
* **`GridView.count`**: Menyusun *children*-nya dalam bentuk grid (kisi) yang bisa di-scroll, dengan jumlah kolom yang ditentukan (`crossAxisCount: 3`).
* **`ItemCard`**: (Widget kustom saya) Widget `StatelessWidget` yang saya buat untuk mewakili satu tombol di grid.
* **`Material`**: Widget yang memberi "fisik" pada kartu saya. Ini yang saya beri `color` dan `borderRadius` (sudut melengkung).
* **`InkWell`**: Membuat *child*-nya (yaitu `Container`) menjadi bisa diklik/disentuh dan memberikan efek riak (ripple effect) saat disentuh.
* **`Container`**: Kotak serbaguna. Di sini saya menggunakannya untuk memberi `padding` internal di dalam tombol/kartu.
* **`Center`**: Memosisikan *child*-nya di tengah-tengah area yang tersedia.
* **`Icon`**: Menampilkan ikon dari koleksi Material Icons (seperti `Icons.storefront`).

---

### 3. Apa Fungsi Widget MaterialApp?

**Fungsi `MaterialApp`:**
`MaterialApp` adalah widget pembungkus utama untuk seluruh aplikasi. Anggap saja ini sebagai "otak" atau "pengatur" utama yang menyediakan fungsionalitas inti yang dibutuhkan oleh semua halaman:

1.  **Navigasi:** Mengelola tumpukan halaman/layar (`Navigator`), memungkinkan user pindah halaman (`Navigator.push`).
2.  **Tema (Theming):** Menyediakan data tema (skema warna, font) ke semua widget di bawahnya. Inilah mengapa `Theme.of(context).colorScheme.primary` di `AppBar` bisa berfungsi.
3.  **Lokalilasi (Bahasa):** Mengatur dukungan untuk berbagai bahasa dan format regional.

**Mengapa Sering Jadi Root Widget?**
Ia harus menjadi *root* (akar) atau salah satu widget paling atas karena ia **menyediakan layanan penting** ini ke semua widget "keturunan" di dalam pohon. Tanpa `MaterialApp` sebagai "leluhur", widget seperti `Scaffold` atau `Navigator` tidak akan berfungsi dengan baik.

---

### 4. StatelessWidget vs. StatefulWidget


* **`StatelessWidget` (Widget Statis)**
    * **Apa itu?** Widget yang **tidak bisa berubah** setelah dibuat. Ia bersifat *immutable* (kekal).
    * **State:** Tidak memiliki *state* internal. Datanya hanya berasal dari parent-nya.
    * **Kapan digunakan?** Untuk UI yang tidak perlu berubah secara internal. Contoh: `Icon`, `Text`, atau `ItemCard` (ia hanya menampilkan data `item` yang diberikan, ia tidak mengubah data itu). `MyHomePage` saat ini juga *stateless*.
    * **Siklus Hidup:** Hanya memiliki metode `build()`.

* **`StatefulWidget` (Widget Dinamis)**
    * **Apa itu?** Widget yang **bisa berubah** selama masa pakainya.
    * **State:** Memiliki objek `State` internal yang bisa menyimpan data (misalnya, teks di `TextField`, status *loading*, dll).
    * **`setState()`:** Memanggil fungsi khusus `setState()` untuk memberi tahu Flutter bahwa data di dalam `State` telah berubah, yang memicu Flutter untuk *membangun ulang* (rebuild) widget tersebut dengan data baru.
    * **Kapan digunakan?** Kapan pun UI perlu diperbarui berdasarkan interaksi pengguna atau data yang berubah. Contoh: *Checkbox* yang dicentang, *Slider* yang digeser, halaman yang memuat data dari internet.
    * **Siklus Hidup:** Lebih kompleks (melibatkan `createState()`, `initState()`, `build()`, `setState()`, `dispose()`, dll).


---

### 5. Apa itu BuildContext?

**`BuildContext`** adalah salah satu konsep paling penting namun sering membingungkan.

Singkatnya: **`BuildContext` adalah "lokasi" atau "alamat" sebuah widget di dalam Widget Tree.**

Setiap widget memiliki `BuildContext`-nya sendiri, yang memberi tahu widget tersebut di mana tepatnya ia berada di dalam pohon.

**Mengapa Penting?**
Karena `BuildContext` adalah cara bagi sebuah widget untuk **berinteraksi dengan leluhurnya (ancestors)**. Ia digunakan untuk "mencari ke atas" di pohon.

**Penggunaannya di Metode `build`:**
Metode `build` menerima `BuildContext` sebagai argumen: `Widget build(BuildContext context)`.

Saya menggunakan `context` ini untuk meminta layanan dari widget leluhur. Di kode saya:
1.  `Theme.of(context)`: "Hei `context`, cari ke atas pohon dan temukan `Theme` terdekat, lalu beri aku data `colorScheme`-nya."
2.  `ScaffoldMessenger.of(context)`: "Hei `context`, cari ke atas pohon dan temukan `ScaffoldMessenger` terdekat agar aku bisa menampilkan `SnackBar`."

Tanpa `context`, widget akan terisolasi dan tidak tahu apa-apa tentang sisa aplikasi (seperti apa temanya atau bagaimana cara menampilkan SnackBar).

---

### 6. Hot Reload vs. Hot Restart

Ini adalah fitur terbaik Flutter untuk pengembangan cepat.

* **Hot Reload (Reload Cepat)**
    * **Apa yang dilakukannya?** Menyuntikkan kode baru ke dalam Dart Virtual Machine (VM) yang *sedang berjalan*.
    * **Hasil:** UI diperbarui seketika (kurang dari 1 detik) untuk mencerminkan kode baru.
    * **Hal Penting:** **State (data) aplikasi tetap terjaga.** Jika saya sedang mengisi formulir dan melakukan *hot reload* untuk mengubah warna tombol, teks yang saya ketik tidak akan hilang.
    * **Gunakan untuk:** 90% waktu development (mengubah UI, layout, warna, logika).

* **Hot Restart (Restart Penuh)**
    * **Apa yang dilakukannya?** Mematikan Dart VM yang sedang berjalan dan *memulai ulang* seluruh aplikasi dari awal.
    * **Hasil:** Aplikasi dimulai ulang sepenuhnya, kembali ke layar awal.
    * **Hal Penting:** **Semua state (data) aplikasi hilang** dan kembali ke nilai awal.
    * **Gunakan untuk:** Saat perubahan kode terlalu besar untuk *hot reload* (misalnya, mengubah *global static variable* atau kadang-kadang `initState`) atau saat aplikasi *error*.

Singkatnya: **Hot Reload** itu cepat dan menyimpan data. **Hot Restart** itu lambat dan mereset data.