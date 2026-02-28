// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class STr extends S {
  STr([String locale = 'tr']) : super(locale);

  @override
  String get commonRetry => 'Tekrar Dene';

  @override
  String get commonUnknownUser => 'Bilinmeyen Kullanıcı';

  @override
  String get transferWalletNotConnected => 'Cüzdan bağlı değil';

  @override
  String get chatCallServiceNotInitialized => 'Arama servisi başlatılmadı';

  @override
  String authLoginFailed(String error) {
    return 'Giriş başarısız: $error';
  }

  @override
  String get chatCallBack => 'Geri ara';

  @override
  String get chatMissedVideoCall => 'Cevapsız görüntülü arama';

  @override
  String get chatMissedVoiceCall => 'Cevapsız sesli arama';

  @override
  String get chatCallNotAnswered => 'Cevaplanmadı';

  @override
  String get chatCallDurationLabel => 'Arama süresi';

  @override
  String get chatVoiceCallCancelled => 'Sesli arama iptal edildi';

  @override
  String get chatVideoCallCancelled => 'Görüntülü arama iptal edildi';

  @override
  String get commonImage => '[Resim]';

  @override
  String get chatVideo => '[Video]';

  @override
  String get chatVoice => '[Ses]';

  @override
  String get commonFile => '[Dosya]';

  @override
  String get chatLocation => '[Konum]';

  @override
  String get chatUnknownMessage => '[Bilinmeyen mesaj]';

  @override
  String get commonDelete => 'Sil';

  @override
  String get chatDeleteThisMessage => 'Bu mesajı silmek istiyor musunuz?';

  @override
  String get chatMessageDeleted => 'Mesaj silindi';

  @override
  String get profileNotLoggedIn => 'Giriş yapılmadı';

  @override
  String get chatMyLocation => 'Konumum';

  @override
  String get commonGroupChat => 'Grup Sohbeti';

  @override
  String get commonSearch => 'Ara';

  @override
  String get commonCancel => 'İptal';

  @override
  String get commonLoadFailed => 'Yükleme başarısız';

  @override
  String get commonMessages => 'Mesajlar';

  @override
  String get commonContacts => 'Kişiler';

  @override
  String get commonMe => 'Ben';

  @override
  String get commonVoiceLoading =>
      'Ses yükleniyor, lütfen daha sonra tekrar deneyin';

  @override
  String get commonVoiceToTextFailed => 'Sesten metne dönüştürme başarısız';

  @override
  String get commonConvertToText => 'Metne çevir';

  @override
  String get chatCopy => 'Kopyala';

  @override
  String get commonForward => 'İlet';

  @override
  String get commonUnfavorite => 'Favorilerden çıkar';

  @override
  String get commonFavorite => 'Favorilere ekle';

  @override
  String get settingsResend => 'Tekrar gönder';

  @override
  String get chatRecall => 'Geri al';

  @override
  String get commonQuote => 'Alıntıla';

  @override
  String get commonRemind => 'Hatırlat';

  @override
  String get chatCopied => 'Kopyalandı';

  @override
  String get storySendMessageHint => 'Mesaj gönder';

  @override
  String get commonMicrophonePermissionRequired =>
      'Lütfen mikrofon iznini verin';

  @override
  String get chatMicrophonePermissionDeniedPermanent =>
      '麦克风权限已被拒绝，请在系统设置中开启以使用语音消息功能。';

  @override
  String commonStartRecordingFailed(String error) {
    return 'Kayıt başlatılamadı: $error';
  }

  @override
  String get commonRecordingTooShort => 'Kayıt çok kısa';

  @override
  String commonStopRecordingFailed(String error) {
    return 'Kayıt durdurulamadı: $error';
  }

  @override
  String get chatReleaseToCancel => 'İptal etmek için bırakın';

  @override
  String get chatReleaseToSend =>
      'Göndermek için bırakın, iptal için yukarı kaydırın';

  @override
  String get commonHoldToTalk => 'Konuşmak için basılı tutun';

  @override
  String get commonSend => 'Gönder';

  @override
  String get commonAddFriend => 'Arkadaş Ekle';

  @override
  String get commonChatServiceNotConnected => 'Sohbet servisi bağlı değil';

  @override
  String contactUserNotFoundHint(String query) {
    return '\"$query\" kullanıcısı bulunamadı\n\nİpuçları:\n• Tam kullanıcı ID\'sini girin, örn. @kullaniciadi:sunucu.com\n• Kullanıcı adı yazımını kontrol edin';
  }

  @override
  String contactCreateChatFailed(String error) {
    return 'Sohbet oluşturulamadı: $error';
  }

  @override
  String contactSearchFailed(String error) {
    return 'Arama başarısız: $error';
  }

  @override
  String get contactEnterUserIdOrUsername =>
      'Aramak için kullanıcı ID\'si veya adı girin';

  @override
  String get contactSearching => 'Aranıyor...';

  @override
  String get contactSearchUserToChat =>
      'Sohbet başlatmak için kullanıcı arayın';

  @override
  String get contactMatrixIdExample =>
      'Tam Matrix ID\'si girebilirsiniz\nörn. @kullanici:matrix.n42.network';

  @override
  String contactUserNotFound(String username) {
    return '\"$username\" kullanıcısı bulunamadı';
  }

  @override
  String get commonChat => 'Sohbet';

  @override
  String get commonSettings => 'Ayarlar';

  @override
  String get profileEditProfile => 'Profili Düzenle';

  @override
  String get authLogin => 'Giriş Yap';

  @override
  String get commonCreateGroup => 'Grup Oluştur';

  @override
  String get chatError => 'Hata';

  @override
  String get commonTransfer => 'Transfer';

  @override
  String get commonReceived => 'Alındı';

  @override
  String get commonRefunded => 'İade edildi';

  @override
  String get commonExpired => 'Süresi doldu';

  @override
  String get chatRedPacketGreeting => 'İyi dilekler';

  @override
  String get commonN42RedPacket => 'N42 Kırmızı Paket';

  @override
  String get commonClaimed => 'Alındı';

  @override
  String get commonAllClaimed => 'Tamamı alındı';

  @override
  String get chatReadAloud => '朗读';

  @override
  String get chatReply => 'Yanıtla';

  @override
  String get commonEdit => 'Düzenle';

  @override
  String get chatSelectForwardTarget => 'Alıcı seçin';

  @override
  String commonSendCount(int count) {
    return 'Gönder ($count)';
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
  String get contactFriendInfo => 'Arkadaş Bilgisi';

  @override
  String get contactFriendInfoDesc =>
      'Arkadaşınıza not, telefon, etiket ekleyin ve izinleri ayarlayın.';

  @override
  String get commonMoments => 'Anlar';

  @override
  String get commonSendMessage => 'Mesaj';

  @override
  String get contactAudioVideoCall => 'Sesli/Görüntülü Arama';

  @override
  String get contactVideoChannel => 'Video Kanalı';

  @override
  String get contactRemark => 'Not';

  @override
  String get contactRemarkName => 'Takma Ad';

  @override
  String get contactPhone => 'Telefon';

  @override
  String get contactTags => 'Etiketler';

  @override
  String get contactNotes => 'Notlar';

  @override
  String get contactPhotos => 'Fotoğraflar';

  @override
  String get contactPermissions => 'İzinler';

  @override
  String get contactChatMomentsEtc => 'Sohbet, Anlar, Spor, vb.';

  @override
  String get contactMoreInfo => 'Daha Fazla Bilgi';

  @override
  String get contactCommonGroups => 'Ortak Gruplar';

  @override
  String get contactSource => 'Kaynak';

  @override
  String get settingsNotificationSettings => 'Bildirimler';

  @override
  String get settingsPrivacy => 'Gizlilik';

  @override
  String get settingsAppearance => 'Görünüm';

  @override
  String get settingsAbout => 'Hakkında';

  @override
  String get commonLogout => 'Çıkış Yap';

  @override
  String get commonLogoutConfirm => 'Çıkış yapmak istediğinizden emin misiniz?';

  @override
  String get commonSave => 'Kaydet';

  @override
  String get profileNickname => 'Takma Ad';

  @override
  String get profileEnterNickname => 'Takma ad girin';

  @override
  String get profileSignature => 'İmza';

  @override
  String get profileAddSignature => 'İmza ekle';

  @override
  String get commonTakePhoto => 'Fotoğraf Çek';

  @override
  String get profileChooseFromGallery => 'Galeriden Seç';

  @override
  String profileSaveFailed(String error) {
    return 'Kaydetme başarısız: $error';
  }

  @override
  String get authSecureDecentralizedChat =>
      'Güvenli, merkezi olmayan mesajlaşma';

  @override
  String get commonEndToEndEncryption => 'Uçtan uca şifreleme';

  @override
  String get authMessagesOnlyYouCanSee =>
      'Mesajlar sadece siz ve alıcı tarafından görülebilir';

  @override
  String get authDecentralized => 'Merkezi Olmayan';

  @override
  String get authBasedOnMatrix => 'Matrix açık protokolü üzerine kurulu';

  @override
  String get authWalletIntegration => 'Cüzdan Entegrasyonu';

  @override
  String get authEasyCryptoTransfer => 'Kolay kripto para transferi';

  @override
  String get authRegister => 'Kayıt Ol';

  @override
  String get authAgreeTerms => 'Giriş yaparak kabul etmiş olursunuz';

  @override
  String get authTermsOfService => 'Hizmet Şartları';

  @override
  String get authAnd => 've';

  @override
  String get authPrivacyPolicy => 'Gizlilik Politikası';

  @override
  String get authServerAddress => 'Sunucu Adresi';

  @override
  String get authEnterServerAddress => 'Sunucu adresi girin';

  @override
  String authConnectedTo(String serverName) {
    return '$serverName sunucusuna bağlandı';
  }

  @override
  String get authUsername => 'Kullanıcı Adı';

  @override
  String get authEnterUsername => 'Kullanıcı adı girin';

  @override
  String get authUsernameOrEmail => 'Kullanıcı Adı veya E-posta';

  @override
  String get authEnterUsernameOrEmail => 'Kullanıcı adı veya e-posta girin';

  @override
  String get authPassword => 'Şifre';

  @override
  String get authEnterPassword => 'Şifre girin';

  @override
  String get authRegisterAccount => 'Kayıt Ol';

  @override
  String get authForgotPassword => 'Şifremi Unuttum';

  @override
  String get authOtherLoginMethods => 'Diğer giriş yöntemleri';

  @override
  String get authCreateAccount => 'Hesap Oluştur';

  @override
  String get authJoinN42Chat => 'Sohbete başlamak için N42 Chat\'e katılın';

  @override
  String get authUsernameHint => '3-20 karakter, harf/rakam/_';

  @override
  String get authUsernameMinLength =>
      'Kullanıcı adı en az 3 karakter olmalıdır';

  @override
  String get authUsernameMaxLength =>
      'Kullanıcı adı en fazla 20 karakter olmalıdır';

  @override
  String get authUsernameFormat =>
      'Kullanıcı adı sadece harf, rakam ve alt çizgi içerebilir';

  @override
  String get authPasswordHint => 'En az 8 karakter';

  @override
  String get commonPasswordMinLength => 'Şifre en az 8 karakter olmalıdır';

  @override
  String get authConfirmPassword => 'Şifreyi Onayla';

  @override
  String get authFilled => 'Dolduruldu';

  @override
  String get authEnterInviteCode => 'Davet kodu girin';

  @override
  String get authAlreadyHaveAccount => 'Zaten hesabınız var mı?';

  @override
  String get authLoginNow => 'Hemen giriş yapın';

  @override
  String get profileAvatar => 'Avatar';

  @override
  String get profileStatus => 'Durum';

  @override
  String get commonLoading => 'Yükleniyor...';

  @override
  String get conversationNoConversations => 'Sohbet yok';

  @override
  String get conversationTapToChat => 'Sohbet başlatmak için sağ üste dokunun';

  @override
  String get conversationStartGroup => 'Grup Sohbeti Başlat';

  @override
  String get commonScan => 'Tara';

  @override
  String get commonPayment => 'Ödeme';

  @override
  String commonFeatureComingSoon(String feature) {
    return '$feature yakında';
  }

  @override
  String get conversationMarkAsRead => 'Okundu olarak işaretle';

  @override
  String get commonUnmute => 'Sesi aç';

  @override
  String get commonMute => 'Sessize al';

  @override
  String get conversationUnpin => 'Sabitlemeyi kaldır';

  @override
  String get conversationPin => 'Sabitle';

  @override
  String get conversationDeleteConversation => 'Sohbeti Sil';

  @override
  String conversationDeleteConversationConfirm(String name) {
    return '\"$name\" ile sohbeti silmek istiyor musunuz?';
  }

  @override
  String get commonNoContacts => 'Kişi yok';

  @override
  String get contactAddFriendsToChat => 'Sohbete başlamak için arkadaş ekleyin';

  @override
  String get contactNotFound => 'Kişi bulunamadı';

  @override
  String get contactTryOtherKeywords =>
      'Başka anahtar kelimeler veya genel arama deneyin';

  @override
  String get contactSearchResults => 'Arama sonuçları';

  @override
  String get contactNewFriends => 'Yeni Arkadaşlar';

  @override
  String get contactChatOnlyFriends => 'Chat-only Friends';

  @override
  String get contactOfficialAccounts => 'Resmi Hesaplar';

  @override
  String get contactServiceAccounts => 'Hizmet Hesapları';

  @override
  String get contactEnterpriseContacts => 'Kurumsal Kişiler';

  @override
  String get contactRecommendToFriend => 'Kişiyi paylaş';

  @override
  String get commonSetRemark => 'Not ekle';

  @override
  String get contactSendingCard => 'Kişi kartı gönderiliyor...';

  @override
  String get commonFileLabel => 'Dosya';

  @override
  String get commonLocationLabel => 'Konum';

  @override
  String contactRecommendFailed(String error) {
    return 'Öneri başarısız: $error';
  }

  @override
  String get profileEnterRemark => 'Not girin';

  @override
  String get contactOpeningChat => 'Sohbet açılıyor...';

  @override
  String contactOpenChatFailed(String error) {
    return 'Sohbet açılamadı: $error';
  }

  @override
  String get contactAddContact => 'Kişi Ekle';

  @override
  String get contactEnterUserId => 'Kullanıcı ID\'si girin';

  @override
  String get contactNoFriendRequests => 'Arkadaşlık isteği yok';

  @override
  String get commonAccept => 'Kabul Et';

  @override
  String get commonReject => 'Reddet';

  @override
  String get commonNoGroups => 'Grup yok';

  @override
  String get contactSelectFriendToRecommend => 'Önermek için arkadaş seçin';

  @override
  String get commonSearchContacts => 'Kişilerde ara';

  @override
  String get contactNoContactsFound => 'Kişi bulunamadı';

  @override
  String get favoriteYesterday => 'Dün';

  @override
  String get chatJustNow => 'Az önce';

  @override
  String get profileOnline => 'Çevrimiçi';

  @override
  String get profileOffline => 'Çevrimdışı';

  @override
  String get searchContactsGroupsMessages => 'Kişi, grup ve mesajlarda ara';

  @override
  String get searchError => 'Arama hatası';

  @override
  String get chatSearchHint => 'Kişi, grup ve mesajlarda ara';

  @override
  String get searchHistory => 'Arama Geçmişi';

  @override
  String get commonClear => 'Temizle';

  @override
  String get commonAll => 'Tümü';

  @override
  String get searchGroups => 'Gruplar';

  @override
  String get searchNoResults => 'Sonuç yok';

  @override
  String commonGroupMembers(int count) {
    return 'Üyeler ($count)';
  }

  @override
  String get groupMembersTitle => 'Grup Üyeleri';

  @override
  String get groupViewAll => 'Tümünü gör';

  @override
  String get groupOwner => 'Sahip';

  @override
  String get groupAdmin => 'Yönetici';

  @override
  String get groupInvite => 'Davet Et';

  @override
  String get commonGroupAnnouncement => 'Grup Duyurusu';

  @override
  String get commonNotSet => 'Ayarlanmadı';

  @override
  String get groupDescription => 'Grup Açıklaması';

  @override
  String get groupPublicGroup => 'Herkese Açık Grup';

  @override
  String get commonClearChatHistory => 'Sohbet Geçmişini Temizle';

  @override
  String get commonDissolveGroup => 'Grubu Dağıt';

  @override
  String get commonLeaveGroup => 'Gruptan Ayrıl';

  @override
  String get groupChangeGroupName => 'Grup Adını Değiştir';

  @override
  String get commonEnterGroupName => 'Grup adı girin';

  @override
  String get commonConfirm => 'Onayla';

  @override
  String get groupEnterGroupDescription => 'Grup açıklaması girin';

  @override
  String get groupPublish => 'Yayınla';

  @override
  String get chatClearHistoryConfirm =>
      'Tüm sohbet geçmişini temizle? Bu işlem geri alınamaz.';

  @override
  String get chatClearAction => 'Temizle';

  @override
  String get commonChatHistoryCleared => 'Sohbet geçmişi temizlendi';

  @override
  String get commonDissolve => 'Dağıt';

  @override
  String get groupQrCode => 'Grup QR Kodu';

  @override
  String get commonSearchChatHistory => 'Sohbet Geçmişinde Ara';

  @override
  String get groupIdCopied => 'Grup ID\'si kopyalandı';

  @override
  String get transferEnterOrPasteAddress =>
      'Cüzdan adresini girin veya yapıştırın';

  @override
  String get transferSelectToken => 'Token Seç';

  @override
  String get commonTransferAmount => 'Transfer Tutarı';

  @override
  String get transferAvailable => 'Kullanılabilir';

  @override
  String get transferMemoOptional => 'Not (isteğe bağlı)';

  @override
  String get transferConfirmTransfer => 'Transferi Onayla';

  @override
  String get transferAddressVerified => 'Adres doğrulandı';

  @override
  String transferAvailableBalance(String balance, String symbol) {
    return 'Kullanılabilir: $balance $symbol';
  }

  @override
  String get commonEnterAmount => 'Tutar girin';

  @override
  String get commonRedPacketCountMin => 'En az 1 kırmızı paket gerekli';

  @override
  String get commonViewRedPacketDetails => 'Kırmızı paket detaylarını gör';

  @override
  String get commonEnterTransferAmount => 'Transfer tutarını girin';

  @override
  String get commonTransferTo => 'Transfer hedefi';

  @override
  String commonFromSender(String name, Object senderName) {
    return '$senderName tarafından';
  }

  @override
  String get commonConfirmReceive => 'Alımı Onayla';

  @override
  String get groupProfile => 'Grup Bilgisi';

  @override
  String get groupRemoveMember => 'Gruptan Çıkar';

  @override
  String get commonRemove => 'Çıkar';

  @override
  String get profileClearStatus => 'Durumu Temizle';

  @override
  String get profileClearStatusConfirm => 'Mevcut durumu temizle?';

  @override
  String get profileStatusCleared => 'Durum temizlendi';

  @override
  String get profileUserNotExist => 'Kullanıcı mevcut değil';

  @override
  String get profileUserIdCopied => 'Kullanıcı ID\'si kopyalandı';

  @override
  String get commonReport => 'Şikayet Et';

  @override
  String get profileQrCode => 'QR Kod';

  @override
  String get profileAvatarUpdated => 'Avatar güncellendi';

  @override
  String commonSelectImageFailed(String error) {
    return 'Resim seçilemedi: $error';
  }

  @override
  String get profileChangeName => 'Adı Değiştir';

  @override
  String get profileMale => 'Erkek';

  @override
  String get profileFemale => 'Kadın';

  @override
  String chatFeatureInDev(String feature) {
    return '$feature geliştirme aşamasında...';
  }

  @override
  String profileSaveAddressFailed(String error) {
    return 'Adres kaydedilemedi: $error';
  }

  @override
  String get profileAddNew => 'Ekle';

  @override
  String get profileAddAddress => 'Adres Ekle';

  @override
  String get profileAddressAdded => 'Adres eklendi';

  @override
  String get profileAddressUpdated => 'Adres güncellendi';

  @override
  String get profileDeleteAddress => 'Adresi Sil';

  @override
  String get profileAddressDeleted => 'Adres silindi';

  @override
  String profileSaveInvoiceFailed(String error) {
    return 'Fatura kaydedilemedi: $error';
  }

  @override
  String get profileMyInvoices => 'Faturalarım';

  @override
  String get profileAddInvoice => 'Fatura Ekle';

  @override
  String get profileInvoiceAdded => 'Fatura eklendi';

  @override
  String get profileInvoiceUpdated => 'Fatura güncellendi';

  @override
  String get profileDeleteInvoice => 'Faturayı Sil';

  @override
  String get profileInvoiceDeleted => 'Fatura silindi';

  @override
  String get profilePersonal => 'Bireysel';

  @override
  String get groupSelectAtLeastOne => 'Lütfen en az bir üye seçin';

  @override
  String get chatFileNotExist => 'Dosya mevcut değil';

  @override
  String chatSendFailed(String error) {
    return 'Gönderme başarısız: $error';
  }

  @override
  String get chatCannotOpenBrowser => 'Tarayıcı açılamadı';

  @override
  String chatSelectFileFailed(String error) {
    return 'Dosya seçilemedi: $error';
  }

  @override
  String settingsSetupFailed(String error) {
    return 'Kurulum başarısız: $error';
  }

  @override
  String get transferEnterValidAmount => 'Lütfen geçerli bir tutar girin';

  @override
  String get commonAddressCopied => 'Adres kopyalandı';

  @override
  String favoriteOpenItem(String content) {
    return 'Aç: $content';
  }

  @override
  String get favoriteDeleted => 'Silindi';

  @override
  String get profileWallet => 'Cüzdan';

  @override
  String get chatRecording => 'Kayıt';

  @override
  String get chatInvalidVideoUrl => 'Geçersiz video URL\'si';

  @override
  String get chatDownloadFile => 'Dosyayı indir';

  @override
  String get chatClearChatHistoryTitle => 'Sohbet Geçmişini Temizle';

  @override
  String get chatVideoCall => 'Görüntülü Arama';

  @override
  String get commonVoiceCall => 'Sesli Arama';

  @override
  String get callLeaveMeeting => 'Toplantıdan Ayrıl';

  @override
  String get chatDetails => 'Sohbet Detayları';

  @override
  String get chatViewAllGroupMembers => 'Tüm üyeleri gör';

  @override
  String get chatGroupName => 'Grup Adı';

  @override
  String get chatGroupNameUpdated => 'Grup adı güncellendi';

  @override
  String get chatUpdateFailed => 'Güncelleme başarısız';

  @override
  String get chatNoPermissionToModify => 'Değiştirme izniniz yok';

  @override
  String get chatGroupManagement => 'Grup Yönetimi';

  @override
  String get chatMyNicknameInGroup => 'Gruptaki Takma Adım';

  @override
  String get chatPinChat => 'Sohbeti Sabitle';

  @override
  String get chatStrongReminder => 'Güçlü Hatırlatıcı';

  @override
  String get chatSetChatBackground => 'Sohbet Arka Planını Ayarla';

  @override
  String get chatUnknownFile => 'Bilinmeyen dosya';

  @override
  String get chatDownload => 'İndir';

  @override
  String get chatInvalidLocation => 'Geçersiz konum';

  @override
  String get chatTapToCancel => 'İptal etmek için dokunun';

  @override
  String chatCaptureFailed(Object error) {
    return 'Yakalama başarısız: $error';
  }

  @override
  String get chatProcessingVideo => 'Video işleniyor...';

  @override
  String get chatVideoFileNotExist => 'Video dosyası mevcut değil';

  @override
  String get chatVideoDataEmpty => 'Video verisi boş';

  @override
  String get chatVideoTooLarge => 'Video boyutu 100MB\'ı geçemez';

  @override
  String get chatSendingVideo => 'Video gönderiliyor...';

  @override
  String chatSendVideoFailed(Object error) {
    return 'Video gönderilemedi: $error';
  }

  @override
  String get chatImageFileNotExist => 'Resim dosyası mevcut değil';

  @override
  String get commonImageDataEmpty => 'Resim verisi boş';

  @override
  String get chatSendingImage => 'Resim gönderiliyor...';

  @override
  String chatSendImageFailed(Object error) {
    return 'Resim gönderilemedi: $error';
  }

  @override
  String get chatSendLocation => 'Konum Gönder';

  @override
  String get chatSelectLocationAndSend => 'Konum seçin ve gönderin';

  @override
  String get chatShareRealTimeLocation => 'Gerçek Zamanlı Konum Paylaş';

  @override
  String get chatShareLocationForOneHour =>
      'Arkadaşınızla 1 saat gerçek zamanlı konum paylaşın';

  @override
  String get chatLocationSent => 'Konum gönderildi';

  @override
  String get chatSelectMessages => 'Mesaj seç';

  @override
  String chatSelectedCount(int count) {
    return '$count seçildi';
  }

  @override
  String get chatSelectAll => 'Tümünü Seç';

  @override
  String chatGroupChatCount(int count) {
    return 'Grup Sohbeti ($count)';
  }

  @override
  String get chatPrivateChat => 'Özel Sohbet';

  @override
  String get chatNoMessages => 'Mesaj yok';

  @override
  String get chatSendFirstMessage =>
      'Sohbeti başlatmak için ilk mesajı gönderin';

  @override
  String get chatEncryptionNotice =>
      'Bu sohbet uçtan uca şifrelenmiştir. Mesajları sadece siz ve alıcı okuyabilir.';

  @override
  String get chatMultiForward => 'İlet';

  @override
  String get chatCollect => 'Kaydet';

  @override
  String get chatNoMembers => 'Üye yok';

  @override
  String get chatMemberNotFound => 'Üye bulunamadı';

  @override
  String get chatVoiceFileNotExist => 'Ses dosyası mevcut değil';

  @override
  String get chatVoiceFileEmpty => 'Ses dosyası boş';

  @override
  String get chatSendingVoice => 'Ses gönderiliyor...';

  @override
  String chatSendVoiceFailed(Object error) {
    return 'Ses gönderilemedi: $error';
  }

  @override
  String get chatMessageForwarded => 'Mesaj iletildi';

  @override
  String chatForwardFailed(Object error) {
    return 'İletme başarısız: $error';
  }

  @override
  String get chatUnfavorited => 'Favorilerden çıkarıldı';

  @override
  String get chatFavorited => 'Favorilere eklendi';

  @override
  String get chatReactionAdded => 'Tepki eklendi';

  @override
  String get chatReactionRemoved => 'Tepki kaldırıldı';

  @override
  String get chatFailedMessageDeleted => 'Başarısız mesaj silindi';

  @override
  String get chatDeleteMessages => 'Mesajları sil';

  @override
  String chatDeleteMessagesConfirm(Object count) {
    return '$count mesajı silmek istediğinizden emin misiniz?';
  }

  @override
  String chatNoteOtherMessages(Object count) {
    return 'Not: $count mesaj başkalarına ait ve sadece sizin için silinecek.';
  }

  @override
  String chatMyMessagesWillBeRecalled(Object count) {
    return 'Sizden $count mesaj herkes için geri alınacak.';
  }

  @override
  String chatRecalledCount(Object count, Object localCount) {
    return '$count mesaj geri alındı, $localCount sadece sizin için silindi';
  }

  @override
  String chatRecalledMessages(Object count) {
    return '$count mesaj geri alındı';
  }

  @override
  String chatDeletedLocally(Object count) {
    return '$count mesaj sadece sizin için silindi';
  }

  @override
  String chatForwardedCount(Object count) {
    return '$count mesaj iletildi';
  }

  @override
  String chatForwardComplete(Object failed, Object success) {
    return 'İletme tamamlandı: $success başarılı, $failed başarısız';
  }

  @override
  String get chatRemindOnlyInGroup =>
      'Hatırlatma özelliği sadece grup sohbetlerinde kullanılabilir';

  @override
  String get chatOnlyTextSearchable => 'Sadece metin mesajları aranabilir';

  @override
  String chatSearchFor(Object text) {
    return '\"$text\" ara';
  }

  @override
  String get chatBaiduSearch => 'Baidu Arama';

  @override
  String get chatGoogleSearch => 'Google Arama';

  @override
  String get chatBingSearch => 'Bing Arama';

  @override
  String get chatCalling => 'Aranıyor...';

  @override
  String get chatRinging => 'Çalıyor...';

  @override
  String get chatInCall => 'Aramada';

  @override
  String commonFeatureInDevelopment(String feature) {
    return 'Özellik geliştirme aşamasında...';
  }

  @override
  String chatCollectMessages(Object count) {
    return '$count mesaj kaydedildi';
  }

  @override
  String commonMemberCount(int count) {
    return '$count üye';
  }

  @override
  String groupDone(int count) {
    return 'Tamamlandı($count)';
  }

  @override
  String get profileServices => 'Hizmetler';

  @override
  String get commonFavorites => 'Favoriler';

  @override
  String get profileOrdersAndCards => 'Siparişler ve Kartlar';

  @override
  String get profileStickers => 'Çıkartmalar';

  @override
  String profileStatusSetTo(String status) {
    return 'Durum ayarlandı: $status';
  }

  @override
  String get profileAvatarUploadFailed => 'Avatar yüklemesi başarısız';

  @override
  String get profilePersonalProfile => 'Kişisel Profil';

  @override
  String get profileName => 'Ad';

  @override
  String get profileGender => 'Cinsiyet';

  @override
  String get profileRegion => 'Bölge';

  @override
  String get commonMyQrCode => 'QR Kodum';

  @override
  String get profilePoke => 'Dürt';

  @override
  String get profileRingtone => 'Zil Sesi';

  @override
  String get profileDefaultRingtone => 'Varsayılan Zil Sesi';

  @override
  String get profileMyAddresses => 'Adreslerim';

  @override
  String profileGenderSetTo(String gender) {
    return 'Cinsiyet ayarlandı: $gender';
  }

  @override
  String get profileSelectRegion => 'Bölge Seç';

  @override
  String get profileSelectCity => 'Şehir Seç';

  @override
  String profileRegionSetTo(String region) {
    return 'Bölge ayarlandı: $region';
  }

  @override
  String get profileSetPoke => 'Dürtmeyi Ayarla';

  @override
  String get profileFriendPokedMe => 'Arkadaş beni dürttü';

  @override
  String get profileExample => 'Örnek';

  @override
  String get profileOnTheShoulder => ' omuzdan';

  @override
  String get profilePokeCleared => 'Dürtme temizlendi';

  @override
  String profilePokeSetTo(String suffix) {
    return 'Dürtme ayarlandı: beni dürttü$suffix';
  }

  @override
  String get profileEditSignature => 'İmzayı Düzenle';

  @override
  String get profileIntroduceYourself => 'Kendinizi tanıtacak bir cümle';

  @override
  String get profileSignatureCleared => 'İmza temizlendi';

  @override
  String get profileSignatureUpdated => 'İmza güncellendi';

  @override
  String get profileScanToAddFriend =>
      'Beni arkadaş olarak eklemek için yukarıdaki QR kodu tarayın';

  @override
  String profileRingtoneSetTo(String ringtone) {
    return 'Zil sesi ayarlandı: $ringtone';
  }

  @override
  String commonConfirmDissolveGroup(String name) {
    return '\"$name\" grubunu dağıtmak istediğinize emin misiniz? Bu işlem geri alınamaz.';
  }

  @override
  String get authEnterValidServerAddress =>
      'Lütfen geçerli bir sunucu adresi girin';

  @override
  String get authEmailOtp => 'E-posta OTP';

  @override
  String get authEnterServerAddressFirst => 'Lütfen önce sunucu adresi girin';

  @override
  String get authPasskeyRequiresServer =>
      'Passkey girişi sunucu desteği gerektirir';

  @override
  String get authLoginAgreement => 'Giriş yaparak kabul etmiş olursunuz ';

  @override
  String get authPleaseAgreeToTerms =>
      'Lütfen Hizmet Şartları ve Gizlilik Politikasını okuyun ve kabul edin';

  @override
  String get authRegisterFailed => 'Kayıt başarısız';

  @override
  String get commonReenterPassword => 'Şifreyi tekrar girin';

  @override
  String get commonPasswordsDoNotMatch => 'Şifreler eşleşmiyor';

  @override
  String get authInviteCodeBuiltIn => 'Davet Kodu (Yerleşik)';

  @override
  String get authInviteCodeBuiltInNote =>
      'Davet kodu yerleşiktir, genellikle değiştirmeye gerek yoktur';

  @override
  String get authIHaveReadAndAgree => 'Okudum ve kabul ediyorum ';

  @override
  String get mainStartGroupChat => 'Grup Sohbeti Başlat';

  @override
  String get mainAddFriends => 'Arkadaş Ekle';

  @override
  String get mainPaymentAndCollection => 'Ödeme';

  @override
  String contactCount(int count) {
    return '$count kişi';
  }

  @override
  String get contactAddToHomeScreen => 'Ana ekrana ekle';

  @override
  String contactRecommendedCardTo(String contact, String recipient) {
    return '$contact kartı $recipient kişisine önerildi';
  }

  @override
  String get contactEnterRemarkName => 'Takma ad girin';

  @override
  String contactRemarkSetTo(String remark) {
    return 'Not ayarlandı: $remark';
  }

  @override
  String contactAcceptedFriendRequest(String name) {
    return '$name arkadaşlık isteği kabul edildi';
  }

  @override
  String contactRejectedFriendRequest(String name) {
    return '$name arkadaşlık isteği reddedildi';
  }

  @override
  String get commonGroupInvites => 'Grup Davetleri';

  @override
  String commonMyGroups(int count) {
    return 'Gruplarım ($count)';
  }

  @override
  String get commonInvitedToJoinGroup => 'Gruba davet edildi';

  @override
  String commonConfirmLeaveGroup(String name) {
    return '\"$name\" grubundan ayrılmak istediğinize emin misiniz?';
  }

  @override
  String get commonLeave => 'Ayrıl';

  @override
  String get commonRecallThisMessage => 'Bu mesajı geri al?';

  @override
  String get commonSavedToGallery => 'Galeriye kaydedildi';

  @override
  String get commonFailedToSave => 'Kaydetme başarısız';

  @override
  String get chatSaving => 'Kaydediliyor...';

  @override
  String get commonShare => 'Paylaş';

  @override
  String get chatSaveToGallery => 'Galeriye Kaydet';

  @override
  String chatDownloadFailed(String code) {
    return 'İndirme başarısız: $code';
  }

  @override
  String commonShareFailed(String error) {
    return 'Paylaşım başarısız: $error';
  }

  @override
  String get chatFailedToLoadImage => 'Resim yüklenemedi';

  @override
  String get chatVideoRecordingFailed =>
      'Video kaydı başarısız. Lütfen tekrar deneyin.';

  @override
  String get profileRedPacket => 'Kırmızı Paket';

  @override
  String get commonMusic => 'Müzik';

  @override
  String get commonCoupon => 'Kupon';

  @override
  String get commonGift => 'Hediye';

  @override
  String get commonPoll => 'Anket';

  @override
  String get favoriteText => 'Metin';

  @override
  String get favoriteLinkLabel => 'Bağlantı';

  @override
  String get favoriteNote => 'Not';

  @override
  String get favoriteMyNotes => 'Notlarım';

  @override
  String get favoriteToday => 'Bugün';

  @override
  String favoriteDaysAgoText(int count) {
    return '$count gün önce';
  }

  @override
  String favoriteDateFormat(int month, int day) {
    return '$day/$month';
  }

  @override
  String get favoriteNoFavorites => 'Henüz favori yok';

  @override
  String get favoriteLongPressToFavorite =>
      'Favorilere eklemek için mesaja uzun basın';

  @override
  String get favoriteNewNote => 'Yeni Not';

  @override
  String get favoriteLink => 'Favori Bağlantı';

  @override
  String get favoriteEditTags => 'Etiketleri Düzenle';

  @override
  String get favoriteDeleteFavorite => 'Favoriyi Sil';

  @override
  String get favoriteDeleteFavoriteConfirm =>
      'Bu favoriyi silmek istediğinizden emin misiniz?';

  @override
  String get favoriteNoSearchResultsFound => 'Sonuç bulunamadı';

  @override
  String get commonSendRedPacket => 'Kırmızı Paket Gönder';

  @override
  String get transferAmount => 'Tutar';

  @override
  String get commonRedPacketCover => 'Kırmızı Paket Kapağı';

  @override
  String get commonRedPacketType => 'Kırmızı Paket Türü';

  @override
  String get commonNormalRedPacket => 'Normal';

  @override
  String get commonLuckyRedPacket => 'Şanslı';

  @override
  String get commonRedPacketCount => 'Kırmızı Paket Sayısı';

  @override
  String get commonPieces => 'adet';

  @override
  String get commonPutMoneyInRedPacket => 'Kırmızı pakete para koy';

  @override
  String get commonRedPacketRefundNotice =>
      'Alınmayan kırmızı paketler 24 saat sonra iade edilir';

  @override
  String get commonOpenRedPacket => 'Aç';

  @override
  String get commonRedPacketAllClaimed => 'Kırmızı paket tamamı alındı';

  @override
  String get commonRedPacketExpired => 'Kırmızı paket süresi doldu';

  @override
  String get commonAddTransferNote => 'Transfer notu ekle';

  @override
  String get commonYuan => 'TL';

  @override
  String get commonReplyWithEmoji => 'Bu emoji ile yanıtla';

  @override
  String get contactEditRemark => 'Notu Düzenle';

  @override
  String get contactSetPermissions => 'İzinleri Ayarla';

  @override
  String get profileAddToBlacklist => 'Kara Listeye Ekle';

  @override
  String get contactDeleteContact => 'Kişiyi Sil';

  @override
  String contactDeleteContactConfirm(String name) {
    return '$name kişisini silmek istediğinizden emin misiniz?';
  }

  @override
  String get transferTitle => 'Transfer';

  @override
  String get transferReceiverAddressLabel => 'Alıcı Adresi';

  @override
  String get transferSelectTokenLabel => 'Token Seç';

  @override
  String get transferAmountLabel => 'Transfer Tutarı';

  @override
  String get transferMemoLabel => 'Not (isteğe bağlı)';

  @override
  String get transferAddMemoHint => 'Not ekle';

  @override
  String get transferSendPaymentRequest => 'Ödeme Talebi Gönder';

  @override
  String get transferQrCodeGenerateFailed => 'QR kod oluşturma başarısız';

  @override
  String get transferScanQrToPayMe => 'Bana ödeme yapmak için QR kodu tarayın';

  @override
  String get transferMyWalletAddress => 'Cüzdan Adresim';

  @override
  String get transferCreatePaymentRequest => 'Ödeme Talebi Oluştur';

  @override
  String profileN42IdLabel(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get commonRedPacketDefaultGreeting => 'İyi dilekler';

  @override
  String commonSenderRedPacket(String name) {
    return '$name Kırmızı Paketi';
  }

  @override
  String get transferEnterValidAddress => 'Lütfen geçerli bir adres girin';

  @override
  String get transferPleaseSelectToken => 'Lütfen bir token seçin';

  @override
  String get commonReceivedTransfer => 'Transfer Alındı';

  @override
  String commonSenderSentRedPacket(String name) {
    return '$name bir kırmızı paket gönderdi';
  }

  @override
  String get commonSavedToBalance =>
      'Bakiyeye kaydedildi, doğrudan transfer edilebilir';

  @override
  String get commonRedPacketExpiredOrEmpty =>
      'Kırmızı paket süresi doldu/tamamı alındı';

  @override
  String get transferScanFeatureComingSoon => 'Tarama özelliği yakında...';

  @override
  String get contactSetAsStarred => 'Yıldızlı Olarak Ayarla';

  @override
  String get contactAddToBlocklist => 'Engelleme Listesine Ekle';

  @override
  String get commonClaimedYour => ' sizinkini aldı ';

  @override
  String get commonClaimedText => ' aldı ';

  @override
  String commonUserTyping(String name) {
    return '$name yazıyor...';
  }

  @override
  String get commonTyping => 'Yazıyor...';

  @override
  String get commonWaitingToReceive => 'Alınmayı bekliyor';

  @override
  String get commonTapToClaim => 'Almak için dokunun';

  @override
  String get commonHasBeenReceived => 'Alındı';

  @override
  String get commonGetLucky => 'Şansını dene';

  @override
  String get qrcodeCameraStartFailed => 'Kamera başlatılamadı';

  @override
  String get qrcodeUnknownError => 'Bilinmeyen hata';

  @override
  String get qrcodePlaceQrCodeInFrame =>
      'QR kodu taramak için çerçeveye yerleştirin';

  @override
  String get qrcodeCloseManualInput => 'Manuel Girişi Kapat';

  @override
  String get qrcodeManualInputUserId => 'Manuel Kullanıcı ID Girişi';

  @override
  String get commonAdd => 'Ekle';

  @override
  String get profileSetStatus => 'Durum Ayarla';

  @override
  String get profileVisibleToFriends24h => '24 saat arkadaşlara görünür';

  @override
  String get profileWriteStatus => 'Durum Yaz';

  @override
  String get profileEnterYourStatus => 'Durumunuzu girin...';

  @override
  String get profileOk => 'Tamam';

  @override
  String get qrcodeCameraPermissionRequired =>
      'QR kod taramak için kamera izni gerekli';

  @override
  String get qrcodeCameraPermissionDenied =>
      'Kamera izni kalıcı olarak reddedildi. Lütfen sistem ayarlarından etkinleştirin.';

  @override
  String qrcodePermissionCheckError(String error) {
    return 'İzin kontrol hatası: $error';
  }

  @override
  String get qrcodeInvalidQrCode => 'Geçersiz QR kod';

  @override
  String qrcodeCannotAddFriend(String error) {
    return 'Arkadaş eklenemedi: $error';
  }

  @override
  String get qrcodeScanQrCode => 'QR Kod Tara';

  @override
  String get qrcodeCheckingCameraPermission =>
      'Kamera izni kontrol ediliyor...';

  @override
  String get qrcodeNeedCameraPermission => 'Kamera İzni Gerekli';

  @override
  String get qrcodeRetryPermission => 'Tekrar Dene';

  @override
  String get qrcodeOpenSettings => 'Ayarları Aç';

  @override
  String get groupInviteMembers => 'Üye Davet Et';

  @override
  String groupInviteCount(int count) {
    return 'Davet Et($count)';
  }

  @override
  String get profileNoShippingAddress => 'Teslimat adresi yok';

  @override
  String get profileDefaultLabel => 'Varsayılan';

  @override
  String get profileNoInvoice => 'Fatura yok';

  @override
  String get profileCompany => 'Şirket';

  @override
  String get profileTaxNumber => 'Vergi Numarası';

  @override
  String get profileConfirmDeleteAddress =>
      'Bu adresi silmek istediğinizden emin misiniz?';

  @override
  String get profileConfirmDeleteInvoice =>
      'Bu faturayı silmek istediğinizden emin misiniz?';

  @override
  String get commonGroupOwner => 'Sahip';

  @override
  String get commonGroupAdmin => 'Yönetici';

  @override
  String get groupSearchMembers => 'Üyelerde ara';

  @override
  String groupTotalMembers(int count) {
    return '$count üye';
  }

  @override
  String get chatRemoveFromGroup => 'Gruptan Çıkar';

  @override
  String groupConfirmRemoveMember(String name) {
    return '\"$name\" kişisini gruptan çıkarmak istediğinizden emin misiniz?';
  }

  @override
  String get chatUnknownSong => 'Bilinmeyen Şarkı';

  @override
  String get chatUnknownArtist => 'Bilinmeyen Sanatçı';

  @override
  String get chatUnknownContact => 'Bilinmeyen Kişi';

  @override
  String get chatPersonalCard => 'Kişi Kartı';

  @override
  String get chatSingleChoice => 'Tekli';

  @override
  String get chatMultiChoice => 'Çoklu';

  @override
  String get chatEnded => 'Sona erdi';

  @override
  String get chatEndPollButton => 'Anketi Bitir';

  @override
  String get chatPollHint =>
      'Anket sohbette görüntülenecek. Grup üyeleri oy verebilir.';

  @override
  String get chatSearchSongOrArtist => 'Şarkı veya sanatçı ara';

  @override
  String get chatNoSongsFound => 'Şarkı bulunamadı';

  @override
  String get chatSongNameOptional => 'Şarkı Adı (İsteğe bağlı)';

  @override
  String get chatEnterSongName => 'Şarkı adı girin';

  @override
  String get chatArtistNameOptional => 'Sanatçı Adı (İsteğe bağlı)';

  @override
  String get chatEnterArtistName => 'Sanatçı adı girin';

  @override
  String get chatRealTimeLocationSharing =>
      'Gerçek zamanlı konum paylaşımı geliştirme aşamasında...';

  @override
  String get profileVoiceCallFeatureInDev =>
      'Sesli arama özelliği geliştirme aşamasında...';

  @override
  String get profileReportFeatureInDev =>
      'Şikayet özelliği geliştirme aşamasında...';

  @override
  String get profileShareFeatureInDev =>
      'Paylaşım özelliği geliştirme aşamasında...';

  @override
  String get profileQrCodeFeatureInDev =>
      'QR kod özelliği geliştirme aşamasında...';

  @override
  String get qrcodeScanQrToAddMe =>
      'Beni arkadaş olarak eklemek için yukarıdaki QR kodu tarayın';

  @override
  String get qrcodeSaveToAlbum => 'Albüme Kaydet';

  @override
  String get qrcodeChangeStyle => 'Stili Değiştir';

  @override
  String get qrcodeCopyId => 'ID Kopyala';

  @override
  String get qrcodeIdCopied => 'ID kopyalandı';

  @override
  String get qrcodeMoreStylesFeatureComingSoon => 'Daha fazla stil yakında';

  @override
  String get profileBio => 'Biyografi';

  @override
  String get profileHomeServer => 'Sunucu';

  @override
  String get profileShareContactCard => 'Kişi Kartını Paylaş';

  @override
  String get profileRemoveFromBlacklist => 'Kara Listeden Çıkar';

  @override
  String get profileConfirmAddBlacklist =>
      'Bu kullanıcıyı kara listeye eklemek istediğinizden emin misiniz? Onlardan mesaj almayacaksınız.';

  @override
  String get profileConfirmRemoveBlacklist =>
      'Bu kullanıcıyı kara listeden çıkarmak istediğinizden emin misiniz?';

  @override
  String get profileRemarkSaved => 'Not kaydedildi';

  @override
  String get profileRemarkCleared => 'Not temizlendi';

  @override
  String get transferReceive => 'Al';

  @override
  String get transferPleaseConnectWallet => 'Lütfen önce cüzdanınızı bağlayın';

  @override
  String get transferSendRequest => 'Talep Gönder';

  @override
  String get transferPleaseEnterValidAmount => 'Lütfen geçerli bir tutar girin';

  @override
  String get searchPlaceholder => 'Kişi, grup ve mesajlarda ara';

  @override
  String get searchEnterKeywordToSearch =>
      'Aramaya başlamak için anahtar kelime girin';

  @override
  String get searchClearHistory => 'Temizle';

  @override
  String searchNoResultsForQuery(String query) {
    return '\"$query\" için sonuç bulunamadı';
  }

  @override
  String get searchAllResults => 'Tümü';

  @override
  String get searchInChat => 'Sohbette ara';

  @override
  String get searchContactLabel => 'Kişi';

  @override
  String get searchGroupLabel => 'Grup';

  @override
  String get searchConversationLabel => 'Sohbet';

  @override
  String get searchMessageLabel => 'Mesaj';

  @override
  String get settingsSecurityTitle => 'Güvenlik';

  @override
  String get settingsKeyBackup => 'Anahtar Yedekleme';

  @override
  String get settingsBackupEncryptionKeys => 'Şifreleme Anahtarlarını Yedekle';

  @override
  String settingsKeysBackedUp(int count) {
    return '$count anahtar yedeklendi';
  }

  @override
  String get settingsBackupNotSet => 'Yedekleme ayarlanmadı';

  @override
  String get settingsRestoreKeys => 'Anahtarları Geri Yükle';

  @override
  String get settingsRestoreKeysFromBackup =>
      'Yedekten şifreleme anahtarlarını geri yükle';

  @override
  String get settingsExportKeys => 'Anahtarları Dışa Aktar';

  @override
  String get settingsExportKeysToFile => 'Anahtarları dosyaya aktar';

  @override
  String get settingsLoggedInDevices => 'Giriş Yapılmış Cihazlar';

  @override
  String get settingsNoOtherDevices => 'Başka cihaz yok';

  @override
  String get settingsVerified => 'Doğrulanmış';

  @override
  String get settingsUnverified => 'Doğrulanmamış';

  @override
  String get settingsAdvanced => 'Gelişmiş';

  @override
  String get settingsCrossSigning => 'Çapraz İmza';

  @override
  String get settingsEnabled => 'Etkin';

  @override
  String get settingsNotEnabled => 'Etkin değil';

  @override
  String get settingsResetEncryption => 'Şifrelemeyi Sıfırla';

  @override
  String get settingsDeleteAllEncryptionKeys =>
      'Tüm şifreleme anahtarlarını sil';

  @override
  String get settingsEncryptionNotSupported => 'Şifreleme desteklenmiyor';

  @override
  String get settingsNotInitialized => 'Başlatılmadı';

  @override
  String get settingsBackupKeyTitle => 'Anahtarları Yedekle';

  @override
  String get settingsBackupKeyMessage =>
      'Yeni bir anahtar yedeklemesi oluştur? Bu, yeni bir cihazda şifrelenmiş mesajları geri yüklemenize yardımcı olacaktır.';

  @override
  String get settingsBackup => 'Yedekle';

  @override
  String get settingsRestoreKeyTitle => 'Anahtarları Geri Yükle';

  @override
  String get settingsRestoreKeyMessage =>
      'Şifrelenmiş mesajları geri yüklemek için kurtarma şifrenizi veya kurtarma anahtarınızı girin.';

  @override
  String get settingsRestore => 'Geri Yükle';

  @override
  String get settingsExportKeyTitle => 'Anahtarları Dışa Aktar';

  @override
  String get settingsExportKeyMessage =>
      'Dışa aktarılan anahtar dosyası tüm şifreleme anahtarlarınızı içerir. Lütfen güvenli bir yerde saklayın.';

  @override
  String get settingsExport => 'Dışa Aktar';

  @override
  String settingsDeviceIdLabel(String deviceId) {
    return 'Cihaz ID: $deviceId';
  }

  @override
  String get settingsDeviceStatusVerified => 'Durum: Doğrulanmış';

  @override
  String get settingsDeviceStatusUnverified => 'Durum: Doğrulanmamış';

  @override
  String settingsLastActiveLabel(String lastSeen) {
    return 'Son etkinlik: $lastSeen';
  }

  @override
  String get settingsVerifyThisDevice => 'Bu cihazı doğrula';

  @override
  String get settingsCrossSigningAlreadyEnabled => 'Çapraz imza zaten etkin';

  @override
  String get settingsCrossSigningSetupSuccess =>
      'Çapraz imza kurulumu başarılı';

  @override
  String get settingsResetEncryptionTitle => 'Şifrelemeyi Sıfırla';

  @override
  String get settingsResetEncryptionWarning =>
      'Uyarı: Bu tüm şifreleme anahtarlarınızı silecektir. Önceki şifrelenmiş mesajların şifresini çözemeyeceksiniz. Bu işlem geri alınamaz.';

  @override
  String get settingsReset => 'Sıfırla';

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
      'Toplantıdan ayrılmak istediğinizden emin misiniz?';

  @override
  String chatPokedSomeone(String name, String suffix) {
    return '$name kişisini$suffix dürttü';
  }

  @override
  String get chatNoContactsToAdd => 'Eklenecek kişi yok';

  @override
  String get chatAddMembers => 'Üye Ekle';

  @override
  String chatInvitedMembers(int count) {
    return '$count üye davet edildi';
  }

  @override
  String chatInviteFailed(String error) {
    return 'Davet başarısız: $error';
  }

  @override
  String get chatMemberRemoved => 'Üye çıkarıldı';

  @override
  String chatRemoveFailed(String error) {
    return 'Çıkarma başarısız: $error';
  }

  @override
  String get chatRealTimeLocationShareMessage =>
      'Paylaştıktan sonra, karşı taraf 1 saat boyunca gerçek zamanlı konumunuzu görebilir.';

  @override
  String get chatStartSharing => 'Paylaşımı Başlat';

  @override
  String get chatLocationServiceNotEnabled => 'Konum servisi etkin değil';

  @override
  String get chatEnableLocationService =>
      'Bu özelliği kullanmak için lütfen konum servisini etkinleştirin';

  @override
  String get chatGoToSettings => 'Ayarlara Git';

  @override
  String get chatLocationPermissionRequired =>
      'Bu özellik için konum izni gerekli';

  @override
  String get chatLocationPermissionDeniedPermanent =>
      'Konum izni kalıcı olarak reddedildi. Lütfen ayarlardan etkinleştirin.';

  @override
  String get chatLocationPermissionDenied => 'Konum izni reddedildi';

  @override
  String get chatGettingLocation => 'Konum alınıyor...';

  @override
  String chatGetLocationFailed(String error) {
    return 'Konum alınamadı: $error';
  }

  @override
  String get chatMapPreview => 'Harita Önizleme';

  @override
  String get chatSearchLocation => 'Konum ara';

  @override
  String chatRedPacketSent(String amount, String token) {
    return '$amount $token kırmızı paket gönderildi';
  }

  @override
  String get chatTransferDefault => 'Transfer';

  @override
  String chatTransferSent(String amount, String token) {
    return '$amount $token transfer gönderildi';
  }

  @override
  String chatPickFileFailed(String error) {
    return 'Dosya seçilemedi: $error';
  }

  @override
  String get chatFileSizeLimit => 'Dosya boyutu 50MB\'ı geçemez';

  @override
  String chatFileSending(String filename) {
    return 'Dosya gönderiliyor: $filename';
  }

  @override
  String chatSendFileFailed(String error) {
    return 'Dosya gönderilemedi: $error';
  }

  @override
  String chatContactCardSent(String name) {
    return '$name kişi kartı gönderildi';
  }

  @override
  String get chatFavoritesFeature => 'Favoriler';

  @override
  String get chatCouponsFeature => 'Kuponlar';

  @override
  String get chatGiftFeature => 'Hediye';

  @override
  String chatSharedMusic(String name) {
    return '$name paylaşıldı';
  }

  @override
  String get chatEndPollTitle => 'Anketi Bitir';

  @override
  String get chatEndPollConfirmMessage =>
      'Bu anketi bitirmek istediğinizden emin misiniz? Bitirdikten sonra oylama kapanacaktır.';

  @override
  String get chatPollEndedMessage => 'Anket sona erdi';

  @override
  String get chatConnectingCall => 'Bağlanıyor...';

  @override
  String get chatMuteCall => 'Sessize Al';

  @override
  String get chatSpeakerOff => 'Hoparlör Kapalı';

  @override
  String get chatSpeakerOn => 'Hoparlör';

  @override
  String get chatCameraOn => 'Kamera Açık';

  @override
  String get chatCameraOff => 'Kamera Kapalı';

  @override
  String get chatHangUp => 'Kapat';

  @override
  String get chatSelectForwardTargetTitle => 'İletilecek Hedefi Seçin';

  @override
  String get chatNoForwardableChat => 'İletmek için sohbet yok';

  @override
  String get chatNoMatchingChat => 'Eşleşen sohbet bulunamadı';

  @override
  String get chatLocationTitle => 'Konum';

  @override
  String get chatSendButton => 'Gönder';

  @override
  String get chatRetryButton => 'Tekrar Dene';

  @override
  String get chatSearchContactHint => 'Kişilerde ara';

  @override
  String get chatShareMusic => 'Müzik Paylaş';

  @override
  String get chatRecentPlayed => 'Son Çalınanlar';

  @override
  String get chatMyFavorites => 'Favorilerim';

  @override
  String get chatNetworkLink => 'Bağlantı';

  @override
  String get chatLocalFile => 'Yerel';

  @override
  String get chatPasteMusicLink => 'Müzik bağlantısı yapıştırın';

  @override
  String get chatShareMusicButton => 'Müzik Paylaş';

  @override
  String get chatSelectLocalAudio => 'Yerel Ses Dosyası Seç';

  @override
  String get chatSupportedAudioFormats =>
      'MP3, M4A, WAV, FLAC vb. desteklenir.';

  @override
  String get chatSelectFileButton => 'Dosya Seç';

  @override
  String get chatPleaseEnterMusicLink => 'Lütfen müzik bağlantısı girin';

  @override
  String get chatPleaseEnterValidLink => 'Lütfen geçerli bir URL girin';

  @override
  String get chatSharedSong => 'Paylaşılan Şarkı';

  @override
  String get chatSelectMember => 'Üye Seç';

  @override
  String get chatSearchMemberHint => 'Üyelerde ara';

  @override
  String get chatNoMatchingMembers => 'Eşleşen üye bulunamadı';

  @override
  String get commonUnknownMember => 'Bilinmeyen';

  @override
  String chatSelectedMessagesCount(int count) {
    return '$count mesaj seçildi';
  }

  @override
  String get chatSearchContactsOrGroups => 'Kişi veya gruplarda ara';

  @override
  String get chatVideoTitle => 'Video';

  @override
  String get chatLoadingText => 'Yükleniyor...';

  @override
  String get chatVideoLoadFailed => 'Video yüklenemedi';

  @override
  String get chatPlayerInitFailed => 'Oynatıcı başlatılamadı';

  @override
  String get chatCreatePollTitle => 'Anket Oluştur';

  @override
  String get chatSubmitPoll => 'Gönder';

  @override
  String get chatPollQuestionLabel => 'Anket Sorusu';

  @override
  String get chatEnterPollQuestionHint => 'Anket sorusu girin';

  @override
  String get chatPollOptionsLabel => 'Anket Seçenekleri';

  @override
  String chatOptionHintWithIndex(int index) {
    return 'Seçenek $index';
  }

  @override
  String get chatAddOptionButton => 'Seçenek Ekle';

  @override
  String get chatPollSettingsLabel => 'Anket Ayarları';

  @override
  String get chatSelectionType => 'Seçim Türü';

  @override
  String get chatSingleChoiceLabel => 'Tekli';

  @override
  String get chatMultiChoiceLabel => 'Çoklu';

  @override
  String get chatAnonymousPollSwitch => 'Anonim Anket';

  @override
  String get chatPleaseEnterQuestion => 'Lütfen anket sorusu girin';

  @override
  String get chatAtLeastTwoOptions => 'En az 2 seçenek gerekli';

  @override
  String chatConfirmWithCount(int count) {
    return 'Onayla ($count)';
  }

  @override
  String get authEmailVerificationTitle => 'E-posta Doğrulama';

  @override
  String get authEnterValidEmailAddress =>
      'Lütfen geçerli bir e-posta adresi girin';

  @override
  String authVerificationCodeSentTo(String email) {
    return '$email adresine doğrulama kodu gönderildi';
  }

  @override
  String authSendCodeFailed(String error) {
    return 'Kod gönderilemedi: $error';
  }

  @override
  String get authVerificationSuccess => 'Doğrulama başarılı';

  @override
  String get authVerificationFailed => 'Doğrulama başarısız';

  @override
  String authVerificationCodeError(String error) {
    return 'Doğrulama kodu hatası: $error';
  }

  @override
  String get commonEnterVerificationCode => 'Doğrulama kodunu girin';

  @override
  String get authEnterYourEmail => 'E-posta girin';

  @override
  String authWeSentCodeTo(String email) {
    return '$email adresine\n6 haneli kod gönderdik';
  }

  @override
  String get authEnterEmailForCode =>
      'E-posta adresinizi girin, doğrulama kodu göndereceğiz';

  @override
  String get commonSendVerificationCode => 'Doğrulama kodu gönder';

  @override
  String get authResendVerificationCode => 'Doğrulama kodunu tekrar gönder';

  @override
  String authCanResendAfter(int seconds) {
    return '$seconds saniye sonra tekrar gönderilebilir';
  }

  @override
  String get commonChangeEmail => 'E-postayı değiştir';

  @override
  String get contactAddToContacts => 'Kişilere Ekle';

  @override
  String get contactAddingToContacts => 'Ekleniyor...';

  @override
  String get contactAddedToContacts => 'Kişilere eklendi';

  @override
  String contactAddFailedWithError(String error) {
    return 'Ekleme başarısız: $error';
  }

  @override
  String get contactAddPhone => 'Telefon ekle';

  @override
  String get contactAddTag => 'Etiket ekle';

  @override
  String get contactAddText => 'Metin ekle';

  @override
  String get contactAddPhoto => 'Fotoğraf ekle';

  @override
  String contactGroupCountLabel(int count) {
    return '$count grup';
  }

  @override
  String get contactAddedViaSearch => 'Arama yoluyla eklendi';

  @override
  String get contactAddTime => 'Zaman ekle';

  @override
  String get contactDoneButton => 'Tamam';

  @override
  String get callWaitingForParticipants => 'Katılımcılar bekleniyor...';

  @override
  String callParticipantMe(String name) {
    return '$name (Ben)';
  }

  @override
  String get callSharingLabel => 'Paylaşılıyor';

  @override
  String callScreenSharingBy(String name) {
    return '$name ekran paylaşıyor';
  }

  @override
  String callParticipantCount(int count) {
    return '$count katılımcı';
  }

  @override
  String get callMuteLabel => 'Sessize Al';

  @override
  String get callUnmuteLabel => 'Sesi Aç';

  @override
  String get callTurnOffVideo => 'Videoyu kapat';

  @override
  String get callTurnOnVideo => 'Videoyu aç';

  @override
  String get callShareScreen => 'Ekran paylaş';

  @override
  String get callStopSharing => 'Paylaşımı durdur';

  @override
  String get callSwitchCameraLabel => 'Değiştir';

  @override
  String get callLeaveLabel => 'Ayrıl';

  @override
  String get callParticipantsLabel => 'Katılımcılar';

  @override
  String get callJoiningMeeting => 'Toplantıya katılınıyor...';

  @override
  String chatPollVotesFormat(int count, String percentage) {
    return '$count oy ($percentage%)';
  }

  @override
  String chatPollParticipantsFormat(int count) {
    return '$count katılımcı';
  }

  @override
  String get commonTapToRetry => 'Tekrar denemek için dokunun';

  @override
  String get chatDefaultRedPacketGreeting => 'Bol şans ve bereket dilerim';

  @override
  String get groupAllowOthersToSearchAndJoin =>
      'Başkalarının arama yapmasına ve katılmasına izin ver';

  @override
  String get groupConfirmClearChatHistory =>
      'Sohbet geçmişini temizlemek istediğinizden emin misiniz?';

  @override
  String get groupCreateGroupToChat =>
      'Sohbet etmeye başlamak için bir grup oluşturun';

  @override
  String get groupEditGroupAnnouncement => 'Grup duyurusunu düzenle';

  @override
  String get groupEditGroupDescription => 'Grup açıklamasını düzenle';

  @override
  String get groupEnterGroupAnnouncement => 'Grup duyurusunu girin';

  @override
  String chatErrorWithMessage(String message) {
    return 'Hata: $message';
  }

  @override
  String groupMemberCountClickToCopy(int count) {
    return '$count üye, grup ID\'sini kopyalamak için tıklayın';
  }

  @override
  String get chatMusicLinkLabel => 'Müzik bağlantısı';

  @override
  String get chatNoMediaUrlAvailable => 'Medya URL\'si mevcut değil';

  @override
  String get groupNoPermissionToEditGroupName =>
      'Grup adını düzenleme izniniz yok';

  @override
  String get chatRedPacketTransferCannotForward =>
      'Kırmızı zarflar ve transferler iletilemez';

  @override
  String get authEmailAddress => 'E-posta adresi';

  @override
  String get commonEnterEmailAddress => 'E-posta adresini girin';

  @override
  String get authEmailRecoveryHint => 'Şifre kurtarma için kullanılır';

  @override
  String get commonInvalidEmailFormat => 'Geçerli bir e-posta adresi girin';

  @override
  String get authOptional => 'İsteğe bağlı';

  @override
  String get authResetPassword => 'Şifre sıfırla';

  @override
  String get authEnterRegisteredEmail =>
      'Kayıt olduğunuz e-posta adresini girin';

  @override
  String get authSendResetCode => 'Sıfırlama kodu gönder';

  @override
  String authResetCodeSent(String email) {
    return 'Sıfırlama kodu $email adresine gönderildi';
  }

  @override
  String get authEnterResetCode => 'Sıfırlama kodunu girin';

  @override
  String get authSetNewPassword => 'Yeni şifre belirle';

  @override
  String get commonConfirmNewPassword => 'Yeni şifreyi onayla';

  @override
  String get commonNewPassword => 'Yeni şifre';

  @override
  String get authPasswordResetSuccess =>
      'Şifre başarıyla sıfırlandı. Yeni şifrenizle giriş yapın.';

  @override
  String get authResetPasswordFailed => 'Şifre sıfırlanamadı';

  @override
  String get settingsChangePassword => 'Şifre değiştir';

  @override
  String get settingsCurrentPassword => 'Mevcut şifre';

  @override
  String get settingsEnterCurrentPassword => 'Mevcut şifreyi girin';

  @override
  String get settingsEnterNewPassword => 'Yeni şifreyi girin';

  @override
  String get settingsPasswordChanged =>
      'Şifre başarıyla değiştirildi. Yeni şifrenizle giriş yapın.';

  @override
  String get settingsChangePasswordFailed => 'Şifre değiştirilemedi';

  @override
  String get settingsNewPasswordMustBeDifferent =>
      'Yeni şifre mevcut şifreden farklı olmalıdır';

  @override
  String get settingsChangePasswordInfo =>
      'Şifre değiştirildikten sonra çıkış yapılacak ve yeni şifre ile giriş yapmanız gerekecek.';

  @override
  String get settingsPasswordRequirements => 'Şifre gereksinimleri:';

  @override
  String get settingsSecurityNote =>
      'Güvenlik için şifre değiştirdikten sonra tüm cihazlarda yeniden giriş yapmanız gerekecek.';

  @override
  String get settingsSecurity => 'Güvenlik';

  @override
  String get settingsCurrentBoundEmail => 'Mevcut bağlı e-posta';

  @override
  String get settingsNewEmailAddress => 'Yeni e-posta adresi';

  @override
  String get settingsEnterNewEmail => 'Yeni e-posta adresini girin';

  @override
  String get settingsVerificationCode => 'Doğrulama kodu';

  @override
  String get settingsVerificationCodeSent => 'Doğrulama kodu gönderildi';

  @override
  String get settingsCodeSentTo => 'Doğrulama kodu gönderildi';

  @override
  String get settingsDidNotReceiveCode => 'Kodu almadınız mı?';

  @override
  String get settingsEmailChangedSuccess => 'E-posta başarıyla değiştirildi';

  @override
  String get settingsChangeEmailFailed => 'E-posta değiştirilemedi';

  @override
  String get settingsEmailSecurityNote =>
      'E-postanız şifre kurtarma için kullanılır. Güvende tutun.';

  @override
  String get commonGoogleLogin => 'Google ile giriş yap';

  @override
  String get commonAppleLogin => 'Apple ile giriş yap';

  @override
  String get commonWechat => 'WeChat';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get settingsLanguageChanged => 'Dil değiştirildi';

  @override
  String get settingsTranslation => '翻译';

  @override
  String get settingsTranslateTextTo => '将文字翻译为';

  @override
  String get settingsTranslateDescription => '选择你希望将消息翻译成的语言。';

  @override
  String get settingsAutoTranslate => '自动翻译聊天中收到的消息';

  @override
  String get settingsAutoTranslateDescription => '自动将聊天中收到的消息翻译为你选择的语言。';

  @override
  String get settingsBiometricLogin => 'Biyometrik giriş';

  @override
  String authLoginWithBiometric(Object type) {
    return '$type ile giriş yap';
  }

  @override
  String get settingsBiometricLoginEnabled => 'Biyometrik giriş etkin';

  @override
  String get settingsBiometricLoginDisabled => 'Biyometrik giriş devre dışı';

  @override
  String get settingsEnableBiometricLogin => 'Biyometrik girişi etkinleştir';

  @override
  String get settingsBiometricEnabled => 'Etkin - Giriş için biyometri kullan';

  @override
  String get settingsBiometricDisabled =>
      'Devre dışı - Etkinleştirmek için dokunun';

  @override
  String get settingsBiometricNeedRelogin =>
      'Biyometrik girişi etkinleştirmek için çıkış yapıp tekrar giriş yapın';

  @override
  String get authOr => 'VEYA';

  @override
  String get qrcodeCameraPermissionRestricted =>
      'Bu cihazda kamera erişimi kısıtlı';

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
  String get profileEnterPokeSuffixHint => 'Dürtme ekini girin, ör.: omzuna';

  @override
  String get groupAlbum => 'Grup albümü';

  @override
  String get groupFiles => 'Grup dosyaları';

  @override
  String get groupImages => 'Görseller';

  @override
  String get groupVideos => 'Videolar';

  @override
  String get groupTotal => 'Toplam';

  @override
  String get groupSize => 'Boyut';

  @override
  String get groupNoMedia => 'Medya yok';

  @override
  String get groupNoMediaDescription =>
      'Bu grupta henüz fotoğraf veya video yok';

  @override
  String get groupDocuments => 'Belgeler';

  @override
  String get groupNoFiles => 'Dosya yok';

  @override
  String get groupNoFilesDescription => 'Bu grupta henüz dosya yok';

  @override
  String groupDownloadStarted(String filename) {
    return '$filename indiriliyor...';
  }

  @override
  String get contactNoCommonGroups => 'Ortak grup yok';

  @override
  String get contactNoCommonGroupsDescription => 'Ortak grubunuz yok';

  @override
  String get chatVoiceMessage => 'Ses';

  @override
  String get chatMessage => 'Mesaj';

  @override
  String get conversationHideChat => 'Gizle';

  @override
  String get settingsQuickReply => 'Hızlı yanıt';

  @override
  String get commonTranslate => 'Çevir';

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
    return 'Sohbet: $roomId';
  }

  @override
  String commonContactWithId(String userId) {
    return 'Kişi: $userId';
  }

  @override
  String get commonDiscover => 'Keşfet';

  @override
  String commonDeveloping(String title) {
    return '$title\n(Yakında)';
  }

  @override
  String get commonPageNotFound => 'Sayfa bulunamadı';

  @override
  String get commonBackToHome => 'Ana Sayfaya Dön';

  @override
  String get settingsMessageNotifications => 'Mesaj bildirimleri';

  @override
  String get settingsReceiveNewMessageNotifications =>
      'Yeni mesaj bildirimleri al';

  @override
  String get settingsShowMessagePreview => 'Mesaj önizlemesini göster';

  @override
  String get settingsShowMessageContentInNotification =>
      'Bildirimlerde mesaj içeriğini göster';

  @override
  String get settingsNotificationSound => 'Bildirim sesi';

  @override
  String get settingsPlaySoundOnMessage => 'Mesaj alındığında ses çal';

  @override
  String get commonVibration => 'Titreşim';

  @override
  String get settingsVibrateOnMessage => 'Mesaj alındığında titret';

  @override
  String get settingsDoNotDisturbMode => 'Rahatsız etmeyin';

  @override
  String get settingsDoNotDisturbDescription =>
      'Belirtilen süre boyunca bildirim alma';

  @override
  String get settingsStartTime => 'Başlangıç saati';

  @override
  String get settingsEndTime => 'Bitiş saati';

  @override
  String get settingsDeleteQuickReply => 'Hızlı yanıtı sil';

  @override
  String get settingsEditQuickReply => 'Hızlı yanıtı düzenle';

  @override
  String get settingsAddQuickReply => 'Hızlı yanıt ekle';

  @override
  String get settingsManageQuickReplies => 'Hızlı yanıtları yönet';

  @override
  String get settingsNoQuickReplies => 'Hızlı yanıt yok';

  @override
  String get settingsDefaultQuickReplies =>
      'Varsayılan hızlı yanıtlar gösterilecek';

  @override
  String get settingsWhoCanSee => 'Kimler görebilir';

  @override
  String get settingsLastSeen => 'Son görülme';

  @override
  String get settingsHiddenChats => 'Gizli sohbetler';

  @override
  String get settingsMessagesLabel => 'Mesajlar';

  @override
  String get settingsAllowStrangerMessages =>
      'Yabancılardan mesajlara izin ver';

  @override
  String get settingsReceiveMessagesFromNonContacts =>
      'Kişiler dışından mesaj al';

  @override
  String get settingsReadReceipts => 'Okundu bilgisi';

  @override
  String get settingsLetOthersKnowYouRead =>
      'Başkalarının mesajlarını okuduğunuzu bilmelerini sağlayın';

  @override
  String get settingsTypingIndicator => 'Yazma göstergesi';

  @override
  String get settingsLetOthersKnowYouTyping =>
      'Başkalarının yazdığınızı bilmelerini sağlayın';

  @override
  String get settingsEveryone => 'Herkes';

  @override
  String get settingsContactsOnly => 'Sadece kişiler';

  @override
  String get settingsNobody => 'Hiç kimse';

  @override
  String settingsWhoCanSeeTitle(String title) {
    return '$title kimler görebilir';
  }

  @override
  String settingsVersionInfo(String version) {
    return 'Sürüm $version';
  }

  @override
  String get settingsCheckForUpdates => 'Güncellemeleri kontrol et';

  @override
  String get settingsOpenSourceLicenses => 'Açık kaynak lisansları';

  @override
  String get settingsFeedbackAndSuggestions => 'Geri bildirim ve öneriler';

  @override
  String get settingsBuiltOnMatrix => 'Matrix protokolü üzerine kurulu';

  @override
  String get settingsNoHiddenChats => 'Gizli sohbet yok';

  @override
  String get settingsNoHiddenChatsDescription =>
      'Gizlediğiniz sohbetler burada görünecek';

  @override
  String get settingsUnhideChat => 'Göster';

  @override
  String get settingsDarkMode => 'Karanlık mod';

  @override
  String get settingsFontSize => 'Yazı tipi boyutu';

  @override
  String get settingsBubbleStyle => 'Balon stili';

  @override
  String get settingsFollowSystem => 'Sistemi takip et';

  @override
  String get settingsAutoSwitchBySystem =>
      'Sistem ayarlarına göre otomatik geçiş yap';

  @override
  String get settingsLightMode => 'Aydınlık mod';

  @override
  String get settingsAlwaysUseLightTheme => 'Her zaman açık tema kullan';

  @override
  String get settingsDarkModeOption => 'Karanlık mod';

  @override
  String get settingsAlwaysUseDarkTheme => 'Her zaman koyu tema kullan';

  @override
  String get settingsFontSizeSmall => 'Küçük';

  @override
  String get settingsFontSizeStandard => 'Standart';

  @override
  String get settingsFontSizeLarge => 'Büyük';

  @override
  String get settingsFontSizeExtraLarge => 'Çok büyük';

  @override
  String get settingsBubbleStyleWechat => 'WeChat stili';

  @override
  String get settingsBubbleStyleWechatDesc => 'Klasik WeChat balon stili';

  @override
  String get settingsBubbleStyleModern => 'Modern stil';

  @override
  String get settingsBubbleStyleModernDesc => 'Temiz modern balon stili';

  @override
  String get settingsBubbleStyleClassic => 'Klasik stil';

  @override
  String get settingsBubbleStyleClassicDesc => 'Geleneksel balon stili';

  @override
  String get discoverVideoChannels => 'Kanallar';

  @override
  String get discoverLive => 'Canlı';

  @override
  String get discoverListen => 'Dinle';

  @override
  String get discoverWatch => 'İzle';

  @override
  String get discoverSearchDiscover => 'Ara';

  @override
  String get discoverNearbyPeople => 'Yakındakiler';

  @override
  String get discoverGames => 'Oyunlar';

  @override
  String get discoverMiniPrograms => 'Mini Programlar';

  @override
  String get chatAlreadyInCall => 'Zaten bir aramada';

  @override
  String get commonConnectionFailed => 'Bağlantı başarısız';

  @override
  String get chatCallRejected => 'Arama reddedildi';

  @override
  String get chatNoAnswer => 'Cevap yok';

  @override
  String get commonClose => 'Kapat';

  @override
  String get chatSelectContact => 'Kişi Seç';

  @override
  String get chatVoteRemoved => 'Oy kaldırıldı';

  @override
  String get chatVoteChanged => 'Oy değiştirildi';

  @override
  String get chatVoted => 'Oy verildi';

  @override
  String chatReplyTo(String name) {
    return '$name adlı kişiye yanıt';
  }

  @override
  String get chatCurrentLocation => 'Mevcut Konum';

  @override
  String chatNearbyPlace(int index) {
    return 'Yakın Yer $index';
  }

  @override
  String chatApproximateDistance(String distance) {
    return 'Yaklaşık $distance';
  }

  @override
  String get chatAddress => 'Adres';

  @override
  String get chatLatitude => 'Enlem';

  @override
  String get chatLongitude => 'Boylam';

  @override
  String get groupDescriptionUpdated => 'Grup açıklaması güncellendi';

  @override
  String get groupAvatarUpdated => 'Grup avatarı güncellendi';

  @override
  String get callDecline => 'Reddet';

  @override
  String get callAnswer => 'Yanıtla';

  @override
  String get callIncomingVideoCall => 'Gelen görüntülü arama';

  @override
  String get callIncomingVoiceCall => 'Gelen sesli arama';

  @override
  String get callVideoCallInProgress => 'Görüntülü arama';

  @override
  String get callVoiceCallInProgress => 'Sesli arama';

  @override
  String get callReconnectingCall => 'Yeniden bağlanıyor...';

  @override
  String get callEnded => 'Arama sonlandı';

  @override
  String get callFailed => 'Arama başarısız';

  @override
  String get callLivekitNotConfigured => 'LiveKit yapılandırılmadı';

  @override
  String callJoinMeetingFailed(String error) {
    return 'Toplantıya katılınamadı: $error';
  }

  @override
  String callScreenShareFailed(String error) {
    return 'Ekran paylaşımı başarısız: $error';
  }

  @override
  String get profileN42BeanTitle => 'N42 Bean';

  @override
  String get profileNoN42Bean => 'N42 Bean yok';

  @override
  String get profileN42BeanDetails => 'N42 Bean Detayları';

  @override
  String get profileN42BeanDescription =>
      'N42 Bean, N42\'deki sanal eşya ve hizmetleri almak için kullanılan bir tokendır. Şu anda şunlar için kullanılabilir:';

  @override
  String get profileN42BeanFeature1 => 'Üyelere özel çıkartmalar ve temalar';

  @override
  String get profileN42BeanFeature2 => 'Sohbet balonu özelleştirme';

  @override
  String get profileN42BeanFeature3 => 'Kırmızı zarf kapağı özelleştirme';

  @override
  String get profileN42BeanFeature4 => 'Özel takma ad rozeti';

  @override
  String get profileN42BeanFeature5 => 'Grup sohbeti ayrıcalıkları';

  @override
  String get profileN42BeanFeature6 => 'Bulut depolama genişletme';

  @override
  String get profileN42BeanFeature7 => 'Görüntülü arama güzellik filtreleri';

  @override
  String get profileN42BeanFeature8 => 'Anlar arka plan özelleştirme';

  @override
  String get profileN42BeanFeature9 => 'VIP müşteri hizmetleri önceliği';

  @override
  String get profileGotIt => 'Anladım';

  @override
  String get profileNoN42BeanRecords => 'N42 Bean kaydı yok';

  @override
  String get profileMoodAndThoughts => 'Ruh Hali ve Düşünceler';

  @override
  String get profileStatusHappy => 'Mutlu';

  @override
  String get profileStatusCracked => 'Paramparça';

  @override
  String get profileStatusLucky => 'Şanslı';

  @override
  String get profileStatusSunny => 'Güneşli';

  @override
  String get profileStatusTired => 'Yorgun';

  @override
  String get profileStatusDaydream => 'Hayal';

  @override
  String get profileStatusRushing => 'Acele';

  @override
  String get profileStatusOverthinking => 'Fazla Düşünme';

  @override
  String get profileStatusEnergized => 'Enerjik';

  @override
  String get profileWorkAndStudy => 'İş ve Çalışma';

  @override
  String get profileStatusWorking => 'Çalışıyor';

  @override
  String get profileStatusStudying => 'Ders Çalışıyor';

  @override
  String get profileStatusBusy => 'Meşgul';

  @override
  String get profileStatusSlacking => 'Tembellik';

  @override
  String get profileStatusTraveling => 'Seyahatte';

  @override
  String get profileStatusGoingHome => 'Eve Gidiyor';

  @override
  String get profileStatusDnd => 'Rahatsız Etmeyin';

  @override
  String get profileActivities => 'Aktiviteler';

  @override
  String get profileStatusHanging => 'Takılıyor';

  @override
  String get profileStatusCheckIn => 'Check-in';

  @override
  String get profileStatusExercising => 'Egzersiz';

  @override
  String get profileStatusCoffee => 'Kahve';

  @override
  String get profileStatusBubbleTea => 'Bubble Tea';

  @override
  String get profileStatusEating => 'Yemek Yiyor';

  @override
  String get profileStatusParenting => 'Ebeveynlik';

  @override
  String get profileStatusSavingWorld => 'Dünyayı Kurtarıyor';

  @override
  String get profileStatusSelfie => 'Selfie';

  @override
  String get profileRest => 'Dinlenme';

  @override
  String get profileStatusRetreat => 'Dinlenme';

  @override
  String get profileStatusHome => 'Evde';

  @override
  String get profileStatusSleeping => 'Uyuyor';

  @override
  String get profileStatusCatLover => 'Kedi Sever';

  @override
  String get profileStatusDogWalking => 'Köpek Gezdiriyor';

  @override
  String get profileStatusGaming => 'Oyun Oynuyor';

  @override
  String get profileStatusListening => 'Dinliyor';

  @override
  String get profileEditAddress => 'Adresi Düzenle';

  @override
  String get profileRecipient => 'Alıcı';

  @override
  String get profileEnterRecipientName => 'Alıcı adını girin';

  @override
  String get profilePhoneNumber => 'Telefon Numarası';

  @override
  String get profileEnterPhoneNumber => 'Telefon numarası girin';

  @override
  String get profileRegionHint => 'İl/İlçe/Mahalle';

  @override
  String get profileDetailedAddress => 'Detaylı Adres';

  @override
  String get profileDetailedAddressHint => 'Sokak, bina numarası, vb.';

  @override
  String get profileSetAsDefaultAddress => 'Varsayılan adres olarak ayarla';

  @override
  String get profilePleaseCompleteInfo => 'Lütfen tüm alanları doldurun';

  @override
  String get profileEditInvoice => 'Faturayı Düzenle';

  @override
  String get profileInvoiceType => 'Fatura türü: ';

  @override
  String get profileCompanyName => 'Şirket Adı';

  @override
  String get profilePersonalName => 'Kişi Adı';

  @override
  String get profileEnterCompanyName => 'Şirket adı girin';

  @override
  String get profileEnterName => 'Ad girin';

  @override
  String get profileTaxIdNumber => 'Vergi Kimlik Numarası';

  @override
  String get profileEnterTaxIdNumber => 'Vergi kimlik numarası girin';

  @override
  String get profileBankNameOptional => 'Banka Adı (İsteğe bağlı)';

  @override
  String get profileEnterBankName => 'Banka adı girin';

  @override
  String get profileBankAccountOptional => 'Banka Hesabı (İsteğe bağlı)';

  @override
  String get profileEnterBankAccount => 'Banka hesabı girin';

  @override
  String get profileCompanyAddressOptional => 'Şirket Adresi (İsteğe bağlı)';

  @override
  String get profileEnterCompanyAddress => 'Şirket adresi girin';

  @override
  String get profileCompanyPhoneOptional => 'Şirket Telefonu (İsteğe bağlı)';

  @override
  String get profileEnterCompanyPhone => 'Şirket telefonu girin';

  @override
  String get profileSetAsDefaultInvoice => 'Varsayılan fatura olarak ayarla';

  @override
  String get profileRingtoneVibrate => 'Titreşim';

  @override
  String get profileRingtoneSilent => 'Sessiz';

  @override
  String get profileVibrateMode => 'Titreşim modu';

  @override
  String get profileSilentMode => 'Sessiz mod';

  @override
  String profilePlayFailed(String ringtoneName) {
    return 'Çalınamadı: $ringtoneName';
  }

  @override
  String profilePlaying(String ringtoneName) {
    return 'Çalıyor: $ringtoneName';
  }

  @override
  String get profileStop => 'Durdur';

  @override
  String get profileSelectRingtone => 'Zil Sesi Seç';

  @override
  String get profileLoadingRingtones => 'Zil sesleri yükleniyor...';

  @override
  String get profileNoRingtonesFound => 'Zil sesi bulunamadı';

  @override
  String mainMessagesWithCount(int count) {
    return 'Mesajlar($count)';
  }

  @override
  String get storyViewers => 'İzleyenler';

  @override
  String get storyNoViewers => 'Henüz izleyen yok';

  @override
  String get storyReplyToStory => 'Hikayeye yanıt ver...';

  @override
  String get commonCopiedToClipboard => 'Panoya kopyalandı';

  @override
  String get commonMore => 'Daha fazla';

  @override
  String get commonTranslating => 'Çevriliyor...';

  @override
  String commonTranslatedFrom(String language) {
    return '$language dilinden çevrildi';
  }

  @override
  String get commonTranslation => 'Çeviri';

  @override
  String get commonTranslationFailed => 'Çeviri başarısız';

  @override
  String get commonAllRead => 'Tümü okundu';

  @override
  String commonReadCount(int count) {
    return '$count okundu';
  }

  @override
  String get commonYouRecalledMessage => 'Bir mesajı geri aldınız';

  @override
  String get commonMessageRecalled => 'Mesaj geri alındı';

  @override
  String get commonReEdit => 'Yeniden düzenle';

  @override
  String get commonWalletArea => 'Cüzdan alanı';

  @override
  String get callIncomingCall => 'Gelen arama';

  @override
  String get callMissedCall => 'Cevapsız arama';

  @override
  String get groupRemoveAdmin => 'Yöneticilikten Çıkar';

  @override
  String get chatSelectCurrency => 'Para birimi seç';

  @override
  String get chatSelectEmoji => 'Emoji seç';

  @override
  String get chatSelectRedPacketCover => 'Kapak seç';

  @override
  String get groupSetAsAdmin => 'Yönetici Yap';

  @override
  String get chatVideoPlaybackFailed => 'Video oynatma başarısız';

  @override
  String get groupViewProfile => 'Profili Gör';

  @override
  String get favoriteAddLinkComingSoon => 'Bağlantı ekleme özelliği yakında';

  @override
  String get favoriteNewNoteComingSoon => 'Yeni not özelliği yakında';

  @override
  String get qrcodeSaveFeatureComingSoon => 'Kaydetme özelliği yakında';

  @override
  String get qrcodeShareFeatureComingSoon => 'Paylaşım özelliği yakında';

  @override
  String qrcodeProcessFailed(String error) {
    return 'QR kod işlenemedi: $error';
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

  @override
  String get momentVisibilityPublic => '公开';

  @override
  String get momentVisibilityPrivate => '私密';

  @override
  String get momentVisibilityPartial => '部分可见';

  @override
  String get momentVisibilityExcluded => '不给谁看';

  @override
  String momentUserMoments(String userName) {
    return '$userName的朋友圈';
  }

  @override
  String get momentForwardTo => '转发给';

  @override
  String get momentForwardSuccess => '转发成功';

  @override
  String get momentSelectFriends => '选择好友';

  @override
  String get momentSelectTags => '按标签选择';

  @override
  String momentSelectedCount(int count) {
    return '已选择 ($count)';
  }

  @override
  String get momentNoMomentsYet => '暂无动态';

  @override
  String get momentForwardMoment => '转发动态';

  @override
  String get momentAddComment => '写评论...';

  @override
  String momentForwardContent(String content) {
    return '[朋友圈] $content';
  }

  @override
  String get momentDeleteMoment => '删除动态';

  @override
  String get momentDeleteConfirm => '确定要删除这条动态吗？';

  @override
  String get momentComment => '评论';

  @override
  String get momentWriteComment => '写评论...';

  @override
  String get momentLike => '赞';

  @override
  String get momentUnlike => '取消';

  @override
  String get momentForward => '转发';

  @override
  String get momentDelete => '删除';

  @override
  String get momentReply => '回复';

  @override
  String get momentMoment => '动态';

  @override
  String momentLikesCount(int count) {
    return '$count 个赞';
  }

  @override
  String momentCommentsCount(int count) {
    return '$count 条评论';
  }

  @override
  String get momentNoComments => '暂无评论';

  @override
  String get momentFailedToLoad => '图片加载失败';

  @override
  String momentReplyTo(String userName) {
    return '回复 $userName...';
  }

  @override
  String get momentNoConversations => '暂无会话';

  @override
  String get momentJustNow => '刚刚';

  @override
  String momentMinutesAgo(int count) {
    return '$count分钟前';
  }

  @override
  String momentHoursAgo(int count) {
    return '$count小时前';
  }

  @override
  String momentDaysAgo(int count) {
    return '$count天前';
  }

  @override
  String get chatGroupAnnouncementHint => '输入群公告';

  @override
  String get chatGroupAnnouncementEmpty => '暂无群公告';

  @override
  String get chatEditNickname => '编辑群昵称';

  @override
  String get chatNicknameHint => '输入你在群里的昵称';

  @override
  String get contactAddPhoneHint => '输入电话号码';

  @override
  String get contactNotesHint => '添加联系人备忘';

  @override
  String get reportTitle => '投诉';

  @override
  String get reportReasonSpam => '垃圾信息';

  @override
  String get reportReasonHarassment => '骚扰';

  @override
  String get reportReasonFraud => '欺诈';

  @override
  String get reportReasonOther => '其他';

  @override
  String get reportSubmitted => '投诉已提交';

  @override
  String get reportDescription => '补充说明（选填）';

  @override
  String get qrcodeSaved => '二维码已保存到相册';

  @override
  String get chatSendRedPacketInChat => '请在聊天中发送红包';

  @override
  String get commonSaveFailed => '保存失败';

  @override
  String get reportSelectReason => '请选择投诉原因';

  @override
  String get gameCenter => 'Oyunlar';

  @override
  String get gameHighScore => 'En İyi';

  @override
  String get gameScore => 'Puan';

  @override
  String get gameOver => 'Oyun Bitti';

  @override
  String get gamePlayAgain => 'Tekrar Oyna';

  @override
  String get gameLeaderboard => 'Sıralama';

  @override
  String get gamePause => 'Duraklatıldı';

  @override
  String get gameResume => 'Devam etmek için dokun';

  @override
  String get gameConfirmExit => 'Oyundan çıkmak istiyor musunuz?';

  @override
  String get gameNoScores => 'Henüz skor yok';

  @override
  String get game2048 => '2048';

  @override
  String get game2048Desc => 'Karoları birleştirerek 2048\'e ulaşın';

  @override
  String get gameBlockDrop => 'Block Drop';

  @override
  String get gameBlockDropDesc => 'Blokları düşürüp satırları temizleyin';

  @override
  String get gameMinesweeper => 'Mayın Tarlası';

  @override
  String get gameMinesweeperDesc => 'Tüm güvenli hücreleri bulun';

  @override
  String get gameMatch3 => 'Match 3';

  @override
  String get gameMatch3Desc => '3 veya daha fazla taşı eşleştirin';

  @override
  String get gameMinesweeperEasy => 'Kolay';

  @override
  String get gameMinesweeperMedium => 'Orta';

  @override
  String get gameMinesLeft => 'Kalan Mayın';

  @override
  String get gameTimeLeft => 'Süre';

  @override
  String get gameLevel => 'Seviye';

  @override
  String get gameNext => 'Sonraki';

  @override
  String get gameBestTime => 'En İyi Süre';

  @override
  String get gameNewRecord => 'Yeni Rekor!';

  @override
  String get gameLines => 'Satır';

  @override
  String get storyMyStory => '我的动态';

  @override
  String get storageSmartCleanup => '智能清理';

  @override
  String get storageOldMediaFiles => '旧媒体文件';

  @override
  String get storageLargeFiles => '大文件';

  @override
  String get storageAppCache => '应用缓存';

  @override
  String get storageSettings => '存储设置';

  @override
  String get storageAutoCleanup => '自动清理';

  @override
  String storageAutoCleanupDesc(int days) {
    return '自动清理 $days 天以上未访问的文件';
  }

  @override
  String get storageCleanupPeriod => '清理周期';

  @override
  String get storagePreserveThumbnails => '保留缩略图';

  @override
  String get storagePreserveThumbnailsDesc => '清理时保留图片缩略图';

  @override
  String get storageWarningHigh => '存储空间较高，建议清理旧文件。';

  @override
  String get storageWarningCritical => '存储空间严重不足，请立即清理。';

  @override
  String storageFreed(String size, int count) {
    return '已释放 $size（$count 个文件）';
  }

  @override
  String storageDays(int days) {
    return '$days 天';
  }

  @override
  String storageViewAllRooms(int count) {
    return '查看全部 $count 个房间';
  }

  @override
  String get storageNoFiles => '暂无文件';

  @override
  String get storageFilePinned => '已保留';

  @override
  String storageDeleteSelected(int count) {
    return '删除 $count 个选中文件？文件可从服务器重新下载。';
  }

  @override
  String get backupRestore => '备份与恢复';

  @override
  String get backupCreate => '创建备份';

  @override
  String get backupCreateDesc => '备份设置和加密密钥。消息将在重新登录后从服务器恢复。';

  @override
  String get backupIncludeKeys => '包含加密密钥';

  @override
  String get backupIncludeKeysDesc => '读取加密消息所必需';

  @override
  String get backupPasswordProtect => '密码保护';

  @override
  String get backupEnterPassword => '输入备份密码';

  @override
  String get backupHistory => '备份历史';

  @override
  String get backupNoBackups => '暂无备份';

  @override
  String get backupRestore2 => '恢复';

  @override
  String get backupDelete => '删除';

  @override
  String get backupDeleteConfirm => '确定删除此备份？此操作不可撤销。';

  @override
  String get backupRestoreFromFile => '从文件恢复';

  @override
  String get backupRestoreFromFileDesc => '导入来自其他设备或之前备份的 .n42backup 文件。';

  @override
  String get backupChooseFile => '选择备份文件';

  @override
  String get backupRestoring => '恢复中...';

  @override
  String backupCreated(int rooms, int messages) {
    return '备份已创建：$rooms 个房间，$messages 条消息';
  }

  @override
  String backupRestored(int settings, int rooms) {
    return '已恢复 $settings 项设置（来自 $rooms 个房间）';
  }

  @override
  String backupFailed(String error) {
    return '备份失败：$error';
  }

  @override
  String get backupPasswordRequired => '此备份需要密码';

  @override
  String get blocGroupNotFound => '群组未找到';

  @override
  String blocGroupMembersInvited(int count) {
    return '已邀请$count位成员';
  }

  @override
  String get blocGroupMemberRemoved => '成员已移除';

  @override
  String get blocGroupAdminRemoved => '已取消管理员';

  @override
  String get blocGroupLeft => '已退出群聊';

  @override
  String get blocGroupDisbanded => '群聊已解散';

  @override
  String get blocGroupJoined => '已加入群聊';

  @override
  String get blocGroupInviteDeclined => '已拒绝邀请';

  @override
  String get blocGroupTokenGateUpdated => 'Token 门槛已更新';

  @override
  String get blocTransferProcessing => '转账处理中...';

  @override
  String get blocTransferCancelled => '转账已取消';

  @override
  String get blocTransferFailed => '转账失败';

  @override
  String get blocPaymentProcessing => '支付处理中...';

  @override
  String get blocPaymentFailed => '支付失败';

  @override
  String get groupMaxMembers => '群人数上限';

  @override
  String get groupMaxMembersUnlimited => '不限';

  @override
  String get groupMaxMembersHint => '输入上限（留空表示不限）';

  @override
  String get groupMaxMembersUpdated => '群人数上限已更新';

  @override
  String get groupFull => '群已满员';

  @override
  String get groupChannels => '话题频道';

  @override
  String get groupChannelsEmpty => '暂无话题频道';

  @override
  String get groupChannelsCount => '个频道';

  @override
  String get groupChannelCreate => '新建频道';

  @override
  String get groupChannelName => '频道名称';

  @override
  String get groupChannelTopic => '频道话题（可选）';

  @override
  String get groupChannelDelete => '删除频道';

  @override
  String get groupChannelDeleteConfirm => '确认删除此频道？消息不可恢复。';

  @override
  String get groupBotSettings => 'Bot 设置';

  @override
  String get groupBotEnabled => '启用 Bot';

  @override
  String get groupBotWelcomeMessage => '欢迎语模板';

  @override
  String get groupBotWelcomeHint => '用 \'name\' 作为新成员名字占位符';

  @override
  String get groupBotConfigUpdated => 'Bot 设置已更新';

  @override
  String get groupContentFilter => '关键词过滤';

  @override
  String get groupContentFilterEnabled => '启用关键词过滤';

  @override
  String get groupContentFilterReplace => '替换为 ***';

  @override
  String get groupContentFilterHide => '隐藏消息';

  @override
  String get groupContentFilterAddWord => '添加关键词';

  @override
  String get groupContentFilterUpdated => '内容过滤设置已更新';

  @override
  String get chatSlashCommands => '指令';

  @override
  String get chatCommandPoll => '/poll — 创建投票';

  @override
  String get chatCommandAnnounce => '/announce — 发布公告';

  @override
  String get chatCommandWelcome => '/welcome — 设置欢迎语';

  @override
  String get chatReportMessage => '举报';

  @override
  String get chatReportReason => '举报原因';

  @override
  String get chatReportSpam => '垃圾信息';

  @override
  String get chatReportHarassment => '骚扰';

  @override
  String get chatReportInappropriate => '违规内容';

  @override
  String get chatReportOther => '其他';

  @override
  String get chatReportSuccess => '举报已提交';

  @override
  String get spacesName => '社区名称';

  @override
  String get spacesNameHint => '例如：加密交易者';

  @override
  String get spacesNameRequired => '请输入社区名称';

  @override
  String get spacesDescription => '简介';

  @override
  String get spacesDescriptionHint => '介绍一下这个社区';

  @override
  String get spacesType => '社区类型';

  @override
  String get spacesPublicDesc => '任何人均可发现并加入';

  @override
  String get spacesPrivateDesc => '仅受邀成员可加入';

  @override
  String get spacesNotFound => '社区不存在';

  @override
  String get spacesSearch => '搜索社区...';

  @override
  String get spacesMembers => '成员';

  @override
  String get spacesNoChannels => '暂无频道';

  @override
  String get spacesLeave => '退出社区';

  @override
  String spacesLeaveConfirm(String name) {
    return '确定要退出「$name」吗？';
  }

  @override
  String get spacesDelete => '解散社区';

  @override
  String spacesDeleteConfirm(String name) {
    return '此操作将永久删除「$name」及其所有频道，且不可撤销。';
  }

  @override
  String get spacesCreateChannel => '创建频道';

  @override
  String get spacesChannelName => '频道名称';

  @override
  String get spacesChannelTopic => '话题（可选）';

  @override
  String get spacesDeleteChannel => '删除频道';

  @override
  String spacesDeleteChannelConfirm(String name) {
    return '确定要删除频道「#$name」吗？';
  }

  @override
  String get spacesEditName => '修改名称';

  @override
  String get spacesEditDescription => '修改简介';

  @override
  String spacesViewAllMembers(int count) {
    return '查看全部 $count 位成员';
  }

  @override
  String spacesKickMemberTitle(String name) {
    return '踢出 $name';
  }

  @override
  String spacesBanMemberTitle(String name) {
    return '封禁 $name';
  }

  @override
  String get spacesPromoteAdmin => '设为管理员';

  @override
  String get spacesDemoteAdmin => '撤销管理员';

  @override
  String get spacesInviteMember => '邀请成员';

  @override
  String get spacesInviteMemberUserId => '用户 ID（如 @user:server.com）';

  @override
  String get spacesSave => '保存';

  @override
  String get settingsScreenshotProtection => '截图防护';

  @override
  String get settingsScreenshotProtectionDesc => '防止截图和屏幕录制';

  @override
  String get chatSelfDestructTimer => '阅后即焚';

  @override
  String get chatTimerPickerTitle => '设置阅后即焚时间';

  @override
  String get chatTimerOff => '关闭';

  @override
  String get onChainNotificationsTitle => 'Zincir Üstü Olaylar';

  @override
  String get onChainMarkAllRead => 'Tümünü okundu işaretle';

  @override
  String get onChainNoNotifications => 'Henüz zincir üstü olay yok';

  @override
  String get onChainNoNotificationsDesc =>
      'Abone olunan kanallardan olaylar burada görünecek';

  @override
  String get onChainViewDetails => 'Ayrıntıları gör';

  @override
  String get chatCommandHelp => '/help — Tüm komutları göster';

  @override
  String get chatCommandPrice => '/price — Token fiyatını al';

  @override
  String get chatCommandBalance => '/balance — Cüzdan bakiyesini göster';

  @override
  String get chatCommandChains => '/chains — 236+ desteklenen ağı listele';

  @override
  String get chatMiniApps => 'Uygulamalar';

  @override
  String get miniAppMarketTitle => 'Mini Uygulamalar';

  @override
  String get miniAppCategoryAll => 'Tümü';

  @override
  String get miniAppSearch => 'Uygulama ara...';

  @override
  String get miniAppFeatured => 'Öne Çıkanlar';

  @override
  String get miniAppAllApps => 'Tüm Uygulamalar';

  @override
  String get miniAppNoResults => 'Uygulama bulunamadı';

  @override
  String get slideToPayLabel => '→→→  Onaylamak için kaydırın';

  @override
  String get slideToPayConfirming => 'Onaylanıyor...';

  @override
  String get redPacketBestLuck => 'En iyi şans';

  @override
  String get redPacketBestLuckCongrats => 'En iyi şans! En çok siz aldınız!';

  @override
  String redPacketStats(int claimed, int total) {
    return '$claimed / $total talep edildi';
  }

  @override
  String get redPacketStatsTotal => 'toplam';

  @override
  String redPacketGrabbedViral(String amount, String token) {
    return '🧧 Kırmızı zarf aldı • $amount $token';
  }

  @override
  String get web3SearchHint => '@matrix:id  •  0x adres  •  name.eth';

  @override
  String get web3SearchPlaceholder => 'ID, cüzdan veya ENS ile ara...';

  @override
  String get web3WalletAddress => 'Cüzdan adresi';

  @override
  String get web3AddressCopied => 'Adres kopyalandı';

  @override
  String get web3Copy => 'Kopyala';

  @override
  String get web3SendMessage => 'Mesaj gönder';

  @override
  String get web3SendToWallet => 'Cüzdana mesaj';

  @override
  String get web3WalletOnlyHint =>
      'Bu adresin N42 hesabı yok. Katıldıklarında mesaj iletilecek.';

  @override
  String get web3NftAvatar => 'NFT Avatar';

  @override
  String get web3ResolveFailed => 'Kimlik çözümlenemedi';

  @override
  String web3EnsNotFound(String name) {
    return 'ENS adı \"$name\" bulunamadı';
  }

  @override
  String get web3NoN42AccountTitle => 'N42 hesabı yok';

  @override
  String get web3NoN42AccountDesc =>
      'This wallet address has no N42 account yet. You can share your N42 invite link with them to get started.';

  @override
  String get web3ShareInvite => 'Daveti paylaş';

  @override
  String get nftPickerTitle => 'NFT avatar seç';

  @override
  String get nftPickerTabPopular => 'Popüler';

  @override
  String get nftPickerTabCustom => 'Özel';

  @override
  String get nftPickerChain => 'Chain';

  @override
  String get nftPickerContract => 'Contract Address';

  @override
  String get nftPickerTokenId => 'Token ID';

  @override
  String get nftPickerVerifyOwnership => 'Sahipliği doğrula ve önizle';

  @override
  String get nftPickerUseAsAvatar => 'Avatar olarak kullan';

  @override
  String get nftPickerPreview => 'Preview';

  @override
  String get nftPickerNotOwned => 'Bu NFT\'ye sahip değilsiniz';

  @override
  String get nftPickerInvalidTokenId => 'Invalid token ID';

  @override
  String get nftPickerEnterBoth => 'Enter contract address and token ID';

  @override
  String get nftPickerInfoTitle => 'NFT Avatar — Zincir Üzeri Doğrulama';

  @override
  String get nftPickerInfoDesc =>
      'Bind an NFT you own as your avatar. Anyone can verify ownership on-chain. Displayed with a gold ring across N42.';

  @override
  String get nftPickerPopularCollections => 'Popüler koleksiyonlar';

  @override
  String get nftPickerWalletHint =>
      'N42 cüzdanınızı bağlayarak 236+ zincirde NFT\'lerinizi otomatik keşfedin.';

  @override
  String get profileBindNftAvatar => 'Bind NFT Avatar';

  @override
  String get profileChangeAvatar => 'Change Avatar';

  @override
  String get groupTopics => 'Topics';

  @override
  String get groupTopicsEmpty => 'No topics yet';

  @override
  String get syncInProgress => 'Syncing message history...';

  @override
  String get recoveryKeyReminderTitle => 'Protect your messages';

  @override
  String get recoveryKeyReminderDesc =>
      'Create a recovery key to securely sync encrypted messages across devices';

  @override
  String get recoveryKeySetupNow => 'Set up now';

  @override
  String get recoveryKeyRemindLater => 'Remind me later';

  @override
  String get channelReadOnly => '仅管理员可在此频道发言';

  @override
  String get channelSubscribers => '订阅者';

  @override
  String get channelVerified => '已认证频道';

  @override
  String get redPacketHistory => '红包记录';

  @override
  String get redPacketSent => '已发出';

  @override
  String get redPacketReceived => '已收到';

  @override
  String get redPacketExpired => '已过期';

  @override
  String get redPacketClaimed => '已领取';

  @override
  String get redPacketInsufficientBalance => '余额不足';

  @override
  String selfDestructCountdown(String time) {
    return '$time 后销毁';
  }

  @override
  String get messageDestroyed => '消息已销毁';

  @override
  String miniAppPermissionDenied(String permission) {
    return '权限不足：$permission';
  }

  @override
  String get aiSuggestionGasFee => '什么是 Gas 费？';

  @override
  String get aiSuggestionDefi => 'DeFi 入门';

  @override
  String get aiSuggestionSecurity => '如何检查合约安全';

  @override
  String get aiSuggestionBridge => '跨链桥接';

  @override
  String get channelDiscoverTitle => '发现频道';

  @override
  String get channelDiscoverSearch => '搜索频道...';

  @override
  String get channelJoin => '加入';

  @override
  String get channelJoined => '已加入';

  @override
  String get channelCategory => '分类';

  @override
  String slowModeCooldown(int seconds) {
    return '慢速模式：请等待 $seconds 秒';
  }

  @override
  String get addressCopyAction => '复制地址';

  @override
  String get addressSendMessage => '发消息';

  @override
  String get addressViewProfile => '查看资料';

  @override
  String get sendToAddress => '通过钱包地址发消息';
}
