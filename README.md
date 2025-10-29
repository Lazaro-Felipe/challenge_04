# 🎬 Cinema Challenge - Projeto Completo

## 📁 Estrutura do Projeto

```
challenge_final/
├── cinema-automation-suite/           # 🤖 Suite de Automação
│   ├── backend-tests/                 # Testes de API
│   ├── config/                        # Configurações
│   ├── utils/                         # Keywords customizadas
│   └── run_all_tests.bat             # Executar testes
│
├── cinema-challenge-back/             # 🔧 Backend API (Node.js)
│   ├── src/                          # Código fonte
│   ├── package.json                  # Dependências
│   └── .env                          # Configurações
│
└── cinema-challenge-front/            # 🌐 Frontend (React)
    ├── src/                          # Código fonte
    ├── package.json                  # Dependências
    └── public/                       # Arquivos públicos
```

## 🚀 Como Executar

### 1. Mover as Aplicações (se necessário)
```bash
# Parar os serviços primeiro (Ctrl+C nos terminais)
# Depois mover as pastas:
move c:\Users\lazaro\cinema-challenge-back c:\Users\lazaro\Downloads\challenge_final\
move c:\Users\lazaro\cinema-challenge-front c:\Users\lazaro\Downloads\challenge_final\
```

### 2. Iniciar Backend
```bash
cd cinema-challenge-back
npm start  # Porta 5000
```

### 3. Iniciar Frontend  
```bash
cd cinema-challenge-front
npm start  # Porta 3002
```

### 4. Executar Testes
```bash
cd cinema-automation-suite
robot --outputdir reports backend-tests/
```

## 📍 Localização Atual das Aplicações
- **Backend**: `c:\Users\lazaro\cinema-challenge-back`
- **Frontend**: `c:\Users\lazaro\cinema-challenge-front`
- **Testes**: `c:\Users\lazaro\Downloads\challenge_final\cinema-automation-suite`