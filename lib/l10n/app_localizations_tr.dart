// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class STr extends S {
  STr([String locale = 'tr']) : super(locale);

  @override
  String get chatModuleInitFailed => 'Sohbet modülü başlatılamadı';

  @override
  String get checkNetworkRetry =>
      'Lütfen ağ bağlantınızı kontrol edin ve tekrar deneyin';

  @override
  String get retry => 'Tekrar Dene';

  @override
  String get unknownUser => 'Bilinmeyen Kullanıcı';

  @override
  String get walletNotConnected => 'Cüzdan bağlı değil';

  @override
  String get cannotGetWalletAddress => 'Cüzdan adresi alınamadı';

  @override
  String paymentRequestMemo(String requestId) {
    return 'Ödeme talebi: $requestId';
  }

  @override
  String get callServiceNotInitialized => 'Arama servisi başlatılmadı';

  @override
  String get alreadyInCall => 'Zaten bir aramada';

  @override
  String get meetingServiceNotInitialized => 'Toplantı servisi başlatılmadı';

  @override
  String get livekitNotConfigured => 'LiveKit yapılandırılmadı';

  @override
  String get unknownConversation => 'Bilinmeyen sohbet';

  @override
  String startCallFailed(String error) {
    return 'Arama başlatılamadı: $error';
  }

  @override
  String answerCallFailed(String error) {
    return 'Yanıtlanamadı: $error';
  }

  @override
  String get connectionFailed => 'Bağlantı başarısız';

  @override
  String get callRejected => 'Arama reddedildi';

  @override
  String get noAnswer => 'Cevap yok';

  @override
  String get invalidLoginResponse => 'Geçersiz giriş yanıtı';

  @override
  String loginFailed(String error) {
    return 'Giriş başarısız: $error';
  }

  @override
  String get sessionRestoreFailed => 'Oturum geri yüklenemedi';

  @override
  String get additionalVerificationRequired => 'Ek doğrulama gerekli';

  @override
  String registrationFailed(String error) {
    return 'Kayıt başarısız: $error';
  }

  @override
  String cannotConnectServer(String error) {
    return 'Sunucuya bağlanılamadı: $error';
  }

  @override
  String get wrongUsernamePassword => 'Yanlış kullanıcı adı veya şifre';

  @override
  String get usernameTaken => 'Kullanıcı adı zaten alınmış';

  @override
  String get invalidUsernameFormat => 'Geçersiz kullanıcı adı formatı';

  @override
  String get rateLimitExceeded =>
      'Çok fazla istek, lütfen daha sonra tekrar deneyin';

  @override
  String get loginExpired => 'Oturum süresi doldu';

  @override
  String joinMeetingFailed(String error) {
    return 'Toplantıya katılınamadı: $error';
  }

  @override
  String screenShareFailed(String error) {
    return 'Ekran paylaşımı başarısız: $error';
  }

  @override
  String get answer => 'Yanıtla';

  @override
  String get decline => 'Reddet';

  @override
  String get missedCall => 'Cevapsız arama';

  @override
  String get callBack => 'Geri ara';

  @override
  String get incomingCall => 'Gelen arama';

  @override
  String get missedVideoCall => 'Cevapsız görüntülü arama';

  @override
  String get missedVoiceCall => 'Cevapsız sesli arama';

  @override
  String get passkeyNotInitialized => 'Passkey başlatılmadı';

  @override
  String get googleSignInNotConfigured => 'Google Giriş yapılandırılmadı';

  @override
  String get encryptedMessage => '[Şifreli mesaj]';

  @override
  String get sticker => '[Çıkartma]';

  @override
  String get groupCreated => 'Grup oluşturuldu';

  @override
  String get groupNameChanged => 'Grup adı değiştirildi';

  @override
  String get groupAvatarChanged => 'Grup avatarı değiştirildi';

  @override
  String get groupAnnouncementChanged => 'Grup duyurusu değiştirildi';

  @override
  String get image => '[Resim]';

  @override
  String get video => '[Video]';

  @override
  String get voice => '[Ses]';

  @override
  String get file => '[Dosya]';

  @override
  String get location => '[Konum]';

  @override
  String get unknownMessage => '[Bilinmeyen mesaj]';

  @override
  String joinedGroup(String senderName) {
    return '$senderName gruba katıldı';
  }

  @override
  String leftGroup(String senderName) {
    return '$senderName gruptan ayrıldı';
  }

  @override
  String invitedToGroup(String senderName) {
    return '$senderName davet edildi';
  }

  @override
  String removedFromGroup(String senderName) {
    return '$senderName gruptan çıkarıldı';
  }

  @override
  String get avatarDataEmpty => 'Avatar verisi boş';

  @override
  String get avatarTooLarge => 'Avatar dosyası çok büyük, maksimum 10MB';

  @override
  String get uploadAvatarFailed => 'Avatar yüklenemedi';

  @override
  String get delete => 'Sil';

  @override
  String get notLoggedIn => 'Giriş yapılmadı';

  @override
  String roomNotExist(String roomId) {
    return 'Oda bulunamadı: $roomId';
  }

  @override
  String get uploadImageFailed => 'Resim yüklenemedi';

  @override
  String get matrixClientNotInitialized => 'Matrix istemcisi başlatılmadı';

  @override
  String get uploadVoiceFailed => 'Ses yüklenemedi: MXC URI alınamadı';

  @override
  String get uploadVideoFailed => 'Video yüklenemedi: MXC URI alınamadı';

  @override
  String get uploadFileFailed => 'Dosya yüklenemedi: MXC URI alınamadı';

  @override
  String locationWithCoords(String lat, String lon) {
    return 'Konum: $lat, $lon';
  }

  @override
  String get myLocation => 'Konumum';

  @override
  String get pollEnded => 'Anket sona erdi';

  @override
  String get groupChat => 'Grup Sohbeti';

  @override
  String get search => 'Ara';

  @override
  String get cancel => 'İptal';

  @override
  String get userCancelled => 'Kullanıcı iptal etti';

  @override
  String get noData => 'Veri yok';

  @override
  String get noSearchResults => 'Arama sonucu yok';

  @override
  String get tryDifferentKeyword => 'Farklı bir anahtar kelime deneyin';

  @override
  String get loadFailed => 'Yükleme başarısız';

  @override
  String get checkNetwork => 'Lütfen ağ bağlantınızı kontrol edin';

  @override
  String get networkConnectionFailed => 'Ağ bağlantısı başarısız';

  @override
  String get checkNetworkSettings => 'Lütfen ağ ayarlarınızı kontrol edin';

  @override
  String get messages => 'Mesajlar';

  @override
  String get contacts => 'Kişiler';

  @override
  String get discover => 'Keşfet';

  @override
  String get me => 'Ben';

  @override
  String get voiceLoading => 'Ses yükleniyor, lütfen daha sonra tekrar deneyin';

  @override
  String get voiceToTextFailed => 'Sesten metne dönüştürme başarısız';

  @override
  String get converting => 'Dönüştürülüyor...';

  @override
  String get convertToText => 'Metne çevir';

  @override
  String get convertToTextTitle => 'Metne Dönüştür';

  @override
  String get selectEmoji => 'Emoji seç';

  @override
  String get frequentlyUsed => 'Sık kullanılan';

  @override
  String get copy => 'Kopyala';

  @override
  String get forward => 'İlet';

  @override
  String get unfavorite => 'Favorilerden çıkar';

  @override
  String get favorite => 'Favorilere ekle';

  @override
  String get resend => 'Tekrar gönder';

  @override
  String get recall => 'Geri al';

  @override
  String get multiSelect => 'Çoklu seçim';

  @override
  String get quote => 'Alıntıla';

  @override
  String get remind => 'Hatırlat';

  @override
  String get searchThis => 'Ara';

  @override
  String get recallMessageConfirm => 'Bu mesajı geri almak istiyor musunuz?';

  @override
  String get youRecalledMessage => 'Bir mesajı geri aldınız';

  @override
  String get otherRecalledMessage => 'Mesaj geri alındı';

  @override
  String get reEdit => 'Yeniden düzenle';

  @override
  String get copied => 'Kopyalandı';

  @override
  String get sendMessageHint => 'Mesaj gönder';

  @override
  String get microphonePermissionRequired => 'Lütfen mikrofon iznini verin';

  @override
  String startRecordingFailed(String error) {
    return 'Kayıt başlatılamadı: $error';
  }

  @override
  String get recordingTooShort => 'Kayıt çok kısa';

  @override
  String stopRecordingFailed(String error) {
    return 'Kayıt durdurulamadı: $error';
  }

  @override
  String get releaseToCancel => 'İptal etmek için bırakın';

  @override
  String get releaseToSend =>
      'Göndermek için bırakın, iptal için yukarı kaydırın';

  @override
  String get holdToTalk => 'Konuşmak için basılı tutun';

  @override
  String get send => 'Gönder';

  @override
  String conversationLabel(String roomId) {
    return 'Sohbet: $roomId';
  }

  @override
  String contactLabel(String userId) {
    return 'Kişi: $userId';
  }

  @override
  String get addFriend => 'Arkadaş Ekle';

  @override
  String get chatServiceNotConnected => 'Sohbet servisi bağlı değil';

  @override
  String userNotFoundHint(String query) {
    return '\"$query\" kullanıcısı bulunamadı\n\nİpuçları:\n• Tam kullanıcı ID\'sini girin, örn. @kullaniciadi:sunucu.com\n• Kullanıcı adı yazımını kontrol edin';
  }

  @override
  String createChatFailed(String error) {
    return 'Sohbet oluşturulamadı: $error';
  }

  @override
  String searchFailed(String error) {
    return 'Arama başarısız: $error';
  }

  @override
  String get enterUserIdOrUsername =>
      'Aramak için kullanıcı ID\'si veya adı girin';

  @override
  String get searching => 'Aranıyor...';

  @override
  String get searchUserToChat => 'Sohbet başlatmak için kullanıcı arayın';

  @override
  String get matrixIdExample =>
      'Tam Matrix ID\'si girebilirsiniz\nörn. @kullanici:matrix.n42.network';

  @override
  String userNotFound(String username) {
    return '\"$username\" kullanıcısı bulunamadı';
  }

  @override
  String get chat => 'Sohbet';

  @override
  String get settings => 'Ayarlar';

  @override
  String get editProfile => 'Profili Düzenle';

  @override
  String get login => 'Giriş Yap';

  @override
  String get createGroup => 'Grup Oluştur';

  @override
  String developing(String title) {
    return '$title\n(Yakında)';
  }

  @override
  String get error => 'Hata';

  @override
  String get pageNotFound => 'Sayfa bulunamadı';

  @override
  String get backToHome => 'Ana Sayfaya Dön';

  @override
  String get allRead => 'Tümü okundu';

  @override
  String readCount(int count) {
    return '$count okundu';
  }

  @override
  String get transfer => 'Transfer';

  @override
  String get pendingReceipt => 'Bekliyor';

  @override
  String get tapToReceive => 'Almak için dokunun';

  @override
  String get received => 'Alındı';

  @override
  String get paymentReceived => 'Ödeme alındı';

  @override
  String get refunded => 'İade edildi';

  @override
  String get expired => 'Süresi doldu';

  @override
  String get redPacketGreeting => 'İyi dilekler';

  @override
  String get n42RedPacket => 'N42 Kırmızı Paket';

  @override
  String get goodLuck => 'Şans dile';

  @override
  String get claimed => 'Alındı';

  @override
  String get allClaimed => 'Tamamı alındı';

  @override
  String get emoji => 'Emoji';

  @override
  String get love => 'Aşk';

  @override
  String get animals => 'Hayvanlar';

  @override
  String get food => 'Yiyecek';

  @override
  String get travel => 'Seyahat';

  @override
  String get activities => 'Aktiviteler';

  @override
  String get objects => 'Nesneler';

  @override
  String get symbols => 'Semboller';

  @override
  String get reply => 'Yanıtla';

  @override
  String get copiedToClipboard => 'Panoya kopyalandı';

  @override
  String get edit => 'Düzenle';

  @override
  String get more => 'Daha fazla';

  @override
  String get selectForwardTarget => 'Alıcı seçin';

  @override
  String sendCount(int count) {
    return 'Gönder ($count)';
  }

  @override
  String get draft => '[Taslak] ';

  @override
  String n42Id(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get friendInfo => 'Arkadaş Bilgisi';

  @override
  String get friendInfoDesc =>
      'Arkadaşınıza not, telefon, etiket ekleyin ve izinleri ayarlayın.';

  @override
  String get moments => 'Anlar';

  @override
  String get sendMessage => 'Mesaj';

  @override
  String get audioVideoCall => 'Sesli/Görüntülü Arama';

  @override
  String get videoChannel => 'Video Kanalı';

  @override
  String get remark => 'Not';

  @override
  String get remarkName => 'Takma Ad';

  @override
  String get phone => 'Telefon';

  @override
  String get tags => 'Etiketler';

  @override
  String get notes => 'Notlar';

  @override
  String get photos => 'Fotoğraflar';

  @override
  String get permissions => 'İzinler';

  @override
  String get chatMomentsEtc => 'Sohbet, Anlar, Spor, vb.';

  @override
  String get moreInfo => 'Daha Fazla Bilgi';

  @override
  String get commonGroups => 'Ortak Gruplar';

  @override
  String get zeroGroups => '0';

  @override
  String get source => 'Kaynak';

  @override
  String get notificationSettings => 'Bildirimler';

  @override
  String get receiveNotifications => 'Yeni mesaj bildirimleri al';

  @override
  String get showPreview => 'Mesaj önizlemesi göster';

  @override
  String get showContentInNotification =>
      'Bildirimlerde mesaj içeriğini göster';

  @override
  String get notificationSound => 'Bildirim sesi';

  @override
  String get playSoundOnMessage => 'Mesaj alındığında ses çal';

  @override
  String get vibrate => 'Titreşim';

  @override
  String get vibrateOnMessage => 'Mesaj alındığında titret';

  @override
  String get doNotDisturb => 'Rahatsız Etmeyin';

  @override
  String get dndDescription => 'Belirli saatlerde bildirimleri sessize al';

  @override
  String get startTime => 'Başlangıç saati';

  @override
  String get endTime => 'Bitiş saati';

  @override
  String get privacy => 'Gizlilik';

  @override
  String get appearance => 'Görünüm';

  @override
  String get about => 'Hakkında';

  @override
  String get logout => 'Çıkış Yap';

  @override
  String get logoutConfirm => 'Çıkış yapmak istediğinizden emin misiniz?';

  @override
  String get exit => 'Çıkış Yap';

  @override
  String get save => 'Kaydet';

  @override
  String get nickname => 'Takma Ad';

  @override
  String get enterNickname => 'Takma ad girin';

  @override
  String get signature => 'İmza';

  @override
  String get addSignature => 'İmza ekle';

  @override
  String get takePhoto => 'Fotoğraf Çek';

  @override
  String get chooseFromGallery => 'Galeriden Seç';

  @override
  String saveFailed(String error) {
    return 'Kaydetme başarısız: $error';
  }

  @override
  String get secureDecentralizedChat => 'Güvenli, merkezi olmayan mesajlaşma';

  @override
  String get endToEndEncryption => 'Uçtan uca şifreleme';

  @override
  String get messagesOnlyYouCanSee =>
      'Mesajlar sadece siz ve alıcı tarafından görülebilir';

  @override
  String get decentralized => 'Merkezi Olmayan';

  @override
  String get basedOnMatrix => 'Matrix açık protokolü üzerine kurulu';

  @override
  String get walletIntegration => 'Cüzdan Entegrasyonu';

  @override
  String get easyCryptoTransfer => 'Kolay kripto para transferi';

  @override
  String get register => 'Kayıt Ol';

  @override
  String get agreeTerms => 'Giriş yaparak kabul etmiş olursunuz';

  @override
  String get termsOfService => 'Hizmet Şartları';

  @override
  String get and => 've';

  @override
  String get privacyPolicy => 'Gizlilik Politikası';

  @override
  String get serverAddress => 'Sunucu Adresi';

  @override
  String get enterServerAddress => 'Sunucu adresi girin';

  @override
  String get validServerAddress => 'Lütfen geçerli bir sunucu adresi girin';

  @override
  String connectedTo(String serverName) {
    return '$serverName sunucusuna bağlandı';
  }

  @override
  String get username => 'Kullanıcı Adı';

  @override
  String get enterUsername => 'Kullanıcı adı girin';

  @override
  String get password => 'Şifre';

  @override
  String get enterPassword => 'Şifre girin';

  @override
  String get registerAccount => 'Kayıt Ol';

  @override
  String get forgotPassword => 'Şifremi Unuttum';

  @override
  String get otherLoginMethods => 'Diğer giriş yöntemleri';

  @override
  String get emailVerification => 'E-posta doğrulama kodu';

  @override
  String get enterServerFirst => 'Lütfen önce sunucu adresini girin';

  @override
  String get passkeyNeedsServer => 'Passkey girişi sunucu desteği gerektirir';

  @override
  String googleLoginSuccess(String email) {
    return 'Google giriş başarılı: $email';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Google giriş başarısız: $error';
  }

  @override
  String get appleLoginSuccess => 'Apple giriş başarılı';

  @override
  String appleLoginFailed(String error) {
    return 'Apple giriş başarısız: $error';
  }

  @override
  String get createAccount => 'Hesap Oluştur';

  @override
  String get joinN42Chat => 'Sohbete başlamak için N42 Chat\'e katılın';

  @override
  String get usernameHint => '3-20 karakter, harf/rakam/_';

  @override
  String get usernameMinLength => 'Kullanıcı adı en az 3 karakter olmalıdır';

  @override
  String get usernameMaxLength =>
      'Kullanıcı adı en fazla 20 karakter olmalıdır';

  @override
  String get usernameFormat =>
      'Kullanıcı adı sadece harf, rakam ve alt çizgi içerebilir';

  @override
  String get passwordHint => 'En az 8 karakter';

  @override
  String get passwordMinLength => 'Şifre en az 8 karakter olmalıdır';

  @override
  String get confirmPassword => 'Şifreyi Onayla';

  @override
  String get reEnterPassword => 'Şifreyi tekrar girin';

  @override
  String get passwordsNotMatch => 'Şifreler eşleşmiyor';

  @override
  String get inviteCode => 'Davet kodu (yerleşik)';

  @override
  String get filled => 'Dolduruldu';

  @override
  String get enterInviteCode => 'Davet kodu girin';

  @override
  String get inviteCodeHint =>
      'Davet kodu yerleşiktir, genellikle değiştirmeye gerek yoktur';

  @override
  String get agreeTermsFirst =>
      'Lütfen önce şartları ve gizlilik politikasını okuyun ve kabul edin';

  @override
  String get iAgree => 'Okudum ve kabul ediyorum';

  @override
  String get alreadyHaveAccount => 'Zaten hesabınız var mı?';

  @override
  String get loginNow => 'Hemen giriş yapın';

  @override
  String get whoCanSee => 'Kimler görebilir';

  @override
  String get avatar => 'Avatar';

  @override
  String get status => 'Durum';

  @override
  String get lastSeen => 'Son görülme';

  @override
  String get messageSettings => 'Mesajlar';

  @override
  String get allowStrangerMessage => 'Yabancılardan mesaj kabul et';

  @override
  String get receiveNonContact => 'Kişi listesinde olmayanlardan mesaj al';

  @override
  String get readReceipts => 'Okundu bilgisi';

  @override
  String get letOthersKnowRead =>
      'Başkalarının mesajlarınızı okuduğunuzu bilmesine izin ver';

  @override
  String get typingStatus => 'Yazma durumu';

  @override
  String get letOthersKnowTyping =>
      'Başkalarının yazdığınızı bilmesine izin ver';

  @override
  String get everyone => 'Herkes';

  @override
  String get contactsOnly => 'Sadece kişiler';

  @override
  String get nobody => 'Hiç kimse';

  @override
  String whoCanSeeItem(String title) {
    return '$title kimler görebilir';
  }

  @override
  String version(String version) {
    return 'Sürüm $version';
  }

  @override
  String get checkUpdate => 'Güncellemeleri kontrol et';

  @override
  String get openSourceLicenses => 'Açık kaynak lisansları';

  @override
  String get feedback => 'Geri Bildirim';

  @override
  String get builtOnMatrix => 'Matrix protokolü üzerine kurulu';

  @override
  String get loading => 'Yükleniyor...';

  @override
  String get noConversations => 'Sohbet yok';

  @override
  String get tapToChat => 'Sohbet başlatmak için sağ üste dokunun';

  @override
  String get startGroup => 'Grup Sohbeti Başlat';

  @override
  String get scan => 'Tara';

  @override
  String get payment => 'Ödeme';

  @override
  String featureComingSoon(String feature) {
    return '$feature yakında';
  }

  @override
  String get markAsRead => 'Okundu olarak işaretle';

  @override
  String get unmute => 'Sesi aç';

  @override
  String get mute => 'Sessize al';

  @override
  String get unpin => 'Sabitlemeyi kaldır';

  @override
  String get pin => 'Sabitle';

  @override
  String get deleteConversation => 'Sohbeti Sil';

  @override
  String deleteConversationConfirm(String name) {
    return '\"$name\" ile sohbeti silmek istiyor musunuz?';
  }

  @override
  String get noContacts => 'Kişi yok';

  @override
  String get addFriendsToChat => 'Sohbete başlamak için arkadaş ekleyin';

  @override
  String get contactNotFound => 'Kişi bulunamadı';

  @override
  String get tryOtherKeywords =>
      'Başka anahtar kelimeler veya genel arama deneyin';

  @override
  String get searchResults => 'Arama sonuçları';

  @override
  String get newFriends => 'Yeni Arkadaşlar';

  @override
  String get chatOnlyFriends => 'Sadece sohbet arkadaşları';

  @override
  String get officialAccounts => 'Resmi Hesaplar';

  @override
  String get serviceAccounts => 'Hizmet Hesapları';

  @override
  String get enterpriseContacts => 'Kurumsal Kişiler';

  @override
  String contactsCount(int count) {
    return '$count kişi';
  }

  @override
  String get recommendToFriend => 'Kişiyi paylaş';

  @override
  String get setRemark => 'Not ekle';

  @override
  String get addToHome => 'Ana ekrana ekle';

  @override
  String get sendingCard => 'Kişi kartı gönderiliyor...';

  @override
  String get contactCard => '[Kişi Kartı]';

  @override
  String cardSent(String contact, String friend) {
    return '$contact kartı $friend kişisine gönderildi';
  }

  @override
  String recommendFailed(String error) {
    return 'Öneri başarısız: $error';
  }

  @override
  String get enterRemark => 'Not girin';

  @override
  String remarkSet(String remark) {
    return 'Not ayarlandı: $remark';
  }

  @override
  String get openingChat => 'Sohbet açılıyor...';

  @override
  String openChatFailed(String error) {
    return 'Sohbet açılamadı: $error';
  }

  @override
  String get addContact => 'Kişi Ekle';

  @override
  String get enterUserId => 'Kullanıcı ID\'si girin';

  @override
  String get noFriendRequests => 'Arkadaşlık isteği yok';

  @override
  String get accept => 'Kabul Et';

  @override
  String get reject => 'Reddet';

  @override
  String acceptedRequest(String name) {
    return '$name arkadaşlık isteği kabul edildi';
  }

  @override
  String rejectedRequest(String name) {
    return '$name arkadaşlık isteği reddedildi';
  }

  @override
  String get noGroups => 'Grup yok';

  @override
  String get creatingGroup => 'Grup oluşturma yakında...';

  @override
  String get selectFriendToRecommend => 'Önermek için arkadaş seçin';

  @override
  String get searchContacts => 'Kişilerde ara';

  @override
  String get noContactsFound => 'Kişi bulunamadı';

  @override
  String get yesterday => 'Dün';

  @override
  String get monday => 'Pzt';

  @override
  String get tuesday => 'Sal';

  @override
  String get wednesday => 'Çar';

  @override
  String get thursday => 'Per';

  @override
  String get friday => 'Cum';

  @override
  String get saturday => 'Cmt';

  @override
  String get sunday => 'Paz';

  @override
  String get justNow => 'Az önce';

  @override
  String minutesAgo(int count) {
    return '$count dk önce';
  }

  @override
  String hoursAgo(int count) {
    return '${count}s önce';
  }

  @override
  String daysAgo(int count) {
    return '${count}g önce';
  }

  @override
  String get online => 'Çevrimiçi';

  @override
  String get offline => 'Çevrimdışı';

  @override
  String minutesAgoOnline(int count) {
    return '$count dk önce çevrimiçi';
  }

  @override
  String hoursAgoOnline(int count) {
    return '${count}s önce çevrimiçi';
  }

  @override
  String daysAgoOnline(int count) {
    return '${count}g önce çevrimiçi';
  }

  @override
  String get searchContactsGroupsMessages => 'Kişi, grup ve mesajlarda ara';

  @override
  String get searchError => 'Arama hatası';

  @override
  String get searchHint => 'Kişi, grup ve mesajlarda ara';

  @override
  String get enterKeyword => 'Aramak için anahtar kelime girin';

  @override
  String get searchHistory => 'Arama Geçmişi';

  @override
  String get clear => 'Temizle';

  @override
  String noResultsFor(String query) {
    return '\"$query\" için sonuç yok';
  }

  @override
  String get all => 'Tümü';

  @override
  String get groups => 'Gruplar';

  @override
  String get noResults => 'Sonuç yok';

  @override
  String get groupInfo => 'Grup Bilgisi';

  @override
  String groupMembers(int count) {
    return 'Üyeler ($count)';
  }

  @override
  String get viewAll => 'Tümünü gör';

  @override
  String get owner => 'Sahip';

  @override
  String get admin => 'Yönetici';

  @override
  String get invite => 'Davet Et';

  @override
  String get groupAnnouncement => 'Grup Duyurusu';

  @override
  String get notSet => 'Ayarlanmadı';

  @override
  String get groupDescription => 'Grup Açıklaması';

  @override
  String get publicGroup => 'Herkese Açık Grup';

  @override
  String get allowSearchJoin => 'Başkalarının arayıp katılmasına izin ver';

  @override
  String get clearChatHistory => 'Sohbet Geçmişini Temizle';

  @override
  String get dissolveGroup => 'Grubu Dağıt';

  @override
  String get leaveGroup => 'Gruptan Ayrıl';

  @override
  String get changeGroupName => 'Grup Adını Değiştir';

  @override
  String get enterGroupName => 'Grup adı girin';

  @override
  String get confirm => 'Onayla';

  @override
  String get changeGroupDescription => 'Grup Açıklamasını Değiştir';

  @override
  String get enterGroupDescription => 'Grup açıklaması girin';

  @override
  String get editAnnouncement => 'Duyuruyu Düzenle';

  @override
  String get enterAnnouncement => 'Duyuru girin';

  @override
  String get publish => 'Yayınla';

  @override
  String get clearHistoryConfirm =>
      'Tüm sohbet geçmişini temizle? Bu işlem geri alınamaz.';

  @override
  String get clearAction => 'Temizle';

  @override
  String get chatHistoryCleared => 'Sohbet geçmişi temizlendi';

  @override
  String leaveGroupConfirm(String name) {
    return '\"$name\" grubundan ayrılmak istiyor musunuz?';
  }

  @override
  String dissolveGroupConfirm(String name) {
    return '\"$name\" grubunu dağıtmak istiyor musunuz? Bu işlem geri alınamaz.';
  }

  @override
  String get dissolve => 'Dağıt';

  @override
  String get groupQrCode => 'Grup QR Kodu';

  @override
  String get searchChatHistory => 'Sohbet Geçmişinde Ara';

  @override
  String get groupIdCopied => 'Grup ID\'si kopyalandı';

  @override
  String tapCopyGroupId(int count) {
    return '$count üye · Grup ID\'sini kopyalamak için dokunun';
  }

  @override
  String featureInDevelopment(Object feature) {
    return 'Özellik geliştirme aşamasında...';
  }

  @override
  String get receiverAddress => 'Alıcı Adresi';

  @override
  String get enterOrPasteAddress => 'Cüzdan adresini girin veya yapıştırın';

  @override
  String get selectToken => 'Token Seç';

  @override
  String get transferAmount => 'Transfer Tutarı';

  @override
  String get available => 'Kullanılabilir';

  @override
  String get allAmount => 'Tümü';

  @override
  String get memoOptional => 'Not (isteğe bağlı)';

  @override
  String get addMemo => 'Not ekle';

  @override
  String get confirmTransfer => 'Transferi Onayla';

  @override
  String get invalidAddress => 'Lütfen geçerli bir alıcı adresi girin';

  @override
  String get invalidAmount => 'Lütfen geçerli bir tutar girin';

  @override
  String get selectTokenPlease => 'Lütfen bir token seçin';

  @override
  String get addressVerified => 'Adres doğrulandı';

  @override
  String availableBalance(String balance, String symbol) {
    return 'Kullanılabilir: $balance $symbol';
  }

  @override
  String get scanningInDevelopment =>
      'Tarama özelliği geliştirme aşamasında...';

  @override
  String get enterAmount => 'Tutar girin';

  @override
  String get redPacketCountMin => 'En az 1 kırmızı paket gerekli';

  @override
  String get viewRedPacketDetails => 'Kırmızı paket detaylarını gör';

  @override
  String get enterTransferAmount => 'Transfer tutarını girin';

  @override
  String get transferTo => 'Transfer hedefi';

  @override
  String get selectCurrency => 'Para birimi seç';

  @override
  String get receiveTransfer => 'Transfer alındı';

  @override
  String fromSender(String name, Object senderName) {
    return '$senderName tarafından';
  }

  @override
  String get confirmReceive => 'Alımı Onayla';

  @override
  String get groupProfile => 'Grup Bilgisi';

  @override
  String get viewProfile => 'Profili Gör';

  @override
  String get removeMember => 'Gruptan Çıkar';

  @override
  String removeMemberConfirm(String name) {
    return '\"$name\" kişisini gruptan çıkarmak istiyor musunuz?';
  }

  @override
  String get remove => 'Çıkar';

  @override
  String get clearStatus => 'Durumu Temizle';

  @override
  String get clearStatusConfirm => 'Mevcut durumu temizle?';

  @override
  String get statusCleared => 'Durum temizlendi';

  @override
  String statusSet(String result) {
    return 'Durum ayarlandı: $result';
  }

  @override
  String get userNotExist => 'Kullanıcı mevcut değil';

  @override
  String get userIdCopied => 'Kullanıcı ID\'si kopyalandı';

  @override
  String get voiceCallInDevelopment => 'Sesli arama geliştirme aşamasında...';

  @override
  String get report => 'Şikayet Et';

  @override
  String get reportInDevelopment => 'Şikayet özelliği geliştirme aşamasında...';

  @override
  String get shareCard => 'Kartı Paylaş';

  @override
  String get shareInDevelopment => 'Paylaşım özelliği geliştirme aşamasında...';

  @override
  String get qrCode => 'QR Kod';

  @override
  String get qrCodeInDevelopment => 'QR kod özelliği geliştirme aşamasında...';

  @override
  String get avatarUpdated => 'Avatar güncellendi';

  @override
  String selectImageFailed(String error) {
    return 'Resim seçilemedi: $error';
  }

  @override
  String get changeName => 'Adı Değiştir';

  @override
  String get male => 'Erkek';

  @override
  String get female => 'Kadın';

  @override
  String genderSet(String gender) {
    return 'Cinsiyet ayarlandı: $gender';
  }

  @override
  String regionSet(String region) {
    return 'Bölge ayarlandı: $region';
  }

  @override
  String get setPatText => 'Dürtme Metnini Ayarla';

  @override
  String get changeSignature => 'İmzayı Değiştir';

  @override
  String ringtoneSet(String result) {
    return 'Zil sesi ayarlandı: $result';
  }

  @override
  String featureInDev(String feature) {
    return '$feature geliştirme aşamasında...';
  }

  @override
  String saveAddressFailed(String error) {
    return 'Adres kaydedilemedi: $error';
  }

  @override
  String get myAddress => 'Adreslerim';

  @override
  String get addNew => 'Ekle';

  @override
  String get addAddress => 'Adres Ekle';

  @override
  String get addressAdded => 'Adres eklendi';

  @override
  String get addressUpdated => 'Adres güncellendi';

  @override
  String get deleteAddress => 'Adresi Sil';

  @override
  String get deleteAddressConfirm => 'Bu adresi silmek istiyor musunuz?';

  @override
  String get addressDeleted => 'Adres silindi';

  @override
  String get setDefaultAddress => 'Varsayılan olarak ayarla';

  @override
  String get fillCompleteInfo => 'Lütfen tüm alanları doldurun';

  @override
  String saveInvoiceFailed(String error) {
    return 'Fatura kaydedilemedi: $error';
  }

  @override
  String get myInvoices => 'Faturalarım';

  @override
  String get addInvoice => 'Fatura Ekle';

  @override
  String get invoiceAdded => 'Fatura eklendi';

  @override
  String get invoiceUpdated => 'Fatura güncellendi';

  @override
  String get deleteInvoice => 'Faturayı Sil';

  @override
  String get deleteInvoiceConfirm => 'Bu faturayı silmek istiyor musunuz?';

  @override
  String get invoiceDeleted => 'Fatura silindi';

  @override
  String get invoiceType => 'Fatura türü: ';

  @override
  String get personal => 'Bireysel';

  @override
  String get enterprise => 'Kurumsal';

  @override
  String get setDefaultInvoice => 'Varsayılan olarak ayarla';

  @override
  String get enterTaxId => 'Vergi numarası girin';

  @override
  String get vibrateMode => 'Titreşim modu';

  @override
  String get silentMode => 'Sessiz mod';

  @override
  String playing(String ringtoneName) {
    return 'Çalıyor: $ringtoneName';
  }

  @override
  String playFailed(String ringtoneName) {
    return 'Çalınamadı: $ringtoneName';
  }

  @override
  String get enterGroupNamePlease => 'Lütfen grup adı girin';

  @override
  String get selectAtLeastOne => 'Lütfen en az bir üye seçin';

  @override
  String get fillStatus => 'Durum Yaz';

  @override
  String get fileNotExist => 'Dosya mevcut değil';

  @override
  String sendFailed(String error) {
    return 'Gönderme başarısız: $error';
  }

  @override
  String get cannotOpenBrowser => 'Tarayıcı açılamadı';

  @override
  String selectFileFailed(String error) {
    return 'Dosya seçilemedi: $error';
  }

  @override
  String get enterMusicLink => 'Müzik bağlantısı girin';

  @override
  String get enterValidLink => 'Lütfen geçerli bir bağlantı girin';

  @override
  String get enterPollQuestion => 'Anket sorusu girin';

  @override
  String get minTwoOptions => 'En az 2 seçenek gerekli';

  @override
  String get crossDeviceEnabled => 'Cihazlar arası imza etkin';

  @override
  String get crossDeviceSet => 'Cihazlar arası imza başarıyla ayarlandı';

  @override
  String setupFailed(String error) {
    return 'Kurulum başarısız: $error';
  }

  @override
  String get receiveAmount => 'Alınacak Tutar';

  @override
  String get enterValidAmount => 'Lütfen geçerli bir tutar girin';

  @override
  String get addressCopied => 'Adres kopyalandı';

  @override
  String openItem(String content) {
    return 'Aç: $content';
  }

  @override
  String get newNoteComingSoon => 'Yeni not özelliği yakında';

  @override
  String get addLinkComingSoon => 'Bağlantı ekleme özelliği yakında';

  @override
  String get deleted => 'Silindi';

  @override
  String get shareComingSoon => 'Paylaşım özelliği yakında';

  @override
  String get saveComingSoon => 'Kaydetme özelliği yakında';

  @override
  String get moreStylesComingSoon => 'Daha fazla stil yakında';

  @override
  String get wallet => 'Cüzdan';

  @override
  String get walletArea => 'Cüzdan alanı';

  @override
  String get recording => 'Kayıt';

  @override
  String get invalidVideoUrl => 'Geçersiz video URL\'si';

  @override
  String get downloadFile => 'Dosyayı indir';

  @override
  String get clearChatHistoryTitle => 'Sohbet Geçmişini Temizle';

  @override
  String get cannotUndo => 'Bu işlem geri alınamaz';

  @override
  String get videoCall => 'Görüntülü Arama';

  @override
  String get voiceCall => 'Sesli Arama';

  @override
  String get leaveMeeting => 'Toplantıdan Ayrıl';

  @override
  String get chatDetails => 'Sohbet Detayları';

  @override
  String get viewAllGroupMembers => 'Tüm üyeleri gör';

  @override
  String get groupName => 'Grup Adı';

  @override
  String get groupNameUpdated => 'Grup adı güncellendi';

  @override
  String get updateFailed => 'Güncelleme başarısız';

  @override
  String get noPermissionToModify => 'Değiştirme izniniz yok';

  @override
  String get groupManagement => 'Grup Yönetimi';

  @override
  String get myNicknameInGroup => 'Gruptaki Takma Adım';

  @override
  String get pinChat => 'Sohbeti Sabitle';

  @override
  String get strongReminder => 'Güçlü Hatırlatıcı';

  @override
  String get setChatBackground => 'Sohbet Arka Planını Ayarla';

  @override
  String get unknownFile => 'Bilinmeyen dosya';

  @override
  String get download => 'İndir';

  @override
  String get invalidLocation => 'Geçersiz konum';

  @override
  String get address => 'Adres';

  @override
  String get latitude => 'Enlem';

  @override
  String get longitude => 'Boylam';

  @override
  String get close => 'Kapat';

  @override
  String get tapToCancel => 'İptal etmek için dokunun';

  @override
  String captureFailed(Object error) {
    return 'Yakalama başarısız: $error';
  }

  @override
  String get processingVideo => 'Video işleniyor...';

  @override
  String get videoFileNotExist => 'Video dosyası mevcut değil';

  @override
  String get videoDataEmpty => 'Video verisi boş';

  @override
  String get videoTooLarge => 'Video boyutu 100MB\'ı geçemez';

  @override
  String get sendingVideo => 'Video gönderiliyor...';

  @override
  String sendVideoFailed(Object error) {
    return 'Video gönderilemedi: $error';
  }

  @override
  String get imageFileNotExist => 'Resim dosyası mevcut değil';

  @override
  String get imageDataEmpty => 'Resim verisi boş';

  @override
  String get sendingImage => 'Resim gönderiliyor...';

  @override
  String sendImageFailed(Object error) {
    return 'Resim gönderilemedi: $error';
  }

  @override
  String get sendLocation => 'Konum Gönder';

  @override
  String get selectLocationAndSend => 'Konum seçin ve gönderin';

  @override
  String get shareRealTimeLocation => 'Gerçek Zamanlı Konum Paylaş';

  @override
  String get shareLocationForOneHour =>
      'Arkadaşınızla 1 saat gerçek zamanlı konum paylaşın';

  @override
  String get locationSent => 'Konum gönderildi';

  @override
  String get selectMessages => 'Mesaj seç';

  @override
  String selectedCount(int count) {
    return '$count seçildi';
  }

  @override
  String get selectAll => 'Tümünü Seç';

  @override
  String groupChatCount(int count) {
    return 'Grup Sohbeti ($count)';
  }

  @override
  String get privateChat => 'Özel Sohbet';

  @override
  String get noMessages => 'Mesaj yok';

  @override
  String get sendFirstMessage => 'Sohbeti başlatmak için ilk mesajı gönderin';

  @override
  String get encryptionNotice =>
      'Bu sohbet uçtan uca şifrelenmiştir. Mesajları sadece siz ve alıcı okuyabilir.';

  @override
  String replyTo(String name) {
    return '$name adlı kişiye yanıt';
  }

  @override
  String get multiForward => 'İlet';

  @override
  String get collect => 'Kaydet';

  @override
  String get noMembers => 'Üye yok';

  @override
  String get memberNotFound => 'Üye bulunamadı';

  @override
  String get voiceFileNotExist => 'Ses dosyası mevcut değil';

  @override
  String get voiceFileEmpty => 'Ses dosyası boş';

  @override
  String get sendingVoice => 'Ses gönderiliyor...';

  @override
  String sendVoiceFailed(Object error) {
    return 'Ses gönderilemedi: $error';
  }

  @override
  String get messageCopied => 'Mesaj kopyalandı';

  @override
  String get messageForwarded => 'Mesaj iletildi';

  @override
  String forwardFailed(Object error) {
    return 'İletme başarısız: $error';
  }

  @override
  String get unfavorited => 'Favorilerden çıkarıldı';

  @override
  String get favorited => 'Favorilere eklendi';

  @override
  String get reactionAdded => 'Tepki eklendi';

  @override
  String get failedMessageDeleted => 'Başarısız mesaj silindi';

  @override
  String get deleteMessages => 'Mesajları sil';

  @override
  String deleteMessagesConfirm(Object count) {
    return '$count mesajı silmek istediğinizden emin misiniz?';
  }

  @override
  String noteOtherMessages(Object count) {
    return 'Not: $count mesaj başkalarına ait, sadece yerel olarak silinebilir.';
  }

  @override
  String myMessagesWillBeRecalled(Object count) {
    return 'Sizden $count mesaj geri alınacak.';
  }

  @override
  String recalledCount(Object count, Object localCount) {
    return '$count mesaj geri alındı, $localCount yerel olarak silindi';
  }

  @override
  String recalledMessages(Object count) {
    return '$count mesaj geri alındı';
  }

  @override
  String deletedLocally(Object count) {
    return '$count mesaj silindi (yerel)';
  }

  @override
  String forwardedCount(Object count) {
    return '$count mesaj iletildi';
  }

  @override
  String forwardComplete(Object failed, Object success) {
    return 'İletme tamamlandı: $success başarılı, $failed başarısız';
  }

  @override
  String get remindOnlyInGroup =>
      'Hatırlatma özelliği sadece grup sohbetlerinde kullanılabilir';

  @override
  String get onlyTextSearchable => 'Sadece metin mesajları aranabilir';

  @override
  String searchFor(Object text) {
    return '\"$text\" ara';
  }

  @override
  String get baiduSearch => 'Baidu Arama';

  @override
  String get googleSearch => 'Google Arama';

  @override
  String get bingSearch => 'Bing Arama';

  @override
  String get calling => 'Aranıyor...';

  @override
  String get connecting => 'Bağlanıyor...';

  @override
  String get ringing => 'Çalıyor...';

  @override
  String get inCall => 'Aramada';

  @override
  String collectMessages(Object count) {
    return '$count mesaj kaydedildi';
  }

  @override
  String get voted => 'Oy verildi';

  @override
  String get voteChanged => 'Oy değiştirildi';

  @override
  String get voteRemoved => 'Oy kaldırıldı';

  @override
  String get endPoll => 'Anketi Bitir';

  @override
  String get endPollConfirm =>
      'Bu anketi bitirmek istediğinizden emin misiniz? Bitirdikten sonra oy verilemez.';

  @override
  String memberCount(int count) {
    return '$count üye';
  }

  @override
  String get videoChannels => 'Kanallar';

  @override
  String get live => 'Canlı';

  @override
  String get listen => 'Dinle';

  @override
  String get watch => 'İzle';

  @override
  String get searchDiscover => 'Ara';

  @override
  String get nearbyPeople => 'Yakındakiler';

  @override
  String get games => 'Oyunlar';

  @override
  String get miniPrograms => 'Mini Programlar';

  @override
  String done(int count) {
    return 'Tamamlandı($count)';
  }

  @override
  String get services => 'Hizmetler';

  @override
  String get favorites => 'Favoriler';

  @override
  String get ordersAndCards => 'Siparişler ve Kartlar';

  @override
  String get stickers => 'Çıkartmalar';

  @override
  String statusSetTo(String status) {
    return 'Durum ayarlandı: $status';
  }

  @override
  String get avatarUploadFailed => 'Avatar yüklemesi başarısız';

  @override
  String get personalProfile => 'Kişisel Profil';

  @override
  String get name => 'Ad';

  @override
  String get gender => 'Cinsiyet';

  @override
  String get region => 'Bölge';

  @override
  String get myQrCode => 'QR Kodum';

  @override
  String get poke => 'Dürt';

  @override
  String get ringtone => 'Zil Sesi';

  @override
  String get defaultRingtone => 'Varsayılan Zil Sesi';

  @override
  String get myAddresses => 'Adreslerim';

  @override
  String genderSetTo(String gender) {
    return 'Cinsiyet ayarlandı: $gender';
  }

  @override
  String get selectRegion => 'Bölge Seç';

  @override
  String get selectCity => 'Şehir Seç';

  @override
  String regionSetTo(String region) {
    return 'Bölge ayarlandı: $region';
  }

  @override
  String get setPoke => 'Dürtmeyi Ayarla';

  @override
  String get friendPokedMe => 'Arkadaş beni dürttü';

  @override
  String get enterPokeSuffix => 'Dürtme soneki girin, örn: omuzdan';

  @override
  String get example => 'Örnek';

  @override
  String get onTheShoulder => ' omuzdan';

  @override
  String get pokeCleared => 'Dürtme temizlendi';

  @override
  String pokeSetTo(String suffix) {
    return 'Dürtme ayarlandı: beni dürttü$suffix';
  }

  @override
  String get editSignature => 'İmzayı Düzenle';

  @override
  String get introduceYourself => 'Kendinizi tanıtacak bir cümle';

  @override
  String get signatureCleared => 'İmza temizlendi';

  @override
  String get signatureUpdated => 'İmza güncellendi';

  @override
  String get scanToAddFriend =>
      'Beni arkadaş olarak eklemek için yukarıdaki QR kodu tarayın';

  @override
  String ringtoneSetTo(String ringtone) {
    return 'Zil sesi ayarlandı: $ringtone';
  }

  @override
  String get confirmDissolveGroup =>
      'Bu grubu dağıtmak istediğinizden emin misiniz';

  @override
  String get enterValidServerAddress =>
      'Lütfen geçerli bir sunucu adresi girin';

  @override
  String get emailOtp => 'E-posta OTP';

  @override
  String get enterServerAddressFirst => 'Lütfen önce sunucu adresi girin';

  @override
  String get passkeyRequiresServer =>
      'Passkey girişi sunucu desteği gerektirir';

  @override
  String get loginAgreement => 'Giriş yaparak kabul etmiş olursunuz ';

  @override
  String get pleaseAgreeToTerms =>
      'Lütfen Hizmet Şartları ve Gizlilik Politikasını okuyun ve kabul edin';

  @override
  String get registerFailed => 'Kayıt başarısız';

  @override
  String get reenterPassword => 'Şifreyi tekrar girin';

  @override
  String get passwordsDoNotMatch => 'Şifreler eşleşmiyor';

  @override
  String get inviteCodeBuiltIn => 'Davet Kodu (Yerleşik)';

  @override
  String get inviteCodeBuiltInNote =>
      'Davet kodu yerleşiktir, genellikle değiştirmeye gerek yoktur';

  @override
  String get iHaveReadAndAgree => 'Okudum ve kabul ediyorum ';

  @override
  String get startGroupChat => 'Grup Sohbeti Başlat';

  @override
  String get addFriends => 'Arkadaş Ekle';

  @override
  String get paymentAndCollection => 'Ödeme';

  @override
  String messagesWithCount(int count) {
    return 'Mesajlar($count)';
  }

  @override
  String contactCount(int count) {
    return '$count kişi';
  }

  @override
  String get addToHomeScreen => 'Ana ekrana ekle';

  @override
  String recommendedCardTo(String contact, String recipient) {
    return '$contact kartı $recipient kişisine önerildi';
  }

  @override
  String get enterRemarkName => 'Takma ad girin';

  @override
  String remarkSetTo(String remark) {
    return 'Not ayarlandı: $remark';
  }

  @override
  String acceptedFriendRequest(String name) {
    return '$name arkadaşlık isteği kabul edildi';
  }

  @override
  String rejectedFriendRequest(String name) {
    return '$name arkadaşlık isteği reddedildi';
  }

  @override
  String get groupInvites => 'Grup Davetleri';

  @override
  String get myGroups => 'Gruplarım';

  @override
  String get invitedToJoinGroup => 'Gruba davet edildi';

  @override
  String get confirmLeaveGroup =>
      'Bu gruptan ayrılmak istediğinizden emin misiniz';

  @override
  String get leave => 'Ayrıl';

  @override
  String get saveMedia => 'Kaydet';

  @override
  String get recallThisMessage => 'Bu mesajı geri al?';

  @override
  String get messageRecalled => 'Mesaj geri alındı';

  @override
  String get savedToGallery => 'Galeriye kaydedildi';

  @override
  String get failedToSave => 'Kaydetme başarısız';

  @override
  String get saving => 'Kaydediliyor...';

  @override
  String get share => 'Paylaş';

  @override
  String get saveToGallery => 'Galeriye Kaydet';

  @override
  String get downloadFailed => 'İndirme başarısız';

  @override
  String get noMediaUrl => 'Medya URL\'si mevcut değil';

  @override
  String get shareFailed => 'Paylaşım başarısız';

  @override
  String get failedToLoadImage => 'Resim yüklenemedi';

  @override
  String get failedToLoadMoreMessages => 'Daha fazla mesaj yüklenemedi';

  @override
  String get failedToSend => 'Gönderme başarısız';

  @override
  String get failedToSendImage => 'Resim gönderilemedi';

  @override
  String get failedToSendVoice => 'Ses gönderilemedi';

  @override
  String get failedToSendFile => 'Dosya gönderilemedi';

  @override
  String get failedToSendVideo => 'Video gönderilemedi';

  @override
  String get failedToSendLocation => 'Konum gönderilemedi';

  @override
  String get failedToResend => 'Tekrar gönderme başarısız';

  @override
  String get failedToRecall => 'Geri alma başarısız';

  @override
  String get failedToReply => 'Yanıtlama başarısız';

  @override
  String get failedToAddReaction => 'Tepki ekleme başarısız';

  @override
  String get failedToSendPoll => 'Anket gönderilemedi';

  @override
  String get failedToVote => 'Oy verme başarısız';

  @override
  String get failedToLoadMessages => 'Mesajlar yüklenemedi';

  @override
  String get callFeatureComingSoon =>
      'Sesli ve görüntülü arama özelliği yakında';

  @override
  String get cannotForwardRedPacketOrTransfer =>
      'Kırmızı paketler ve transferler iletilemez';

  @override
  String get videoRecordingFailed =>
      'Video kaydı başarısız. Lütfen tekrar deneyin.';

  @override
  String get redPacket => 'Kırmızı Paket';

  @override
  String get music => 'Müzik';

  @override
  String get coupon => 'Kupon';

  @override
  String get gift => 'Hediye';

  @override
  String get poll => 'Anket';

  @override
  String get text => 'Metin';

  @override
  String get link => 'Bağlantı';

  @override
  String get note => 'Not';

  @override
  String get myNotes => 'Notlarım';

  @override
  String get today => 'Bugün';

  @override
  String daysAgoText(int count) {
    return '$count gün önce';
  }

  @override
  String dateFormat(int month, int day) {
    return '$day/$month';
  }

  @override
  String get noFavorites => 'Henüz favori yok';

  @override
  String get longPressToFavorite => 'Favorilere eklemek için mesaja uzun basın';

  @override
  String get newNote => 'Yeni Not';

  @override
  String get favoriteLink => 'Favori Bağlantı';

  @override
  String get editTags => 'Etiketleri Düzenle';

  @override
  String get deleteFavorite => 'Favoriyi Sil';

  @override
  String get deleteFavoriteConfirm =>
      'Bu favoriyi silmek istediğinizden emin misiniz?';

  @override
  String get noSearchResultsFound => 'Sonuç bulunamadı';

  @override
  String get sendRedPacket => 'Kırmızı Paket Gönder';

  @override
  String get amount => 'Tutar';

  @override
  String get redPacketCover => 'Kırmızı Paket Kapağı';

  @override
  String get redPacketType => 'Kırmızı Paket Türü';

  @override
  String get normalRedPacket => 'Normal';

  @override
  String get luckyRedPacket => 'Şanslı';

  @override
  String get redPacketCount => 'Kırmızı Paket Sayısı';

  @override
  String get pieces => 'adet';

  @override
  String get putMoneyInRedPacket => 'Kırmızı pakete para koy';

  @override
  String get redPacketRefundNotice =>
      'Alınmayan kırmızı paketler 24 saat sonra iade edilir';

  @override
  String get openRedPacket => 'Aç';

  @override
  String get redPacketAllClaimed => 'Kırmızı paket tamamı alındı';

  @override
  String get redPacketExpired => 'Kırmızı paket süresi doldu';

  @override
  String get addTransferNote => 'Transfer notu ekle';

  @override
  String get yuan => 'TL';

  @override
  String get savedToChangeCanTransfer =>
      'Bakiyeye kaydedildi, doğrudan transfer edilebilir';

  @override
  String get replyWithEmoji => 'Bu emoji ile yanıtla';

  @override
  String get claimedYourRedPacket => 'sizin kırmızı paketinizi aldı';

  @override
  String get claimedRedPacket => 'aldı';

  @override
  String get otherTyping => 'yazıyor...';

  @override
  String get processing => 'İşleniyor...';

  @override
  String get transferCancelled => 'Transfer iptal edildi';

  @override
  String get transferFailed => 'Transfer başarısız';

  @override
  String get creatingPaymentRequest => 'Ödeme talebi oluşturuluyor...';

  @override
  String get processingPayment => 'Ödeme işleniyor...';

  @override
  String get paymentFailed => 'Ödeme başarısız';

  @override
  String get clickRetry => 'Tekrar denemek için dokunun';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get editRemark => 'Notu Düzenle';

  @override
  String get setPermissions => 'İzinleri Ayarla';

  @override
  String get recommendToFriends => 'Arkadaşlara Öner';

  @override
  String get setStarFriend => 'Yıldızlı Arkadaş Olarak Ayarla';

  @override
  String get addToBlacklist => 'Kara Listeye Ekle';

  @override
  String get complain => 'Şikayet Et';

  @override
  String get deleteContact => 'Kişiyi Sil';

  @override
  String deleteContactConfirm(String name) {
    return '$name kişisini silmek istediğinizden emin misiniz?';
  }

  @override
  String get transferTitle => 'Transfer';

  @override
  String get receiverAddressLabel => 'Alıcı Adresi';

  @override
  String get selectTokenLabel => 'Token Seç';

  @override
  String get transferAmountLabel => 'Transfer Tutarı';

  @override
  String get memoLabel => 'Not (isteğe bağlı)';

  @override
  String get enterOrPasteAddressHint => 'Cüzdan adresini girin veya yapıştırın';

  @override
  String get scanInDevelopment => 'Tarama özelliği geliştirme aşamasında...';

  @override
  String get availableLabel => 'Kullanılabilir';

  @override
  String availableBalanceFormat(String balance, String symbol) {
    return 'Kullanılabilir: $balance $symbol';
  }

  @override
  String get addMemoHint => 'Not ekle';

  @override
  String get receiveTitle => 'Al';

  @override
  String get walletNotConnectedTitle => 'Cüzdan bağlı değil';

  @override
  String get connectWalletFirst => 'Lütfen önce cüzdanı bağlayın';

  @override
  String get sendPaymentRequest => 'Ödeme Talebi Gönder';

  @override
  String get qrCodeGenerateFailed => 'QR kod oluşturma başarısız';

  @override
  String get scanQrToPayMe => 'Bana ödeme yapmak için QR kodu tarayın';

  @override
  String get myWalletAddress => 'Cüzdan Adresim';

  @override
  String get createPaymentRequest => 'Ödeme Talebi Oluştur';

  @override
  String get selectTokenHint => 'Token Seç';

  @override
  String get amountLabel => 'Tutar';

  @override
  String get cancelButton => 'İptal';

  @override
  String get sendRequestButton => 'Talep Gönder';

  @override
  String get allReadReceipt => 'Tümü okundu';

  @override
  String readCountReceipt(int count) {
    return '$count okundu';
  }

  @override
  String n42IdLabel(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get redPacketDefaultGreeting => 'İyi dilekler';

  @override
  String senderRedPacket(String name) {
    return '$name Kırmızı Paketi';
  }

  @override
  String get allButton => '全部';

  @override
  String get enterValidAddress => 'Lütfen geçerli bir adres girin';

  @override
  String get pleaseSelectToken => 'Lütfen bir token seçin';

  @override
  String get receivedTransfer => 'Transfer Alındı';

  @override
  String get selectForwardRecipient => 'İletilecek kişiyi seçin';

  @override
  String get emojiFaces => 'Yüzler';

  @override
  String get emojiHearts => 'Kalpler';

  @override
  String get emojiAnimals => 'Hayvanlar';

  @override
  String get emojiFood => 'Yiyecek';

  @override
  String get emojiTransport => 'Ulaşım';

  @override
  String get emojiActivities => 'Aktiviteler';

  @override
  String get emojiObjects => 'Nesneler';

  @override
  String get emojiSymbols => 'Semboller';

  @override
  String get transferProcessing => 'Transfer işleniyor...';

  @override
  String senderSentRedPacket(String name) {
    return '$name bir kırmızı paket gönderdi';
  }

  @override
  String get savedToBalance =>
      'Bakiyeye kaydedildi, doğrudan transfer edilebilir';

  @override
  String get redPacketExpiredOrEmpty =>
      'Kırmızı paket süresi doldu/tamamı alındı';

  @override
  String get scanFeatureComingSoon => 'Tarama özelliği yakında...';

  @override
  String get setAsStarred => 'Yıldızlı Olarak Ayarla';

  @override
  String get addToBlocklist => 'Engelleme Listesine Ekle';

  @override
  String get claimedYour => ' sizinkini aldı ';

  @override
  String get claimedText => ' aldı ';

  @override
  String userTyping(String name) {
    return '$name yazıyor...';
  }

  @override
  String get typing => 'Yazıyor...';

  @override
  String get waitingToReceive => 'Alınmayı bekliyor';

  @override
  String get tapToClaim => 'Almak için dokunun';

  @override
  String get hasBeenReceived => 'Alındı';

  @override
  String get getLucky => 'Şansını dene';

  @override
  String get cameraStartFailed => 'Kamera başlatılamadı';

  @override
  String get unknownError => 'Bilinmeyen hata';

  @override
  String get placeQrCodeInFrame => 'QR kodu taramak için çerçeveye yerleştirin';

  @override
  String get closeManualInput => 'Manuel Girişi Kapat';

  @override
  String get manualInputUserId => 'Manuel Kullanıcı ID Girişi';

  @override
  String get add => 'Ekle';

  @override
  String get ringtoneClear => 'Temizle';

  @override
  String get ringtonePhone => 'Telefon';

  @override
  String get ringtoneClassic => 'Klasik';

  @override
  String get ringtoneSoft => 'Yumuşak';

  @override
  String get ringtoneVibrate => 'Titreşim';

  @override
  String get ringtoneSilent => 'Sessiz';

  @override
  String get stop => 'Durdur';

  @override
  String get selectRingtone => 'Zil Sesi Seç';

  @override
  String get loadingRingtones => 'Zil sesleri yükleniyor...';

  @override
  String get noRingtonesFound => 'Zil sesi bulunamadı';

  @override
  String get moodAndThoughts => 'Ruh Hali ve Düşünceler';

  @override
  String get statusHappy => 'Mutlu';

  @override
  String get statusCracked => 'Paramparça';

  @override
  String get statusLucky => 'Şanslı';

  @override
  String get statusSunny => 'Güneşli';

  @override
  String get statusTired => 'Yorgun';

  @override
  String get statusDaydream => 'Hayal';

  @override
  String get statusRushing => 'Acele';

  @override
  String get statusOverthinking => 'Fazla Düşünme';

  @override
  String get statusEnergized => 'Enerjik';

  @override
  String get workAndStudy => 'İş ve Çalışma';

  @override
  String get statusWorking => 'Çalışıyor';

  @override
  String get statusStudying => 'Ders Çalışıyor';

  @override
  String get statusBusy => 'Meşgul';

  @override
  String get statusSlacking => 'Tembellik';

  @override
  String get statusTraveling => 'Seyahatte';

  @override
  String get statusGoingHome => 'Eve Gidiyor';

  @override
  String get statusDnd => 'Rahatsız Etmeyin';

  @override
  String get statusHanging => 'Takılıyor';

  @override
  String get statusCheckIn => 'Check-in';

  @override
  String get statusExercising => 'Egzersiz';

  @override
  String get statusCoffee => 'Kahve';

  @override
  String get statusBubbleTea => 'Bubble Tea';

  @override
  String get statusEating => 'Yemek Yiyor';

  @override
  String get statusParenting => 'Ebeveynlik';

  @override
  String get statusSavingWorld => 'Dünyayı Kurtarıyor';

  @override
  String get statusSelfie => 'Selfie';

  @override
  String get rest => 'Dinlenme';

  @override
  String get statusRetreat => 'Dinlenme';

  @override
  String get statusHome => 'Evde';

  @override
  String get statusSleeping => 'Uyuyor';

  @override
  String get statusCatLover => 'Kedi Sever';

  @override
  String get statusDogWalking => 'Köpek Gezdiriyor';

  @override
  String get statusGaming => 'Oyun Oynuyor';

  @override
  String get statusListening => 'Dinliyor';

  @override
  String get setStatus => 'Durum Ayarla';

  @override
  String get visibleToFriends24h => '24 saat arkadaşlara görünür';

  @override
  String get writeStatus => 'Durum Yaz';

  @override
  String get enterYourStatus => 'Durumunuzu girin...';

  @override
  String get ok => 'Tamam';

  @override
  String get cameraPermissionRequired =>
      'QR kod taramak için kamera izni gerekli';

  @override
  String get cameraPermissionDenied =>
      'Kamera izni kalıcı olarak reddedildi. Lütfen sistem ayarlarından etkinleştirin.';

  @override
  String get cannotGetCameraPermission => 'Kamera izni alınamadı';

  @override
  String permissionCheckError(String error) {
    return 'İzin kontrol hatası: $error';
  }

  @override
  String get invalidQrCode => 'Geçersiz QR kod';

  @override
  String qrCodeProcessFailed(String error) {
    return 'QR kod işlenemedi: $error';
  }

  @override
  String cannotAddFriend(String error) {
    return 'Arkadaş eklenemedi: $error';
  }

  @override
  String get scanQrCode => 'QR Kod Tara';

  @override
  String get checkingCameraPermission => 'Kamera izni kontrol ediliyor...';

  @override
  String get needCameraPermission => 'Kamera İzni Gerekli';

  @override
  String get retryPermission => 'Tekrar Dene';

  @override
  String get openSettings => 'Ayarları Aç';

  @override
  String get inviteMembers => 'Üye Davet Et';

  @override
  String inviteCount(int count) {
    return 'Davet Et($count)';
  }

  @override
  String get noShippingAddress => 'Teslimat adresi yok';

  @override
  String get defaultLabel => 'Varsayılan';

  @override
  String get editAddress => 'Adresi Düzenle';

  @override
  String get recipient => 'Alıcı';

  @override
  String get enterRecipientName => 'Alıcı adını girin';

  @override
  String get phoneNumber => 'Telefon Numarası';

  @override
  String get enterPhoneNumber => 'Telefon numarası girin';

  @override
  String get regionHint => 'İl/İlçe/Mahalle';

  @override
  String get detailedAddress => 'Detaylı Adres';

  @override
  String get detailedAddressHint => 'Sokak, bina numarası, vb.';

  @override
  String get setAsDefaultAddress => 'Varsayılan adres olarak ayarla';

  @override
  String get pleaseCompleteInfo => 'Lütfen tüm alanları doldurun';

  @override
  String get noInvoice => 'Fatura yok';

  @override
  String get company => 'Şirket';

  @override
  String get taxNumber => 'Vergi Numarası';

  @override
  String get editInvoice => 'Faturayı Düzenle';

  @override
  String get companyName => 'Şirket Adı';

  @override
  String get enterCompanyName => 'Şirket adı girin';

  @override
  String get personalName => 'Kişi Adı';

  @override
  String get enterName => 'Ad girin';

  @override
  String get taxIdNumber => 'Vergi Kimlik Numarası';

  @override
  String get enterTaxIdNumber => 'Vergi kimlik numarası girin';

  @override
  String get bankNameOptional => 'Banka Adı (İsteğe bağlı)';

  @override
  String get enterBankName => 'Banka adı girin';

  @override
  String get bankAccountOptional => 'Banka Hesabı (İsteğe bağlı)';

  @override
  String get enterBankAccount => 'Banka hesabı girin';

  @override
  String get companyAddressOptional => 'Şirket Adresi (İsteğe bağlı)';

  @override
  String get enterCompanyAddress => 'Şirket adresi girin';

  @override
  String get companyPhoneOptional => 'Şirket Telefonu (İsteğe bağlı)';

  @override
  String get enterCompanyPhone => 'Şirket telefonu girin';

  @override
  String get setAsDefaultInvoice => 'Varsayılan fatura olarak ayarla';

  @override
  String get confirmDeleteAddress =>
      'Bu adresi silmek istediğinizden emin misiniz?';

  @override
  String get confirmDeleteInvoice =>
      'Bu faturayı silmek istediğinizden emin misiniz?';

  @override
  String get groupOwner => 'Sahip';

  @override
  String get groupAdmin => 'Yönetici';

  @override
  String get searchMembers => 'Üyelerde ara';

  @override
  String totalMembers(int count) {
    return '$count üye';
  }

  @override
  String get removeFromGroup => 'Gruptan Çıkar';

  @override
  String confirmRemoveMember(String name) {
    return '\"$name\" kişisini gruptan çıkarmak istediğinizden emin misiniz?';
  }

  @override
  String get setAsAdmin => 'Yönetici Yap';

  @override
  String get removeAdmin => 'Yöneticilikten Çıkar';

  @override
  String get deleteContactSuccess => 'Kişi silindi';

  @override
  String get unknownSong => 'Bilinmeyen Şarkı';

  @override
  String get unknownArtist => 'Bilinmeyen Sanatçı';

  @override
  String get unknownContact => 'Bilinmeyen Kişi';

  @override
  String get personalCard => 'Kişi Kartı';

  @override
  String get singleChoice => 'Tekli';

  @override
  String get multiChoice => 'Çoklu';

  @override
  String get ended => 'Sona erdi';

  @override
  String get endPollButton => 'Anketi Bitir';

  @override
  String get createPoll => 'Anket Oluştur';

  @override
  String get pollQuestion => 'Anket Sorusu';

  @override
  String get pollOptions => 'Anket Seçenekleri';

  @override
  String optionPlaceholder(int index) {
    return 'Seçenek $index';
  }

  @override
  String get addOption => 'Seçenek Ekle';

  @override
  String get pollSettings => 'Anket Ayarları';

  @override
  String get anonymousPoll => 'Anonim Anket';

  @override
  String get pollHint =>
      'Anket sohbette görüntülenecek. Grup üyeleri oy verebilir.';

  @override
  String get searchSongOrArtist => 'Şarkı veya sanatçı ara';

  @override
  String get noSongsFound => 'Şarkı bulunamadı';

  @override
  String get supportedMusicPlatforms =>
      'NetEase, QQ Music vb. platformlardan müzik bağlantılarını destekler.';

  @override
  String get songNameOptional => 'Şarkı Adı (İsteğe bağlı)';

  @override
  String get enterSongName => 'Şarkı adı girin';

  @override
  String get artistNameOptional => 'Sanatçı Adı (İsteğe bağlı)';

  @override
  String get enterArtistName => 'Sanatçı adı girin';

  @override
  String get shareSong => 'Şarkı Paylaş';

  @override
  String get realTimeLocationSharing =>
      'Gerçek zamanlı konum paylaşımı geliştirme aşamasında...';

  @override
  String get voiceCallFeatureInDev =>
      'Sesli arama özelliği geliştirme aşamasında...';

  @override
  String get reportFeatureInDev => 'Şikayet özelliği geliştirme aşamasında...';

  @override
  String get shareFeatureInDev => 'Paylaşım özelliği geliştirme aşamasında...';

  @override
  String get qrCodeFeatureInDev => 'QR kod özelliği geliştirme aşamasında...';

  @override
  String get scanQrToAddMe =>
      'Beni arkadaş olarak eklemek için yukarıdaki QR kodu tarayın';

  @override
  String get saveToAlbum => 'Albüme Kaydet';

  @override
  String get changeStyle => 'Stili Değiştir';

  @override
  String get copyId => 'ID Kopyala';

  @override
  String get idCopied => 'ID kopyalandı';

  @override
  String get shareFeatureComingSoon => 'Paylaşım özelliği yakında';

  @override
  String get saveFeatureComingSoon => 'Kaydetme özelliği yakında';

  @override
  String get moreStylesFeatureComingSoon => 'Daha fazla stil yakında';

  @override
  String get confirmEndPoll =>
      'Bu anketi bitirmek istediğinizden emin misiniz?';

  @override
  String get cannotVoteAfterEnd => 'Bitirdikten sonra oy verilemez.';

  @override
  String get bio => 'Biyografi';

  @override
  String get homeServer => 'Sunucu';

  @override
  String get shareContactCard => 'Kişi Kartını Paylaş';

  @override
  String get removeFromBlacklist => 'Kara Listeden Çıkar';

  @override
  String get confirmAddBlacklist =>
      'Bu kullanıcıyı kara listeye eklemek istediğinizden emin misiniz? Onlardan mesaj almayacaksınız.';

  @override
  String get confirmRemoveBlacklist =>
      'Bu kullanıcıyı kara listeden çıkarmak istediğinizden emin misiniz?';

  @override
  String get remarkSaved => 'Not kaydedildi';

  @override
  String get remarkCleared => 'Not temizlendi';

  @override
  String get receive => 'Al';

  @override
  String get pleaseConnectWallet => 'Lütfen önce cüzdanınızı bağlayın';

  @override
  String get sendRequest => 'Talep Gönder';

  @override
  String get pleaseEnterValidAmount => 'Lütfen geçerli bir tutar girin';

  @override
  String get searchPlaceholder => 'Kişi, grup ve mesajlarda ara';

  @override
  String get enterKeywordToSearch =>
      'Aramaya başlamak için anahtar kelime girin';

  @override
  String get clearHistory => 'Temizle';

  @override
  String noResultsForQuery(String query) {
    return '\"$query\" için sonuç bulunamadı';
  }

  @override
  String get allResults => 'Tümü';

  @override
  String get searchInChat => 'Sohbette ara';

  @override
  String get groupLabel => 'Grup';

  @override
  String get messageLabel => 'Mesaj';

  @override
  String get securityTitle => 'Güvenlik';

  @override
  String get keyBackup => 'Anahtar Yedekleme';

  @override
  String get backupEncryptionKeys => 'Şifreleme Anahtarlarını Yedekle';

  @override
  String keysBackedUp(int count) {
    return '$count anahtar yedeklendi';
  }

  @override
  String get backupNotSet => 'Yedekleme ayarlanmadı';

  @override
  String get restoreKeys => 'Anahtarları Geri Yükle';

  @override
  String get restoreKeysFromBackup =>
      'Yedekten şifreleme anahtarlarını geri yükle';

  @override
  String get exportKeys => 'Anahtarları Dışa Aktar';

  @override
  String get exportKeysToFile => 'Anahtarları dosyaya aktar';

  @override
  String get loggedInDevices => 'Giriş Yapılmış Cihazlar';

  @override
  String get noOtherDevices => 'Başka cihaz yok';

  @override
  String get verified => 'Doğrulanmış';

  @override
  String get unverified => 'Doğrulanmamış';

  @override
  String get advanced => 'Gelişmiş';

  @override
  String get crossSigning => 'Çapraz İmza';

  @override
  String get enabled => 'Etkin';

  @override
  String get notEnabled => 'Etkin değil';

  @override
  String get resetEncryption => 'Şifrelemeyi Sıfırla';

  @override
  String get deleteAllEncryptionKeys => 'Tüm şifreleme anahtarlarını sil';

  @override
  String get encryptionNotSupported => 'Şifreleme desteklenmiyor';

  @override
  String get notInitialized => 'Başlatılmadı';

  @override
  String get backupKeyTitle => 'Anahtarları Yedekle';

  @override
  String get backupKeyMessage =>
      'Yeni bir anahtar yedeklemesi oluştur? Bu, yeni bir cihazda şifrelenmiş mesajları geri yüklemenize yardımcı olacaktır.';

  @override
  String get backup => 'Yedekle';

  @override
  String get restoreKeyTitle => 'Anahtarları Geri Yükle';

  @override
  String get restoreKeyMessage =>
      'Şifrelenmiş mesajları geri yüklemek için kurtarma şifrenizi veya kurtarma anahtarınızı girin.';

  @override
  String get restore => 'Geri Yükle';

  @override
  String get exportKeyTitle => 'Anahtarları Dışa Aktar';

  @override
  String get exportKeyMessage =>
      'Dışa aktarılan anahtar dosyası tüm şifreleme anahtarlarınızı içerir. Lütfen güvenli bir yerde saklayın.';

  @override
  String get export => 'Dışa Aktar';

  @override
  String deviceIdLabel(String deviceId) {
    return 'Cihaz ID: $deviceId';
  }

  @override
  String get deviceStatusVerified => 'Durum: Doğrulanmış';

  @override
  String get deviceStatusUnverified => 'Durum: Doğrulanmamış';

  @override
  String lastActiveLabel(String lastSeen) {
    return 'Son etkinlik: $lastSeen';
  }

  @override
  String get verifyThisDevice => 'Bu cihazı doğrula';

  @override
  String get crossSigningAlreadyEnabled => 'Çapraz imza zaten etkin';

  @override
  String get crossSigningSetupSuccess => 'Çapraz imza kurulumu başarılı';

  @override
  String get resetEncryptionTitle => 'Şifrelemeyi Sıfırla';

  @override
  String get resetEncryptionWarning =>
      'Uyarı: Bu tüm şifreleme anahtarlarınızı silecektir. Önceki şifrelenmiş mesajların şifresini çözemeyeceksiniz. Bu işlem geri alınamaz.';

  @override
  String get reset => 'Sıfırla';

  @override
  String get leaveMeetingConfirm =>
      'Toplantıdan ayrılmak istediğinizden emin misiniz?';

  @override
  String pokedSomeone(String name, String suffix) {
    return '$name kişisini$suffix dürttü';
  }

  @override
  String get noContactsToAdd => 'Eklenecek kişi yok';

  @override
  String get addMembers => 'Üye Ekle';

  @override
  String invitedMembers(int count) {
    return '$count üye davet edildi';
  }

  @override
  String inviteFailed(String error) {
    return 'Davet başarısız: $error';
  }

  @override
  String get memberRemoved => 'Üye çıkarıldı';

  @override
  String removeFailed(String error) {
    return 'Çıkarma başarısız: $error';
  }

  @override
  String get realTimeLocationShareMessage =>
      'Paylaştıktan sonra, karşı taraf 1 saat boyunca gerçek zamanlı konumunuzu görebilir.';

  @override
  String get startSharing => 'Paylaşımı Başlat';

  @override
  String get locationServiceNotEnabled => 'Konum servisi etkin değil';

  @override
  String get enableLocationService =>
      'Bu özelliği kullanmak için lütfen konum servisini etkinleştirin';

  @override
  String get goToSettings => 'Ayarlara Git';

  @override
  String get locationPermissionRequired => 'Bu özellik için konum izni gerekli';

  @override
  String get locationPermissionDeniedPermanent =>
      'Konum izni kalıcı olarak reddedildi. Lütfen ayarlardan etkinleştirin.';

  @override
  String get locationPermissionDenied => 'Konum izni reddedildi';

  @override
  String get gettingLocation => 'Konum alınıyor...';

  @override
  String getLocationFailed(String error) {
    return 'Konum alınamadı: $error';
  }

  @override
  String get currentLocation => 'Mevcut Konum';

  @override
  String nearbyPlace(int index) {
    return 'Yakın Yer $index';
  }

  @override
  String approximateDistance(String distance) {
    return 'Yaklaşık $distance';
  }

  @override
  String get mapPreview => 'Harita Önizleme';

  @override
  String get searchLocation => 'Konum ara';

  @override
  String redPacketSent(String amount, String token) {
    return '$amount $token kırmızı paket gönderildi';
  }

  @override
  String get transferDefault => 'Transfer';

  @override
  String transferSent(String amount, String token) {
    return '$amount $token transfer gönderildi';
  }

  @override
  String pickFileFailed(String error) {
    return 'Dosya seçilemedi: $error';
  }

  @override
  String get fileSizeLimit => 'Dosya boyutu 50MB\'ı geçemez';

  @override
  String fileSending(String filename) {
    return 'Dosya gönderiliyor: $filename';
  }

  @override
  String sendFileFailed(String error) {
    return 'Dosya gönderilemedi: $error';
  }

  @override
  String contactCardSent(String name) {
    return '$name kişi kartı gönderildi';
  }

  @override
  String get favoritesFeature => 'Favoriler';

  @override
  String get couponsFeature => 'Kuponlar';

  @override
  String get giftFeature => 'Hediye';

  @override
  String sharedMusic(String name) {
    return '$name paylaşıldı';
  }

  @override
  String get endPollTitle => 'Anketi Bitir';

  @override
  String get endPollConfirmMessage =>
      'Bu anketi bitirmek istediğinizden emin misiniz? Bitirdikten sonra oylama kapanacaktır.';

  @override
  String get pollEndedMessage => 'Anket sona erdi';

  @override
  String get connectingCall => 'Bağlanıyor...';

  @override
  String get muteCall => 'Sessize Al';

  @override
  String get speakerOff => 'Hoparlör Kapalı';

  @override
  String get speakerOn => 'Hoparlör';

  @override
  String get cameraOn => 'Kamera Açık';

  @override
  String get cameraOff => 'Kamera Kapalı';

  @override
  String get hangUp => 'Kapat';

  @override
  String get selectForwardTargetTitle => 'İletilecek Hedefi Seçin';

  @override
  String get noForwardableChat => 'İletmek için sohbet yok';

  @override
  String get noMatchingChat => 'Eşleşen sohbet bulunamadı';

  @override
  String get imagePreview => '[Resim]';

  @override
  String get voicePreview => '[Ses]';

  @override
  String get videoPreview => '[Video]';

  @override
  String filePreviewWithName(String filename) {
    return '[Dosya] $filename';
  }

  @override
  String locationPreviewWithAddress(String address) {
    return '[Konum] $address';
  }

  @override
  String musicPreviewWithTitle(String title) {
    return '[Müzik] $title';
  }

  @override
  String get messagePreview => '[Mesaj]';

  @override
  String get locationTitle => 'Konum';

  @override
  String get sendButton => 'Gönder';

  @override
  String get retryButton => 'Tekrar Dene';

  @override
  String get selectContact => 'Kişi Seç';

  @override
  String get searchContactHint => 'Kişilerde ara';

  @override
  String get shareMusic => 'Müzik Paylaş';

  @override
  String get recentPlayed => 'Son Çalınanlar';

  @override
  String get myFavorites => 'Favorilerim';

  @override
  String get networkLink => 'Bağlantı';

  @override
  String get localFile => 'Yerel';

  @override
  String get musicLinkRequired => 'Müzik Bağlantısı *';

  @override
  String get pasteMusicLink => 'Müzik bağlantısı yapıştırın';

  @override
  String get enterSongNamePlaceholder => 'Şarkı adı girin';

  @override
  String get enterArtistNamePlaceholder => 'Sanatçı adı girin';

  @override
  String get shareMusicButton => 'Müzik Paylaş';

  @override
  String get selectLocalAudio => 'Yerel Ses Dosyası Seç';

  @override
  String get supportedAudioFormats => 'MP3, M4A, WAV, FLAC vb. desteklenir.';

  @override
  String get selectFileButton => 'Dosya Seç';

  @override
  String get pleaseEnterMusicLink => 'Lütfen müzik bağlantısı girin';

  @override
  String get pleaseEnterValidLink => 'Lütfen geçerli bir URL girin';

  @override
  String get sharedSong => 'Paylaşılan Şarkı';

  @override
  String get selectMember => 'Üye Seç';

  @override
  String get searchMemberHint => 'Üyelerde ara';

  @override
  String get noMatchingMembers => 'Eşleşen üye bulunamadı';

  @override
  String get unknownMember => 'Bilinmeyen';

  @override
  String selectedMessagesCount(int count) {
    return '$count mesaj seçildi';
  }

  @override
  String get searchContactsOrGroups => 'Kişi veya gruplarda ara';

  @override
  String get noMatchingConversations => 'Eşleşen sohbet bulunamadı';

  @override
  String get videoTitle => 'Video';

  @override
  String get loadingText => 'Yükleniyor...';

  @override
  String get videoPlaybackFailed => 'Video oynatma başarısız';

  @override
  String get videoLoadFailed => 'Video yüklenemedi';

  @override
  String get playerInitFailed => 'Oynatıcı başlatılamadı';

  @override
  String get createPollTitle => 'Anket Oluştur';

  @override
  String get submitPoll => 'Gönder';

  @override
  String get pollQuestionLabel => 'Anket Sorusu';

  @override
  String get enterPollQuestionHint => 'Anket sorusu girin';

  @override
  String get pollOptionsLabel => 'Anket Seçenekleri';

  @override
  String optionHintWithIndex(int index) {
    return 'Seçenek $index';
  }

  @override
  String get addOptionButton => 'Seçenek Ekle';

  @override
  String get pollSettingsLabel => 'Anket Ayarları';

  @override
  String get selectionType => 'Seçim Türü';

  @override
  String get singleChoiceLabel => 'Tekli';

  @override
  String get multiChoiceLabel => 'Çoklu';

  @override
  String get anonymousPollSwitch => 'Anonim Anket';

  @override
  String get pleaseEnterQuestion => 'Lütfen anket sorusu girin';

  @override
  String get atLeastTwoOptions => 'En az 2 seçenek gerekli';

  @override
  String confirmWithCount(int count) {
    return 'Onayla ($count)';
  }

  @override
  String get emailVerificationTitle => 'E-posta Doğrulama';

  @override
  String get enterValidEmailAddress =>
      'Lütfen geçerli bir e-posta adresi girin';

  @override
  String verificationCodeSentTo(String email) {
    return '$email adresine doğrulama kodu gönderildi';
  }

  @override
  String sendCodeFailed(String error) {
    return 'Kod gönderilemedi: $error';
  }

  @override
  String get verificationSuccess => 'Doğrulama başarılı';

  @override
  String get verificationFailed => 'Doğrulama başarısız';

  @override
  String verificationCodeError(String error) {
    return 'Doğrulama kodu hatası: $error';
  }

  @override
  String get enterVerificationCode => 'Doğrulama kodunu girin';

  @override
  String get enterYourEmail => 'E-posta girin';

  @override
  String weSentCodeTo(String email) {
    return '$email adresine\n6 haneli kod gönderdik';
  }

  @override
  String get enterEmailForCode =>
      'E-posta adresinizi girin, doğrulama kodu göndereceğiz';

  @override
  String get sendVerificationCode => 'Doğrulama kodu gönder';

  @override
  String get resendVerificationCode => 'Doğrulama kodunu tekrar gönder';

  @override
  String canResendAfter(int seconds) {
    return '$seconds saniye sonra tekrar gönderilebilir';
  }

  @override
  String get changeEmail => 'E-postayı değiştir';

  @override
  String get addToContacts => 'Kişilere Ekle';

  @override
  String get addingToContacts => 'Ekleniyor...';

  @override
  String get addedToContacts => 'Kişilere eklendi';

  @override
  String addFailedWithError(String error) {
    return 'Ekleme başarısız: $error';
  }

  @override
  String get addPhone => 'Telefon ekle';

  @override
  String get addTag => 'Etiket ekle';

  @override
  String get addText => 'Metin ekle';

  @override
  String get addPhoto => 'Fotoğraf ekle';

  @override
  String groupCountLabel(int count) {
    return '$count grup';
  }

  @override
  String get addedViaSearch => 'Arama yoluyla eklendi';

  @override
  String get addTime => 'Zaman ekle';

  @override
  String get doneButton => 'Tamam';

  @override
  String get waitingForParticipants => 'Katılımcılar bekleniyor...';

  @override
  String participantMe(String name) {
    return '$name (Ben)';
  }

  @override
  String get sharingLabel => 'Paylaşılıyor';

  @override
  String screenSharingBy(String name) {
    return '$name ekran paylaşıyor';
  }

  @override
  String participantCount(int count) {
    return '$count katılımcı';
  }

  @override
  String get muteLabel => 'Sessize Al';

  @override
  String get unmuteLabel => 'Sesi Aç';

  @override
  String get turnOffVideo => 'Videoyu kapat';

  @override
  String get turnOnVideo => 'Videoyu aç';

  @override
  String get shareScreen => 'Ekran paylaş';

  @override
  String get stopSharing => 'Paylaşımı durdur';

  @override
  String get switchCameraLabel => 'Değiştir';

  @override
  String get leaveLabel => 'Ayrıl';

  @override
  String get participantsLabel => 'Katılımcılar';

  @override
  String get joiningMeeting => 'Toplantıya katılınıyor...';
}
