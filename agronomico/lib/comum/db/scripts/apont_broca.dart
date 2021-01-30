const tabelaApontBroca = '''
  CREATE TABLE apont_broca (
    noColetor INTEGER NOT NULL,
    instancia TEXT NOT NULL,
    noBoletim INTEGER NOT NULL,
    noSequencia INTEGER NOT NULL,
    versao TEXT NOT NULL DEFAULT '1.0.0',
    cdSafra INTEGER,
    cdUpnivel1 TEXT NOT NULL,
    cdUpnivel2 TEXT NOT NULL,
    cdUpnivel3 TEXT NOT NULL,
    qtBrocados REAL,
    qtCanaPodr REAL,
    qtCanas REAL,
    qtCanasbroc REAL,
    qtEntrPodr REAL,
    qtEntrenos REAL,
    qtMedia REAL,
    cdFunc INTEGER,
    dtOperacao TEXT,
    hrOperacao TEXT,
    status TEXT,
    dtStatus TEXT,
    PRIMARY KEY(dispositivo,instancia,noBoletim, noSequencia, cdUpnivel1, cdUpnivel2, cdUpnivel3)
  );
''';
