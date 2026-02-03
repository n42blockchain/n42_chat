// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class SId extends S {
  SId([String locale = 'id']) : super(locale);

  @override
  String get chatModuleInitFailed => 'Gagal menginisialisasi modul chat';

  @override
  String get checkNetworkRetry =>
      'Silakan periksa koneksi jaringan Anda dan coba lagi';

  @override
  String get retry => 'Coba Lagi';

  @override
  String get unknownUser => 'Pengguna Tidak Dikenal';

  @override
  String get walletNotConnected => 'Dompet tidak terhubung';

  @override
  String get cannotGetWalletAddress => 'Tidak dapat mendapatkan alamat dompet';

  @override
  String paymentRequestMemo(String requestId) {
    return 'Permintaan pembayaran: $requestId';
  }

  @override
  String get callServiceNotInitialized =>
      'Layanan panggilan belum diinisialisasi';

  @override
  String get alreadyInCall => 'Sedang dalam panggilan';

  @override
  String get meetingServiceNotInitialized =>
      'Layanan meeting belum diinisialisasi';

  @override
  String get livekitNotConfigured => 'LiveKit belum dikonfigurasi';

  @override
  String get unknownConversation => 'Percakapan tidak dikenal';

  @override
  String startCallFailed(String error) {
    return 'Gagal memulai panggilan: $error';
  }

  @override
  String answerCallFailed(String error) {
    return 'Gagal menjawab: $error';
  }

  @override
  String get connectionFailed => 'Koneksi gagal';

  @override
  String get callRejected => 'Panggilan ditolak';

  @override
  String get noAnswer => 'Tidak ada jawaban';

  @override
  String get invalidLoginResponse => 'Respons login tidak valid';

  @override
  String loginFailed(String error) {
    return 'Login gagal: $error';
  }

  @override
  String get sessionRestoreFailed => 'Gagal memulihkan sesi';

  @override
  String get additionalVerificationRequired => 'Verifikasi tambahan diperlukan';

  @override
  String registrationFailed(String error) {
    return 'Pendaftaran gagal: $error';
  }

  @override
  String cannotConnectServer(String error) {
    return 'Tidak dapat terhubung ke server: $error';
  }

  @override
  String get wrongUsernamePassword => 'Nama pengguna atau kata sandi salah';

  @override
  String get usernameTaken => 'Nama pengguna sudah digunakan';

  @override
  String get invalidUsernameFormat => 'Format nama pengguna tidak valid';

  @override
  String get rateLimitExceeded =>
      'Terlalu banyak permintaan, silakan coba lagi nanti';

  @override
  String get loginExpired => 'Login kedaluwarsa';

  @override
  String joinMeetingFailed(String error) {
    return 'Gagal bergabung ke meeting: $error';
  }

  @override
  String screenShareFailed(String error) {
    return 'Berbagi layar gagal: $error';
  }

  @override
  String get answer => 'Jawab';

  @override
  String get decline => 'Tolak';

  @override
  String get missedCall => 'Panggilan tidak terjawab';

  @override
  String get callBack => 'Panggil balik';

  @override
  String get incomingCall => 'Panggilan masuk';

  @override
  String get missedVideoCall => 'Panggilan video tidak terjawab';

  @override
  String get missedVoiceCall => 'Panggilan suara tidak terjawab';

  @override
  String get passkeyNotInitialized => 'Passkey belum diinisialisasi';

  @override
  String get googleSignInNotConfigured => 'Google Sign In belum dikonfigurasi';

  @override
  String get encryptedMessage => '[Pesan terenkripsi]';

  @override
  String get sticker => '[Stiker]';

  @override
  String get groupCreated => 'Grup dibuat';

  @override
  String get groupNameChanged => 'Nama grup diubah';

  @override
  String get groupAvatarChanged => 'Avatar grup diubah';

  @override
  String get groupAnnouncementChanged => 'Pengumuman grup diubah';

  @override
  String get image => '[Gambar]';

  @override
  String get video => '[Video]';

  @override
  String get voice => '[Suara]';

  @override
  String get file => '[Berkas]';

  @override
  String get location => '[Lokasi]';

  @override
  String get unknownMessage => '[Pesan tidak dikenal]';

  @override
  String joinedGroup(String senderName) {
    return '$senderName bergabung ke grup';
  }

  @override
  String leftGroup(String senderName) {
    return '$senderName keluar dari grup';
  }

  @override
  String invitedToGroup(String senderName) {
    return '$senderName diundang';
  }

  @override
  String removedFromGroup(String senderName) {
    return '$senderName dikeluarkan';
  }

  @override
  String get avatarDataEmpty => 'Data avatar kosong';

  @override
  String get avatarTooLarge => 'Berkas avatar terlalu besar, maksimal 10MB';

  @override
  String get uploadAvatarFailed => 'Gagal mengunggah avatar';

  @override
  String get delete => 'Hapus';

  @override
  String get notLoggedIn => 'Belum masuk';

  @override
  String roomNotExist(String roomId) {
    return 'Ruangan tidak ditemukan: $roomId';
  }

  @override
  String get uploadImageFailed => 'Gagal mengunggah gambar';

  @override
  String get matrixClientNotInitialized => 'Matrix client belum diinisialisasi';

  @override
  String get uploadVoiceFailed =>
      'Gagal mengunggah suara: Tidak dapat mendapatkan MXC URI';

  @override
  String get uploadVideoFailed =>
      'Gagal mengunggah video: Tidak dapat mendapatkan MXC URI';

  @override
  String get uploadFileFailed =>
      'Gagal mengunggah berkas: Tidak dapat mendapatkan MXC URI';

  @override
  String locationWithCoords(String lat, String lon) {
    return 'Lokasi: $lat, $lon';
  }

  @override
  String get myLocation => 'Lokasi saya';

  @override
  String get pollEnded => 'Polling berakhir';

  @override
  String get groupChat => 'Chat Grup';

  @override
  String get search => 'Cari';

  @override
  String get cancel => 'Batal';

  @override
  String get userCancelled => 'Pengguna membatalkan';

  @override
  String get noData => 'Tidak ada data';

  @override
  String get noSearchResults => 'Tidak ada hasil pencarian';

  @override
  String get tryDifferentKeyword => 'Coba kata kunci lain';

  @override
  String get loadFailed => 'Gagal memuat';

  @override
  String get checkNetwork => 'Silakan periksa koneksi jaringan Anda';

  @override
  String get networkConnectionFailed => 'Koneksi jaringan gagal';

  @override
  String get checkNetworkSettings => 'Silakan periksa pengaturan jaringan Anda';

  @override
  String get messages => 'Pesan';

  @override
  String get contacts => 'Kontak';

  @override
  String get discover => 'Jelajahi';

  @override
  String get me => 'Saya';

  @override
  String get voiceLoading => 'Suara sedang dimuat, silakan coba lagi nanti';

  @override
  String get voiceToTextFailed => 'Gagal mengubah suara ke teks';

  @override
  String get converting => 'Mengonversi...';

  @override
  String get convertToText => 'Ke teks';

  @override
  String get convertToTextTitle => 'Ubah ke Teks';

  @override
  String get selectEmoji => 'Pilih emoji';

  @override
  String get selectRedPacketCover => 'Pilih sampul';

  @override
  String get frequentlyUsed => 'Sering digunakan';

  @override
  String get copy => 'Salin';

  @override
  String get forward => 'Teruskan';

  @override
  String get unfavorite => 'Batal favorit';

  @override
  String get favorite => 'Favorit';

  @override
  String get resend => 'Kirim ulang';

  @override
  String get recall => 'Tarik';

  @override
  String get multiSelect => 'Pilih banyak';

  @override
  String get quote => 'Kutip';

  @override
  String get remind => 'Ingatkan';

  @override
  String get searchThis => 'Cari';

  @override
  String get recallMessageConfirm => 'Tarik pesan ini?';

  @override
  String get youRecalledMessage => 'Anda menarik sebuah pesan';

  @override
  String get otherRecalledMessage => 'Pesan ditarik';

  @override
  String get reEdit => 'Edit ulang';

  @override
  String get copied => 'Disalin';

  @override
  String get sendMessageHint => 'Kirim pesan';

  @override
  String get microphonePermissionRequired => 'Silakan izinkan akses mikrofon';

  @override
  String startRecordingFailed(String error) {
    return 'Gagal memulai rekaman: $error';
  }

  @override
  String get recordingTooShort => 'Rekaman terlalu pendek';

  @override
  String stopRecordingFailed(String error) {
    return 'Gagal menghentikan rekaman: $error';
  }

  @override
  String get releaseToCancel => 'Lepas untuk membatalkan';

  @override
  String get releaseToSend => 'Lepas untuk kirim, geser ke atas untuk batal';

  @override
  String get holdToTalk => 'Tahan untuk bicara';

  @override
  String get send => 'Kirim';

  @override
  String conversationWithId(String roomId) {
    return 'Percakapan: $roomId';
  }

  @override
  String contactWithId(String userId) {
    return 'Kontak: $userId';
  }

  @override
  String get addFriend => 'Tambah Teman';

  @override
  String get chatServiceNotConnected => 'Layanan chat tidak terhubung';

  @override
  String userNotFoundHint(String query) {
    return 'Pengguna \"$query\" tidak ditemukan\n\nTips:\n• Coba masukkan ID pengguna lengkap, contoh @username:server.com\n• Periksa ejaan nama pengguna';
  }

  @override
  String createChatFailed(String error) {
    return 'Gagal membuat chat: $error';
  }

  @override
  String searchFailed(String error) {
    return 'Pencarian gagal: $error';
  }

  @override
  String get enterUserIdOrUsername =>
      'Masukkan ID atau nama pengguna untuk mencari';

  @override
  String get searching => 'Mencari...';

  @override
  String get searchUserToChat => 'Cari pengguna untuk mulai mengobrol';

  @override
  String get matrixIdExample =>
      'Anda dapat memasukkan Matrix ID lengkap\ncontoh @user:matrix.n42.network';

  @override
  String userNotFound(String username) {
    return 'Pengguna \"$username\" tidak ditemukan';
  }

  @override
  String get chat => 'Chat';

  @override
  String get settings => 'Pengaturan';

  @override
  String get editProfile => 'Edit Profil';

  @override
  String get login => 'Masuk';

  @override
  String get createGroup => 'Buat Grup';

  @override
  String developing(String title) {
    return '$title\n(Segera hadir)';
  }

  @override
  String get error => 'Kesalahan';

  @override
  String get pageNotFound => 'Halaman tidak ditemukan';

  @override
  String get backToHome => 'Kembali ke Beranda';

  @override
  String get allRead => 'Semua dibaca';

  @override
  String readCount(int count) {
    return '$count dibaca';
  }

  @override
  String get transfer => 'Transfer';

  @override
  String get pendingReceipt => 'Tertunda';

  @override
  String get tapToReceive => 'Ketuk untuk menerima';

  @override
  String get received => 'Diterima';

  @override
  String get paymentReceived => 'Pembayaran diterima';

  @override
  String get refunded => 'Dikembalikan';

  @override
  String get expired => 'Kedaluwarsa';

  @override
  String get redPacketGreeting => 'Semoga sukses selalu';

  @override
  String get n42RedPacket => 'Angpao N42';

  @override
  String get goodLuck => 'Semoga beruntung';

  @override
  String get claimed => 'Diklaim';

  @override
  String get allClaimed => 'Semua diklaim';

  @override
  String get emoji => 'Emoji';

  @override
  String get love => 'Cinta';

  @override
  String get animals => 'Hewan';

  @override
  String get food => 'Makanan';

  @override
  String get travel => 'Perjalanan';

  @override
  String get activities => 'Aktivitas';

  @override
  String get objects => 'Objek';

  @override
  String get symbols => 'Simbol';

  @override
  String get reply => 'Balas';

  @override
  String get copiedToClipboard => 'Disalin ke papan klip';

  @override
  String get edit => 'Edit';

  @override
  String get more => 'Lainnya';

  @override
  String get selectForwardTarget => 'Pilih penerima';

  @override
  String sendCount(int count) {
    return 'Kirim ($count)';
  }

  @override
  String get draft => '[Draf] ';

  @override
  String n42Id(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get n42IdTitle => 'N42 ID';

  @override
  String get n42Bean => 'N42 Bean';

  @override
  String get friendInfo => 'Info Teman';

  @override
  String get friendInfoDesc =>
      'Tambahkan catatan teman, telepon, tag, catatan, foto dan atur izin.';

  @override
  String get moments => 'Moments';

  @override
  String get sendMessage => 'Pesan';

  @override
  String get audioVideoCall => 'Panggilan Audio/Video';

  @override
  String get videoChannel => 'Saluran Video';

  @override
  String get remark => 'Catatan';

  @override
  String get remarkName => 'Nama Catatan';

  @override
  String get phone => 'Telepon';

  @override
  String get tags => 'Tag';

  @override
  String get notes => 'Catatan';

  @override
  String get photos => 'Foto';

  @override
  String get permissions => 'Izin';

  @override
  String get chatMomentsEtc => 'Chat, Moments, Olahraga, dll.';

  @override
  String get moreInfo => 'Info Lainnya';

  @override
  String get commonGroups => 'Grup bersama';

  @override
  String get zeroGroups => '0';

  @override
  String get source => 'Sumber';

  @override
  String get notificationSettings => 'Notifikasi';

  @override
  String get receiveNotifications => 'Terima notifikasi pesan baru';

  @override
  String get showPreview => 'Tampilkan pratinjau pesan';

  @override
  String get showContentInNotification => 'Tampilkan isi pesan di notifikasi';

  @override
  String get notificationSound => 'Suara notifikasi';

  @override
  String get playSoundOnMessage => 'Putar suara saat menerima pesan';

  @override
  String get vibrate => 'Getar';

  @override
  String get vibrateOnMessage => 'Getar saat menerima pesan';

  @override
  String get doNotDisturb => 'Jangan Ganggu';

  @override
  String get dndDescription => 'Bisukan notifikasi pada jam tertentu';

  @override
  String get startTime => 'Waktu mulai';

  @override
  String get endTime => 'Waktu selesai';

  @override
  String get privacy => 'Privasi';

  @override
  String get appearance => 'Tampilan';

  @override
  String get about => 'Tentang';

  @override
  String get logout => 'Keluar';

  @override
  String get logoutConfirm => 'Apakah Anda yakin ingin keluar?';

  @override
  String get exit => 'Keluar';

  @override
  String get save => 'Simpan';

  @override
  String get nickname => 'Nama Panggilan';

  @override
  String get enterNickname => 'Masukkan nama panggilan';

  @override
  String get signature => 'Tanda Tangan';

  @override
  String get addSignature => 'Tambahkan tanda tangan';

  @override
  String get takePhoto => 'Ambil Foto';

  @override
  String get chooseFromGallery => 'Pilih dari Galeri';

  @override
  String saveFailed(String error) {
    return 'Gagal menyimpan: $error';
  }

  @override
  String get secureDecentralizedChat => 'Pesan aman dan terdesentralisasi';

  @override
  String get endToEndEncryption => 'Enkripsi ujung ke ujung';

  @override
  String get messagesOnlyYouCanSee =>
      'Pesan hanya dapat dilihat oleh Anda dan penerima';

  @override
  String get decentralized => 'Terdesentralisasi';

  @override
  String get basedOnMatrix => 'Dibangun di atas protokol terbuka Matrix';

  @override
  String get walletIntegration => 'Integrasi Dompet';

  @override
  String get easyCryptoTransfer => 'Transfer kripto dengan mudah';

  @override
  String get register => 'Daftar';

  @override
  String get agreeTerms => 'Dengan masuk, Anda menyetujui';

  @override
  String get termsOfService => 'Ketentuan Layanan';

  @override
  String get and => 'dan';

  @override
  String get privacyPolicy => 'Kebijakan Privasi';

  @override
  String get serverAddress => 'Alamat Server';

  @override
  String get enterServerAddress => 'Masukkan alamat server';

  @override
  String get validServerAddress => 'Silakan masukkan alamat server yang valid';

  @override
  String connectedTo(String serverName) {
    return 'Terhubung ke $serverName';
  }

  @override
  String get username => 'Nama Pengguna';

  @override
  String get enterUsername => 'Masukkan nama pengguna';

  @override
  String get password => 'Kata Sandi';

  @override
  String get enterPassword => 'Masukkan kata sandi';

  @override
  String get registerAccount => 'Daftar';

  @override
  String get forgotPassword => 'Lupa Kata Sandi';

  @override
  String get otherLoginMethods => 'Metode login lainnya';

  @override
  String get emailVerification => 'Kode verifikasi email';

  @override
  String get enterServerFirst =>
      'Silakan masukkan alamat server terlebih dahulu';

  @override
  String get passkeyNeedsServer => 'Login passkey memerlukan dukungan server';

  @override
  String googleLoginSuccess(String email) {
    return 'Login Google berhasil: $email';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Login Google gagal: $error';
  }

  @override
  String get appleLoginSuccess => 'Login Apple berhasil';

  @override
  String appleLoginFailed(String error) {
    return 'Login Apple gagal: $error';
  }

  @override
  String get createAccount => 'Buat Akun';

  @override
  String get joinN42Chat => 'Bergabung dengan N42 Chat untuk mulai mengobrol';

  @override
  String get usernameHint => '3-20 karakter, huruf/angka/_';

  @override
  String get usernameMinLength => 'Nama pengguna minimal 3 karakter';

  @override
  String get usernameMaxLength => 'Nama pengguna maksimal 20 karakter';

  @override
  String get usernameFormat =>
      'Nama pengguna hanya boleh berisi huruf, angka, dan garis bawah';

  @override
  String get passwordHint => 'Minimal 8 karakter';

  @override
  String get passwordMinLength => 'Kata sandi minimal 8 karakter';

  @override
  String get confirmPassword => 'Konfirmasi Kata Sandi';

  @override
  String get reEnterPassword => 'Masukkan ulang kata sandi';

  @override
  String get passwordsNotMatch => 'Kata sandi tidak cocok';

  @override
  String get inviteCode => 'Kode undangan (bawaan)';

  @override
  String get filled => 'Terisi';

  @override
  String get enterInviteCode => 'Masukkan kode undangan';

  @override
  String get inviteCodeHint =>
      'Kode undangan sudah bawaan, biasanya tidak perlu diubah';

  @override
  String get agreeTermsFirst =>
      'Silakan baca dan setujui ketentuan dan kebijakan privasi terlebih dahulu';

  @override
  String get iAgree => 'Saya telah membaca dan menyetujui';

  @override
  String get alreadyHaveAccount => 'Sudah punya akun?';

  @override
  String get loginNow => 'Masuk sekarang';

  @override
  String get whoCanSee => 'Siapa yang dapat melihat';

  @override
  String get avatar => 'Avatar';

  @override
  String get status => 'Status';

  @override
  String get lastSeen => 'Terakhir dilihat';

  @override
  String get messageSettings => 'Pesan';

  @override
  String get allowStrangerMessage => 'Izinkan pesan dari orang asing';

  @override
  String get receiveNonContact => 'Terima pesan dari non-kontak';

  @override
  String get readReceipts => 'Tanda baca';

  @override
  String get letOthersKnowRead =>
      'Beri tahu orang lain Anda telah membaca pesan mereka';

  @override
  String get typingStatus => 'Status mengetik';

  @override
  String get letOthersKnowTyping => 'Beri tahu orang lain Anda sedang mengetik';

  @override
  String get everyone => 'Semua orang';

  @override
  String get contactsOnly => 'Hanya kontak';

  @override
  String get nobody => 'Tidak ada';

  @override
  String whoCanSeeItem(String title) {
    return 'Siapa yang dapat melihat $title';
  }

  @override
  String version(String version) {
    return 'Versi $version';
  }

  @override
  String get checkUpdate => 'Periksa pembaruan';

  @override
  String get openSourceLicenses => 'Lisensi open source';

  @override
  String get feedback => 'Umpan Balik';

  @override
  String get builtOnMatrix => 'Dibangun di atas protokol Matrix';

  @override
  String get loading => 'Memuat...';

  @override
  String get noConversations => 'Tidak ada percakapan';

  @override
  String get tapToChat => 'Ketuk kanan atas untuk mulai mengobrol';

  @override
  String get startGroup => 'Mulai Chat Grup';

  @override
  String get scan => 'Pindai';

  @override
  String get payment => 'Pembayaran';

  @override
  String featureComingSoon(String feature) {
    return '$feature segera hadir';
  }

  @override
  String get markAsRead => 'Tandai sudah dibaca';

  @override
  String get unmute => 'Bunyikan';

  @override
  String get mute => 'Bisukan';

  @override
  String get unpin => 'Lepas pin';

  @override
  String get pin => 'Pin';

  @override
  String get deleteConversation => 'Hapus Percakapan';

  @override
  String deleteConversationConfirm(String name) {
    return 'Hapus percakapan dengan \"$name\"?';
  }

  @override
  String get noContacts => 'Tidak ada kontak';

  @override
  String get addFriendsToChat => 'Tambah teman untuk mulai mengobrol';

  @override
  String get contactNotFound => 'Kontak tidak ditemukan';

  @override
  String get tryOtherKeywords => 'Coba kata kunci lain atau pencarian global';

  @override
  String get searchResults => 'Hasil pencarian';

  @override
  String get newFriends => 'Teman Baru';

  @override
  String get chatOnlyFriends => 'Teman khusus chat';

  @override
  String get officialAccounts => 'Akun Resmi';

  @override
  String get serviceAccounts => 'Akun Layanan';

  @override
  String get enterpriseContacts => 'Kontak Perusahaan';

  @override
  String contactsCount(int count) {
    return '$count kontak';
  }

  @override
  String get recommendToFriend => 'Bagikan kontak';

  @override
  String get setRemark => 'Atur catatan';

  @override
  String get addToHome => 'Tambahkan ke layar utama';

  @override
  String get sendingCard => 'Mengirim kartu kontak...';

  @override
  String get contactCard => '[Kartu Kontak]';

  @override
  String get fileLabel => 'Berkas';

  @override
  String get locationLabel => 'Lokasi';

  @override
  String cardSent(String contact, String friend) {
    return 'Mengirim kartu $contact ke $friend';
  }

  @override
  String recommendFailed(String error) {
    return 'Rekomendasi gagal: $error';
  }

  @override
  String get enterRemark => 'Masukkan catatan';

  @override
  String remarkSet(String remark) {
    return 'Catatan diatur ke: $remark';
  }

  @override
  String get openingChat => 'Membuka chat...';

  @override
  String openChatFailed(String error) {
    return 'Gagal membuka chat: $error';
  }

  @override
  String get addContact => 'Tambah Kontak';

  @override
  String get enterUserId => 'Masukkan ID pengguna';

  @override
  String get noFriendRequests => 'Tidak ada permintaan pertemanan';

  @override
  String get accept => 'Terima';

  @override
  String get reject => 'Tolak';

  @override
  String acceptedRequest(String name) {
    return 'Menerima permintaan pertemanan $name';
  }

  @override
  String rejectedRequest(String name) {
    return 'Menolak permintaan pertemanan $name';
  }

  @override
  String get noGroups => 'Tidak ada grup';

  @override
  String get creatingGroup => 'Pembuatan grup segera hadir...';

  @override
  String get selectFriendToRecommend => 'Pilih teman untuk direkomendasikan';

  @override
  String get searchContacts => 'Cari kontak';

  @override
  String get noContactsFound => 'Tidak ada kontak ditemukan';

  @override
  String get yesterday => 'Kemarin';

  @override
  String get monday => 'Sen';

  @override
  String get tuesday => 'Sel';

  @override
  String get wednesday => 'Rab';

  @override
  String get thursday => 'Kam';

  @override
  String get friday => 'Jum';

  @override
  String get saturday => 'Sab';

  @override
  String get sunday => 'Min';

  @override
  String get justNow => 'Baru saja';

  @override
  String minutesAgo(int count) {
    return '$count menit lalu';
  }

  @override
  String hoursAgo(int count) {
    return '$count jam lalu';
  }

  @override
  String daysAgo(int count) {
    return '$count hari lalu';
  }

  @override
  String get online => 'Online';

  @override
  String get offline => 'Offline';

  @override
  String minutesAgoOnline(int count) {
    return 'Online $count menit lalu';
  }

  @override
  String hoursAgoOnline(int count) {
    return 'Online $count jam lalu';
  }

  @override
  String daysAgoOnline(int count) {
    return 'Online $count hari lalu';
  }

  @override
  String get searchContactsGroupsMessages => 'Cari kontak, grup, pesan';

  @override
  String get searchError => 'Kesalahan pencarian';

  @override
  String get searchHint => 'Cari kontak, grup, dan pesan';

  @override
  String get enterKeyword => 'Masukkan kata kunci untuk mencari';

  @override
  String get searchHistory => 'Riwayat Pencarian';

  @override
  String get clear => 'Hapus';

  @override
  String noResultsFor(String query) {
    return 'Tidak ada hasil untuk \"$query\"';
  }

  @override
  String get all => 'Semua';

  @override
  String get groups => 'Grup';

  @override
  String get noResults => 'Tidak ada hasil';

  @override
  String get groupInfo => 'Info Grup';

  @override
  String groupMembers(int count) {
    return 'Anggota ($count)';
  }

  @override
  String get groupMembersTitle => 'Anggota Grup';

  @override
  String get viewAll => 'Lihat semua';

  @override
  String get owner => 'Pemilik';

  @override
  String get admin => 'Admin';

  @override
  String get invite => 'Undang';

  @override
  String get groupAnnouncement => 'Pengumuman Grup';

  @override
  String get notSet => 'Belum diatur';

  @override
  String get groupDescription => 'Deskripsi Grup';

  @override
  String get publicGroup => 'Grup Publik';

  @override
  String get allowSearchJoin => 'Izinkan orang lain mencari dan bergabung';

  @override
  String get clearChatHistory => 'Hapus Riwayat Chat';

  @override
  String get dissolveGroup => 'Bubarkan Grup';

  @override
  String get leaveGroup => 'Keluar Grup';

  @override
  String get changeGroupName => 'Ubah Nama Grup';

  @override
  String get enterGroupName => 'Masukkan nama grup';

  @override
  String get confirm => 'Konfirmasi';

  @override
  String get changeGroupDescription => 'Ubah Deskripsi Grup';

  @override
  String get enterGroupDescription => 'Masukkan deskripsi grup';

  @override
  String get editAnnouncement => 'Edit Pengumuman';

  @override
  String get enterAnnouncement => 'Masukkan pengumuman';

  @override
  String get publish => 'Publikasikan';

  @override
  String get clearHistoryConfirm =>
      'Hapus semua riwayat chat? Ini tidak dapat dibatalkan.';

  @override
  String get clearAction => 'Hapus';

  @override
  String get chatHistoryCleared => 'Riwayat chat dihapus';

  @override
  String leaveGroupConfirm(String name) {
    return 'Keluar dari \"$name\"?';
  }

  @override
  String dissolveGroupConfirm(String name) {
    return 'Bubarkan \"$name\"? Ini tidak dapat dibatalkan.';
  }

  @override
  String get dissolve => 'Bubarkan';

  @override
  String get groupQrCode => 'Kode QR Grup';

  @override
  String get searchChatHistory => 'Cari Riwayat Chat';

  @override
  String get groupIdCopied => 'ID Grup disalin';

  @override
  String tapCopyGroupId(int count) {
    return '$count anggota - Ketuk untuk menyalin ID Grup';
  }

  @override
  String get receiverAddress => 'Alamat Penerima';

  @override
  String get enterOrPasteAddress => 'Masukkan atau tempel alamat dompet';

  @override
  String get selectToken => 'Pilih Token';

  @override
  String get transferAmount => 'Jumlah Transfer';

  @override
  String get available => 'Tersedia';

  @override
  String get allAmount => 'Semua';

  @override
  String get memoOptional => 'Memo (opsional)';

  @override
  String get addMemo => 'Tambahkan memo';

  @override
  String get confirmTransfer => 'Konfirmasi Transfer';

  @override
  String get invalidAddress => 'Silakan masukkan alamat penerima yang valid';

  @override
  String get invalidAmount => 'Silakan masukkan jumlah yang valid';

  @override
  String get selectTokenPlease => 'Silakan pilih token';

  @override
  String get addressVerified => 'Alamat terverifikasi';

  @override
  String availableBalance(String balance, String symbol) {
    return 'Tersedia: $balance $symbol';
  }

  @override
  String get scanningInDevelopment => 'Fitur pindai sedang dikembangkan...';

  @override
  String get enterAmount => 'Masukkan jumlah';

  @override
  String get redPacketCountMin => 'Minimal 1 angpao diperlukan';

  @override
  String get viewRedPacketDetails => 'Lihat detail angpao';

  @override
  String get enterTransferAmount => 'Masukkan jumlah transfer';

  @override
  String get transferTo => 'Transfer ke';

  @override
  String get selectCurrency => 'Pilih mata uang';

  @override
  String get receiveTransfer => 'Menerima transfer';

  @override
  String fromSender(String name, Object senderName) {
    return 'Dari $senderName';
  }

  @override
  String get confirmReceive => 'Konfirmasi Penerimaan';

  @override
  String get groupProfile => 'Info Grup';

  @override
  String get viewProfile => 'Lihat Profil';

  @override
  String get removeMember => 'Keluarkan dari Grup';

  @override
  String removeMemberConfirm(String name) {
    return 'Keluarkan \"$name\" dari grup?';
  }

  @override
  String get remove => 'Keluarkan';

  @override
  String get clearStatus => 'Hapus Status';

  @override
  String get clearStatusConfirm => 'Hapus status saat ini?';

  @override
  String get statusCleared => 'Status dihapus';

  @override
  String statusSet(String result) {
    return 'Status diatur ke: $result';
  }

  @override
  String get userNotExist => 'Pengguna tidak ada';

  @override
  String get userIdCopied => 'ID Pengguna disalin';

  @override
  String get voiceCallInDevelopment => 'Panggilan suara sedang dikembangkan...';

  @override
  String get report => 'Laporkan';

  @override
  String get reportInDevelopment => 'Fitur laporan sedang dikembangkan...';

  @override
  String get shareCard => 'Bagikan Kartu';

  @override
  String get shareInDevelopment => 'Fitur bagikan sedang dikembangkan...';

  @override
  String get qrCode => 'Kode QR';

  @override
  String get qrCodeInDevelopment => 'Fitur kode QR sedang dikembangkan...';

  @override
  String get avatarUpdated => 'Avatar diperbarui';

  @override
  String selectImageFailed(String error) {
    return 'Gagal memilih gambar: $error';
  }

  @override
  String get changeName => 'Ubah Nama';

  @override
  String get male => 'Pria';

  @override
  String get female => 'Wanita';

  @override
  String genderSet(String gender) {
    return 'Jenis kelamin diatur ke: $gender';
  }

  @override
  String regionSet(String region) {
    return 'Wilayah diatur ke: $region';
  }

  @override
  String get setPatText => 'Atur Teks Tepukan';

  @override
  String get changeSignature => 'Ubah Tanda Tangan';

  @override
  String ringtoneSet(String result) {
    return 'Nada dering diatur ke: $result';
  }

  @override
  String featureInDev(String feature) {
    return '$feature sedang dikembangkan...';
  }

  @override
  String saveAddressFailed(String error) {
    return 'Gagal menyimpan alamat: $error';
  }

  @override
  String get myAddress => 'Alamat Saya';

  @override
  String get addNew => 'Tambah';

  @override
  String get addAddress => 'Tambah Alamat';

  @override
  String get addressAdded => 'Alamat ditambahkan';

  @override
  String get addressUpdated => 'Alamat diperbarui';

  @override
  String get deleteAddress => 'Hapus Alamat';

  @override
  String get deleteAddressConfirm => 'Hapus alamat ini?';

  @override
  String get addressDeleted => 'Alamat dihapus';

  @override
  String get setDefaultAddress => 'Atur sebagai default';

  @override
  String get fillCompleteInfo => 'Silakan isi semua kolom';

  @override
  String saveInvoiceFailed(String error) {
    return 'Gagal menyimpan faktur: $error';
  }

  @override
  String get myInvoices => 'Faktur Saya';

  @override
  String get addInvoice => 'Tambah Faktur';

  @override
  String get invoiceAdded => 'Faktur ditambahkan';

  @override
  String get invoiceUpdated => 'Faktur diperbarui';

  @override
  String get deleteInvoice => 'Hapus Faktur';

  @override
  String get deleteInvoiceConfirm => 'Hapus faktur ini?';

  @override
  String get invoiceDeleted => 'Faktur dihapus';

  @override
  String get invoiceType => 'Jenis faktur: ';

  @override
  String get personal => 'Pribadi';

  @override
  String get enterprise => 'Perusahaan';

  @override
  String get setDefaultInvoice => 'Atur sebagai default';

  @override
  String get enterTaxId => 'Masukkan NPWP';

  @override
  String get vibrateMode => 'Mode getar';

  @override
  String get silentMode => 'Mode senyap';

  @override
  String playing(String ringtoneName) {
    return 'Memutar: $ringtoneName';
  }

  @override
  String playFailed(String ringtoneName) {
    return 'Gagal memutar: $ringtoneName';
  }

  @override
  String get enterGroupNamePlease => 'Silakan masukkan nama grup';

  @override
  String get selectAtLeastOne => 'Silakan pilih minimal satu anggota';

  @override
  String get fillStatus => 'Tulis Status';

  @override
  String get fileNotExist => 'Berkas tidak ada';

  @override
  String sendFailed(String error) {
    return 'Gagal mengirim: $error';
  }

  @override
  String get cannotOpenBrowser => 'Tidak dapat membuka browser';

  @override
  String selectFileFailed(String error) {
    return 'Gagal memilih berkas: $error';
  }

  @override
  String get enterMusicLink => 'Masukkan tautan musik';

  @override
  String get enterValidLink => 'Silakan masukkan tautan yang valid';

  @override
  String get enterPollQuestion => 'Masukkan pertanyaan polling';

  @override
  String get minTwoOptions => 'Minimal 2 opsi diperlukan';

  @override
  String get crossDeviceEnabled =>
      'Penandatanganan lintas perangkat diaktifkan';

  @override
  String get crossDeviceSet =>
      'Penandatanganan lintas perangkat berhasil diatur';

  @override
  String setupFailed(String error) {
    return 'Pengaturan gagal: $error';
  }

  @override
  String get receiveAmount => 'Jumlah Diterima';

  @override
  String get enterValidAmount => 'Silakan masukkan jumlah yang valid';

  @override
  String get addressCopied => 'Alamat disalin';

  @override
  String openItem(String content) {
    return 'Buka: $content';
  }

  @override
  String get newNoteComingSoon => 'Fitur catatan baru segera hadir';

  @override
  String get addLinkComingSoon => 'Fitur tambah tautan segera hadir';

  @override
  String get deleted => 'Dihapus';

  @override
  String get shareComingSoon => 'Fitur bagikan segera hadir';

  @override
  String get saveComingSoon => 'Fitur simpan segera hadir';

  @override
  String get moreStylesComingSoon => 'Lebih banyak gaya segera hadir';

  @override
  String get wallet => 'Dompet';

  @override
  String get walletArea => 'Area dompet';

  @override
  String get recording => 'Merekam';

  @override
  String get invalidVideoUrl => 'URL video tidak valid';

  @override
  String get downloadFile => 'Unduh berkas';

  @override
  String get clearChatHistoryTitle => 'Hapus Riwayat Chat';

  @override
  String get cannotUndo => 'Ini tidak dapat dibatalkan';

  @override
  String get videoCall => 'Panggilan Video';

  @override
  String get voiceCall => 'Panggilan Suara';

  @override
  String get leaveMeeting => 'Tinggalkan Meeting';

  @override
  String get chatDetails => 'Detail Chat';

  @override
  String get viewAllGroupMembers => 'Lihat semua anggota';

  @override
  String get groupName => 'Nama Grup';

  @override
  String get groupNameUpdated => 'Nama grup diperbarui';

  @override
  String get groupDescriptionUpdated => 'Deskripsi grup diperbarui';

  @override
  String get groupAvatarUpdated => 'Avatar grup diperbarui';

  @override
  String get updateFailed => 'Pembaruan gagal';

  @override
  String get noPermissionToModify => 'Anda tidak memiliki izin untuk mengubah';

  @override
  String get groupManagement => 'Manajemen Grup';

  @override
  String get myNicknameInGroup => 'Nama Panggilan Saya di Grup';

  @override
  String get pinChat => 'Pin Chat';

  @override
  String get strongReminder => 'Pengingat Kuat';

  @override
  String get setChatBackground => 'Atur Latar Belakang Chat';

  @override
  String get unknownFile => 'Berkas tidak dikenal';

  @override
  String get download => 'Unduh';

  @override
  String get invalidLocation => 'Lokasi tidak valid';

  @override
  String get address => 'Alamat';

  @override
  String get latitude => 'Garis Lintang';

  @override
  String get longitude => 'Garis Bujur';

  @override
  String get close => 'Tutup';

  @override
  String get tapToCancel => 'Ketuk untuk membatalkan';

  @override
  String captureFailed(Object error) {
    return 'Gagal mengambil gambar: $error';
  }

  @override
  String get processingVideo => 'Memproses video...';

  @override
  String get videoFileNotExist => 'Berkas video tidak ada';

  @override
  String get videoDataEmpty => 'Data video kosong';

  @override
  String get videoTooLarge => 'Ukuran video tidak boleh melebihi 100MB';

  @override
  String get sendingVideo => 'Mengirim video...';

  @override
  String sendVideoFailed(Object error) {
    return 'Gagal mengirim video: $error';
  }

  @override
  String get imageFileNotExist => 'Berkas gambar tidak ada';

  @override
  String get imageDataEmpty => 'Data gambar kosong';

  @override
  String get sendingImage => 'Mengirim gambar...';

  @override
  String sendImageFailed(Object error) {
    return 'Gagal mengirim gambar: $error';
  }

  @override
  String get sendLocation => 'Kirim Lokasi';

  @override
  String get selectLocationAndSend => 'Pilih lokasi dan kirim';

  @override
  String get shareRealTimeLocation => 'Bagikan Lokasi Real-time';

  @override
  String get shareLocationForOneHour =>
      'Bagikan lokasi real-time dengan teman selama 1 jam';

  @override
  String get locationSent => 'Lokasi terkirim';

  @override
  String get selectMessages => 'Pilih pesan';

  @override
  String selectedCount(int count) {
    return 'Dipilih $count';
  }

  @override
  String get selectAll => 'Pilih Semua';

  @override
  String groupChatCount(int count) {
    return 'Chat Grup ($count)';
  }

  @override
  String get privateChat => 'Chat Pribadi';

  @override
  String get noMessages => 'Tidak ada pesan';

  @override
  String get sendFirstMessage => 'Kirim pesan pertama untuk mulai mengobrol';

  @override
  String get encryptionNotice =>
      'Chat ini dienkripsi ujung ke ujung. Hanya Anda dan penerima yang dapat membaca pesan.';

  @override
  String replyTo(String name) {
    return 'Balas ke $name';
  }

  @override
  String get multiForward => 'Teruskan';

  @override
  String get collect => 'Koleksi';

  @override
  String get noMembers => 'Tidak ada anggota';

  @override
  String get memberNotFound => 'Anggota tidak ditemukan';

  @override
  String get voiceFileNotExist => 'Berkas suara tidak ada';

  @override
  String get voiceFileEmpty => 'Berkas suara kosong';

  @override
  String get sendingVoice => 'Mengirim suara...';

  @override
  String sendVoiceFailed(Object error) {
    return 'Gagal mengirim suara: $error';
  }

  @override
  String get messageCopied => 'Pesan disalin';

  @override
  String get messageForwarded => 'Pesan diteruskan';

  @override
  String forwardFailed(Object error) {
    return 'Gagal meneruskan: $error';
  }

  @override
  String get unfavorited => 'Batal favorit';

  @override
  String get favorited => 'Difavoritkan';

  @override
  String get reactionAdded => 'Reaksi ditambahkan';

  @override
  String get reactionRemoved => 'Reaksi dihapus';

  @override
  String get failedMessageDeleted => 'Pesan gagal dihapus';

  @override
  String get deleteMessages => 'Hapus pesan';

  @override
  String deleteMessagesConfirm(Object count) {
    return 'Apakah Anda yakin ingin menghapus $count pesan?';
  }

  @override
  String noteOtherMessages(Object count) {
    return 'Catatan: $count pesan dari orang lain dan hanya akan dihapus untuk Anda.';
  }

  @override
  String myMessagesWillBeRecalled(Object count) {
    return '$count pesan dari Anda akan ditarik untuk semua.';
  }

  @override
  String recalledCount(Object count, Object localCount) {
    return 'Menarik $count pesan, $localCount dihapus hanya untuk Anda';
  }

  @override
  String recalledMessages(Object count) {
    return 'Menarik $count pesan';
  }

  @override
  String deletedLocally(Object count) {
    return '$count pesan dihapus hanya untuk Anda';
  }

  @override
  String forwardedCount(Object count) {
    return 'Meneruskan $count pesan';
  }

  @override
  String forwardComplete(Object failed, Object success) {
    return 'Penerusan selesai: $success berhasil, $failed gagal';
  }

  @override
  String get remindOnlyInGroup => 'Fitur pengingat hanya tersedia di chat grup';

  @override
  String get onlyTextSearchable => 'Hanya pesan teks yang dapat dicari';

  @override
  String searchFor(Object text) {
    return 'Cari \"$text\"';
  }

  @override
  String get baiduSearch => 'Pencarian Baidu';

  @override
  String get googleSearch => 'Pencarian Google';

  @override
  String get bingSearch => 'Pencarian Bing';

  @override
  String get calling => 'Memanggil...';

  @override
  String get connecting => 'Menghubungkan...';

  @override
  String get ringing => 'Berdering...';

  @override
  String get inCall => 'Dalam panggilan';

  @override
  String featureInDevelopment(String feature) {
    return 'Fitur sedang dikembangkan...';
  }

  @override
  String collectMessages(Object count) {
    return 'Mengoleksi $count pesan';
  }

  @override
  String get voted => 'Memilih';

  @override
  String get voteChanged => 'Pilihan diubah';

  @override
  String get voteRemoved => 'Pilihan dihapus';

  @override
  String get endPoll => 'Akhiri Polling';

  @override
  String get endPollConfirm =>
      'Apakah Anda yakin ingin mengakhiri polling ini? Tidak ada lagi suara yang dapat diberikan setelah diakhiri.';

  @override
  String memberCount(int count) {
    return '$count anggota';
  }

  @override
  String get videoChannels => 'Saluran';

  @override
  String get live => 'Siaran';

  @override
  String get listen => 'Dengarkan';

  @override
  String get watch => 'Tonton';

  @override
  String get searchDiscover => 'Cari';

  @override
  String get nearbyPeople => 'Sekitar';

  @override
  String get games => 'Permainan';

  @override
  String get miniPrograms => 'Mini Program';

  @override
  String done(int count) {
    return 'Selesai($count)';
  }

  @override
  String get services => 'Layanan';

  @override
  String get favorites => 'Favorit';

  @override
  String get ordersAndCards => 'Pesanan & Kartu';

  @override
  String get stickers => 'Stiker';

  @override
  String statusSetTo(String status) {
    return 'Status diatur ke: $status';
  }

  @override
  String get avatarUploadFailed => 'Gagal mengunggah avatar';

  @override
  String get personalProfile => 'Profil Pribadi';

  @override
  String get name => 'Nama';

  @override
  String get gender => 'Jenis Kelamin';

  @override
  String get region => 'Wilayah';

  @override
  String get myQrCode => 'Kode QR Saya';

  @override
  String get poke => 'Colek';

  @override
  String get ringtone => 'Nada Dering';

  @override
  String get defaultRingtone => 'Nada Dering Default';

  @override
  String get myAddresses => 'Alamat Saya';

  @override
  String genderSetTo(String gender) {
    return 'Jenis kelamin diatur ke: $gender';
  }

  @override
  String get selectRegion => 'Pilih Wilayah';

  @override
  String get selectCity => 'Pilih Kota';

  @override
  String regionSetTo(String region) {
    return 'Wilayah diatur ke: $region';
  }

  @override
  String get setPoke => 'Atur Colek';

  @override
  String get friendPokedMe => 'Teman mencolek saya';

  @override
  String get enterPokeSuffix => 'Masukkan akhiran colek, contoh: di bahu';

  @override
  String get example => 'Contoh';

  @override
  String get onTheShoulder => ' di bahu';

  @override
  String get pokeCleared => 'Colek dihapus';

  @override
  String pokeSetTo(String suffix) {
    return 'Colek diatur ke: mencolek saya$suffix';
  }

  @override
  String get editSignature => 'Edit Tanda Tangan';

  @override
  String get introduceYourself => 'Sebuah kalimat untuk memperkenalkan diri';

  @override
  String get signatureCleared => 'Tanda tangan dihapus';

  @override
  String get signatureUpdated => 'Tanda tangan diperbarui';

  @override
  String get scanToAddFriend =>
      'Pindai kode QR di atas untuk menambahkan saya sebagai teman';

  @override
  String ringtoneSetTo(String ringtone) {
    return 'Nada dering diatur ke: $ringtone';
  }

  @override
  String confirmDissolveGroup(String name) {
    return 'Apakah Anda yakin ingin membubarkan \"$name\"? Tindakan ini tidak dapat dibatalkan.';
  }

  @override
  String get enterValidServerAddress =>
      'Silakan masukkan alamat server yang valid';

  @override
  String get emailOtp => 'OTP Email';

  @override
  String get enterServerAddressFirst =>
      'Silakan masukkan alamat server terlebih dahulu';

  @override
  String get passkeyRequiresServer =>
      'Login passkey memerlukan dukungan server';

  @override
  String get loginAgreement => 'Dengan masuk, Anda menyetujui ';

  @override
  String get pleaseAgreeToTerms =>
      'Silakan baca dan setujui Ketentuan Layanan dan Kebijakan Privasi';

  @override
  String get registerFailed => 'Pendaftaran gagal';

  @override
  String get reenterPassword => 'Masukkan ulang kata sandi';

  @override
  String get passwordsDoNotMatch => 'Kata sandi tidak cocok';

  @override
  String get inviteCodeBuiltIn => 'Kode Undangan (Bawaan)';

  @override
  String get inviteCodeBuiltInNote =>
      'Kode undangan sudah bawaan, biasanya tidak perlu diubah';

  @override
  String get iHaveReadAndAgree => 'Saya telah membaca dan menyetujui ';

  @override
  String get startGroupChat => 'Mulai Chat Grup';

  @override
  String get addFriends => 'Tambah Teman';

  @override
  String get paymentAndCollection => 'Pembayaran';

  @override
  String messagesWithCount(int count) {
    return 'Pesan($count)';
  }

  @override
  String contactCount(int count) {
    return '$count kontak';
  }

  @override
  String get addToHomeScreen => 'Tambahkan ke layar utama';

  @override
  String recommendedCardTo(String contact, String recipient) {
    return 'Merekomendasikan kartu $contact ke $recipient';
  }

  @override
  String get enterRemarkName => 'Masukkan nama catatan';

  @override
  String remarkSetTo(String remark) {
    return 'Catatan diatur ke: $remark';
  }

  @override
  String acceptedFriendRequest(String name) {
    return 'Menerima permintaan pertemanan $name';
  }

  @override
  String rejectedFriendRequest(String name) {
    return 'Menolak permintaan pertemanan $name';
  }

  @override
  String get groupInvites => 'Undangan Grup';

  @override
  String myGroups(int count) {
    return 'Grup Saya ($count)';
  }

  @override
  String get invitedToJoinGroup => 'Diundang untuk bergabung ke grup';

  @override
  String confirmLeaveGroup(String name) {
    return 'Apakah Anda yakin ingin keluar dari \"$name\"?';
  }

  @override
  String get leave => 'Keluar';

  @override
  String get saveMedia => 'Simpan';

  @override
  String get recallThisMessage => 'Tarik pesan ini?';

  @override
  String get messageRecalled => 'Pesan ditarik';

  @override
  String get savedToGallery => 'Disimpan ke galeri';

  @override
  String get failedToSave => 'Gagal menyimpan';

  @override
  String get saving => 'Menyimpan...';

  @override
  String get share => 'Bagikan';

  @override
  String get saveToGallery => 'Simpan ke Galeri';

  @override
  String downloadFailed(String code) {
    return 'Unduhan gagal: $code';
  }

  @override
  String get noMediaUrl => 'Tidak ada URL media tersedia';

  @override
  String shareFailed(String error) {
    return 'Gagal berbagi: $error';
  }

  @override
  String get failedToLoadImage => 'Gagal memuat gambar';

  @override
  String get failedToLoadMoreMessages => 'Gagal memuat lebih banyak pesan';

  @override
  String get failedToSend => 'Gagal mengirim';

  @override
  String get failedToSendImage => 'Gagal mengirim gambar';

  @override
  String get failedToSendVoice => 'Gagal mengirim suara';

  @override
  String get failedToSendFile => 'Gagal mengirim berkas';

  @override
  String get failedToSendVideo => 'Gagal mengirim video';

  @override
  String get failedToSendLocation => 'Gagal mengirim lokasi';

  @override
  String get failedToResend => 'Gagal mengirim ulang';

  @override
  String get failedToRecall => 'Gagal menarik';

  @override
  String get failedToReply => 'Gagal membalas';

  @override
  String get failedToAddReaction => 'Gagal menambahkan reaksi';

  @override
  String get failedToSendPoll => 'Gagal mengirim polling';

  @override
  String get failedToVote => 'Gagal memilih';

  @override
  String get failedToLoadMessages => 'Gagal memuat pesan';

  @override
  String get callFeatureComingSoon =>
      'Fitur panggilan suara dan video segera hadir';

  @override
  String get cannotForwardRedPacketOrTransfer =>
      'Angpao dan transfer tidak dapat diteruskan';

  @override
  String get videoRecordingFailed =>
      'Perekaman video gagal. Silakan coba lagi.';

  @override
  String get redPacket => 'Angpao';

  @override
  String get music => 'Musik';

  @override
  String get coupon => 'Kupon';

  @override
  String get gift => 'Hadiah';

  @override
  String get poll => 'Polling';

  @override
  String get text => 'Teks';

  @override
  String get link => 'Tautan';

  @override
  String get note => 'Catatan';

  @override
  String get myNotes => 'Catatan Saya';

  @override
  String get today => 'Hari ini';

  @override
  String daysAgoText(int count) {
    return '$count hari lalu';
  }

  @override
  String dateFormat(int month, int day) {
    return '$day/$month';
  }

  @override
  String get noFavorites => 'Belum ada favorit';

  @override
  String get longPressToFavorite => 'Tekan lama pesan untuk difavoritkan';

  @override
  String get newNote => 'Catatan Baru';

  @override
  String get favoriteLink => 'Favoritkan Tautan';

  @override
  String get editTags => 'Edit Tag';

  @override
  String get deleteFavorite => 'Hapus Favorit';

  @override
  String get deleteFavoriteConfirm =>
      'Apakah Anda yakin ingin menghapus favorit ini?';

  @override
  String get noSearchResultsFound => 'Tidak ada hasil ditemukan';

  @override
  String get sendRedPacket => 'Kirim Angpao';

  @override
  String get amount => 'Jumlah';

  @override
  String get redPacketCover => 'Sampul Angpao';

  @override
  String get redPacketType => 'Jenis Angpao';

  @override
  String get normalRedPacket => 'Normal';

  @override
  String get luckyRedPacket => 'Hoki';

  @override
  String get redPacketCount => 'Jumlah Angpao';

  @override
  String get pieces => 'buah';

  @override
  String get putMoneyInRedPacket => 'Masukkan uang ke angpao';

  @override
  String get redPacketRefundNotice =>
      'Angpao yang tidak diklaim akan dikembalikan setelah 24 jam';

  @override
  String get openRedPacket => 'Buka';

  @override
  String get redPacketAllClaimed => 'Angpao habis diklaim';

  @override
  String get redPacketExpired => 'Angpao kedaluwarsa';

  @override
  String get addTransferNote => 'Tambahkan catatan transfer';

  @override
  String get yuan => 'IDR';

  @override
  String get savedToChangeCanTransfer =>
      'Disimpan ke saldo, dapat ditransfer langsung';

  @override
  String get replyWithEmoji => 'Balas dengan emoji ini';

  @override
  String get claimedYourRedPacket => 'mengklaim';

  @override
  String get claimedRedPacket => 'mengklaim';

  @override
  String get otherTyping => 'mengetik...';

  @override
  String get processing => 'Memproses...';

  @override
  String get transferCancelled => 'Transfer dibatalkan';

  @override
  String get transferFailed => 'Transfer gagal';

  @override
  String get creatingPaymentRequest => 'Membuat permintaan pembayaran...';

  @override
  String get processingPayment => 'Memproses pembayaran...';

  @override
  String get paymentFailed => 'Pembayaran gagal';

  @override
  String get clickRetry => 'Ketuk untuk mencoba lagi';

  @override
  String get settingsTitle => 'Pengaturan';

  @override
  String get editRemark => 'Edit Catatan';

  @override
  String get setPermissions => 'Atur Izin';

  @override
  String get recommendToFriends => 'Rekomendasikan ke Teman';

  @override
  String get setStarFriend => 'Atur sebagai Teman Bintang';

  @override
  String get addToBlacklist => 'Tambahkan ke Daftar Hitam';

  @override
  String get complain => 'Laporkan';

  @override
  String get deleteContact => 'Hapus Kontak';

  @override
  String deleteContactConfirm(String name) {
    return 'Apakah Anda yakin ingin menghapus $name?';
  }

  @override
  String get transferTitle => 'Transfer';

  @override
  String get receiverAddressLabel => 'Alamat Penerima';

  @override
  String get selectTokenLabel => 'Pilih Token';

  @override
  String get transferAmountLabel => 'Jumlah Transfer';

  @override
  String get memoLabel => 'Memo (opsional)';

  @override
  String get enterOrPasteAddressHint => 'Masukkan atau tempel alamat dompet';

  @override
  String get scanInDevelopment => 'Fitur pindai sedang dikembangkan...';

  @override
  String get availableLabel => 'Tersedia';

  @override
  String availableBalanceFormat(String balance, String symbol) {
    return 'Tersedia: $balance $symbol';
  }

  @override
  String get addMemoHint => 'Tambahkan memo';

  @override
  String get receiveTitle => 'Terima';

  @override
  String get walletNotConnectedTitle => 'Dompet tidak terhubung';

  @override
  String get connectWalletFirst => 'Silakan hubungkan dompet terlebih dahulu';

  @override
  String get sendPaymentRequest => 'Kirim Permintaan Pembayaran';

  @override
  String get qrCodeGenerateFailed => 'Gagal membuat kode QR';

  @override
  String get scanQrToPayMe => 'Pindai kode QR untuk membayar saya';

  @override
  String get myWalletAddress => 'Alamat Dompet Saya';

  @override
  String get createPaymentRequest => 'Buat Permintaan Pembayaran';

  @override
  String get selectTokenHint => 'Pilih Token';

  @override
  String get amountLabel => 'Jumlah';

  @override
  String get cancelButton => 'Batal';

  @override
  String get sendRequestButton => 'Kirim Permintaan';

  @override
  String get allReadReceipt => 'Semua dibaca';

  @override
  String readCountReceipt(int count) {
    return '$count dibaca';
  }

  @override
  String n42IdLabel(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get redPacketDefaultGreeting => 'Semoga sukses selalu';

  @override
  String senderRedPacket(String name) {
    return 'Angpao $name';
  }

  @override
  String get allButton => 'Semua';

  @override
  String get enterValidAddress => 'Silakan masukkan alamat yang valid';

  @override
  String get pleaseSelectToken => 'Silakan pilih token';

  @override
  String get receivedTransfer => 'Transfer Diterima';

  @override
  String get selectForwardRecipient => 'Pilih penerima terusan';

  @override
  String get emojiFaces => 'Wajah';

  @override
  String get emojiHearts => 'Hati';

  @override
  String get emojiAnimals => 'Hewan';

  @override
  String get emojiFood => 'Makanan';

  @override
  String get emojiTransport => 'Transportasi';

  @override
  String get emojiActivities => 'Aktivitas';

  @override
  String get emojiObjects => 'Objek';

  @override
  String get emojiSymbols => 'Simbol';

  @override
  String get transferProcessing => 'Memproses transfer...';

  @override
  String senderSentRedPacket(String name) {
    return '$name mengirim angpao';
  }

  @override
  String get savedToBalance => 'Disimpan ke saldo, dapat ditransfer langsung';

  @override
  String get redPacketExpiredOrEmpty => 'Angpao kedaluwarsa/habis diklaim';

  @override
  String get scanFeatureComingSoon => 'Fitur pindai segera hadir...';

  @override
  String get setAsStarred => 'Atur sebagai Berbintang';

  @override
  String get addToBlocklist => 'Tambahkan ke Daftar Blokir';

  @override
  String get claimedYour => ' mengklaim ';

  @override
  String get claimedText => ' mengklaim ';

  @override
  String userTyping(String name) {
    return '$name sedang mengetik...';
  }

  @override
  String get typing => 'Mengetik...';

  @override
  String get waitingToReceive => 'Menunggu untuk diterima';

  @override
  String get tapToClaim => 'Ketuk untuk klaim';

  @override
  String get hasBeenReceived => 'Sudah diterima';

  @override
  String get getLucky => 'Semoga beruntung';

  @override
  String get cameraStartFailed => 'Kamera gagal dimulai';

  @override
  String get unknownError => 'Kesalahan tidak dikenal';

  @override
  String get placeQrCodeInFrame =>
      'Letakkan kode QR dalam bingkai untuk memindai';

  @override
  String get closeManualInput => 'Tutup Input Manual';

  @override
  String get manualInputUserId => 'Input Manual ID Pengguna';

  @override
  String get add => 'Tambah';

  @override
  String get ringtoneClear => 'Hapus';

  @override
  String get ringtonePhone => 'Telepon';

  @override
  String get ringtoneClassic => 'Klasik';

  @override
  String get ringtoneSoft => 'Lembut';

  @override
  String get ringtoneVibrate => 'Getar';

  @override
  String get ringtoneSilent => 'Senyap';

  @override
  String get stop => 'Berhenti';

  @override
  String get selectRingtone => 'Pilih Nada Dering';

  @override
  String get loadingRingtones => 'Memuat nada dering...';

  @override
  String get noRingtonesFound => 'Tidak ada nada dering ditemukan';

  @override
  String get moodAndThoughts => 'Suasana Hati & Pikiran';

  @override
  String get statusHappy => 'Senang';

  @override
  String get statusCracked => 'Hancur';

  @override
  String get statusLucky => 'Beruntung';

  @override
  String get statusSunny => 'Cerah';

  @override
  String get statusTired => 'Lelah';

  @override
  String get statusDaydream => 'Melamun';

  @override
  String get statusRushing => 'Terburu-buru';

  @override
  String get statusOverthinking => 'Berpikir Berlebihan';

  @override
  String get statusEnergized => 'Berenergi';

  @override
  String get workAndStudy => 'Kerja & Belajar';

  @override
  String get statusWorking => 'Bekerja';

  @override
  String get statusStudying => 'Belajar';

  @override
  String get statusBusy => 'Sibuk';

  @override
  String get statusSlacking => 'Santai';

  @override
  String get statusTraveling => 'Bepergian';

  @override
  String get statusGoingHome => 'Pulang';

  @override
  String get statusDnd => 'Jangan Ganggu';

  @override
  String get statusHanging => 'Nongkrong';

  @override
  String get statusCheckIn => 'Check In';

  @override
  String get statusExercising => 'Berolahraga';

  @override
  String get statusCoffee => 'Kopi';

  @override
  String get statusBubbleTea => 'Boba';

  @override
  String get statusEating => 'Makan';

  @override
  String get statusParenting => 'Mengasuh';

  @override
  String get statusSavingWorld => 'Menyelamatkan Dunia';

  @override
  String get statusSelfie => 'Selfie';

  @override
  String get rest => 'Istirahat';

  @override
  String get statusRetreat => 'Istirahat';

  @override
  String get statusHome => 'Di Rumah';

  @override
  String get statusSleeping => 'Tidur';

  @override
  String get statusCatLover => 'Pecinta Kucing';

  @override
  String get statusDogWalking => 'Jalan-jalan dengan Anjing';

  @override
  String get statusGaming => 'Bermain Game';

  @override
  String get statusListening => 'Mendengarkan';

  @override
  String get setStatus => 'Atur Status';

  @override
  String get visibleToFriends24h => 'Terlihat oleh teman selama 24 jam';

  @override
  String get writeStatus => 'Tulis Status';

  @override
  String get enterYourStatus => 'Masukkan status Anda...';

  @override
  String get ok => 'OK';

  @override
  String get cameraPermissionRequired =>
      'Izin kamera diperlukan untuk memindai kode QR';

  @override
  String get cameraPermissionDenied =>
      'Izin kamera ditolak secara permanen. Silakan aktifkan di pengaturan sistem.';

  @override
  String get cannotGetCameraPermission => 'Tidak dapat mendapatkan izin kamera';

  @override
  String permissionCheckError(String error) {
    return 'Kesalahan memeriksa izin: $error';
  }

  @override
  String get invalidQrCode => 'Kode QR tidak valid';

  @override
  String qrCodeProcessFailed(String error) {
    return 'Gagal memproses kode QR: $error';
  }

  @override
  String cannotAddFriend(String error) {
    return 'Tidak dapat menambah teman: $error';
  }

  @override
  String get scanQrCode => 'Pindai Kode QR';

  @override
  String get checkingCameraPermission => 'Memeriksa izin kamera...';

  @override
  String get needCameraPermission => 'Izin Kamera Diperlukan';

  @override
  String get retryPermission => 'Coba Lagi';

  @override
  String get openSettings => 'Buka Pengaturan';

  @override
  String get inviteMembers => 'Undang Anggota';

  @override
  String inviteCount(int count) {
    return 'Undang($count)';
  }

  @override
  String get noShippingAddress => 'Tidak ada alamat pengiriman';

  @override
  String get defaultLabel => 'Default';

  @override
  String get editAddress => 'Edit Alamat';

  @override
  String get recipient => 'Penerima';

  @override
  String get enterRecipientName => 'Masukkan nama penerima';

  @override
  String get phoneNumber => 'Nomor Telepon';

  @override
  String get enterPhoneNumber => 'Masukkan nomor telepon';

  @override
  String get regionHint => 'Provinsi/Kota/Kabupaten';

  @override
  String get detailedAddress => 'Alamat Lengkap';

  @override
  String get detailedAddressHint => 'Jalan, nomor gedung, dll.';

  @override
  String get setAsDefaultAddress => 'Atur sebagai alamat default';

  @override
  String get pleaseCompleteInfo => 'Silakan lengkapi semua kolom';

  @override
  String get noInvoice => 'Tidak ada faktur';

  @override
  String get company => 'Perusahaan';

  @override
  String get taxNumber => 'Nomor Pajak';

  @override
  String get editInvoice => 'Edit Faktur';

  @override
  String get companyName => 'Nama Perusahaan';

  @override
  String get enterCompanyName => 'Masukkan nama perusahaan';

  @override
  String get personalName => 'Nama Pribadi';

  @override
  String get enterName => 'Masukkan nama';

  @override
  String get taxIdNumber => 'NPWP';

  @override
  String get enterTaxIdNumber => 'Masukkan NPWP';

  @override
  String get bankNameOptional => 'Nama Bank (Opsional)';

  @override
  String get enterBankName => 'Masukkan nama bank';

  @override
  String get bankAccountOptional => 'Rekening Bank (Opsional)';

  @override
  String get enterBankAccount => 'Masukkan rekening bank';

  @override
  String get companyAddressOptional => 'Alamat Perusahaan (Opsional)';

  @override
  String get enterCompanyAddress => 'Masukkan alamat perusahaan';

  @override
  String get companyPhoneOptional => 'Telepon Perusahaan (Opsional)';

  @override
  String get enterCompanyPhone => 'Masukkan telepon perusahaan';

  @override
  String get setAsDefaultInvoice => 'Atur sebagai faktur default';

  @override
  String get confirmDeleteAddress =>
      'Apakah Anda yakin ingin menghapus alamat ini?';

  @override
  String get confirmDeleteInvoice =>
      'Apakah Anda yakin ingin menghapus faktur ini?';

  @override
  String get groupOwner => 'Pemilik';

  @override
  String get groupAdmin => 'Admin';

  @override
  String get searchMembers => 'Cari anggota';

  @override
  String totalMembers(int count) {
    return '$count anggota';
  }

  @override
  String get removeFromGroup => 'Keluarkan dari Grup';

  @override
  String confirmRemoveMember(String name) {
    return 'Apakah Anda yakin ingin mengeluarkan \"$name\" dari grup?';
  }

  @override
  String get setAsAdmin => 'Atur sebagai Admin';

  @override
  String get removeAdmin => 'Hapus Admin';

  @override
  String get deleteContactSuccess => 'Kontak dihapus';

  @override
  String get unknownSong => 'Lagu Tidak Dikenal';

  @override
  String get unknownArtist => 'Artis Tidak Dikenal';

  @override
  String get unknownContact => 'Kontak Tidak Dikenal';

  @override
  String get personalCard => 'Kartu Kontak';

  @override
  String get singleChoice => 'Tunggal';

  @override
  String get multiChoice => 'Multi';

  @override
  String get ended => 'Berakhir';

  @override
  String get endPollButton => 'Akhiri Polling';

  @override
  String get createPoll => 'Buat Polling';

  @override
  String get pollQuestion => 'Pertanyaan Polling';

  @override
  String get pollOptions => 'Opsi Polling';

  @override
  String optionPlaceholder(int index) {
    return 'Opsi $index';
  }

  @override
  String get addOption => 'Tambah Opsi';

  @override
  String get pollSettings => 'Pengaturan Polling';

  @override
  String get anonymousPoll => 'Polling Anonim';

  @override
  String get pollHint =>
      'Polling akan ditampilkan di chat. Anggota grup dapat memilih.';

  @override
  String get searchSongOrArtist => 'Cari lagu atau artis';

  @override
  String get noSongsFound => 'Tidak ada lagu ditemukan';

  @override
  String get supportedMusicPlatforms =>
      'Mendukung tautan musik dari NetEase, QQ Music, dll.';

  @override
  String get songNameOptional => 'Nama Lagu (Opsional)';

  @override
  String get enterSongName => 'Masukkan nama lagu';

  @override
  String get artistNameOptional => 'Nama Artis (Opsional)';

  @override
  String get enterArtistName => 'Masukkan nama artis';

  @override
  String get shareSong => 'Bagikan Lagu';

  @override
  String get realTimeLocationSharing =>
      'Berbagi lokasi real-time sedang dikembangkan...';

  @override
  String get voiceCallFeatureInDev =>
      'Fitur panggilan suara sedang dikembangkan...';

  @override
  String get reportFeatureInDev => 'Fitur laporan sedang dikembangkan...';

  @override
  String get shareFeatureInDev => 'Fitur bagikan sedang dikembangkan...';

  @override
  String get qrCodeFeatureInDev => 'Fitur kode QR sedang dikembangkan...';

  @override
  String get scanQrToAddMe =>
      'Pindai kode QR di atas untuk menambahkan saya sebagai teman';

  @override
  String get saveToAlbum => 'Simpan ke Album';

  @override
  String get changeStyle => 'Ubah Gaya';

  @override
  String get copyId => 'Salin ID';

  @override
  String get idCopied => 'ID disalin';

  @override
  String get shareFeatureComingSoon => 'Fitur bagikan segera hadir';

  @override
  String get saveFeatureComingSoon => 'Fitur simpan segera hadir';

  @override
  String get moreStylesFeatureComingSoon => 'Lebih banyak gaya segera hadir';

  @override
  String get confirmEndPoll =>
      'Apakah Anda yakin ingin mengakhiri polling ini?';

  @override
  String get cannotVoteAfterEnd =>
      'Tidak ada lagi suara yang dapat diberikan setelah diakhiri.';

  @override
  String get bio => 'Bio';

  @override
  String get homeServer => 'Server';

  @override
  String get shareContactCard => 'Bagikan Kartu Kontak';

  @override
  String get removeFromBlacklist => 'Hapus dari Daftar Hitam';

  @override
  String get confirmAddBlacklist =>
      'Apakah Anda yakin ingin menambahkan pengguna ini ke daftar hitam? Anda tidak akan menerima pesan dari mereka.';

  @override
  String get confirmRemoveBlacklist =>
      'Apakah Anda yakin ingin menghapus pengguna ini dari daftar hitam?';

  @override
  String get remarkSaved => 'Catatan disimpan';

  @override
  String get remarkCleared => 'Catatan dihapus';

  @override
  String get receive => 'Terima';

  @override
  String get pleaseConnectWallet =>
      'Silakan hubungkan dompet Anda terlebih dahulu';

  @override
  String get sendRequest => 'Kirim Permintaan';

  @override
  String get pleaseEnterValidAmount => 'Silakan masukkan jumlah yang valid';

  @override
  String get searchPlaceholder => 'Cari kontak, grup, pesan';

  @override
  String get enterKeywordToSearch => 'Masukkan kata kunci untuk mulai mencari';

  @override
  String get clearHistory => 'Hapus';

  @override
  String noResultsForQuery(String query) {
    return 'Tidak ada hasil ditemukan untuk \"$query\"';
  }

  @override
  String get allResults => 'Semua';

  @override
  String get searchInChat => 'Cari di chat';

  @override
  String get contactLabel => 'Kontak';

  @override
  String get groupLabel => 'Grup';

  @override
  String get conversationLabel => 'Percakapan';

  @override
  String get messageLabel => 'Pesan';

  @override
  String get securityTitle => 'Keamanan';

  @override
  String get keyBackup => 'Cadangan Kunci';

  @override
  String get backupEncryptionKeys => 'Cadangkan Kunci Enkripsi';

  @override
  String keysBackedUp(int count) {
    return '$count kunci dicadangkan';
  }

  @override
  String get backupNotSet => 'Cadangan belum diatur';

  @override
  String get restoreKeys => 'Pulihkan Kunci';

  @override
  String get restoreKeysFromBackup => 'Pulihkan kunci enkripsi dari cadangan';

  @override
  String get exportKeys => 'Ekspor Kunci';

  @override
  String get exportKeysToFile => 'Ekspor kunci ke berkas';

  @override
  String get loggedInDevices => 'Perangkat yang Masuk';

  @override
  String get noOtherDevices => 'Tidak ada perangkat lain';

  @override
  String get verified => 'Terverifikasi';

  @override
  String get unverified => 'Belum terverifikasi';

  @override
  String get advanced => 'Lanjutan';

  @override
  String get crossSigning => 'Cross-Signing';

  @override
  String get enabled => 'Diaktifkan';

  @override
  String get notEnabled => 'Tidak diaktifkan';

  @override
  String get resetEncryption => 'Reset Enkripsi';

  @override
  String get deleteAllEncryptionKeys => 'Hapus semua kunci enkripsi';

  @override
  String get encryptionNotSupported => 'Enkripsi tidak didukung';

  @override
  String get notInitialized => 'Belum diinisialisasi';

  @override
  String get backupKeyTitle => 'Cadangkan Kunci';

  @override
  String get backupKeyMessage =>
      'Buat cadangan kunci baru? Ini akan membantu Anda memulihkan pesan terenkripsi di perangkat baru.';

  @override
  String get backup => 'Cadangkan';

  @override
  String get restoreKeyTitle => 'Pulihkan Kunci';

  @override
  String get restoreKeyMessage =>
      'Masukkan kata sandi pemulihan atau kunci pemulihan untuk memulihkan pesan terenkripsi.';

  @override
  String get restore => 'Pulihkan';

  @override
  String get exportKeyTitle => 'Ekspor Kunci';

  @override
  String get exportKeyMessage =>
      'Berkas kunci yang diekspor berisi semua kunci enkripsi Anda. Harap simpan dengan aman.';

  @override
  String get export => 'Ekspor';

  @override
  String deviceIdLabel(String deviceId) {
    return 'ID Perangkat: $deviceId';
  }

  @override
  String get deviceStatusVerified => 'Status: Terverifikasi';

  @override
  String get deviceStatusUnverified => 'Status: Belum terverifikasi';

  @override
  String lastActiveLabel(String lastSeen) {
    return 'Terakhir aktif: $lastSeen';
  }

  @override
  String get verifyThisDevice => 'Verifikasi perangkat ini';

  @override
  String get crossSigningAlreadyEnabled => 'Cross-signing sudah diaktifkan';

  @override
  String get crossSigningSetupSuccess => 'Pengaturan cross-signing berhasil';

  @override
  String get resetEncryptionTitle => 'Reset Enkripsi';

  @override
  String get resetEncryptionWarning =>
      'Peringatan: Ini akan menghapus semua kunci enkripsi Anda. Anda tidak akan dapat mendekripsi pesan terenkripsi sebelumnya. Tindakan ini tidak dapat dibatalkan.';

  @override
  String get reset => 'Reset';

  @override
  String get leaveMeetingConfirm =>
      'Apakah Anda yakin ingin meninggalkan meeting?';

  @override
  String pokedSomeone(String name, String suffix) {
    return 'mencolek $name$suffix';
  }

  @override
  String get noContactsToAdd => 'Tidak ada kontak yang dapat ditambahkan';

  @override
  String get addMembers => 'Tambah Anggota';

  @override
  String invitedMembers(int count) {
    return 'Mengundang $count anggota';
  }

  @override
  String inviteFailed(String error) {
    return 'Undangan gagal: $error';
  }

  @override
  String get memberRemoved => 'Anggota dikeluarkan';

  @override
  String removeFailed(String error) {
    return 'Gagal mengeluarkan: $error';
  }

  @override
  String get realTimeLocationShareMessage =>
      'Setelah berbagi, pihak lain dapat melihat lokasi real-time Anda selama 1 jam.';

  @override
  String get startSharing => 'Mulai Berbagi';

  @override
  String get locationServiceNotEnabled => 'Layanan lokasi tidak diaktifkan';

  @override
  String get enableLocationService =>
      'Silakan aktifkan layanan lokasi untuk menggunakan fitur ini';

  @override
  String get goToSettings => 'Buka Pengaturan';

  @override
  String get locationPermissionRequired =>
      'Izin lokasi diperlukan untuk fitur ini';

  @override
  String get locationPermissionDeniedPermanent =>
      'Izin lokasi telah ditolak secara permanen. Silakan aktifkan di pengaturan.';

  @override
  String get locationPermissionDenied => 'Izin lokasi ditolak';

  @override
  String get gettingLocation => 'Mendapatkan lokasi...';

  @override
  String getLocationFailed(String error) {
    return 'Gagal mendapatkan lokasi: $error';
  }

  @override
  String get currentLocation => 'Lokasi Saat Ini';

  @override
  String nearbyPlace(int index) {
    return 'Tempat Terdekat $index';
  }

  @override
  String approximateDistance(String distance) {
    return 'Sekitar $distance';
  }

  @override
  String get mapPreview => 'Pratinjau Peta';

  @override
  String get searchLocation => 'Cari lokasi';

  @override
  String redPacketSent(String amount, String token) {
    return 'Mengirim angpao $amount $token';
  }

  @override
  String get transferDefault => 'Transfer';

  @override
  String transferSent(String amount, String token) {
    return 'Mengirim transfer $amount $token';
  }

  @override
  String pickFileFailed(String error) {
    return 'Gagal memilih berkas: $error';
  }

  @override
  String get fileSizeLimit => 'Ukuran berkas tidak boleh melebihi 50MB';

  @override
  String fileSending(String filename) {
    return 'Mengirim berkas: $filename';
  }

  @override
  String sendFileFailed(String error) {
    return 'Gagal mengirim berkas: $error';
  }

  @override
  String contactCardSent(String name) {
    return 'Mengirim kartu kontak $name';
  }

  @override
  String get favoritesFeature => 'Favorit';

  @override
  String get couponsFeature => 'Kupon';

  @override
  String get giftFeature => 'Hadiah';

  @override
  String sharedMusic(String name) {
    return 'Membagikan $name';
  }

  @override
  String get endPollTitle => 'Akhiri Polling';

  @override
  String get endPollConfirmMessage =>
      'Apakah Anda yakin ingin mengakhiri polling ini? Pemungutan suara akan ditutup setelah diakhiri.';

  @override
  String get pollEndedMessage => 'Polling berakhir';

  @override
  String get connectingCall => 'Menghubungkan...';

  @override
  String get muteCall => 'Bisukan';

  @override
  String get speakerOff => 'Speaker Mati';

  @override
  String get speakerOn => 'Speaker';

  @override
  String get cameraOn => 'Kamera Nyala';

  @override
  String get cameraOff => 'Kamera Mati';

  @override
  String get hangUp => 'Tutup';

  @override
  String get selectForwardTargetTitle => 'Pilih Tujuan Terusan';

  @override
  String get noForwardableChat => 'Tidak ada chat yang dapat diteruskan';

  @override
  String get noMatchingChat => 'Tidak ada chat yang cocok ditemukan';

  @override
  String get imagePreview => '[Gambar]';

  @override
  String get voicePreview => '[Suara]';

  @override
  String get videoPreview => '[Video]';

  @override
  String filePreviewWithName(String filename) {
    return '[Berkas] $filename';
  }

  @override
  String locationPreviewWithAddress(String address) {
    return '[Lokasi] $address';
  }

  @override
  String musicPreviewWithTitle(String title) {
    return '[Musik] $title';
  }

  @override
  String get messagePreview => '[Pesan]';

  @override
  String get locationTitle => 'Lokasi';

  @override
  String get sendButton => 'Kirim';

  @override
  String get retryButton => 'Coba Lagi';

  @override
  String get selectContact => 'Pilih Kontak';

  @override
  String get searchContactHint => 'Cari kontak';

  @override
  String get shareMusic => 'Bagikan Musik';

  @override
  String get recentPlayed => 'Terbaru';

  @override
  String get myFavorites => 'Favorit';

  @override
  String get networkLink => 'Tautan';

  @override
  String get localFile => 'Lokal';

  @override
  String get musicLinkRequired => 'Tautan Musik *';

  @override
  String get pasteMusicLink => 'Tempel tautan musik';

  @override
  String get enterSongNamePlaceholder => 'Masukkan nama lagu';

  @override
  String get enterArtistNamePlaceholder => 'Masukkan nama artis';

  @override
  String get shareMusicButton => 'Bagikan Musik';

  @override
  String get selectLocalAudio => 'Pilih Berkas Audio Lokal';

  @override
  String get supportedAudioFormats => 'Mendukung MP3, M4A, WAV, FLAC, dll.';

  @override
  String get selectFileButton => 'Pilih Berkas';

  @override
  String get pleaseEnterMusicLink => 'Silakan masukkan tautan musik';

  @override
  String get pleaseEnterValidLink => 'Silakan masukkan URL yang valid';

  @override
  String get sharedSong => 'Lagu Dibagikan';

  @override
  String get selectMember => 'Pilih Anggota';

  @override
  String get searchMemberHint => 'Cari anggota';

  @override
  String get noMatchingMembers => 'Tidak ada anggota yang cocok ditemukan';

  @override
  String get unknownMember => 'Tidak Dikenal';

  @override
  String selectedMessagesCount(int count) {
    return 'Dipilih $count pesan';
  }

  @override
  String get searchContactsOrGroups => 'Cari kontak atau grup';

  @override
  String get noMatchingConversations =>
      'Tidak ada percakapan yang cocok ditemukan';

  @override
  String get videoTitle => 'Video';

  @override
  String get loadingText => 'Memuat...';

  @override
  String get videoPlaybackFailed => 'Pemutaran video gagal';

  @override
  String get videoLoadFailed => 'Gagal memuat video';

  @override
  String get playerInitFailed => 'Gagal menginisialisasi pemutar';

  @override
  String get createPollTitle => 'Buat Polling';

  @override
  String get submitPoll => 'Kirim';

  @override
  String get pollQuestionLabel => 'Pertanyaan Polling';

  @override
  String get enterPollQuestionHint => 'Masukkan pertanyaan polling';

  @override
  String get pollOptionsLabel => 'Opsi Polling';

  @override
  String optionHintWithIndex(int index) {
    return 'Opsi $index';
  }

  @override
  String get addOptionButton => 'Tambah Opsi';

  @override
  String get pollSettingsLabel => 'Pengaturan Polling';

  @override
  String get selectionType => 'Jenis Pilihan';

  @override
  String get singleChoiceLabel => 'Tunggal';

  @override
  String get multiChoiceLabel => 'Multi';

  @override
  String get anonymousPollSwitch => 'Polling Anonim';

  @override
  String get pleaseEnterQuestion => 'Silakan masukkan pertanyaan polling';

  @override
  String get atLeastTwoOptions => 'Minimal 2 opsi diperlukan';

  @override
  String confirmWithCount(int count) {
    return 'Konfirmasi ($count)';
  }

  @override
  String get emailVerificationTitle => 'Verifikasi Email';

  @override
  String get enterValidEmailAddress =>
      'Silakan masukkan alamat email yang valid';

  @override
  String verificationCodeSentTo(String email) {
    return 'Kode verifikasi dikirim ke $email';
  }

  @override
  String sendCodeFailed(String error) {
    return 'Gagal mengirim kode: $error';
  }

  @override
  String get verificationSuccess => 'Verifikasi berhasil';

  @override
  String get verificationFailed => 'Verifikasi gagal';

  @override
  String verificationCodeError(String error) {
    return 'Kesalahan kode verifikasi: $error';
  }

  @override
  String get enterVerificationCode => 'Masukkan kode verifikasi';

  @override
  String get enterYourEmail => 'Masukkan email';

  @override
  String weSentCodeTo(String email) {
    return 'Kami mengirim kode 6 digit ke\n$email';
  }

  @override
  String get enterEmailForCode =>
      'Masukkan alamat email Anda, kami akan mengirim kode verifikasi';

  @override
  String get sendVerificationCode => 'Kirim kode verifikasi';

  @override
  String get resendVerificationCode => 'Kirim ulang kode verifikasi';

  @override
  String canResendAfter(int seconds) {
    return 'Dapat mengirim ulang setelah $seconds detik';
  }

  @override
  String get changeEmail => 'Ubah email';

  @override
  String get addToContacts => 'Tambah ke Kontak';

  @override
  String get addingToContacts => 'Menambahkan...';

  @override
  String get addedToContacts => 'Ditambahkan ke kontak';

  @override
  String addFailedWithError(String error) {
    return 'Gagal menambahkan: $error';
  }

  @override
  String get addPhone => 'Tambah telepon';

  @override
  String get addTag => 'Tambah tag';

  @override
  String get addText => 'Tambah teks';

  @override
  String get addPhoto => 'Tambah foto';

  @override
  String groupCountLabel(int count) {
    return '$count grup';
  }

  @override
  String get addedViaSearch => 'Ditambahkan melalui pencarian';

  @override
  String get addTime => 'Tambah waktu';

  @override
  String get doneButton => 'Selesai';

  @override
  String get waitingForParticipants => 'Menunggu peserta bergabung...';

  @override
  String participantMe(String name) {
    return '$name (Saya)';
  }

  @override
  String get sharingLabel => 'Berbagi';

  @override
  String screenSharingBy(String name) {
    return '$name sedang berbagi layar';
  }

  @override
  String participantCount(int count) {
    return '$count peserta';
  }

  @override
  String get muteLabel => 'Bisukan';

  @override
  String get unmuteLabel => 'Bunyikan';

  @override
  String get turnOffVideo => 'Matikan video';

  @override
  String get turnOnVideo => 'Nyalakan video';

  @override
  String get shareScreen => 'Berbagi layar';

  @override
  String get stopSharing => 'Berhenti berbagi';

  @override
  String get switchCameraLabel => 'Ganti';

  @override
  String get leaveLabel => 'Keluar';

  @override
  String get participantsLabel => 'Peserta';

  @override
  String get joiningMeeting => 'Bergabung ke meeting...';

  @override
  String pollVotesFormat(int count, String percentage) {
    return '$count suara ($percentage%)';
  }

  @override
  String pollParticipantsFormat(int count) {
    return '$count peserta';
  }

  @override
  String get tapToRetry => 'Ketuk untuk mencoba lagi';

  @override
  String get noConversationsToForward =>
      'Tidak ada percakapan untuk diteruskan';

  @override
  String get defaultRedPacketGreeting => 'Semoga sukses dan sejahtera';

  @override
  String get emojiCategoryFace => 'Emotikon';

  @override
  String get emojiCategoryHeart => 'Hati';

  @override
  String get emojiCategoryAnimal => 'Hewan';

  @override
  String get emojiCategoryFood => 'Makanan';

  @override
  String get emojiCategoryTransport => 'Transportasi';

  @override
  String get emojiCategoryActivity => 'Aktivitas';

  @override
  String get emojiCategoryObject => 'Objek';

  @override
  String get emojiCategorySymbol => 'Simbol';

  @override
  String get allowOthersToSearchAndJoin =>
      'Izinkan orang lain untuk mencari dan bergabung';

  @override
  String get allowStrangerMessages => 'Izinkan pesan dari orang asing';

  @override
  String get alwaysUseDarkTheme => 'Selalu gunakan tema gelap';

  @override
  String get alwaysUseLightTheme => 'Selalu gunakan tema terang';

  @override
  String get autoSwitchBySystem => 'Beralih otomatis sesuai pengaturan sistem';

  @override
  String get bubbleStyle => 'Gaya gelembung';

  @override
  String get bubbleStyleClassic => 'Gaya klasik';

  @override
  String get bubbleStyleClassicDesc => 'Gaya gelembung tradisional';

  @override
  String get bubbleStyleModern => 'Gaya modern';

  @override
  String get bubbleStyleModernDesc => 'Gaya gelembung modern yang bersih';

  @override
  String get bubbleStyleWechat => 'Gaya WeChat';

  @override
  String get bubbleStyleWechatDesc => 'Gaya gelembung klasik WeChat';

  @override
  String get callEnded => 'Panggilan berakhir';

  @override
  String get callFailed => 'Panggilan gagal';

  @override
  String get checkForUpdates => 'Periksa pembaruan';

  @override
  String get confirmClearChatHistory =>
      'Apakah Anda yakin ingin menghapus riwayat chat?';

  @override
  String get createGroupToChat => 'Buat grup untuk mulai berbincang';

  @override
  String get darkMode => 'Mode gelap';

  @override
  String get darkModeOption => 'Mode gelap';

  @override
  String get doNotDisturbDescription =>
      'Tidak menerima notifikasi selama waktu yang ditentukan';

  @override
  String get doNotDisturbMode => 'Jangan ganggu';

  @override
  String get editGroupAnnouncement => 'Edit pengumuman grup';

  @override
  String get editGroupDescription => 'Edit deskripsi grup';

  @override
  String get enterGroupAnnouncement => 'Masukkan pengumuman grup';

  @override
  String errorWithMessage(String message) {
    return 'Kesalahan: $message';
  }

  @override
  String get feedbackAndSuggestions => 'Masukan dan saran';

  @override
  String get followSystem => 'Ikuti sistem';

  @override
  String get fontSize => 'Ukuran font';

  @override
  String get fontSizeExtraLarge => 'Sangat besar';

  @override
  String get fontSizeLarge => 'Besar';

  @override
  String get fontSizeSmall => 'Kecil';

  @override
  String get fontSizeStandard => 'Standar';

  @override
  String get incomingVideoCall => 'Panggilan video masuk';

  @override
  String get incomingVoiceCall => 'Panggilan suara masuk';

  @override
  String get letOthersKnowYouRead =>
      'Biarkan orang lain tahu Anda telah membaca pesan mereka';

  @override
  String get letOthersKnowYouTyping =>
      'Biarkan orang lain tahu Anda sedang mengetik';

  @override
  String get lightMode => 'Mode terang';

  @override
  String memberCountClickToCopy(int count) {
    return '$count anggota, klik untuk menyalin ID grup';
  }

  @override
  String get messageNotifications => 'Notifikasi pesan';

  @override
  String get messagesLabel => 'Pesan';

  @override
  String get musicLinkLabel => 'Link musik';

  @override
  String get noMediaUrlAvailable => 'URL media tidak tersedia';

  @override
  String get noPermissionToEditGroupName =>
      'Anda tidak memiliki izin untuk mengubah nama grup';

  @override
  String get receiveMessagesFromNonContacts => 'Terima pesan dari non-kontak';

  @override
  String get receiveNewMessageNotifications => 'Terima notifikasi pesan baru';

  @override
  String get reconnectingCall => 'Menghubungkan ulang...';

  @override
  String get redPacketTransferCannotForward =>
      'Angpao dan transfer tidak dapat diteruskan';

  @override
  String get showMessageContentInNotification =>
      'Tampilkan isi pesan di notifikasi';

  @override
  String get showMessagePreview => 'Tampilkan pratinjau pesan';

  @override
  String get typingIndicator => 'Indikator mengetik';

  @override
  String versionInfo(String version) {
    return 'Versi $version';
  }

  @override
  String get vibration => 'Getaran';

  @override
  String get videoCallInProgress => 'Panggilan video';

  @override
  String get voiceCallInProgress => 'Panggilan suara';

  @override
  String whoCanSeeTitle(String title) {
    return 'Siapa yang bisa melihat $title';
  }

  @override
  String get emailAddress => 'Alamat email';

  @override
  String get enterEmailAddress => 'Masukkan alamat email';

  @override
  String get emailRecoveryHint => 'Digunakan untuk pemulihan kata sandi';

  @override
  String get invalidEmailFormat => 'Masukkan alamat email yang valid';

  @override
  String get optional => 'Opsional';

  @override
  String get resetPassword => 'Reset kata sandi';

  @override
  String get resetPasswordTitle => 'Reset kata sandi Anda';

  @override
  String get enterRegisteredEmail =>
      'Masukkan alamat email yang Anda daftarkan';

  @override
  String get sendResetCode => 'Kirim kode reset';

  @override
  String resetCodeSent(String email) {
    return 'Kode reset dikirim ke $email';
  }

  @override
  String get enterResetCode => 'Masukkan kode reset';

  @override
  String get setNewPassword => 'Atur kata sandi baru';

  @override
  String get confirmNewPassword => 'Konfirmasi kata sandi baru';

  @override
  String get newPassword => 'Kata sandi baru';

  @override
  String get passwordResetSuccess =>
      'Kata sandi berhasil direset. Silakan masuk dengan kata sandi baru Anda.';

  @override
  String get resetPasswordFailed => 'Gagal mereset kata sandi';

  @override
  String get changePassword => 'Ubah kata sandi';

  @override
  String get currentPassword => 'Kata sandi saat ini';

  @override
  String get enterCurrentPassword => 'Masukkan kata sandi saat ini';

  @override
  String get enterNewPassword => 'Masukkan kata sandi baru';

  @override
  String get passwordChanged =>
      'Kata sandi berhasil diubah. Silakan masuk dengan kata sandi baru Anda.';

  @override
  String get changePasswordFailed => 'Gagal mengubah kata sandi';

  @override
  String get incorrectCurrentPassword => 'Kata sandi saat ini salah';

  @override
  String get newPasswordMustBeDifferent =>
      'Kata sandi baru harus berbeda dari kata sandi saat ini';

  @override
  String get changePasswordInfo =>
      'Setelah mengubah kata sandi, Anda akan keluar dan perlu masuk dengan kata sandi baru.';

  @override
  String get passwordRequirements => 'Persyaratan kata sandi:';

  @override
  String get securityNote =>
      'Untuk keamanan, Anda perlu masuk ulang di semua perangkat setelah mengubah kata sandi.';

  @override
  String get security => 'Keamanan';

  @override
  String get currentBoundEmail => 'Email yang terhubung saat ini';

  @override
  String get newEmailAddress => 'Alamat email baru';

  @override
  String get enterNewEmail => 'Masukkan alamat email baru';

  @override
  String get verificationCode => 'Kode verifikasi';

  @override
  String get verificationCodeSent => 'Kode verifikasi terkirim';

  @override
  String get codeSentTo => 'Kode verifikasi dikirim ke';

  @override
  String get didNotReceiveCode => 'Tidak menerima kode?';

  @override
  String get emailChangedSuccess => 'Email berhasil diubah';

  @override
  String get changeEmailFailed => 'Gagal mengubah email';

  @override
  String get emailSecurityNote =>
      'Email Anda digunakan untuk pemulihan kata sandi. Jaga keamanannya.';

  @override
  String get googleLogin => 'Masuk dengan Google';

  @override
  String get appleLogin => 'Masuk dengan Apple';

  @override
  String get facebookLogin => 'Masuk dengan Facebook';

  @override
  String get twitterLogin => 'Masuk dengan Twitter';

  @override
  String get wechatLogin => 'Masuk dengan WeChat';

  @override
  String get wechat => 'WeChat';

  @override
  String get facebook => 'Facebook';

  @override
  String get twitter => 'Twitter';

  @override
  String get wechatNotInstalled => 'Silakan instal WeChat terlebih dahulu';

  @override
  String get wechatLoginFailed => 'Login WeChat gagal';

  @override
  String get facebookLoginFailed => 'Login Facebook gagal';

  @override
  String get twitterLoginFailed => 'Login Twitter gagal';

  @override
  String get twitterNotConfigured => 'Login Twitter tidak dikonfigurasi';

  @override
  String get socialLoginCancelled => 'Login dibatalkan';

  @override
  String get socialLoginFailed => 'Login sosial gagal';

  @override
  String get language => 'Bahasa';

  @override
  String get languageChanged => 'Bahasa diubah';

  @override
  String get biometricLogin => '生物识别登录';

  @override
  String loginWithBiometric(Object type) {
    return '使用$type登录';
  }

  @override
  String get biometricLoginEnabled => '生物识别登录已启用';

  @override
  String get biometricLoginDisabled => '生物识别登录已禁用';

  @override
  String get enableBiometricLogin => '启用生物识别登录';

  @override
  String get disableBiometricLogin => '禁用生物识别登录';

  @override
  String get biometricNotAvailable => '此设备不支持生物识别';

  @override
  String get biometricNotEnrolled => '未录入生物识别数据，请在设备设置中设置';

  @override
  String get biometricAuthFailed => '生物识别验证失败';

  @override
  String get biometricAuthCancelled => '验证已取消';

  @override
  String get biometricLockedOut => '尝试次数过多，请稍后再试';

  @override
  String get useBiometricToLogin => '使用生物识别快速登录';

  @override
  String get authenticateToLogin => '验证身份以登录';

  @override
  String get authenticateToEnable => '验证身份以启用生物识别登录';

  @override
  String get faceId => '面容 ID';

  @override
  String get touchId => '触控 ID';

  @override
  String get fingerprint => '指纹';

  @override
  String get biometric => '生物识别';

  @override
  String get biometricEnabled => '已启用 - 使用生物识别登录';

  @override
  String get biometricDisabled => '已禁用 - 点击启用';

  @override
  String get biometricNeedRelogin => '请退出后重新登录以启用生物识别';

  @override
  String get or => '或';

  @override
  String get n42BeanTitle => 'N42 Bean';

  @override
  String get n42BeanDetails => 'Detail N42 Bean';

  @override
  String get noN42Bean => 'Tidak ada N42 Bean';

  @override
  String get n42BeanDescription =>
      'N42 Bean adalah token untuk menukarkan barang virtual dan layanan di N42. Saat ini tersedia untuk:';

  @override
  String get n42BeanFeature1 => 'Stiker dan tema eksklusif anggota';

  @override
  String get n42BeanFeature2 => 'Kustomisasi gelembung chat';

  @override
  String get n42BeanFeature3 => 'Kustomisasi sampul amplop merah';

  @override
  String get n42BeanFeature4 => 'Lencana nama panggilan eksklusif';

  @override
  String get n42BeanFeature5 => 'Hak istimewa chat grup';

  @override
  String get n42BeanFeature6 => 'Perluasan penyimpanan cloud';

  @override
  String get n42BeanFeature7 => 'Filter kecantikan panggilan video';

  @override
  String get n42BeanFeature8 => 'Kustomisasi latar belakang Moments';

  @override
  String get n42BeanFeature9 => 'Prioritas layanan pelanggan VIP';

  @override
  String get gotIt => 'Mengerti';

  @override
  String get noN42BeanRecords => 'Tidak ada catatan N42 Bean';

  @override
  String get cameraPermissionRestricted =>
      'Akses kamera dibatasi pada perangkat ini';
}
