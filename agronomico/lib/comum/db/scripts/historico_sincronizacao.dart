const historicoSincronizacao = '''
  CREATE TABLE historico_sincronizacao (
    tabela TEXT PRIMARY KEY,
    dataAtualizacao TEXT,
    duracao int,
    quantidade int
  )
''';
