# 🚀 Guia de Setup - Cinema Challenge

## Pré-requisitos para Execução dos Testes

### 1. **Backend API** (Obrigatório)
```bash
cd cinema-challenge-back
npm install
npm run seed    # Popular banco com dados
npm start       # Roda na porta 5000
```

### 2. **Frontend** (Para testes de UI e E2E)
```bash
cd cinema-challenge-front  
npm install
npm start       # Roda na porta 3000
```

### 3. **MongoDB** (Obrigatório)
- Deve estar rodando na porta 27017
- Database: `cinema`

## ✅ Verificação do Setup

### Testar Backend:
```bash
curl http://localhost:5000
# Deve retornar: {"message":"Welcome to Cinema App API"}
```

### Testar Frontend:
- Abrir: http://localhost:3000
- Deve carregar a página de login

## 🎯 Tipos de Teste vs Dependências

| Tipo de Teste | Backend | Frontend | MongoDB |
|---------------|---------|----------|---------|
| **Backend API** | ✅ | ❌ | ✅ |
| **Frontend UI** | ✅ | ✅ | ✅ |
| **End-to-End** | ✅ | ✅ | ✅ |
| **Performance** | ✅ | ❌ | ✅ |

## 🔧 Execução Seletiva

### Apenas testes de Backend (API):
```bash
robot backend-tests/
```
**Precisa**: Backend + MongoDB

### Apenas testes de Frontend:
```bash  
robot frontend-tests/
```
**Precisa**: Backend + Frontend + MongoDB

### Testes End-to-End:
```bash
robot e2e-tests/
```
**Precisa**: Backend + Frontend + MongoDB