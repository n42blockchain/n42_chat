import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/contact_entity.dart';
import '../../../domain/repositories/contact_repository.dart';
import 'contact_event.dart';
import 'contact_state.dart';

/// 联系人BLoC
class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final IContactRepository _contactRepository;

  StreamSubscription<List<ContactEntity>>? _contactsSubscription;
  StreamSubscription<Map<String, bool>>? _onlineStatusSubscription;

  ContactBloc(this._contactRepository) : super(const ContactInitial()) {
    on<LoadContacts>(_onLoadContacts);
    on<RefreshContacts>(_onRefreshContacts);
    on<SearchContacts>(_onSearchContacts);
    on<SearchUsers>(_onSearchUsers);
    on<ClearSearch>(_onClearSearch);
    on<StartChat>(_onStartChat);
    on<IgnoreUser>(_onIgnoreUser);
    on<UnignoreUser>(_onUnignoreUser);
    on<LoadFriendRequests>(_onLoadFriendRequests);
    on<AcceptFriendRequest>(_onAcceptFriendRequest);
    on<RejectFriendRequest>(_onRejectFriendRequest);
    on<ContactsUpdated>(_onContactsUpdated);
    on<OnlineStatusUpdated>(_onOnlineStatusUpdated);
  }

  Future<void> _onLoadContacts(
    LoadContacts event,
    Emitter<ContactState> emit,
  ) async {
    emit(const ContactLoading());

    try {
      // 订阅联系人变化
      _contactsSubscription?.cancel();
      _contactsSubscription = _contactRepository.watchContacts().listen(
        (contacts) {
          add(const ContactsUpdated());
        },
      );

      // 订阅在线状态变化
      _onlineStatusSubscription?.cancel();
      _onlineStatusSubscription =
          _contactRepository.watchOnlineStatus().listen(
        (statusMap) {
          add(OnlineStatusUpdated(statusMap));
        },
      );

      final contacts = await _contactRepository.getContacts();
      final friendRequests = await _contactRepository.getPendingFriendRequests();
      final grouped = _groupContactsByLetter(contacts);

      emit(ContactLoaded(
        contacts: contacts,
        filteredContacts: contacts,
        friendRequests: friendRequests,
        groupedContacts: grouped,
        indexLetters: grouped.keys.toList()..sort(),
      ));
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }

  Future<void> _onRefreshContacts(
    RefreshContacts event,
    Emitter<ContactState> emit,
  ) async {
    if (state is! ContactLoaded) {
      add(const LoadContacts());
      return;
    }

    try {
      final contacts = await _contactRepository.getContacts();
      final friendRequests = await _contactRepository.getPendingFriendRequests();
      final grouped = _groupContactsByLetter(contacts);
      final currentState = state as ContactLoaded;

      emit(currentState.copyWith(
        contacts: contacts,
        filteredContacts:
            currentState.searchQuery.isEmpty ? contacts : currentState.filteredContacts,
        friendRequests: friendRequests,
        groupedContacts: grouped,
        indexLetters: grouped.keys.toList()..sort(),
      ));
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }

  Future<void> _onSearchContacts(
    SearchContacts event,
    Emitter<ContactState> emit,
  ) async {
    if (state is! ContactLoaded) return;

    final currentState = state as ContactLoaded;

    if (event.query.trim().isEmpty) {
      emit(currentState.copyWith(
        filteredContacts: currentState.contacts,
        searchQuery: '',
        isSearching: false,
      ));
      return;
    }

    emit(currentState.copyWith(
      isSearching: true,
      searchQuery: event.query,
    ));

    try {
      final results = await _contactRepository.searchContacts(event.query);
      emit(currentState.copyWith(
        filteredContacts: results,
        searchQuery: event.query,
        isSearching: false,
      ));
    } catch (e) {
      emit(currentState.copyWith(isSearching: false));
    }
  }

  Future<void> _onSearchUsers(
    SearchUsers event,
    Emitter<ContactState> emit,
  ) async {
    if (state is! ContactLoaded) return;

    final currentState = state as ContactLoaded;

    if (event.query.trim().isEmpty) {
      emit(currentState.copyWith(
        searchResults: [],
        isGlobalSearching: false,
      ));
      return;
    }

    emit(currentState.copyWith(isGlobalSearching: true));

    try {
      final results = await _contactRepository.searchUsers(
        event.query,
        limit: event.limit,
      );
      emit(currentState.copyWith(
        searchResults: results,
        isGlobalSearching: false,
      ));
    } catch (e) {
      emit(currentState.copyWith(isGlobalSearching: false));
    }
  }

  void _onClearSearch(
    ClearSearch event,
    Emitter<ContactState> emit,
  ) {
    if (state is! ContactLoaded) return;

    final currentState = state as ContactLoaded;
    emit(currentState.copyWith(
      filteredContacts: currentState.contacts,
      searchResults: [],
      searchQuery: '',
      isSearching: false,
      isGlobalSearching: false,
    ));
  }

  Future<void> _onStartChat(
    StartChat event,
    Emitter<ContactState> emit,
  ) async {
    try {
      final roomId = await _contactRepository.startDirectChat(event.userId);
      emit(ChatStarted(roomId: roomId, userId: event.userId));

      // 恢复到之前的状态
      if (state is! ContactLoaded) {
        add(const LoadContacts());
      }
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }

  Future<void> _onIgnoreUser(
    IgnoreUser event,
    Emitter<ContactState> emit,
  ) async {
    try {
      await _contactRepository.ignoreUser(event.userId);
      add(const RefreshContacts());
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }

  Future<void> _onUnignoreUser(
    UnignoreUser event,
    Emitter<ContactState> emit,
  ) async {
    try {
      await _contactRepository.unignoreUser(event.userId);
      add(const RefreshContacts());
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }

  Future<void> _onLoadFriendRequests(
    LoadFriendRequests event,
    Emitter<ContactState> emit,
  ) async {
    if (state is! ContactLoaded) return;

    final currentState = state as ContactLoaded;

    try {
      final friendRequests = await _contactRepository.getPendingFriendRequests();
      emit(currentState.copyWith(friendRequests: friendRequests));
    } catch (e) {
      // Ignore error for friend requests
    }
  }

  Future<void> _onAcceptFriendRequest(
    AcceptFriendRequest event,
    Emitter<ContactState> emit,
  ) async {
    try {
      await _contactRepository.acceptFriendRequest(event.requestId);
      add(const RefreshContacts());
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }

  Future<void> _onRejectFriendRequest(
    RejectFriendRequest event,
    Emitter<ContactState> emit,
  ) async {
    try {
      await _contactRepository.rejectFriendRequest(event.requestId);
      add(const RefreshContacts());
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }

  Future<void> _onContactsUpdated(
    ContactsUpdated event,
    Emitter<ContactState> emit,
  ) async {
    add(const RefreshContacts());
  }

  void _onOnlineStatusUpdated(
    OnlineStatusUpdated event,
    Emitter<ContactState> emit,
  ) {
    if (state is! ContactLoaded) return;

    final currentState = state as ContactLoaded;
    final updatedContacts = currentState.contacts.map((contact) {
      final isOnline = event.statusMap[contact.userId];
      if (isOnline != null) {
        return contact.copyWith(
          presence: isOnline ? PresenceStatus.online : PresenceStatus.offline,
        );
      }
      return contact;
    }).toList();

    emit(currentState.copyWith(
      contacts: updatedContacts,
      filteredContacts:
          currentState.searchQuery.isEmpty ? updatedContacts : currentState.filteredContacts,
    ));
  }

  /// 按首字母分组联系人
  Map<String, List<ContactEntity>> _groupContactsByLetter(
    List<ContactEntity> contacts,
  ) {
    final grouped = <String, List<ContactEntity>>{};

    for (final contact in contacts) {
      final letter = contact.indexLetter;
      if (!grouped.containsKey(letter)) {
        grouped[letter] = [];
      }
      grouped[letter]!.add(contact);
    }

    // 按名称排序每个组内的联系人
    for (final contacts in grouped.values) {
      contacts.sort((a, b) => a.sortKey.compareTo(b.sortKey));
    }

    return grouped;
  }

  @override
  Future<void> close() {
    _contactsSubscription?.cancel();
    _onlineStatusSubscription?.cancel();
    return super.close();
  }
}

