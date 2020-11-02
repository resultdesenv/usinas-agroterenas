final tabelaUpnivel3 = '''
  CREATE TABLE upnivel3 (
    cdSafra INTEGER NOT NULL,
    cdUpnivel1 TEXT NOT NULL,
    cdUpnivel2 TEXT NOT NULL,
    cdUpnivel3 TEXT NOT NULL,
    cdTpPropr INTEGER,
    deTpPropr TEXT,
    cdVaried INTEGER,
    deVaried TEXT,
    cdEstagio INTEGER,
    deEstagio TEXT,
    dtUltimoCorte TEXT, 
    instancia TEXT,
    precipitacao REAL,
    qtAreaProd REAL,
    producaoSafraAnt REAL,
    sphenophous REAL,
    tch0 REAL,
    tch1 REAL,
    tch2 REAL,
    tch3 REAL,
    tch4 REAL,
    tchAnoPassado REAL,
    tchAnoRetrasado REAL,
    PRIMARY KEY(cdSafra,cdUpnivel1,cdUpnivel2,cdUpnivel3)
  )
''';
