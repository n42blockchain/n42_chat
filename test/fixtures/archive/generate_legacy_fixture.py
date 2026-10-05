"""Create synthetic historical SQLCipher data; argument is a verified 4.10 library."""
import ctypes
import pathlib
import sys

library = ctypes.CDLL(sys.argv[1])
library.sqlite3_open.argtypes = [ctypes.c_char_p, ctypes.POINTER(ctypes.c_void_p)]
library.sqlite3_exec.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_void_p, ctypes.c_void_p, ctypes.POINTER(ctypes.c_char_p)]
library.sqlite3_close.argtypes = [ctypes.c_void_p]
path = pathlib.Path(__file__).with_name('sqlcipher-4.10-archive.db')
path.unlink(missing_ok=True)
db = ctypes.c_void_p()
assert library.sqlite3_open(str(path).encode(), ctypes.byref(db)) == 0

def execute(sql):
    error = ctypes.c_char_p()
    status = library.sqlite3_exec(db, sql.encode(), None, None, ctypes.byref(error))
    if status != 0:
        raise RuntimeError(error.value)

rows = []
@ctypes.CFUNCTYPE(ctypes.c_int, ctypes.c_void_p, ctypes.c_int, ctypes.POINTER(ctypes.c_char_p), ctypes.POINTER(ctypes.c_char_p))
def collect(_, count, values, columns):
    rows.append(values[0].decode())
    return 0
error = ctypes.c_char_p()
assert library.sqlite3_exec(db, b'PRAGMA cipher_version', collect, None, ctypes.byref(error)) == 0
assert rows and rows[0].startswith('4.10.0'), rows
print('Historical fixture writer:', rows[0])

execute('PRAGMA key = "x\'' + 'a' * 64 + '\'";')
execute('''CREATE TABLE archived_messages (
event_id TEXT NOT NULL PRIMARY KEY, room_id TEXT NOT NULL, sender_id TEXT NOT NULL,
origin_server_ts INTEGER NOT NULL, type TEXT NOT NULL, body TEXT, formatted_body TEXT,
msgtype TEXT, relates_to TEXT, media_info TEXT, is_encrypted INTEGER NOT NULL DEFAULT 0,
decrypted_body TEXT, quarter INTEGER NOT NULL, archived_at INTEGER NOT NULL);
CREATE TABLE archive_metadata(room_id TEXT NOT NULL PRIMARY KEY, last_archived_event_id TEXT,
last_archived_ts INTEGER NOT NULL DEFAULT 0,total_archived INTEGER NOT NULL DEFAULT 0,last_archive_time INTEGER);
CREATE VIRTUAL TABLE archive_fts USING fts5(body,content=archived_messages,content_rowid=rowid);
CREATE TRIGGER archive_fts_insert AFTER INSERT ON archived_messages BEGIN
INSERT INTO archive_fts(rowid,body) VALUES(new.rowid,COALESCE(new.body,'')); END;
PRAGMA user_version=1;
INSERT INTO archived_messages(event_id,room_id,sender_id,origin_server_ts,type,body,quarter,archived_at)
VALUES('legacy-event','!legacy:example.org','@fixture:example.org',1,'m.room.message','Historical encrypted archive fixture',202601,1);
''')
assert library.sqlite3_close(db) == 0
print(path)
