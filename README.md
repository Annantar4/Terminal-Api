Backend: Go + Gin (HTTP framework)

Database: PostgreSQL

ORM: GORM

System Design: System Design.png

Script postgreSQL: dump-eticket_db-202509161005.sql

Export Postman: Terminal API.postman_collection.json


Jawaban System Design Test
1.	Gambarkan desain rancangan anda
<img width="1920" height="1080" alt="Add a heading" src="https://github.com/user-attachments/assets/bc634455-d7db-4979-b255-c76fec8a3baa" />

2.	Ceritakan rancangan anda dengan jelas saat ada jaringan internet
   
     User tap in kartu di gate/terminal, lalu gate membaca “id_card” yang ada pada kartu tersebut lalu gate akan request data yang diperlukan ke server. Server akan mendapatkan data “id_card” kartu lalu akan mengisi data “status”, “id_card”, dan waktu user tap in (“check_in”) tersebut ke tabel “transactions”. “Status” pada tabel “transactions” adalah “ongoing” karena belum tap out.

    Saat user mau tap out di gate/terminal, gate akan membaca lagi “id_card” pada kartu tersebut, lalu request ke server dengan data “id_card” dan waktu tap out (“check_out”). Server akan mencari data pada tabel “transactions”, mana “id_card” yang baru di request dengan “status” “ongoing”. Lalu diambil data waktu tap in (“check_in”), dan data waktu tap out (“check_out”), setelah itu dihitung jumlah tarifnya. Setelah itu akan hit API provider kartu / pihak ketiga untuk transaksi dengan menggunakan data “id_card” dan jumlah tarif. Jika respone API tersebut misal “saldo kurang”, server akan kirim data balikan ke gate/terminal bahwa saldo pada kartu tersebut kurang dari jumlah tarif. Tetapi jika respone dari API “success”, server akan kirim data balikan bahwa transaksi berhasil dan gate dapat dibuka. Setelah itu akan update data pada tabel “transaction”, yaitu “status” “success”.

3.  Ceritakan solusi anda dengan jelas (apabila memungkinkan) saat tidak ada jaringan internet
   
    Untuk keadaan offline, pada gate / terminal tersebut diberikan database lokal. Jadi saat offline, data yang dibutuhkan untuk transaksi akan di simpan pada database device lokal gate terlebih dahulu. Lalu jika sudah online lagi, akan sesuai dengan sistem seperti biasa.
