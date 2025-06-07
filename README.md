# 🧮 Calculadora de IMC - Flutter App

Aplicativo desenvolvido em Flutter com arquitetura organizada em **Models**, **Views**, **Controllers** e **Styles**, que permite ao usuário:

- ✅ Realizar **login** com autenticação local via **SQLite**  
- ✅ Fazer **cadastro de novos usuários** com validação de senha e e-mail  
- ✅ Calcular o **IMC (Índice de Massa Corporal)** com mensagens personalizadas e imagens ilustrativas  
- ✅ Visualizar uma **saudação dinâmica** com o nome do usuário e mensagem de acordo com o horário  
- ✅ Realizar **logout** e limpar campos de forma intuitiva

---

## 🧱 Tecnologias Utilizadas

- Flutter SDK (>=3.7.2)
- Dart
- SQLite (via `sqflite`)
- Organização por camadas: `models`, `controllers`, `database`, `views`, `styles`

---

## 📁 Estrutura do Projeto

```
lib/
├── controllers/
│   └── navigation_controller.dart
├── database/
│   └── database.dart
├── models/
│   └── user.dart
├── styles/
│   └── styles.dart
├── views/
│   ├── home_screen.dart (login)
│   ├── tela_cadastro.dart
│   └── tela_calculadora.dart
```

---

## 💡 Funcionalidades em Destaque

- 🎨 Interface customizada com fontes e cores personalizadas
- 🧠 Validações de formulários integradas
- 🔄 Navegação controlada por `NavigationController`
- 📱 Compatível com Android (emulador e dispositivos físicos)

---

## 📌 Observações

> Este projeto é voltado para fins educacionais e demonstra boas práticas no uso do Flutter com SQLite local e separação de responsabilidades.
