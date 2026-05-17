# NBA App

Aplicação Flutter para acompanhar a NBA em português e inglês, com equipas, jogos, classificações, notícias, jogadores, estatísticas, personalização e loja.

## Funcionalidades

- Login/registo local com password encriptada.
- Tema adaptado à equipa favorita.
- Home com equipas, notícias e jogos do dia.
- Jogos e detalhes de equipas/jogadores com cache local.
- Perfil com idioma, moeda, unidades e alertas.
- Loja NBA com carrinho persistente, moeda configurável, checkout fictício, fatura PDF e histórico de encomendas.
- Calendário de jogos, classificação ao vivo (ESPN), notificações da equipa favorita e modo offline.
- Dados mistos de ESPN/API, assets locais, cache Drift e sincronização de estatísticas.

## Como correr

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Para validar o projeto:

```bash
flutter analyze
flutter test
```

## Dados e APIs

- ESPN/NBA API via `NbaApiService`.
- Notícias via `NewsApiService`, com seed local quando necessário.
- Estatísticas de jogadores via Basketball Reference e seeds locais.
- Persistência local com Drift/SQLite.

## Estrutura principal

- `lib/screens`: telas da app.
- `lib/services`: serviços de API, cache, carrinho, tema e formatação.
- `lib/db`: tabelas, DAOs e conexão Drift.
- `assets/data`: dados locais e classificações por época.
- `assets/player_photos` e `assets/store`: imagens usadas na app.
