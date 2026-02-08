// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class SId extends S {
  SId([String locale = 'id']) : super(locale);

  @override
  String get commonRetry => 'Coba Lagi';

  @override
  String get commonUnknownUser => 'Pengguna Tidak Dikenal';

  @override
  String get transferWalletNotConnected => 'Dompet tidak terhubung';

  @override
  String get chatCallServiceNotInitialized =>
      'Layanan panggilan belum diinisialisasi';

  @override
  String authLoginFailed(String error) {
    return 'Login gagal: $error';
  }

  @override
  String get chatCallBack => 'Panggil balik';

  @override
  String get chatMissedVideoCall => 'Panggilan video tidak terjawab';

  @override
  String get chatMissedVoiceCall => 'Panggilan suara tidak terjawab';

  @override
  String get chatCallNotAnswered => 'Tidak dijawab';

  @override
  String get chatCallDurationLabel => 'Durasi panggilan';

  @override
  String get chatVoiceCallCancelled => 'Panggilan suara dibatalkan';

  @override
  String get chatVideoCallCancelled => 'Panggilan video dibatalkan';

  @override
  String get commonImage => '[Gambar]';

  @override
  String get chatVideo => '[Video]';

  @override
  String get chatVoice => '[Suara]';

  @override
  String get commonFile => '[Berkas]';

  @override
  String get chatLocation => '[Lokasi]';

  @override
  String get chatUnknownMessage => '[Pesan tidak dikenal]';

  @override
  String get commonDelete => 'Hapus';

  @override
  String get chatDeleteThisMessage => 'Hapus pesan ini?';

  @override
  String get chatMessageDeleted => 'Pesan dihapus';

  @override
  String get profileNotLoggedIn => 'Belum masuk';

  @override
  String get chatMyLocation => 'Lokasi saya';

  @override
  String get commonGroupChat => 'Chat Grup';

  @override
  String get commonSearch => 'Cari';

  @override
  String get commonCancel => 'Batal';

  @override
  String get commonLoadFailed => 'Gagal memuat';

  @override
  String get commonMessages => 'Pesan';

  @override
  String get commonContacts => 'Kontak';

  @override
  String get commonMe => 'Saya';

  @override
  String get commonVoiceLoading =>
      'Suara sedang dimuat, silakan coba lagi nanti';

  @override
  String get commonVoiceToTextFailed => 'Gagal mengubah suara ke teks';

  @override
  String get commonConvertToText => 'Ke teks';

  @override
  String get chatCopy => 'Salin';

  @override
  String get commonForward => 'Teruskan';

  @override
  String get commonUnfavorite => 'Batal favorit';

  @override
  String get commonFavorite => 'Favorit';

  @override
  String get settingsResend => 'Kirim ulang';

  @override
  String get chatRecall => 'Tarik';

  @override
  String get commonQuote => 'Kutip';

  @override
  String get commonRemind => 'Ingatkan';

  @override
  String get chatCopied => 'Disalin';

  @override
  String get storySendMessageHint => 'Kirim pesan';

  @override
  String get commonMicrophonePermissionRequired =>
      'Silakan izinkan akses mikrofon';

  @override
  String get chatMicrophonePermissionDeniedPermanent =>
      '麦克风权限已被拒绝，请在系统设置中开启以使用语音消息功能。';

  @override
  String commonStartRecordingFailed(String error) {
    return 'Gagal memulai rekaman: $error';
  }

  @override
  String get commonRecordingTooShort => 'Rekaman terlalu pendek';

  @override
  String commonStopRecordingFailed(String error) {
    return 'Gagal menghentikan rekaman: $error';
  }

  @override
  String get chatReleaseToCancel => 'Lepas untuk membatalkan';

  @override
  String get chatReleaseToSend =>
      'Lepas untuk kirim, geser ke atas untuk batal';

  @override
  String get commonHoldToTalk => 'Tahan untuk bicara';

  @override
  String get commonSend => 'Kirim';

  @override
  String get commonAddFriend => 'Tambah Teman';

  @override
  String get commonChatServiceNotConnected => 'Layanan chat tidak terhubung';

  @override
  String contactUserNotFoundHint(String query) {
    return 'Pengguna \"$query\" tidak ditemukan\n\nTips:\n• Coba masukkan ID pengguna lengkap, contoh @username:server.com\n• Periksa ejaan nama pengguna';
  }

  @override
  String contactCreateChatFailed(String error) {
    return 'Gagal membuat chat: $error';
  }

  @override
  String contactSearchFailed(String error) {
    return 'Pencarian gagal: $error';
  }

  @override
  String get contactEnterUserIdOrUsername =>
      'Masukkan ID atau nama pengguna untuk mencari';

  @override
  String get contactSearching => 'Mencari...';

  @override
  String get contactSearchUserToChat => 'Cari pengguna untuk mulai mengobrol';

  @override
  String get contactMatrixIdExample =>
      'Anda dapat memasukkan Matrix ID lengkap\ncontoh @user:matrix.n42.network';

  @override
  String contactUserNotFound(String username) {
    return 'Pengguna \"$username\" tidak ditemukan';
  }

  @override
  String get commonChat => 'Chat';

  @override
  String get commonSettings => 'Pengaturan';

  @override
  String get profileEditProfile => 'Edit Profil';

  @override
  String get authLogin => 'Masuk';

  @override
  String get commonCreateGroup => 'Buat Grup';

  @override
  String get chatError => 'Kesalahan';

  @override
  String get commonTransfer => 'Transfer';

  @override
  String get commonReceived => 'Diterima';

  @override
  String get commonRefunded => 'Dikembalikan';

  @override
  String get commonExpired => 'Kedaluwarsa';

  @override
  String get chatRedPacketGreeting => 'Semoga sukses selalu';

  @override
  String get commonN42RedPacket => 'Angpao N42';

  @override
  String get commonClaimed => 'Diklaim';

  @override
  String get commonAllClaimed => 'Semua diklaim';

  @override
  String get chatReadAloud => '朗读';

  @override
  String get chatReply => 'Balas';

  @override
  String get commonEdit => 'Edit';

  @override
  String get chatSelectForwardTarget => 'Pilih penerima';

  @override
  String commonSendCount(int count) {
    return 'Kirim ($count)';
  }

  @override
  String contactN42Id(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get profileN42IdTitle => 'N42 ID';

  @override
  String get profileN42Bean => 'N42 Bean';

  @override
  String get contactFriendInfo => 'Info Teman';

  @override
  String get contactFriendInfoDesc =>
      'Tambahkan catatan teman, telepon, tag, catatan, foto dan atur izin.';

  @override
  String get commonMoments => 'Moments';

  @override
  String get commonSendMessage => 'Pesan';

  @override
  String get contactAudioVideoCall => 'Panggilan Audio/Video';

  @override
  String get contactVideoChannel => 'Saluran Video';

  @override
  String get contactRemark => 'Catatan';

  @override
  String get contactRemarkName => 'Nama Catatan';

  @override
  String get contactPhone => 'Telepon';

  @override
  String get contactTags => 'Tag';

  @override
  String get contactNotes => 'Catatan';

  @override
  String get contactPhotos => 'Foto';

  @override
  String get contactPermissions => 'Izin';

  @override
  String get contactChatMomentsEtc => 'Chat, Moments, Olahraga, dll.';

  @override
  String get contactMoreInfo => 'Info Lainnya';

  @override
  String get contactCommonGroups => 'Grup bersama';

  @override
  String get contactSource => 'Sumber';

  @override
  String get settingsNotificationSettings => 'Notifikasi';

  @override
  String get settingsPrivacy => 'Privasi';

  @override
  String get settingsAppearance => 'Tampilan';

  @override
  String get settingsAbout => 'Tentang';

  @override
  String get commonLogout => 'Keluar';

  @override
  String get commonLogoutConfirm => 'Apakah Anda yakin ingin keluar?';

  @override
  String get commonSave => 'Simpan';

  @override
  String get profileNickname => 'Nama Panggilan';

  @override
  String get profileEnterNickname => 'Masukkan nama panggilan';

  @override
  String get profileSignature => 'Tanda Tangan';

  @override
  String get profileAddSignature => 'Tambahkan tanda tangan';

  @override
  String get commonTakePhoto => 'Ambil Foto';

  @override
  String get profileChooseFromGallery => 'Pilih dari Galeri';

  @override
  String profileSaveFailed(String error) {
    return 'Gagal menyimpan: $error';
  }

  @override
  String get authSecureDecentralizedChat => 'Pesan aman dan terdesentralisasi';

  @override
  String get commonEndToEndEncryption => 'Enkripsi ujung ke ujung';

  @override
  String get authMessagesOnlyYouCanSee =>
      'Pesan hanya dapat dilihat oleh Anda dan penerima';

  @override
  String get authDecentralized => 'Terdesentralisasi';

  @override
  String get authBasedOnMatrix => 'Dibangun di atas protokol terbuka Matrix';

  @override
  String get authWalletIntegration => 'Integrasi Dompet';

  @override
  String get authEasyCryptoTransfer => 'Transfer kripto dengan mudah';

  @override
  String get authRegister => 'Daftar';

  @override
  String get authAgreeTerms => 'Dengan masuk, Anda menyetujui';

  @override
  String get authTermsOfService => 'Ketentuan Layanan';

  @override
  String get authAnd => 'dan';

  @override
  String get authPrivacyPolicy => 'Kebijakan Privasi';

  @override
  String get authServerAddress => 'Alamat Server';

  @override
  String get authEnterServerAddress => 'Masukkan alamat server';

  @override
  String authConnectedTo(String serverName) {
    return 'Terhubung ke $serverName';
  }

  @override
  String get authUsername => 'Nama Pengguna';

  @override
  String get authEnterUsername => 'Masukkan nama pengguna';

  @override
  String get authPassword => 'Kata Sandi';

  @override
  String get authEnterPassword => 'Masukkan kata sandi';

  @override
  String get authRegisterAccount => 'Daftar';

  @override
  String get authForgotPassword => 'Lupa Kata Sandi';

  @override
  String get authOtherLoginMethods => 'Metode login lainnya';

  @override
  String get authCreateAccount => 'Buat Akun';

  @override
  String get authJoinN42Chat =>
      'Bergabung dengan N42 Chat untuk mulai mengobrol';

  @override
  String get authUsernameHint => '3-20 karakter, huruf/angka/_';

  @override
  String get authUsernameMinLength => 'Nama pengguna minimal 3 karakter';

  @override
  String get authUsernameMaxLength => 'Nama pengguna maksimal 20 karakter';

  @override
  String get authUsernameFormat =>
      'Nama pengguna hanya boleh berisi huruf, angka, dan garis bawah';

  @override
  String get authPasswordHint => 'Minimal 8 karakter';

  @override
  String get commonPasswordMinLength => 'Kata sandi minimal 8 karakter';

  @override
  String get authConfirmPassword => 'Konfirmasi Kata Sandi';

  @override
  String get authFilled => 'Terisi';

  @override
  String get authEnterInviteCode => 'Masukkan kode undangan';

  @override
  String get authAlreadyHaveAccount => 'Sudah punya akun?';

  @override
  String get authLoginNow => 'Masuk sekarang';

  @override
  String get profileAvatar => 'Avatar';

  @override
  String get profileStatus => 'Status';

  @override
  String get commonLoading => 'Memuat...';

  @override
  String get conversationNoConversations => 'Tidak ada percakapan';

  @override
  String get conversationTapToChat => 'Ketuk kanan atas untuk mulai mengobrol';

  @override
  String get conversationStartGroup => 'Mulai Chat Grup';

  @override
  String get commonScan => 'Pindai';

  @override
  String get commonPayment => 'Pembayaran';

  @override
  String commonFeatureComingSoon(String feature) {
    return '$feature segera hadir';
  }

  @override
  String get conversationMarkAsRead => 'Tandai sudah dibaca';

  @override
  String get commonUnmute => 'Bunyikan';

  @override
  String get commonMute => 'Bisukan';

  @override
  String get conversationUnpin => 'Lepas pin';

  @override
  String get conversationPin => 'Pin';

  @override
  String get conversationDeleteConversation => 'Hapus Percakapan';

  @override
  String conversationDeleteConversationConfirm(String name) {
    return 'Hapus percakapan dengan \"$name\"?';
  }

  @override
  String get commonNoContacts => 'Tidak ada kontak';

  @override
  String get contactAddFriendsToChat => 'Tambah teman untuk mulai mengobrol';

  @override
  String get contactNotFound => 'Kontak tidak ditemukan';

  @override
  String get contactTryOtherKeywords =>
      'Coba kata kunci lain atau pencarian global';

  @override
  String get contactSearchResults => 'Hasil pencarian';

  @override
  String get contactNewFriends => 'Teman Baru';

  @override
  String get contactChatOnlyFriends => 'Chat-only Friends';

  @override
  String get contactOfficialAccounts => 'Akun Resmi';

  @override
  String get contactServiceAccounts => 'Akun Layanan';

  @override
  String get contactEnterpriseContacts => 'Kontak Perusahaan';

  @override
  String get contactRecommendToFriend => 'Bagikan kontak';

  @override
  String get commonSetRemark => 'Atur catatan';

  @override
  String get contactSendingCard => 'Mengirim kartu kontak...';

  @override
  String get commonFileLabel => 'Berkas';

  @override
  String get commonLocationLabel => 'Lokasi';

  @override
  String contactRecommendFailed(String error) {
    return 'Rekomendasi gagal: $error';
  }

  @override
  String get profileEnterRemark => 'Masukkan catatan';

  @override
  String get contactOpeningChat => 'Membuka chat...';

  @override
  String contactOpenChatFailed(String error) {
    return 'Gagal membuka chat: $error';
  }

  @override
  String get contactAddContact => 'Tambah Kontak';

  @override
  String get contactEnterUserId => 'Masukkan ID pengguna';

  @override
  String get contactNoFriendRequests => 'Tidak ada permintaan pertemanan';

  @override
  String get commonAccept => 'Terima';

  @override
  String get commonReject => 'Tolak';

  @override
  String get commonNoGroups => 'Tidak ada grup';

  @override
  String get contactSelectFriendToRecommend =>
      'Pilih teman untuk direkomendasikan';

  @override
  String get commonSearchContacts => 'Cari kontak';

  @override
  String get contactNoContactsFound => 'Tidak ada kontak ditemukan';

  @override
  String get favoriteYesterday => 'Kemarin';

  @override
  String get chatJustNow => 'Baru saja';

  @override
  String get profileOnline => 'Online';

  @override
  String get profileOffline => 'Offline';

  @override
  String get searchContactsGroupsMessages => 'Cari kontak, grup, pesan';

  @override
  String get searchError => 'Kesalahan pencarian';

  @override
  String get chatSearchHint => 'Cari kontak, grup, dan pesan';

  @override
  String get searchHistory => 'Riwayat Pencarian';

  @override
  String get commonClear => 'Hapus';

  @override
  String get commonAll => 'Semua';

  @override
  String get searchGroups => 'Grup';

  @override
  String get searchNoResults => 'Tidak ada hasil';

  @override
  String commonGroupMembers(int count) {
    return 'Anggota ($count)';
  }

  @override
  String get groupMembersTitle => 'Anggota Grup';

  @override
  String get groupViewAll => 'Lihat semua';

  @override
  String get groupOwner => 'Pemilik';

  @override
  String get groupAdmin => 'Admin';

  @override
  String get groupInvite => 'Undang';

  @override
  String get commonGroupAnnouncement => 'Pengumuman Grup';

  @override
  String get commonNotSet => 'Belum diatur';

  @override
  String get groupDescription => 'Deskripsi Grup';

  @override
  String get groupPublicGroup => 'Grup Publik';

  @override
  String get commonClearChatHistory => 'Hapus Riwayat Chat';

  @override
  String get commonDissolveGroup => 'Bubarkan Grup';

  @override
  String get commonLeaveGroup => 'Keluar Grup';

  @override
  String get groupChangeGroupName => 'Ubah Nama Grup';

  @override
  String get commonEnterGroupName => 'Masukkan nama grup';

  @override
  String get commonConfirm => 'Konfirmasi';

  @override
  String get groupEnterGroupDescription => 'Masukkan deskripsi grup';

  @override
  String get groupPublish => 'Publikasikan';

  @override
  String get chatClearHistoryConfirm =>
      'Hapus semua riwayat chat? Ini tidak dapat dibatalkan.';

  @override
  String get chatClearAction => 'Hapus';

  @override
  String get commonChatHistoryCleared => 'Riwayat chat dihapus';

  @override
  String get commonDissolve => 'Bubarkan';

  @override
  String get groupQrCode => 'Kode QR Grup';

  @override
  String get commonSearchChatHistory => 'Cari Riwayat Chat';

  @override
  String get groupIdCopied => 'ID Grup disalin';

  @override
  String get transferEnterOrPasteAddress =>
      'Masukkan atau tempel alamat dompet';

  @override
  String get transferSelectToken => 'Pilih Token';

  @override
  String get commonTransferAmount => 'Jumlah Transfer';

  @override
  String get transferAvailable => 'Tersedia';

  @override
  String get transferMemoOptional => 'Memo (opsional)';

  @override
  String get transferConfirmTransfer => 'Konfirmasi Transfer';

  @override
  String get transferAddressVerified => 'Alamat terverifikasi';

  @override
  String transferAvailableBalance(String balance, String symbol) {
    return 'Tersedia: $balance $symbol';
  }

  @override
  String get commonEnterAmount => 'Masukkan jumlah';

  @override
  String get commonRedPacketCountMin => 'Minimal 1 angpao diperlukan';

  @override
  String get commonViewRedPacketDetails => 'Lihat detail angpao';

  @override
  String get commonEnterTransferAmount => 'Masukkan jumlah transfer';

  @override
  String get commonTransferTo => 'Transfer ke';

  @override
  String commonFromSender(String name, Object senderName) {
    return 'Dari $senderName';
  }

  @override
  String get commonConfirmReceive => 'Konfirmasi Penerimaan';

  @override
  String get groupProfile => 'Info Grup';

  @override
  String get groupRemoveMember => 'Keluarkan dari Grup';

  @override
  String get commonRemove => 'Keluarkan';

  @override
  String get profileClearStatus => 'Hapus Status';

  @override
  String get profileClearStatusConfirm => 'Hapus status saat ini?';

  @override
  String get profileStatusCleared => 'Status dihapus';

  @override
  String get profileUserNotExist => 'Pengguna tidak ada';

  @override
  String get profileUserIdCopied => 'ID Pengguna disalin';

  @override
  String get commonReport => 'Laporkan';

  @override
  String get profileQrCode => 'Kode QR';

  @override
  String get profileAvatarUpdated => 'Avatar diperbarui';

  @override
  String commonSelectImageFailed(String error) {
    return 'Gagal memilih gambar: $error';
  }

  @override
  String get profileChangeName => 'Ubah Nama';

  @override
  String get profileMale => 'Pria';

  @override
  String get profileFemale => 'Wanita';

  @override
  String chatFeatureInDev(String feature) {
    return '$feature sedang dikembangkan...';
  }

  @override
  String profileSaveAddressFailed(String error) {
    return 'Gagal menyimpan alamat: $error';
  }

  @override
  String get profileAddNew => 'Tambah';

  @override
  String get profileAddAddress => 'Tambah Alamat';

  @override
  String get profileAddressAdded => 'Alamat ditambahkan';

  @override
  String get profileAddressUpdated => 'Alamat diperbarui';

  @override
  String get profileDeleteAddress => 'Hapus Alamat';

  @override
  String get profileAddressDeleted => 'Alamat dihapus';

  @override
  String profileSaveInvoiceFailed(String error) {
    return 'Gagal menyimpan faktur: $error';
  }

  @override
  String get profileMyInvoices => 'Faktur Saya';

  @override
  String get profileAddInvoice => 'Tambah Faktur';

  @override
  String get profileInvoiceAdded => 'Faktur ditambahkan';

  @override
  String get profileInvoiceUpdated => 'Faktur diperbarui';

  @override
  String get profileDeleteInvoice => 'Hapus Faktur';

  @override
  String get profileInvoiceDeleted => 'Faktur dihapus';

  @override
  String get profilePersonal => 'Pribadi';

  @override
  String get groupSelectAtLeastOne => 'Silakan pilih minimal satu anggota';

  @override
  String get chatFileNotExist => 'Berkas tidak ada';

  @override
  String chatSendFailed(String error) {
    return 'Gagal mengirim: $error';
  }

  @override
  String get chatCannotOpenBrowser => 'Tidak dapat membuka browser';

  @override
  String chatSelectFileFailed(String error) {
    return 'Gagal memilih berkas: $error';
  }

  @override
  String settingsSetupFailed(String error) {
    return 'Pengaturan gagal: $error';
  }

  @override
  String get transferEnterValidAmount => 'Silakan masukkan jumlah yang valid';

  @override
  String get commonAddressCopied => 'Alamat disalin';

  @override
  String favoriteOpenItem(String content) {
    return 'Buka: $content';
  }

  @override
  String get favoriteDeleted => 'Dihapus';

  @override
  String get profileWallet => 'Dompet';

  @override
  String get chatRecording => 'Merekam';

  @override
  String get chatInvalidVideoUrl => 'URL video tidak valid';

  @override
  String get chatDownloadFile => 'Unduh berkas';

  @override
  String get chatClearChatHistoryTitle => 'Hapus Riwayat Chat';

  @override
  String get chatVideoCall => 'Panggilan Video';

  @override
  String get commonVoiceCall => 'Panggilan Suara';

  @override
  String get callLeaveMeeting => 'Tinggalkan Meeting';

  @override
  String get chatDetails => 'Detail Chat';

  @override
  String get chatViewAllGroupMembers => 'Lihat semua anggota';

  @override
  String get chatGroupName => 'Nama Grup';

  @override
  String get chatGroupNameUpdated => 'Nama grup diperbarui';

  @override
  String get chatUpdateFailed => 'Pembaruan gagal';

  @override
  String get chatNoPermissionToModify =>
      'Anda tidak memiliki izin untuk mengubah';

  @override
  String get chatGroupManagement => 'Manajemen Grup';

  @override
  String get chatMyNicknameInGroup => 'Nama Panggilan Saya di Grup';

  @override
  String get chatPinChat => 'Pin Chat';

  @override
  String get chatStrongReminder => 'Pengingat Kuat';

  @override
  String get chatSetChatBackground => 'Atur Latar Belakang Chat';

  @override
  String get chatUnknownFile => 'Berkas tidak dikenal';

  @override
  String get chatDownload => 'Unduh';

  @override
  String get chatInvalidLocation => 'Lokasi tidak valid';

  @override
  String get chatTapToCancel => 'Ketuk untuk membatalkan';

  @override
  String chatCaptureFailed(Object error) {
    return 'Gagal mengambil gambar: $error';
  }

  @override
  String get chatProcessingVideo => 'Memproses video...';

  @override
  String get chatVideoFileNotExist => 'Berkas video tidak ada';

  @override
  String get chatVideoDataEmpty => 'Data video kosong';

  @override
  String get chatVideoTooLarge => 'Ukuran video tidak boleh melebihi 100MB';

  @override
  String get chatSendingVideo => 'Mengirim video...';

  @override
  String chatSendVideoFailed(Object error) {
    return 'Gagal mengirim video: $error';
  }

  @override
  String get chatImageFileNotExist => 'Berkas gambar tidak ada';

  @override
  String get commonImageDataEmpty => 'Data gambar kosong';

  @override
  String get chatSendingImage => 'Mengirim gambar...';

  @override
  String chatSendImageFailed(Object error) {
    return 'Gagal mengirim gambar: $error';
  }

  @override
  String get chatSendLocation => 'Kirim Lokasi';

  @override
  String get chatSelectLocationAndSend => 'Pilih lokasi dan kirim';

  @override
  String get chatShareRealTimeLocation => 'Bagikan Lokasi Real-time';

  @override
  String get chatShareLocationForOneHour =>
      'Bagikan lokasi real-time dengan teman selama 1 jam';

  @override
  String get chatLocationSent => 'Lokasi terkirim';

  @override
  String get chatSelectMessages => 'Pilih pesan';

  @override
  String chatSelectedCount(int count) {
    return 'Dipilih $count';
  }

  @override
  String get chatSelectAll => 'Pilih Semua';

  @override
  String chatGroupChatCount(int count) {
    return 'Chat Grup ($count)';
  }

  @override
  String get chatPrivateChat => 'Chat Pribadi';

  @override
  String get chatNoMessages => 'Tidak ada pesan';

  @override
  String get chatSendFirstMessage =>
      'Kirim pesan pertama untuk mulai mengobrol';

  @override
  String get chatEncryptionNotice =>
      'Chat ini dienkripsi ujung ke ujung. Hanya Anda dan penerima yang dapat membaca pesan.';

  @override
  String get chatMultiForward => 'Teruskan';

  @override
  String get chatCollect => 'Koleksi';

  @override
  String get chatNoMembers => 'Tidak ada anggota';

  @override
  String get chatMemberNotFound => 'Anggota tidak ditemukan';

  @override
  String get chatVoiceFileNotExist => 'Berkas suara tidak ada';

  @override
  String get chatVoiceFileEmpty => 'Berkas suara kosong';

  @override
  String get chatSendingVoice => 'Mengirim suara...';

  @override
  String chatSendVoiceFailed(Object error) {
    return 'Gagal mengirim suara: $error';
  }

  @override
  String get chatMessageForwarded => 'Pesan diteruskan';

  @override
  String chatForwardFailed(Object error) {
    return 'Gagal meneruskan: $error';
  }

  @override
  String get chatUnfavorited => 'Batal favorit';

  @override
  String get chatFavorited => 'Difavoritkan';

  @override
  String get chatReactionAdded => 'Reaksi ditambahkan';

  @override
  String get chatReactionRemoved => 'Reaksi dihapus';

  @override
  String get chatFailedMessageDeleted => 'Pesan gagal dihapus';

  @override
  String get chatDeleteMessages => 'Hapus pesan';

  @override
  String chatDeleteMessagesConfirm(Object count) {
    return 'Apakah Anda yakin ingin menghapus $count pesan?';
  }

  @override
  String chatNoteOtherMessages(Object count) {
    return 'Catatan: $count pesan dari orang lain dan hanya akan dihapus untuk Anda.';
  }

  @override
  String chatMyMessagesWillBeRecalled(Object count) {
    return '$count pesan dari Anda akan ditarik untuk semua.';
  }

  @override
  String chatRecalledCount(Object count, Object localCount) {
    return 'Menarik $count pesan, $localCount dihapus hanya untuk Anda';
  }

  @override
  String chatRecalledMessages(Object count) {
    return 'Menarik $count pesan';
  }

  @override
  String chatDeletedLocally(Object count) {
    return '$count pesan dihapus hanya untuk Anda';
  }

  @override
  String chatForwardedCount(Object count) {
    return 'Meneruskan $count pesan';
  }

  @override
  String chatForwardComplete(Object failed, Object success) {
    return 'Penerusan selesai: $success berhasil, $failed gagal';
  }

  @override
  String get chatRemindOnlyInGroup =>
      'Fitur pengingat hanya tersedia di chat grup';

  @override
  String get chatOnlyTextSearchable => 'Hanya pesan teks yang dapat dicari';

  @override
  String chatSearchFor(Object text) {
    return 'Cari \"$text\"';
  }

  @override
  String get chatBaiduSearch => 'Pencarian Baidu';

  @override
  String get chatGoogleSearch => 'Pencarian Google';

  @override
  String get chatBingSearch => 'Pencarian Bing';

  @override
  String get chatCalling => 'Memanggil...';

  @override
  String get chatRinging => 'Berdering...';

  @override
  String get chatInCall => 'Dalam panggilan';

  @override
  String commonFeatureInDevelopment(String feature) {
    return 'Fitur sedang dikembangkan...';
  }

  @override
  String chatCollectMessages(Object count) {
    return 'Mengoleksi $count pesan';
  }

  @override
  String commonMemberCount(int count) {
    return '$count anggota';
  }

  @override
  String groupDone(int count) {
    return 'Selesai($count)';
  }

  @override
  String get profileServices => 'Layanan';

  @override
  String get commonFavorites => 'Favorit';

  @override
  String get profileOrdersAndCards => 'Pesanan & Kartu';

  @override
  String get profileStickers => 'Stiker';

  @override
  String profileStatusSetTo(String status) {
    return 'Status diatur ke: $status';
  }

  @override
  String get profileAvatarUploadFailed => 'Gagal mengunggah avatar';

  @override
  String get profilePersonalProfile => 'Profil Pribadi';

  @override
  String get profileName => 'Nama';

  @override
  String get profileGender => 'Jenis Kelamin';

  @override
  String get profileRegion => 'Wilayah';

  @override
  String get commonMyQrCode => 'Kode QR Saya';

  @override
  String get profilePoke => 'Colek';

  @override
  String get profileRingtone => 'Nada Dering';

  @override
  String get profileDefaultRingtone => 'Nada Dering Default';

  @override
  String get profileMyAddresses => 'Alamat Saya';

  @override
  String profileGenderSetTo(String gender) {
    return 'Jenis kelamin diatur ke: $gender';
  }

  @override
  String get profileSelectRegion => 'Pilih Wilayah';

  @override
  String get profileSelectCity => 'Pilih Kota';

  @override
  String profileRegionSetTo(String region) {
    return 'Wilayah diatur ke: $region';
  }

  @override
  String get profileSetPoke => 'Atur Colek';

  @override
  String get profileFriendPokedMe => 'Teman mencolek saya';

  @override
  String get profileExample => 'Contoh';

  @override
  String get profileOnTheShoulder => ' di bahu';

  @override
  String get profilePokeCleared => 'Colek dihapus';

  @override
  String profilePokeSetTo(String suffix) {
    return 'Colek diatur ke: mencolek saya$suffix';
  }

  @override
  String get profileEditSignature => 'Edit Tanda Tangan';

  @override
  String get profileIntroduceYourself =>
      'Sebuah kalimat untuk memperkenalkan diri';

  @override
  String get profileSignatureCleared => 'Tanda tangan dihapus';

  @override
  String get profileSignatureUpdated => 'Tanda tangan diperbarui';

  @override
  String get profileScanToAddFriend =>
      'Pindai kode QR di atas untuk menambahkan saya sebagai teman';

  @override
  String profileRingtoneSetTo(String ringtone) {
    return 'Nada dering diatur ke: $ringtone';
  }

  @override
  String commonConfirmDissolveGroup(String name) {
    return 'Apakah Anda yakin ingin membubarkan \"$name\"? Tindakan ini tidak dapat dibatalkan.';
  }

  @override
  String get authEnterValidServerAddress =>
      'Silakan masukkan alamat server yang valid';

  @override
  String get authEmailOtp => 'OTP Email';

  @override
  String get authEnterServerAddressFirst =>
      'Silakan masukkan alamat server terlebih dahulu';

  @override
  String get authPasskeyRequiresServer =>
      'Login passkey memerlukan dukungan server';

  @override
  String get authLoginAgreement => 'Dengan masuk, Anda menyetujui ';

  @override
  String get authPleaseAgreeToTerms =>
      'Silakan baca dan setujui Ketentuan Layanan dan Kebijakan Privasi';

  @override
  String get authRegisterFailed => 'Pendaftaran gagal';

  @override
  String get commonReenterPassword => 'Masukkan ulang kata sandi';

  @override
  String get commonPasswordsDoNotMatch => 'Kata sandi tidak cocok';

  @override
  String get authInviteCodeBuiltIn => 'Kode Undangan (Bawaan)';

  @override
  String get authInviteCodeBuiltInNote =>
      'Kode undangan sudah bawaan, biasanya tidak perlu diubah';

  @override
  String get authIHaveReadAndAgree => 'Saya telah membaca dan menyetujui ';

  @override
  String get mainStartGroupChat => 'Mulai Chat Grup';

  @override
  String get mainAddFriends => 'Tambah Teman';

  @override
  String get mainPaymentAndCollection => 'Pembayaran';

  @override
  String contactCount(int count) {
    return '$count kontak';
  }

  @override
  String get contactAddToHomeScreen => 'Tambahkan ke layar utama';

  @override
  String contactRecommendedCardTo(String contact, String recipient) {
    return 'Merekomendasikan kartu $contact ke $recipient';
  }

  @override
  String get contactEnterRemarkName => 'Masukkan nama catatan';

  @override
  String contactRemarkSetTo(String remark) {
    return 'Catatan diatur ke: $remark';
  }

  @override
  String contactAcceptedFriendRequest(String name) {
    return 'Menerima permintaan pertemanan $name';
  }

  @override
  String contactRejectedFriendRequest(String name) {
    return 'Menolak permintaan pertemanan $name';
  }

  @override
  String get commonGroupInvites => 'Undangan Grup';

  @override
  String commonMyGroups(int count) {
    return 'Grup Saya ($count)';
  }

  @override
  String get commonInvitedToJoinGroup => 'Diundang untuk bergabung ke grup';

  @override
  String commonConfirmLeaveGroup(String name) {
    return 'Apakah Anda yakin ingin keluar dari \"$name\"?';
  }

  @override
  String get commonLeave => 'Keluar';

  @override
  String get commonRecallThisMessage => 'Tarik pesan ini?';

  @override
  String get commonSavedToGallery => 'Disimpan ke galeri';

  @override
  String get commonFailedToSave => 'Gagal menyimpan';

  @override
  String get chatSaving => 'Menyimpan...';

  @override
  String get commonShare => 'Bagikan';

  @override
  String get chatSaveToGallery => 'Simpan ke Galeri';

  @override
  String chatDownloadFailed(String code) {
    return 'Unduhan gagal: $code';
  }

  @override
  String commonShareFailed(String error) {
    return 'Gagal berbagi: $error';
  }

  @override
  String get chatFailedToLoadImage => 'Gagal memuat gambar';

  @override
  String get chatVideoRecordingFailed =>
      'Perekaman video gagal. Silakan coba lagi.';

  @override
  String get profileRedPacket => 'Angpao';

  @override
  String get commonMusic => 'Musik';

  @override
  String get commonCoupon => 'Kupon';

  @override
  String get commonGift => 'Hadiah';

  @override
  String get commonPoll => 'Polling';

  @override
  String get favoriteText => 'Teks';

  @override
  String get favoriteLinkLabel => 'Tautan';

  @override
  String get favoriteNote => 'Catatan';

  @override
  String get favoriteMyNotes => 'Catatan Saya';

  @override
  String get favoriteToday => 'Hari ini';

  @override
  String favoriteDaysAgoText(int count) {
    return '$count hari lalu';
  }

  @override
  String favoriteDateFormat(int month, int day) {
    return '$day/$month';
  }

  @override
  String get favoriteNoFavorites => 'Belum ada favorit';

  @override
  String get favoriteLongPressToFavorite =>
      'Tekan lama pesan untuk difavoritkan';

  @override
  String get favoriteNewNote => 'Catatan Baru';

  @override
  String get favoriteLink => 'Favoritkan Tautan';

  @override
  String get favoriteEditTags => 'Edit Tag';

  @override
  String get favoriteDeleteFavorite => 'Hapus Favorit';

  @override
  String get favoriteDeleteFavoriteConfirm =>
      'Apakah Anda yakin ingin menghapus favorit ini?';

  @override
  String get favoriteNoSearchResultsFound => 'Tidak ada hasil ditemukan';

  @override
  String get commonSendRedPacket => 'Kirim Angpao';

  @override
  String get transferAmount => 'Jumlah';

  @override
  String get commonRedPacketCover => 'Sampul Angpao';

  @override
  String get commonRedPacketType => 'Jenis Angpao';

  @override
  String get commonNormalRedPacket => 'Normal';

  @override
  String get commonLuckyRedPacket => 'Hoki';

  @override
  String get commonRedPacketCount => 'Jumlah Angpao';

  @override
  String get commonPieces => 'buah';

  @override
  String get commonPutMoneyInRedPacket => 'Masukkan uang ke angpao';

  @override
  String get commonRedPacketRefundNotice =>
      'Angpao yang tidak diklaim akan dikembalikan setelah 24 jam';

  @override
  String get commonOpenRedPacket => 'Buka';

  @override
  String get commonRedPacketAllClaimed => 'Angpao habis diklaim';

  @override
  String get commonRedPacketExpired => 'Angpao kedaluwarsa';

  @override
  String get commonAddTransferNote => 'Tambahkan catatan transfer';

  @override
  String get commonYuan => 'IDR';

  @override
  String get commonReplyWithEmoji => 'Balas dengan emoji ini';

  @override
  String get contactEditRemark => 'Edit Catatan';

  @override
  String get contactSetPermissions => 'Atur Izin';

  @override
  String get profileAddToBlacklist => 'Tambahkan ke Daftar Hitam';

  @override
  String get contactDeleteContact => 'Hapus Kontak';

  @override
  String contactDeleteContactConfirm(String name) {
    return 'Apakah Anda yakin ingin menghapus $name?';
  }

  @override
  String get transferTitle => 'Transfer';

  @override
  String get transferReceiverAddressLabel => 'Alamat Penerima';

  @override
  String get transferSelectTokenLabel => 'Pilih Token';

  @override
  String get transferAmountLabel => 'Jumlah Transfer';

  @override
  String get transferMemoLabel => 'Memo (opsional)';

  @override
  String get transferAddMemoHint => 'Tambahkan memo';

  @override
  String get transferSendPaymentRequest => 'Kirim Permintaan Pembayaran';

  @override
  String get transferQrCodeGenerateFailed => 'Gagal membuat kode QR';

  @override
  String get transferScanQrToPayMe => 'Pindai kode QR untuk membayar saya';

  @override
  String get transferMyWalletAddress => 'Alamat Dompet Saya';

  @override
  String get transferCreatePaymentRequest => 'Buat Permintaan Pembayaran';

  @override
  String profileN42IdLabel(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get commonRedPacketDefaultGreeting => 'Semoga sukses selalu';

  @override
  String commonSenderRedPacket(String name) {
    return 'Angpao $name';
  }

  @override
  String get transferEnterValidAddress => 'Silakan masukkan alamat yang valid';

  @override
  String get transferPleaseSelectToken => 'Silakan pilih token';

  @override
  String get commonReceivedTransfer => 'Transfer Diterima';

  @override
  String commonSenderSentRedPacket(String name) {
    return '$name mengirim angpao';
  }

  @override
  String get commonSavedToBalance =>
      'Disimpan ke saldo, dapat ditransfer langsung';

  @override
  String get commonRedPacketExpiredOrEmpty =>
      'Angpao kedaluwarsa/habis diklaim';

  @override
  String get transferScanFeatureComingSoon => 'Fitur pindai segera hadir...';

  @override
  String get contactSetAsStarred => 'Atur sebagai Berbintang';

  @override
  String get contactAddToBlocklist => 'Tambahkan ke Daftar Blokir';

  @override
  String get commonClaimedYour => ' mengklaim ';

  @override
  String get commonClaimedText => ' mengklaim ';

  @override
  String commonUserTyping(String name) {
    return '$name sedang mengetik...';
  }

  @override
  String get commonTyping => 'Mengetik...';

  @override
  String get commonWaitingToReceive => 'Menunggu untuk diterima';

  @override
  String get commonTapToClaim => 'Ketuk untuk klaim';

  @override
  String get commonHasBeenReceived => 'Sudah diterima';

  @override
  String get commonGetLucky => 'Semoga beruntung';

  @override
  String get qrcodeCameraStartFailed => 'Kamera gagal dimulai';

  @override
  String get qrcodeUnknownError => 'Kesalahan tidak dikenal';

  @override
  String get qrcodePlaceQrCodeInFrame =>
      'Letakkan kode QR dalam bingkai untuk memindai';

  @override
  String get qrcodeCloseManualInput => 'Tutup Input Manual';

  @override
  String get qrcodeManualInputUserId => 'Input Manual ID Pengguna';

  @override
  String get commonAdd => 'Tambah';

  @override
  String get profileSetStatus => 'Atur Status';

  @override
  String get profileVisibleToFriends24h => 'Terlihat oleh teman selama 24 jam';

  @override
  String get profileWriteStatus => 'Tulis Status';

  @override
  String get profileEnterYourStatus => 'Masukkan status Anda...';

  @override
  String get profileOk => 'OK';

  @override
  String get qrcodeCameraPermissionRequired =>
      'Izin kamera diperlukan untuk memindai kode QR';

  @override
  String get qrcodeCameraPermissionDenied =>
      'Izin kamera ditolak secara permanen. Silakan aktifkan di pengaturan sistem.';

  @override
  String qrcodePermissionCheckError(String error) {
    return 'Kesalahan memeriksa izin: $error';
  }

  @override
  String get qrcodeInvalidQrCode => 'Kode QR tidak valid';

  @override
  String qrcodeCannotAddFriend(String error) {
    return 'Tidak dapat menambah teman: $error';
  }

  @override
  String get qrcodeScanQrCode => 'Pindai Kode QR';

  @override
  String get qrcodeCheckingCameraPermission => 'Memeriksa izin kamera...';

  @override
  String get qrcodeNeedCameraPermission => 'Izin Kamera Diperlukan';

  @override
  String get qrcodeRetryPermission => 'Coba Lagi';

  @override
  String get qrcodeOpenSettings => 'Buka Pengaturan';

  @override
  String get groupInviteMembers => 'Undang Anggota';

  @override
  String groupInviteCount(int count) {
    return 'Undang($count)';
  }

  @override
  String get profileNoShippingAddress => 'Tidak ada alamat pengiriman';

  @override
  String get profileDefaultLabel => 'Default';

  @override
  String get profileNoInvoice => 'Tidak ada faktur';

  @override
  String get profileCompany => 'Perusahaan';

  @override
  String get profileTaxNumber => 'Nomor Pajak';

  @override
  String get profileConfirmDeleteAddress =>
      'Apakah Anda yakin ingin menghapus alamat ini?';

  @override
  String get profileConfirmDeleteInvoice =>
      'Apakah Anda yakin ingin menghapus faktur ini?';

  @override
  String get commonGroupOwner => 'Pemilik';

  @override
  String get commonGroupAdmin => 'Admin';

  @override
  String get groupSearchMembers => 'Cari anggota';

  @override
  String groupTotalMembers(int count) {
    return '$count anggota';
  }

  @override
  String get chatRemoveFromGroup => 'Keluarkan dari Grup';

  @override
  String groupConfirmRemoveMember(String name) {
    return 'Apakah Anda yakin ingin mengeluarkan \"$name\" dari grup?';
  }

  @override
  String get chatUnknownSong => 'Lagu Tidak Dikenal';

  @override
  String get chatUnknownArtist => 'Artis Tidak Dikenal';

  @override
  String get chatUnknownContact => 'Kontak Tidak Dikenal';

  @override
  String get chatPersonalCard => 'Kartu Kontak';

  @override
  String get chatSingleChoice => 'Tunggal';

  @override
  String get chatMultiChoice => 'Multi';

  @override
  String get chatEnded => 'Berakhir';

  @override
  String get chatEndPollButton => 'Akhiri Polling';

  @override
  String get chatPollHint =>
      'Polling akan ditampilkan di chat. Anggota grup dapat memilih.';

  @override
  String get chatSearchSongOrArtist => 'Cari lagu atau artis';

  @override
  String get chatNoSongsFound => 'Tidak ada lagu ditemukan';

  @override
  String get chatSongNameOptional => 'Nama Lagu (Opsional)';

  @override
  String get chatEnterSongName => 'Masukkan nama lagu';

  @override
  String get chatArtistNameOptional => 'Nama Artis (Opsional)';

  @override
  String get chatEnterArtistName => 'Masukkan nama artis';

  @override
  String get chatRealTimeLocationSharing =>
      'Berbagi lokasi real-time sedang dikembangkan...';

  @override
  String get profileVoiceCallFeatureInDev =>
      'Fitur panggilan suara sedang dikembangkan...';

  @override
  String get profileReportFeatureInDev =>
      'Fitur laporan sedang dikembangkan...';

  @override
  String get profileShareFeatureInDev => 'Fitur bagikan sedang dikembangkan...';

  @override
  String get profileQrCodeFeatureInDev =>
      'Fitur kode QR sedang dikembangkan...';

  @override
  String get qrcodeScanQrToAddMe =>
      'Pindai kode QR di atas untuk menambahkan saya sebagai teman';

  @override
  String get qrcodeSaveToAlbum => 'Simpan ke Album';

  @override
  String get qrcodeChangeStyle => 'Ubah Gaya';

  @override
  String get qrcodeCopyId => 'Salin ID';

  @override
  String get qrcodeIdCopied => 'ID disalin';

  @override
  String get qrcodeMoreStylesFeatureComingSoon =>
      'Lebih banyak gaya segera hadir';

  @override
  String get profileBio => 'Bio';

  @override
  String get profileHomeServer => 'Server';

  @override
  String get profileShareContactCard => 'Bagikan Kartu Kontak';

  @override
  String get profileRemoveFromBlacklist => 'Hapus dari Daftar Hitam';

  @override
  String get profileConfirmAddBlacklist =>
      'Apakah Anda yakin ingin menambahkan pengguna ini ke daftar hitam? Anda tidak akan menerima pesan dari mereka.';

  @override
  String get profileConfirmRemoveBlacklist =>
      'Apakah Anda yakin ingin menghapus pengguna ini dari daftar hitam?';

  @override
  String get profileRemarkSaved => 'Catatan disimpan';

  @override
  String get profileRemarkCleared => 'Catatan dihapus';

  @override
  String get transferReceive => 'Terima';

  @override
  String get transferPleaseConnectWallet =>
      'Silakan hubungkan dompet Anda terlebih dahulu';

  @override
  String get transferSendRequest => 'Kirim Permintaan';

  @override
  String get transferPleaseEnterValidAmount =>
      'Silakan masukkan jumlah yang valid';

  @override
  String get searchPlaceholder => 'Cari kontak, grup, pesan';

  @override
  String get searchEnterKeywordToSearch =>
      'Masukkan kata kunci untuk mulai mencari';

  @override
  String get searchClearHistory => 'Hapus';

  @override
  String searchNoResultsForQuery(String query) {
    return 'Tidak ada hasil ditemukan untuk \"$query\"';
  }

  @override
  String get searchAllResults => 'Semua';

  @override
  String get searchInChat => 'Cari di chat';

  @override
  String get searchContactLabel => 'Kontak';

  @override
  String get searchGroupLabel => 'Grup';

  @override
  String get searchConversationLabel => 'Percakapan';

  @override
  String get searchMessageLabel => 'Pesan';

  @override
  String get settingsSecurityTitle => 'Keamanan';

  @override
  String get settingsKeyBackup => 'Cadangan Kunci';

  @override
  String get settingsBackupEncryptionKeys => 'Cadangkan Kunci Enkripsi';

  @override
  String settingsKeysBackedUp(int count) {
    return '$count kunci dicadangkan';
  }

  @override
  String get settingsBackupNotSet => 'Cadangan belum diatur';

  @override
  String get settingsRestoreKeys => 'Pulihkan Kunci';

  @override
  String get settingsRestoreKeysFromBackup =>
      'Pulihkan kunci enkripsi dari cadangan';

  @override
  String get settingsExportKeys => 'Ekspor Kunci';

  @override
  String get settingsExportKeysToFile => 'Ekspor kunci ke berkas';

  @override
  String get settingsLoggedInDevices => 'Perangkat yang Masuk';

  @override
  String get settingsNoOtherDevices => 'Tidak ada perangkat lain';

  @override
  String get settingsVerified => 'Terverifikasi';

  @override
  String get settingsUnverified => 'Belum terverifikasi';

  @override
  String get settingsAdvanced => 'Lanjutan';

  @override
  String get settingsCrossSigning => 'Cross-Signing';

  @override
  String get settingsEnabled => 'Diaktifkan';

  @override
  String get settingsNotEnabled => 'Tidak diaktifkan';

  @override
  String get settingsResetEncryption => 'Reset Enkripsi';

  @override
  String get settingsDeleteAllEncryptionKeys => 'Hapus semua kunci enkripsi';

  @override
  String get settingsEncryptionNotSupported => 'Enkripsi tidak didukung';

  @override
  String get settingsNotInitialized => 'Belum diinisialisasi';

  @override
  String get settingsBackupKeyTitle => 'Cadangkan Kunci';

  @override
  String get settingsBackupKeyMessage =>
      'Buat cadangan kunci baru? Ini akan membantu Anda memulihkan pesan terenkripsi di perangkat baru.';

  @override
  String get settingsBackup => 'Cadangkan';

  @override
  String get settingsRestoreKeyTitle => 'Pulihkan Kunci';

  @override
  String get settingsRestoreKeyMessage =>
      'Masukkan kata sandi pemulihan atau kunci pemulihan untuk memulihkan pesan terenkripsi.';

  @override
  String get settingsRestore => 'Pulihkan';

  @override
  String get settingsExportKeyTitle => 'Ekspor Kunci';

  @override
  String get settingsExportKeyMessage =>
      'Berkas kunci yang diekspor berisi semua kunci enkripsi Anda. Harap simpan dengan aman.';

  @override
  String get settingsExport => 'Ekspor';

  @override
  String settingsDeviceIdLabel(String deviceId) {
    return 'ID Perangkat: $deviceId';
  }

  @override
  String get settingsDeviceStatusVerified => 'Status: Terverifikasi';

  @override
  String get settingsDeviceStatusUnverified => 'Status: Belum terverifikasi';

  @override
  String settingsLastActiveLabel(String lastSeen) {
    return 'Terakhir aktif: $lastSeen';
  }

  @override
  String get settingsVerifyThisDevice => 'Verifikasi perangkat ini';

  @override
  String get settingsCrossSigningAlreadyEnabled =>
      'Cross-signing sudah diaktifkan';

  @override
  String get settingsCrossSigningSetupSuccess =>
      'Pengaturan cross-signing berhasil';

  @override
  String get settingsResetEncryptionTitle => 'Reset Enkripsi';

  @override
  String get settingsResetEncryptionWarning =>
      'Peringatan: Ini akan menghapus semua kunci enkripsi Anda. Anda tidak akan dapat mendekripsi pesan terenkripsi sebelumnya. Tindakan ini tidak dapat dibatalkan.';

  @override
  String get settingsReset => 'Reset';

  @override
  String get settingsBackupSuccess => '密钥备份成功';

  @override
  String get settingsBackupFailed => '备份失败';

  @override
  String get settingsRecoveryKey => '恢复密钥';

  @override
  String get settingsRecoveryKeySaveWarning =>
      '请将此恢复密钥保存在安全的地方。您需要它在新设备上恢复加密消息。';

  @override
  String get settingsRecoveryKeySaved => '我已保存';

  @override
  String get settingsRestoreSuccess => '密钥恢复成功';

  @override
  String get settingsRestoreFailed => '恢复失败';

  @override
  String get settingsPassword => '密码';

  @override
  String get settingsEnterRecoveryKey => '输入恢复密钥';

  @override
  String get settingsEnterPassword => '输入密码';

  @override
  String get settingsExportSuccess => '密钥已成功导出到服务端备份';

  @override
  String get settingsExportNeedBackupFirst => '请先创建密钥备份';

  @override
  String get settingsExportFailed => '导出失败';

  @override
  String get settingsResetSuccess => '加密重置成功';

  @override
  String get settingsResetFailed => '重置失败';

  @override
  String get callLeaveMeetingConfirm =>
      'Apakah Anda yakin ingin meninggalkan meeting?';

  @override
  String chatPokedSomeone(String name, String suffix) {
    return 'mencolek $name$suffix';
  }

  @override
  String get chatNoContactsToAdd => 'Tidak ada kontak yang dapat ditambahkan';

  @override
  String get chatAddMembers => 'Tambah Anggota';

  @override
  String chatInvitedMembers(int count) {
    return 'Mengundang $count anggota';
  }

  @override
  String chatInviteFailed(String error) {
    return 'Undangan gagal: $error';
  }

  @override
  String get chatMemberRemoved => 'Anggota dikeluarkan';

  @override
  String chatRemoveFailed(String error) {
    return 'Gagal mengeluarkan: $error';
  }

  @override
  String get chatRealTimeLocationShareMessage =>
      'Setelah berbagi, pihak lain dapat melihat lokasi real-time Anda selama 1 jam.';

  @override
  String get chatStartSharing => 'Mulai Berbagi';

  @override
  String get chatLocationServiceNotEnabled => 'Layanan lokasi tidak diaktifkan';

  @override
  String get chatEnableLocationService =>
      'Silakan aktifkan layanan lokasi untuk menggunakan fitur ini';

  @override
  String get chatGoToSettings => 'Buka Pengaturan';

  @override
  String get chatLocationPermissionRequired =>
      'Izin lokasi diperlukan untuk fitur ini';

  @override
  String get chatLocationPermissionDeniedPermanent =>
      'Izin lokasi telah ditolak secara permanen. Silakan aktifkan di pengaturan.';

  @override
  String get chatLocationPermissionDenied => 'Izin lokasi ditolak';

  @override
  String get chatGettingLocation => 'Mendapatkan lokasi...';

  @override
  String chatGetLocationFailed(String error) {
    return 'Gagal mendapatkan lokasi: $error';
  }

  @override
  String get chatMapPreview => 'Pratinjau Peta';

  @override
  String get chatSearchLocation => 'Cari lokasi';

  @override
  String chatRedPacketSent(String amount, String token) {
    return 'Mengirim angpao $amount $token';
  }

  @override
  String get chatTransferDefault => 'Transfer';

  @override
  String chatTransferSent(String amount, String token) {
    return 'Mengirim transfer $amount $token';
  }

  @override
  String chatPickFileFailed(String error) {
    return 'Gagal memilih berkas: $error';
  }

  @override
  String get chatFileSizeLimit => 'Ukuran berkas tidak boleh melebihi 50MB';

  @override
  String chatFileSending(String filename) {
    return 'Mengirim berkas: $filename';
  }

  @override
  String chatSendFileFailed(String error) {
    return 'Gagal mengirim berkas: $error';
  }

  @override
  String chatContactCardSent(String name) {
    return 'Mengirim kartu kontak $name';
  }

  @override
  String get chatFavoritesFeature => 'Favorit';

  @override
  String get chatCouponsFeature => 'Kupon';

  @override
  String get chatGiftFeature => 'Hadiah';

  @override
  String chatSharedMusic(String name) {
    return 'Membagikan $name';
  }

  @override
  String get chatEndPollTitle => 'Akhiri Polling';

  @override
  String get chatEndPollConfirmMessage =>
      'Apakah Anda yakin ingin mengakhiri polling ini? Pemungutan suara akan ditutup setelah diakhiri.';

  @override
  String get chatPollEndedMessage => 'Polling berakhir';

  @override
  String get chatConnectingCall => 'Menghubungkan...';

  @override
  String get chatMuteCall => 'Bisukan';

  @override
  String get chatSpeakerOff => 'Speaker Mati';

  @override
  String get chatSpeakerOn => 'Speaker';

  @override
  String get chatCameraOn => 'Kamera Nyala';

  @override
  String get chatCameraOff => 'Kamera Mati';

  @override
  String get chatHangUp => 'Tutup';

  @override
  String get chatSelectForwardTargetTitle => 'Pilih Tujuan Terusan';

  @override
  String get chatNoForwardableChat => 'Tidak ada chat yang dapat diteruskan';

  @override
  String get chatNoMatchingChat => 'Tidak ada chat yang cocok ditemukan';

  @override
  String get chatLocationTitle => 'Lokasi';

  @override
  String get chatSendButton => 'Kirim';

  @override
  String get chatRetryButton => 'Coba Lagi';

  @override
  String get chatSearchContactHint => 'Cari kontak';

  @override
  String get chatShareMusic => 'Bagikan Musik';

  @override
  String get chatRecentPlayed => 'Terbaru';

  @override
  String get chatMyFavorites => 'Favorit';

  @override
  String get chatNetworkLink => 'Tautan';

  @override
  String get chatLocalFile => 'Lokal';

  @override
  String get chatPasteMusicLink => 'Tempel tautan musik';

  @override
  String get chatShareMusicButton => 'Bagikan Musik';

  @override
  String get chatSelectLocalAudio => 'Pilih Berkas Audio Lokal';

  @override
  String get chatSupportedAudioFormats => 'Mendukung MP3, M4A, WAV, FLAC, dll.';

  @override
  String get chatSelectFileButton => 'Pilih Berkas';

  @override
  String get chatPleaseEnterMusicLink => 'Silakan masukkan tautan musik';

  @override
  String get chatPleaseEnterValidLink => 'Silakan masukkan URL yang valid';

  @override
  String get chatSharedSong => 'Lagu Dibagikan';

  @override
  String get chatSelectMember => 'Pilih Anggota';

  @override
  String get chatSearchMemberHint => 'Cari anggota';

  @override
  String get chatNoMatchingMembers => 'Tidak ada anggota yang cocok ditemukan';

  @override
  String get commonUnknownMember => 'Tidak Dikenal';

  @override
  String chatSelectedMessagesCount(int count) {
    return 'Dipilih $count pesan';
  }

  @override
  String get chatSearchContactsOrGroups => 'Cari kontak atau grup';

  @override
  String get chatVideoTitle => 'Video';

  @override
  String get chatLoadingText => 'Memuat...';

  @override
  String get chatVideoLoadFailed => 'Gagal memuat video';

  @override
  String get chatPlayerInitFailed => 'Gagal menginisialisasi pemutar';

  @override
  String get chatCreatePollTitle => 'Buat Polling';

  @override
  String get chatSubmitPoll => 'Kirim';

  @override
  String get chatPollQuestionLabel => 'Pertanyaan Polling';

  @override
  String get chatEnterPollQuestionHint => 'Masukkan pertanyaan polling';

  @override
  String get chatPollOptionsLabel => 'Opsi Polling';

  @override
  String chatOptionHintWithIndex(int index) {
    return 'Opsi $index';
  }

  @override
  String get chatAddOptionButton => 'Tambah Opsi';

  @override
  String get chatPollSettingsLabel => 'Pengaturan Polling';

  @override
  String get chatSelectionType => 'Jenis Pilihan';

  @override
  String get chatSingleChoiceLabel => 'Tunggal';

  @override
  String get chatMultiChoiceLabel => 'Multi';

  @override
  String get chatAnonymousPollSwitch => 'Polling Anonim';

  @override
  String get chatPleaseEnterQuestion => 'Silakan masukkan pertanyaan polling';

  @override
  String get chatAtLeastTwoOptions => 'Minimal 2 opsi diperlukan';

  @override
  String chatConfirmWithCount(int count) {
    return 'Konfirmasi ($count)';
  }

  @override
  String get authEmailVerificationTitle => 'Verifikasi Email';

  @override
  String get authEnterValidEmailAddress =>
      'Silakan masukkan alamat email yang valid';

  @override
  String authVerificationCodeSentTo(String email) {
    return 'Kode verifikasi dikirim ke $email';
  }

  @override
  String authSendCodeFailed(String error) {
    return 'Gagal mengirim kode: $error';
  }

  @override
  String get authVerificationSuccess => 'Verifikasi berhasil';

  @override
  String get authVerificationFailed => 'Verifikasi gagal';

  @override
  String authVerificationCodeError(String error) {
    return 'Kesalahan kode verifikasi: $error';
  }

  @override
  String get commonEnterVerificationCode => 'Masukkan kode verifikasi';

  @override
  String get authEnterYourEmail => 'Masukkan email';

  @override
  String authWeSentCodeTo(String email) {
    return 'Kami mengirim kode 6 digit ke\n$email';
  }

  @override
  String get authEnterEmailForCode =>
      'Masukkan alamat email Anda, kami akan mengirim kode verifikasi';

  @override
  String get commonSendVerificationCode => 'Kirim kode verifikasi';

  @override
  String get authResendVerificationCode => 'Kirim ulang kode verifikasi';

  @override
  String authCanResendAfter(int seconds) {
    return 'Dapat mengirim ulang setelah $seconds detik';
  }

  @override
  String get commonChangeEmail => 'Ubah email';

  @override
  String get contactAddToContacts => 'Tambah ke Kontak';

  @override
  String get contactAddingToContacts => 'Menambahkan...';

  @override
  String get contactAddedToContacts => 'Ditambahkan ke kontak';

  @override
  String contactAddFailedWithError(String error) {
    return 'Gagal menambahkan: $error';
  }

  @override
  String get contactAddPhone => 'Tambah telepon';

  @override
  String get contactAddTag => 'Tambah tag';

  @override
  String get contactAddText => 'Tambah teks';

  @override
  String get contactAddPhoto => 'Tambah foto';

  @override
  String contactGroupCountLabel(int count) {
    return '$count grup';
  }

  @override
  String get contactAddedViaSearch => 'Ditambahkan melalui pencarian';

  @override
  String get contactAddTime => 'Tambah waktu';

  @override
  String get contactDoneButton => 'Selesai';

  @override
  String get callWaitingForParticipants => 'Menunggu peserta bergabung...';

  @override
  String callParticipantMe(String name) {
    return '$name (Saya)';
  }

  @override
  String get callSharingLabel => 'Berbagi';

  @override
  String callScreenSharingBy(String name) {
    return '$name sedang berbagi layar';
  }

  @override
  String callParticipantCount(int count) {
    return '$count peserta';
  }

  @override
  String get callMuteLabel => 'Bisukan';

  @override
  String get callUnmuteLabel => 'Bunyikan';

  @override
  String get callTurnOffVideo => 'Matikan video';

  @override
  String get callTurnOnVideo => 'Nyalakan video';

  @override
  String get callShareScreen => 'Berbagi layar';

  @override
  String get callStopSharing => 'Berhenti berbagi';

  @override
  String get callSwitchCameraLabel => 'Ganti';

  @override
  String get callLeaveLabel => 'Keluar';

  @override
  String get callParticipantsLabel => 'Peserta';

  @override
  String get callJoiningMeeting => 'Bergabung ke meeting...';

  @override
  String chatPollVotesFormat(int count, String percentage) {
    return '$count suara ($percentage%)';
  }

  @override
  String chatPollParticipantsFormat(int count) {
    return '$count peserta';
  }

  @override
  String get commonTapToRetry => 'Ketuk untuk mencoba lagi';

  @override
  String get chatDefaultRedPacketGreeting => 'Semoga sukses dan sejahtera';

  @override
  String get groupAllowOthersToSearchAndJoin =>
      'Izinkan orang lain untuk mencari dan bergabung';

  @override
  String get groupConfirmClearChatHistory =>
      'Apakah Anda yakin ingin menghapus riwayat chat?';

  @override
  String get groupCreateGroupToChat => 'Buat grup untuk mulai berbincang';

  @override
  String get groupEditGroupAnnouncement => 'Edit pengumuman grup';

  @override
  String get groupEditGroupDescription => 'Edit deskripsi grup';

  @override
  String get groupEnterGroupAnnouncement => 'Masukkan pengumuman grup';

  @override
  String chatErrorWithMessage(String message) {
    return 'Kesalahan: $message';
  }

  @override
  String groupMemberCountClickToCopy(int count) {
    return '$count anggota, klik untuk menyalin ID grup';
  }

  @override
  String get chatMusicLinkLabel => 'Link musik';

  @override
  String get chatNoMediaUrlAvailable => 'URL media tidak tersedia';

  @override
  String get groupNoPermissionToEditGroupName =>
      'Anda tidak memiliki izin untuk mengubah nama grup';

  @override
  String get chatRedPacketTransferCannotForward =>
      'Angpao dan transfer tidak dapat diteruskan';

  @override
  String get authEmailAddress => 'Alamat email';

  @override
  String get commonEnterEmailAddress => 'Masukkan alamat email';

  @override
  String get authEmailRecoveryHint => 'Digunakan untuk pemulihan kata sandi';

  @override
  String get commonInvalidEmailFormat => 'Masukkan alamat email yang valid';

  @override
  String get authOptional => 'Opsional';

  @override
  String get authResetPassword => 'Reset kata sandi';

  @override
  String get authEnterRegisteredEmail =>
      'Masukkan alamat email yang Anda daftarkan';

  @override
  String get authSendResetCode => 'Kirim kode reset';

  @override
  String authResetCodeSent(String email) {
    return 'Kode reset dikirim ke $email';
  }

  @override
  String get authEnterResetCode => 'Masukkan kode reset';

  @override
  String get authSetNewPassword => 'Atur kata sandi baru';

  @override
  String get commonConfirmNewPassword => 'Konfirmasi kata sandi baru';

  @override
  String get commonNewPassword => 'Kata sandi baru';

  @override
  String get authPasswordResetSuccess =>
      'Kata sandi berhasil direset. Silakan masuk dengan kata sandi baru Anda.';

  @override
  String get authResetPasswordFailed => 'Gagal mereset kata sandi';

  @override
  String get settingsChangePassword => 'Ubah kata sandi';

  @override
  String get settingsCurrentPassword => 'Kata sandi saat ini';

  @override
  String get settingsEnterCurrentPassword => 'Masukkan kata sandi saat ini';

  @override
  String get settingsEnterNewPassword => 'Masukkan kata sandi baru';

  @override
  String get settingsPasswordChanged =>
      'Kata sandi berhasil diubah. Silakan masuk dengan kata sandi baru Anda.';

  @override
  String get settingsChangePasswordFailed => 'Gagal mengubah kata sandi';

  @override
  String get settingsNewPasswordMustBeDifferent =>
      'Kata sandi baru harus berbeda dari kata sandi saat ini';

  @override
  String get settingsChangePasswordInfo =>
      'Setelah mengubah kata sandi, Anda akan keluar dan perlu masuk dengan kata sandi baru.';

  @override
  String get settingsPasswordRequirements => 'Persyaratan kata sandi:';

  @override
  String get settingsSecurityNote =>
      'Untuk keamanan, Anda perlu masuk ulang di semua perangkat setelah mengubah kata sandi.';

  @override
  String get settingsSecurity => 'Keamanan';

  @override
  String get settingsCurrentBoundEmail => 'Email yang terhubung saat ini';

  @override
  String get settingsNewEmailAddress => 'Alamat email baru';

  @override
  String get settingsEnterNewEmail => 'Masukkan alamat email baru';

  @override
  String get settingsVerificationCode => 'Kode verifikasi';

  @override
  String get settingsVerificationCodeSent => 'Kode verifikasi terkirim';

  @override
  String get settingsCodeSentTo => 'Kode verifikasi dikirim ke';

  @override
  String get settingsDidNotReceiveCode => 'Tidak menerima kode?';

  @override
  String get settingsEmailChangedSuccess => 'Email berhasil diubah';

  @override
  String get settingsChangeEmailFailed => 'Gagal mengubah email';

  @override
  String get settingsEmailSecurityNote =>
      'Email Anda digunakan untuk pemulihan kata sandi. Jaga keamanannya.';

  @override
  String get commonGoogleLogin => 'Masuk dengan Google';

  @override
  String get commonAppleLogin => 'Masuk dengan Apple';

  @override
  String get commonWechat => 'WeChat';

  @override
  String get settingsLanguage => 'Bahasa';

  @override
  String get settingsLanguageChanged => 'Bahasa diubah';

  @override
  String get settingsBiometricLogin => 'Login biometrik';

  @override
  String authLoginWithBiometric(Object type) {
    return 'Masuk dengan $type';
  }

  @override
  String get settingsBiometricLoginEnabled => 'Login biometrik diaktifkan';

  @override
  String get settingsBiometricLoginDisabled => 'Login biometrik dinonaktifkan';

  @override
  String get settingsEnableBiometricLogin => 'Aktifkan login biometrik';

  @override
  String get settingsBiometricEnabled =>
      'Aktif - Gunakan biometrik untuk masuk';

  @override
  String get settingsBiometricDisabled => 'Nonaktif - Ketuk untuk mengaktifkan';

  @override
  String get settingsBiometricNeedRelogin =>
      'Silakan keluar dan masuk kembali untuk mengaktifkan login biometrik';

  @override
  String get authOr => 'ATAU';

  @override
  String get qrcodeCameraPermissionRestricted =>
      'Akses kamera dibatasi pada perangkat ini';

  @override
  String get authPasskeyLabel => 'Passkey';

  @override
  String get authGoogleLabel => 'Google';

  @override
  String get authAppleLabel => 'Apple';

  @override
  String get authSsoLabel => 'SSO';

  @override
  String get transferAmountHintZero => '0.00';

  @override
  String get commonMatrixIdHint => '@username:server.com';

  @override
  String get authServerAddressHint => 'https://m.si46.world';

  @override
  String get authEmailExampleHint => 'example@email.com';

  @override
  String get authVerificationCodePlaceholder => '------';

  @override
  String get profileEnterPokeSuffixHint =>
      'Masukkan sufiks colek, misal: di bahu';

  @override
  String get groupAlbum => 'Album grup';

  @override
  String get groupFiles => 'File grup';

  @override
  String get groupImages => 'Gambar';

  @override
  String get groupVideos => 'Video';

  @override
  String get groupTotal => 'Total';

  @override
  String get groupSize => 'Ukuran';

  @override
  String get groupNoMedia => 'Tidak ada media';

  @override
  String get groupNoMediaDescription => 'Belum ada foto atau video di grup ini';

  @override
  String get groupDocuments => 'Dokumen';

  @override
  String get groupNoFiles => 'Tidak ada file';

  @override
  String get groupNoFilesDescription => 'Belum ada file di grup ini';

  @override
  String groupDownloadStarted(String filename) {
    return 'Mengunduh $filename...';
  }

  @override
  String get contactNoCommonGroups => 'Tidak ada grup bersama';

  @override
  String get contactNoCommonGroupsDescription =>
      'Kamu tidak memiliki grup bersama';

  @override
  String get chatVoiceMessage => 'Suara';

  @override
  String get chatMessage => 'Pesan';

  @override
  String get conversationHideChat => 'Sembunyikan';

  @override
  String get settingsQuickReply => 'Balasan cepat';

  @override
  String get commonTranslate => 'Terjemahkan';

  @override
  String get contactCreateTag => 'Create Tag';

  @override
  String get contactEnterTagName => 'Enter tag name';

  @override
  String get contactEditTag => 'Edit Tag';

  @override
  String get contactDeleteTag => 'Delete Tag';

  @override
  String contactDeleteTagConfirm(String tagName) {
    return 'Are you sure you want to delete the tag \"$tagName\"?';
  }

  @override
  String get contactNoTags => 'No tags yet';

  @override
  String get contactFriendPermissions => 'Friend Permissions';

  @override
  String get contactSetChatOnly => 'Set as Chat-only';

  @override
  String get contactChatOnlyDesc =>
      'Can only chat with you, other content will be hidden';

  @override
  String get contactHideMyMoments => 'Hide My Moments';

  @override
  String get contactHideMyMomentsDesc => 'This friend cannot see my Moments';

  @override
  String get contactHideTheirMoments => 'Hide Their Moments';

  @override
  String get contactHideTheirMomentsDesc => 'Don\'t see this friend\'s Moments';

  @override
  String get contactHideMyStatus => 'Hide My Status';

  @override
  String get contactHideMyStatusDesc =>
      'This friend cannot see my status updates';

  @override
  String get contactNoChatOnlyFriends => 'No chat-only friends';

  @override
  String get contactNoOfficialAccounts => 'No official accounts';

  @override
  String get contactFollowOfficialAccountsDesc =>
      'Follow official accounts to get the latest updates';

  @override
  String get contactNoServiceAccounts => 'No service accounts';

  @override
  String get contactSubscribeServiceAccountsDesc =>
      'Subscribe to service accounts for convenient services';

  @override
  String get contactNoEnterpriseContacts => 'No enterprise contacts';

  @override
  String get contactEnterpriseContactsDesc =>
      'Enterprise contacts will be displayed here';

  @override
  String get profileCardPack => 'Card Pack';

  @override
  String get profileOrders => 'Orders';

  @override
  String get profileNoOrders => 'No orders';

  @override
  String get profileOrdersDesc => 'Your orders will be displayed here';

  @override
  String get profileNoCards => 'No cards';

  @override
  String get profileCardsDesc => 'Your cards will be displayed here';

  @override
  String get favoriteEnterTagsHint => 'Enter tags separated by commas';

  @override
  String get favoriteTagsUpdated => 'Tags updated';

  @override
  String get favoriteForwardedContent => 'Content forwarded';

  @override
  String get favoriteEnterNoteContent => 'Enter note content';

  @override
  String get favoriteNoteAdded => 'Note added';

  @override
  String get favoriteLinkTitle => 'Link title';

  @override
  String get favoriteLinkUrl => 'https://';

  @override
  String get favoriteLinkAdded => 'Link added';

  @override
  String get contactPhotoAdded => 'Photo added';

  @override
  String get contactEnterPhone => 'Enter phone number';

  @override
  String commonConversationWithId(String roomId) {
    return 'Percakapan: $roomId';
  }

  @override
  String commonContactWithId(String userId) {
    return 'Kontak: $userId';
  }

  @override
  String get commonDiscover => 'Jelajahi';

  @override
  String commonDeveloping(String title) {
    return '$title\n(Segera hadir)';
  }

  @override
  String get commonPageNotFound => 'Halaman tidak ditemukan';

  @override
  String get commonBackToHome => 'Kembali ke Beranda';

  @override
  String get settingsMessageNotifications => 'Notifikasi pesan';

  @override
  String get settingsReceiveNewMessageNotifications =>
      'Terima notifikasi pesan baru';

  @override
  String get settingsShowMessagePreview => 'Tampilkan pratinjau pesan';

  @override
  String get settingsShowMessageContentInNotification =>
      'Tampilkan isi pesan di notifikasi';

  @override
  String get settingsNotificationSound => 'Suara notifikasi';

  @override
  String get settingsPlaySoundOnMessage => 'Putar suara saat menerima pesan';

  @override
  String get commonVibration => 'Getaran';

  @override
  String get settingsVibrateOnMessage => 'Getar saat menerima pesan';

  @override
  String get settingsDoNotDisturbMode => 'Jangan ganggu';

  @override
  String get settingsDoNotDisturbDescription =>
      'Tidak menerima notifikasi selama waktu yang ditentukan';

  @override
  String get settingsStartTime => 'Waktu mulai';

  @override
  String get settingsEndTime => 'Waktu selesai';

  @override
  String get settingsDeleteQuickReply => 'Hapus balasan cepat';

  @override
  String get settingsEditQuickReply => 'Edit balasan cepat';

  @override
  String get settingsAddQuickReply => 'Tambah balasan cepat';

  @override
  String get settingsManageQuickReplies => 'Kelola balasan cepat';

  @override
  String get settingsNoQuickReplies => 'Tidak ada balasan cepat';

  @override
  String get settingsDefaultQuickReplies =>
      'Balasan cepat default akan ditampilkan';

  @override
  String get settingsWhoCanSee => 'Siapa yang dapat melihat';

  @override
  String get settingsLastSeen => 'Terakhir dilihat';

  @override
  String get settingsHiddenChats => 'Chat tersembunyi';

  @override
  String get settingsMessagesLabel => 'Pesan';

  @override
  String get settingsAllowStrangerMessages => 'Izinkan pesan dari orang asing';

  @override
  String get settingsReceiveMessagesFromNonContacts =>
      'Terima pesan dari non-kontak';

  @override
  String get settingsReadReceipts => 'Tanda baca';

  @override
  String get settingsLetOthersKnowYouRead =>
      'Biarkan orang lain tahu Anda telah membaca pesan mereka';

  @override
  String get settingsTypingIndicator => 'Indikator mengetik';

  @override
  String get settingsLetOthersKnowYouTyping =>
      'Biarkan orang lain tahu Anda sedang mengetik';

  @override
  String get settingsEveryone => 'Semua orang';

  @override
  String get settingsContactsOnly => 'Hanya kontak';

  @override
  String get settingsNobody => 'Tidak ada';

  @override
  String settingsWhoCanSeeTitle(String title) {
    return 'Siapa yang bisa melihat $title';
  }

  @override
  String settingsVersionInfo(String version) {
    return 'Versi $version';
  }

  @override
  String get settingsCheckForUpdates => 'Periksa pembaruan';

  @override
  String get settingsOpenSourceLicenses => 'Lisensi open source';

  @override
  String get settingsFeedbackAndSuggestions => 'Masukan dan saran';

  @override
  String get settingsBuiltOnMatrix => 'Dibangun di atas protokol Matrix';

  @override
  String get settingsNoHiddenChats => 'Tidak ada chat tersembunyi';

  @override
  String get settingsNoHiddenChatsDescription =>
      'Chat yang kamu sembunyikan akan muncul di sini';

  @override
  String get settingsUnhideChat => 'Tampilkan';

  @override
  String get settingsDarkMode => 'Mode gelap';

  @override
  String get settingsFontSize => 'Ukuran font';

  @override
  String get settingsBubbleStyle => 'Gaya gelembung';

  @override
  String get settingsFollowSystem => 'Ikuti sistem';

  @override
  String get settingsAutoSwitchBySystem =>
      'Beralih otomatis sesuai pengaturan sistem';

  @override
  String get settingsLightMode => 'Mode terang';

  @override
  String get settingsAlwaysUseLightTheme => 'Selalu gunakan tema terang';

  @override
  String get settingsDarkModeOption => 'Mode gelap';

  @override
  String get settingsAlwaysUseDarkTheme => 'Selalu gunakan tema gelap';

  @override
  String get settingsFontSizeSmall => 'Kecil';

  @override
  String get settingsFontSizeStandard => 'Standar';

  @override
  String get settingsFontSizeLarge => 'Besar';

  @override
  String get settingsFontSizeExtraLarge => 'Sangat besar';

  @override
  String get settingsBubbleStyleWechat => 'Gaya WeChat';

  @override
  String get settingsBubbleStyleWechatDesc => 'Gaya gelembung klasik WeChat';

  @override
  String get settingsBubbleStyleModern => 'Gaya modern';

  @override
  String get settingsBubbleStyleModernDesc =>
      'Gaya gelembung modern yang bersih';

  @override
  String get settingsBubbleStyleClassic => 'Gaya klasik';

  @override
  String get settingsBubbleStyleClassicDesc => 'Gaya gelembung tradisional';

  @override
  String get discoverVideoChannels => 'Saluran';

  @override
  String get discoverLive => 'Siaran';

  @override
  String get discoverListen => 'Dengarkan';

  @override
  String get discoverWatch => 'Tonton';

  @override
  String get discoverSearchDiscover => 'Cari';

  @override
  String get discoverNearbyPeople => 'Sekitar';

  @override
  String get discoverGames => 'Permainan';

  @override
  String get discoverMiniPrograms => 'Mini Program';

  @override
  String get chatAlreadyInCall => 'Sedang dalam panggilan';

  @override
  String get commonConnectionFailed => 'Koneksi gagal';

  @override
  String get chatCallRejected => 'Panggilan ditolak';

  @override
  String get chatNoAnswer => 'Tidak ada jawaban';

  @override
  String get commonClose => 'Tutup';

  @override
  String get chatSelectContact => 'Pilih Kontak';

  @override
  String get chatVoteRemoved => 'Pilihan dihapus';

  @override
  String get chatVoteChanged => 'Pilihan diubah';

  @override
  String get chatVoted => 'Memilih';

  @override
  String chatReplyTo(String name) {
    return 'Balas ke $name';
  }

  @override
  String get chatCurrentLocation => 'Lokasi Saat Ini';

  @override
  String chatNearbyPlace(int index) {
    return 'Tempat Terdekat $index';
  }

  @override
  String chatApproximateDistance(String distance) {
    return 'Sekitar $distance';
  }

  @override
  String get chatAddress => 'Alamat';

  @override
  String get chatLatitude => 'Garis Lintang';

  @override
  String get chatLongitude => 'Garis Bujur';

  @override
  String get groupDescriptionUpdated => 'Deskripsi grup diperbarui';

  @override
  String get groupAvatarUpdated => 'Avatar grup diperbarui';

  @override
  String get callDecline => 'Tolak';

  @override
  String get callAnswer => 'Jawab';

  @override
  String get callIncomingVideoCall => 'Panggilan video masuk';

  @override
  String get callIncomingVoiceCall => 'Panggilan suara masuk';

  @override
  String get callVideoCallInProgress => 'Panggilan video';

  @override
  String get callVoiceCallInProgress => 'Panggilan suara';

  @override
  String get callReconnectingCall => 'Menghubungkan ulang...';

  @override
  String get callEnded => 'Panggilan berakhir';

  @override
  String get callFailed => 'Panggilan gagal';

  @override
  String get callLivekitNotConfigured => 'LiveKit belum dikonfigurasi';

  @override
  String callJoinMeetingFailed(String error) {
    return 'Gagal bergabung ke meeting: $error';
  }

  @override
  String callScreenShareFailed(String error) {
    return 'Berbagi layar gagal: $error';
  }

  @override
  String get profileN42BeanTitle => 'N42 Bean';

  @override
  String get profileNoN42Bean => 'Tidak ada N42 Bean';

  @override
  String get profileN42BeanDetails => 'Detail N42 Bean';

  @override
  String get profileN42BeanDescription =>
      'N42 Bean adalah token untuk menukarkan barang virtual dan layanan di N42. Saat ini tersedia untuk:';

  @override
  String get profileN42BeanFeature1 => 'Stiker dan tema eksklusif anggota';

  @override
  String get profileN42BeanFeature2 => 'Kustomisasi gelembung chat';

  @override
  String get profileN42BeanFeature3 => 'Kustomisasi sampul amplop merah';

  @override
  String get profileN42BeanFeature4 => 'Lencana nama panggilan eksklusif';

  @override
  String get profileN42BeanFeature5 => 'Hak istimewa chat grup';

  @override
  String get profileN42BeanFeature6 => 'Perluasan penyimpanan cloud';

  @override
  String get profileN42BeanFeature7 => 'Filter kecantikan panggilan video';

  @override
  String get profileN42BeanFeature8 => 'Kustomisasi latar belakang Moments';

  @override
  String get profileN42BeanFeature9 => 'Prioritas layanan pelanggan VIP';

  @override
  String get profileGotIt => 'Mengerti';

  @override
  String get profileNoN42BeanRecords => 'Tidak ada catatan N42 Bean';

  @override
  String get profileMoodAndThoughts => 'Suasana Hati & Pikiran';

  @override
  String get profileStatusHappy => 'Senang';

  @override
  String get profileStatusCracked => 'Hancur';

  @override
  String get profileStatusLucky => 'Beruntung';

  @override
  String get profileStatusSunny => 'Cerah';

  @override
  String get profileStatusTired => 'Lelah';

  @override
  String get profileStatusDaydream => 'Melamun';

  @override
  String get profileStatusRushing => 'Terburu-buru';

  @override
  String get profileStatusOverthinking => 'Berpikir Berlebihan';

  @override
  String get profileStatusEnergized => 'Berenergi';

  @override
  String get profileWorkAndStudy => 'Kerja & Belajar';

  @override
  String get profileStatusWorking => 'Bekerja';

  @override
  String get profileStatusStudying => 'Belajar';

  @override
  String get profileStatusBusy => 'Sibuk';

  @override
  String get profileStatusSlacking => 'Santai';

  @override
  String get profileStatusTraveling => 'Bepergian';

  @override
  String get profileStatusGoingHome => 'Pulang';

  @override
  String get profileStatusDnd => 'Jangan Ganggu';

  @override
  String get profileActivities => 'Aktivitas';

  @override
  String get profileStatusHanging => 'Nongkrong';

  @override
  String get profileStatusCheckIn => 'Check In';

  @override
  String get profileStatusExercising => 'Berolahraga';

  @override
  String get profileStatusCoffee => 'Kopi';

  @override
  String get profileStatusBubbleTea => 'Boba';

  @override
  String get profileStatusEating => 'Makan';

  @override
  String get profileStatusParenting => 'Mengasuh';

  @override
  String get profileStatusSavingWorld => 'Menyelamatkan Dunia';

  @override
  String get profileStatusSelfie => 'Selfie';

  @override
  String get profileRest => 'Istirahat';

  @override
  String get profileStatusRetreat => 'Istirahat';

  @override
  String get profileStatusHome => 'Di Rumah';

  @override
  String get profileStatusSleeping => 'Tidur';

  @override
  String get profileStatusCatLover => 'Pecinta Kucing';

  @override
  String get profileStatusDogWalking => 'Jalan-jalan dengan Anjing';

  @override
  String get profileStatusGaming => 'Bermain Game';

  @override
  String get profileStatusListening => 'Mendengarkan';

  @override
  String get profileEditAddress => 'Edit Alamat';

  @override
  String get profileRecipient => 'Penerima';

  @override
  String get profileEnterRecipientName => 'Masukkan nama penerima';

  @override
  String get profilePhoneNumber => 'Nomor Telepon';

  @override
  String get profileEnterPhoneNumber => 'Masukkan nomor telepon';

  @override
  String get profileRegionHint => 'Provinsi/Kota/Kabupaten';

  @override
  String get profileDetailedAddress => 'Alamat Lengkap';

  @override
  String get profileDetailedAddressHint => 'Jalan, nomor gedung, dll.';

  @override
  String get profileSetAsDefaultAddress => 'Atur sebagai alamat default';

  @override
  String get profilePleaseCompleteInfo => 'Silakan lengkapi semua kolom';

  @override
  String get profileEditInvoice => 'Edit Faktur';

  @override
  String get profileInvoiceType => 'Jenis faktur: ';

  @override
  String get profileCompanyName => 'Nama Perusahaan';

  @override
  String get profilePersonalName => 'Nama Pribadi';

  @override
  String get profileEnterCompanyName => 'Masukkan nama perusahaan';

  @override
  String get profileEnterName => 'Masukkan nama';

  @override
  String get profileTaxIdNumber => 'NPWP';

  @override
  String get profileEnterTaxIdNumber => 'Masukkan NPWP';

  @override
  String get profileBankNameOptional => 'Nama Bank (Opsional)';

  @override
  String get profileEnterBankName => 'Masukkan nama bank';

  @override
  String get profileBankAccountOptional => 'Rekening Bank (Opsional)';

  @override
  String get profileEnterBankAccount => 'Masukkan rekening bank';

  @override
  String get profileCompanyAddressOptional => 'Alamat Perusahaan (Opsional)';

  @override
  String get profileEnterCompanyAddress => 'Masukkan alamat perusahaan';

  @override
  String get profileCompanyPhoneOptional => 'Telepon Perusahaan (Opsional)';

  @override
  String get profileEnterCompanyPhone => 'Masukkan telepon perusahaan';

  @override
  String get profileSetAsDefaultInvoice => 'Atur sebagai faktur default';

  @override
  String get profileRingtoneVibrate => 'Getar';

  @override
  String get profileRingtoneSilent => 'Senyap';

  @override
  String get profileVibrateMode => 'Mode getar';

  @override
  String get profileSilentMode => 'Mode senyap';

  @override
  String profilePlayFailed(String ringtoneName) {
    return 'Gagal memutar: $ringtoneName';
  }

  @override
  String profilePlaying(String ringtoneName) {
    return 'Memutar: $ringtoneName';
  }

  @override
  String get profileStop => 'Berhenti';

  @override
  String get profileSelectRingtone => 'Pilih Nada Dering';

  @override
  String get profileLoadingRingtones => 'Memuat nada dering...';

  @override
  String get profileNoRingtonesFound => 'Tidak ada nada dering ditemukan';

  @override
  String mainMessagesWithCount(int count) {
    return 'Pesan($count)';
  }

  @override
  String get storyViewers => 'Penonton';

  @override
  String get storyNoViewers => 'Belum ada penonton';

  @override
  String get storyReplyToStory => 'Balas cerita...';

  @override
  String get commonCopiedToClipboard => 'Disalin ke papan klip';

  @override
  String get commonMore => 'Lainnya';

  @override
  String get commonTranslating => 'Menerjemahkan...';

  @override
  String commonTranslatedFrom(String language) {
    return 'Diterjemahkan dari $language';
  }

  @override
  String get commonTranslation => 'Terjemahan';

  @override
  String get commonTranslationFailed => 'Terjemahan gagal';

  @override
  String get commonAllRead => 'Semua dibaca';

  @override
  String commonReadCount(int count) {
    return '$count dibaca';
  }

  @override
  String get commonYouRecalledMessage => 'Anda menarik sebuah pesan';

  @override
  String get commonMessageRecalled => 'Pesan ditarik';

  @override
  String get commonReEdit => 'Edit ulang';

  @override
  String get commonWalletArea => 'Area dompet';

  @override
  String get callIncomingCall => 'Panggilan masuk';

  @override
  String get callMissedCall => 'Panggilan tidak terjawab';

  @override
  String get groupRemoveAdmin => 'Hapus Admin';

  @override
  String get chatSelectCurrency => 'Pilih mata uang';

  @override
  String get chatSelectEmoji => 'Pilih emoji';

  @override
  String get chatSelectRedPacketCover => 'Pilih sampul';

  @override
  String get groupSetAsAdmin => 'Atur sebagai Admin';

  @override
  String get chatVideoPlaybackFailed => 'Pemutaran video gagal';

  @override
  String get groupViewProfile => 'Lihat Profil';

  @override
  String get favoriteAddLinkComingSoon => 'Fitur tambah tautan segera hadir';

  @override
  String get favoriteNewNoteComingSoon => 'Fitur catatan baru segera hadir';

  @override
  String get qrcodeSaveFeatureComingSoon => 'Fitur simpan segera hadir';

  @override
  String get qrcodeShareFeatureComingSoon => 'Fitur bagikan segera hadir';

  @override
  String qrcodeProcessFailed(String error) {
    return 'Gagal memproses kode QR: $error';
  }

  @override
  String get securityDeviceIdRequired => '需要设备 ID';

  @override
  String securityVerificationStartFailed(String error) {
    return '启动验证失败: $error';
  }

  @override
  String get securityVerificationFailed => '验证失败';

  @override
  String securityVerificationFailedWithReason(String reason) {
    return '验证失败: $reason';
  }

  @override
  String get securityEmojiMismatchRejected => '验证被拒绝 - 表情不匹配';

  @override
  String get securityWaitingForDeviceAccept => '等待另一台设备接受...';

  @override
  String get securityVerifyDevice => '验证此设备';

  @override
  String get securityConfirmEmojiMatch => '确认以下表情符号在两台设备上以相同顺序显示';

  @override
  String get securityEmojiDontMatch => '不匹配';

  @override
  String get securityEmojiMatch => '匹配';

  @override
  String get securityWaitingForDeviceConfirm => '等待另一台设备确认...';

  @override
  String get securityVerificationSuccess => '验证成功！';

  @override
  String get securityDeviceVerifiedTrusted => '此设备已验证并可信任。';

  @override
  String get securityCompareEmoji => '比较两台设备上的表情符号';

  @override
  String get securityCompareNumbers => '比较两台设备上的数字';

  @override
  String get commonTryAgain => '重试';

  @override
  String get commonDone => '完成';

  @override
  String get chatExportTitle => '导出聊天记录';

  @override
  String get chatExportSuccess => '导出成功';

  @override
  String chatExportFailed(String error) {
    return '导出失败: $error';
  }

  @override
  String get chatExportFormat => '导出格式';

  @override
  String get chatExportHtmlDesc => '可在任何浏览器中打开的精美排版';

  @override
  String get chatExportJsonDesc => '机器可读的结构化数据格式';

  @override
  String get chatExportDateRange => '日期范围';

  @override
  String get chatExportAll => '全部消息';

  @override
  String get chatExportLastWeek => '最近7天';

  @override
  String get chatExportLastMonth => '最近一个月';

  @override
  String get chatExportLast3Months => '最近三个月';

  @override
  String get chatExportMessageCount => '待导出消息';

  @override
  String get chatExportButton => '导出并分享';

  @override
  String get chatMediaGallery => '媒体文件';

  @override
  String get chatExportHistory => '导出聊天记录';

  @override
  String get pdfLoadFailed => '加载 PDF 失败';

  @override
  String pdfPageIndicator(int current, int total) {
    return '$current / $total';
  }

  @override
  String get mediaAll => '全部';

  @override
  String get mediaImages => '图片';

  @override
  String get mediaVideos => '视频';

  @override
  String get mediaFiles => '文件';

  @override
  String get mediaAudio => '音频';

  @override
  String mediaItemsCount(int count) {
    return '$count 项';
  }

  @override
  String get mediaNoMediaFound => '暂无媒体文件';

  @override
  String get spacesTitle => '社区';

  @override
  String get spacesCreate => '创建社区';

  @override
  String get spacesJoined => '已加入';

  @override
  String get spacesDiscover => '发现';

  @override
  String get spacesNoJoined => '还没有加入任何社区';

  @override
  String get spacesExplore => '探索社区';

  @override
  String get spacesNoPublic => '没有找到公共社区';

  @override
  String get spacesJoin => '加入';

  @override
  String get spacesSubSpaces => '子社区';

  @override
  String get spacesChannels => '频道';

  @override
  String spacesMembersCount(int count) {
    return '$count 位成员';
  }

  @override
  String get spacesPublic => '公开';

  @override
  String get spacesPrivate => '私密';

  @override
  String get spacesSuggested => '推荐';

  @override
  String spacesChannelsCount(int count) {
    return '$count 个频道';
  }

  @override
  String get callInCallChat => '通话中聊天';

  @override
  String callMessagesCount(int count) {
    return '$count 条消息';
  }

  @override
  String get callNoMessagesYet => '暂无消息\n发送一条消息开始聊天';

  @override
  String get callTypeMessage => '输入消息...';

  @override
  String get callYouSender => '我';

  @override
  String get callChatLabel => '聊天';

  @override
  String get chatEdited => '已编辑';

  @override
  String get chatEditHistory => '编辑历史';

  @override
  String get chatOriginalMessage => '原始消息';

  @override
  String chatEditedAt(String time) {
    return '编辑于 $time';
  }

  @override
  String get chatViewOnce => '阅后即焚';

  @override
  String get chatViewOncePhoto => '阅后即焚照片';

  @override
  String get chatViewOnceVideo => '阅后即焚视频';

  @override
  String get chatViewOnceViewed => '已查看';

  @override
  String get chatViewOnceExpired => '已过期';

  @override
  String get chatViewOnceTap => '点击查看';

  @override
  String get chatAutoFaceBlur => '自动模糊人脸';

  @override
  String get chatAutoFaceBlurDesc => '发送照片时自动模糊人脸';

  @override
  String get threadReplyInThread => '在线程中回复';

  @override
  String threadReplies(int count) {
    return '$count 条回复';
  }

  @override
  String get threadReply => '1 条回复';

  @override
  String threadLatestReply(String preview) {
    return '最新: $preview';
  }

  @override
  String get threadTitle => '消息线程';

  @override
  String get threadReplyPlaceholder => '在线程中回复...';

  @override
  String threadParticipants(int count) {
    return '$count 位参与者';
  }

  @override
  String get voiceRoomTitle => '语音聊天室';

  @override
  String get voiceRoomCreate => '创建语音房间';

  @override
  String get voiceRoomJoin => '加入';

  @override
  String get voiceRoomLeave => '离开';

  @override
  String get voiceRoomEnd => '结束房间';

  @override
  String get voiceRoomRaiseHand => '举手';

  @override
  String get voiceRoomLowerHand => '放下手';

  @override
  String get voiceRoomMute => '静音';

  @override
  String get voiceRoomUnmute => '取消静音';

  @override
  String get voiceRoomHost => '主持人';

  @override
  String get voiceRoomSpeakers => '发言者';

  @override
  String get voiceRoomListeners => '听众';

  @override
  String get voiceRoomLive => '直播中';

  @override
  String get voiceRoomEnded => '已结束';

  @override
  String get voiceRoomScheduled => '已预约';

  @override
  String get voiceRoomApprove => '批准发言';

  @override
  String get voiceRoomDemote => '移至听众';

  @override
  String voiceRoomHandRaised(String name) {
    return '$name 举手了';
  }

  @override
  String get voiceRoomName => '房间名称';

  @override
  String get voiceRoomTopic => '话题（可选）';

  @override
  String get voiceRoomNoActive => '暂无活跃的语音房间';

  @override
  String get voiceRoomConnecting => '连接中...';

  @override
  String get usernameTitle => '用户名';

  @override
  String get usernameSet => '设置用户名';

  @override
  String get usernameChange => '修改用户名';

  @override
  String get usernamePlaceholder => '输入用户名';

  @override
  String get usernameAvailable => '用户名可用';

  @override
  String get usernameUnavailable => '用户名已被占用';

  @override
  String get usernameInvalid => '3-30个字符，小写字母、数字、下划线，必须以字母开头';

  @override
  String get usernameReserved => '此用户名为保留名称';

  @override
  String get usernameSaved => '用户名已保存';

  @override
  String get usernameSearchHint => '通过 @用户名 搜索';

  @override
  String get ensName => 'ENS 域名';

  @override
  String get ensLinked => '已关联 ENS';

  @override
  String get ensResolving => '正在解析 ENS...';

  @override
  String get ensNotFound => '未找到 ENS 域名';

  @override
  String get tokenGateTitle => '代币门控';

  @override
  String get tokenGateEnable => '启用代币门控';

  @override
  String get tokenGateDisable => '禁用代币门控';

  @override
  String get tokenGateAddRule => '添加规则';

  @override
  String get tokenGateRemoveRule => '删除规则';

  @override
  String get tokenGateContractAddress => '合约地址';

  @override
  String get tokenGateMinBalance => '最低余额';

  @override
  String get tokenGateTokenId => 'Token ID (ERC-1155)';

  @override
  String get tokenGateChainId => '链 ID';

  @override
  String get tokenGateVerifying => '正在验证代币持有...';

  @override
  String get tokenGateVerified => '验证通过';

  @override
  String get tokenGateDenied => '您未满足代币要求';

  @override
  String get tokenGateOperatorAnd => '需满足所有规则';

  @override
  String get tokenGateOperatorOr => '满足任一规则即可';

  @override
  String get tokenGateRuleErc20 => 'ERC-20 代币';

  @override
  String get tokenGateRuleErc721 => 'NFT (ERC-721)';

  @override
  String get tokenGateRuleErc1155 => '多代币 (ERC-1155)';

  @override
  String get tokenGateRuleNative => '原生代币';

  @override
  String get tokenGateSaved => '代币门控已保存';

  @override
  String get tokenGateEnableDescription => '要求成员持有指定代币才能加入';

  @override
  String get tokenGateOperator => '规则逻辑';

  @override
  String get tokenGateRules => '规则列表';

  @override
  String get tokenGateSymbol => '代币符号（可选）';

  @override
  String get tokenGateChain => '区块链';

  @override
  String get tokenGateTokenStandard => '代币标准';

  @override
  String get tokenGateDenialMessage => '拒绝消息';

  @override
  String get tokenGateDenialMessageHint => '验证失败时显示的消息';

  @override
  String get tokenGateVerifyTitle => '代币验证';

  @override
  String get tokenGateVerifyPassed => '验证通过';

  @override
  String get tokenGateVerifyFailed => '验证未通过';

  @override
  String get tokenGateRetryVerify => '重新验证';

  @override
  String get tokenGateRequired => '要求';

  @override
  String get tokenGateYourBalance => '你的余额';

  @override
  String get tokenGateRulesActive => '条规则生效';

  @override
  String get tokenGateDisabled => '未启用';

  @override
  String get ensNotBound => '未绑定';

  @override
  String get liveLocation => 'Live Location';

  @override
  String get stopLiveLocation => 'Stop Sharing';

  @override
  String get startLiveLocation => 'Start Sharing';

  @override
  String get selectDuration => 'Select Duration';

  @override
  String get groupChatFiles => 'Chat Files';

  @override
  String get groupLinks => 'Links';

  @override
  String get groupNoLinks => 'No links yet';

  @override
  String get chatBackground => 'Chat Background';

  @override
  String get solidColors => 'Solid Colors';

  @override
  String get gradients => 'Gradients';

  @override
  String get defaultBackground => 'Default';

  @override
  String get settingsFontSizeSlider => 'Font Size';

  @override
  String get autoDownload => 'Auto-Download';

  @override
  String get images => 'Images';

  @override
  String get voice => 'Voice';

  @override
  String get video => 'Video';

  @override
  String get files => 'Files';

  @override
  String get mobileData => 'Mobile Data';

  @override
  String get roaming => 'Roaming';

  @override
  String get storageManagement => 'Storage';

  @override
  String get totalUsage => 'Total Usage';

  @override
  String get cache => 'Cache';

  @override
  String get other => 'Other';

  @override
  String get clearCache => 'Clear Cache';

  @override
  String get cacheCleared => 'Cache cleared';

  @override
  String get clearCacheFailed => 'Failed to clear cache';

  @override
  String get confirmClearCache => 'Clear all cache data?';

  @override
  String get mapView => 'Map View';

  @override
  String liveLocationSharingCount(int count) {
    return '$count people sharing location';
  }

  @override
  String get minutes15 => '15 minutes';

  @override
  String get minutes30 => '30 minutes';

  @override
  String get hour1 => '1 hour';

  @override
  String get hours8 => '8 hours';

  @override
  String get personalCard => 'Personal Card';

  @override
  String get downloadFailed => 'Download failed';

  @override
  String get locationExpired => 'Expired';

  @override
  String secondsRemaining(int count) {
    return '${count}s';
  }

  @override
  String minutesRemaining(int count) {
    return '${count}min';
  }

  @override
  String hoursMinutesRemaining(int hours, int minutes) {
    return '${hours}h ${minutes}min';
  }

  @override
  String get favoriteMessages => 'Favorites';

  @override
  String get linksCopied => 'Link copied';

  @override
  String get noLinksFound => 'No links found';

  @override
  String get roomStorageRanking => 'Room Storage Ranking';

  @override
  String get downloadComplete => 'Download complete';

  @override
  String get downloading => 'Downloading...';

  @override
  String get draftSaved => 'Draft saved';

  @override
  String get voiceRecording => 'Voice Recording';

  @override
  String get searchLocation => 'Search Location';

  @override
  String get tapToSearch => 'Tap to search';

  @override
  String get settingsThisDevice => '本设备';

  @override
  String get settingsJustNow => '刚刚';

  @override
  String get settingsDeviceId => '设备 ID';

  @override
  String get settingsStatus => '状态';

  @override
  String get settingsLastActive => '最后活跃';

  @override
  String get settingsIpAddress => 'IP 地址';

  @override
  String get settingsRenameDevice => '重命名设备';

  @override
  String get settingsDeviceNameHint => '输入设备名称';

  @override
  String get settingsDeviceRenamed => '设备已重命名';

  @override
  String get settingsRenameFailed => '重命名失败';

  @override
  String get settingsRemoteLogout => '远程登出';

  @override
  String settingsRemoteLogoutConfirm(String deviceName) {
    return '确定要登出「$deviceName」吗？此操作无法撤销。';
  }

  @override
  String get settingsDeviceLoggedOut => '设备已登出';

  @override
  String get settingsLogoutFailed => '登出失败';

  @override
  String get settingsLogout => '登出';

  @override
  String get settingsVerifyIdentity => '验证身份';

  @override
  String get settingsEnterPasswordToConfirm => '请输入密码以确认此操作。';

  @override
  String get scheduledSendTitle => '定时发送';

  @override
  String get scheduledSendInOneHour => '1小时后';

  @override
  String get scheduledSendTonight => '今晚 (20:00)';

  @override
  String get scheduledSendTomorrowMorning => '明早 (9:00)';

  @override
  String get scheduledSendCustom => '自定义时间';

  @override
  String get scheduledMessageLabel => '定时发送';

  @override
  String get scheduledMessageCancel => '取消定时发送';

  @override
  String get chatLockTitle => '聊天锁';

  @override
  String get chatLockEnable => '锁定此聊天';

  @override
  String get chatLockDisable => '解锁此聊天';

  @override
  String get chatLockDescription => '锁定的聊天需要通过生物识别或 PIN 码验证才能打开';

  @override
  String get chatLockVerifyTitle => '聊天已锁定';

  @override
  String get chatLockVerifySubtitle => '验证后访问此聊天';

  @override
  String get chatLockVerifyFailed => '验证失败';

  @override
  String get chatLockEnabled => '聊天已锁定';

  @override
  String get chatLockDisabled => '聊天已解锁';

  @override
  String get chatLockPinTitle => '输入 PIN 码';

  @override
  String get chatLockPinSetTitle => '设置 PIN 码';

  @override
  String get chatLockPinConfirmTitle => '确认 PIN 码';

  @override
  String get chatLockPinMismatch => 'PIN 码不一致';

  @override
  String get chatLockUseBiometric => '使用生物识别';

  @override
  String get chatLockUsePin => '使用 PIN 码';

  @override
  String get mediaEditorUndo => '撤销';

  @override
  String get mediaEditorRedo => '重做';

  @override
  String get mediaEditorCrop => '裁剪';

  @override
  String get mediaEditorFilter => '滤镜';

  @override
  String get mediaEditorDraw => '涂鸦';

  @override
  String get mediaEditorText => '文字';

  @override
  String get aiAssistant => 'AI 助手';

  @override
  String get aiAssistantWelcome => '你好！我是 N42 AI 助手，有什么可以帮你的吗？';

  @override
  String get aiAssistantNotConfigured => 'AI 服务未配置';

  @override
  String get aiAssistantSettings => 'AI 设置';

  @override
  String get aiAssistantClearHistory => '清空对话历史';

  @override
  String get aiAssistantClearHistoryConfirm => '确定清空所有 AI 对话历史？';

  @override
  String get aiAssistantStopGenerating => '停止生成';

  @override
  String get aiAssistantModel => '模型';

  @override
  String get aiAssistantTemperature => '温度';

  @override
  String get aiAssistantMaxTokens => '最大令牌数';

  @override
  String get aiAssistantContextWindow => '上下文窗口';

  @override
  String get aiAssistantServiceStatus => '服务状态';

  @override
  String get aiAssistantAvailable => '可用';

  @override
  String get aiAssistantUnavailable => '不可用';

  @override
  String get aiSummarize => 'AI 总结';

  @override
  String aiSummarizeUnread(int count) {
    return 'AI 总结 $count 条未读消息';
  }

  @override
  String get aiSummarizeLoading => '正在总结...';

  @override
  String get aiSummarizeError => '总结失败';

  @override
  String get aiRewrite => 'AI 改写';

  @override
  String get aiRewriteFormal => '正式';

  @override
  String get aiRewriteCasual => '轻松';

  @override
  String get aiRewritePlayful => '俏皮';

  @override
  String get aiRewriteProfessional => '专业';

  @override
  String get aiRewriteAccept => '使用';

  @override
  String get aiRewriteCancel => '取消';

  @override
  String get aiRewriteLoading => '正在改写...';

  @override
  String get aiLinkSummary => 'AI 摘要';

  @override
  String get aiLinkSummaryAnalyzing => '正在分析...';

  @override
  String get chatFolderManagement => '管理文件夹';

  @override
  String get chatFolderSystem => '系统文件夹';

  @override
  String get chatFolderCustom => '自定义文件夹';

  @override
  String get chatFolderEmpty => '暂无自定义文件夹';

  @override
  String get chatFolderCreate => '创建文件夹';

  @override
  String get chatFolderEdit => '编辑文件夹';

  @override
  String get chatFolderNameHint => '文件夹名称';

  @override
  String get chatFolderAll => '全部';

  @override
  String get chatFolderUnread => '未读';

  @override
  String get chatFolderPersonal => '私聊';

  @override
  String get chatFolderGroups => '群组';

  @override
  String get chatFolderChannels => '频道';

  @override
  String get chatFolderMuted => '已静音';

  @override
  String get storyAddMusic => '添加音乐';

  @override
  String get storyChangeMusic => '更换音乐';

  @override
  String get storyBackgroundMusic => '背景音乐';

  @override
  String get storyMusicPreview => '预览 (最长15秒)';

  @override
  String get storyChooseFromDevice => '从设备选择';

  @override
  String get storyUseThisMusic => '使用此音乐';

  @override
  String get authPasskeyNotSupported => '此设备不支持 Passkey';

  @override
  String get authPasskeyRegister => '注册 Passkey';

  @override
  String get authPasskeyNoRegistered => '未注册 Passkey';

  @override
  String get authPasskeyRegisterHint => '注册 Passkey 以实现无密码登录';

  @override
  String get authPasskeyNameYours => '为 Passkey 命名';

  @override
  String get authPasskeyRegistered => 'Passkey 注册成功';

  @override
  String get authPasskeyDeleted => 'Passkey 已删除';

  @override
  String authPasskeyDeleteConfirm(String name) {
    return '删除 Passkey \"$name\"？删除后将无法使用该 Passkey 登录。';
  }
}
