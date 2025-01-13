# USF Gerenciador - Unidade de Saúde da Família

## 1. Introdução
Bem-vindo(a) ao repositório do projeto **USF Gerenciador**! Este aplicativo foi criado com o objetivo de facilitar e melhorar a gestão de filas, agendamentos e documentação nas Unidades de Saúde da Família (USF). Este projeto é um conceito desenvolvido para explorar funcionalidades e promover contribuições da comunidade.

## 2. Funcionalidades Principais

### 2.1. Autenticação de Usuário
- Login com e-mail e senha.
- Cadastro de novos usuários.

### 2.2. Agendamento de Consultas
- Escolha de especialidades disponíveis.
- Exibição de horários disponíveis.
- Verificação de necessidade de encaminhamento antes da consulta.

### 2.3. Ver Fila de Espera
- Verificação da posição na fila em tempo real.
- Validação de presença por geolocalização e token.

### 2.4. Documentos do Paciente
- Justificativas de ausência.
- Encaminhamentos médicos.
- Resultados de exames.
- Receituário médico.

## 3. Tecnologias Utilizadas
- **Frontend**: Flutter.
- **Backend**: Node.js com Express.
- **Banco de Dados**: MongoDB.
- **Firebase**: Para notificações push.

## 4. Requisitos
- Flutter SDK >= 2.18.0.
- Node.js >= 16.
- MongoDB instalado e configurado.

## 5. Como Configurar o Projeto Localmente
1. Clone este repositório:
```bash
 git clone https://github.com/OhmXLLI/usf-gerenciador.git
```
2. Navegue até a pasta do projeto:
```bash
 cd usf-gerenciador
```
3. Instale as dependências do Flutter:
```bash
 flutter pub get
```
4. Instale as dependências do backend:
```bash
 cd backend_usf
 npm install
```

## 6. Como Executar o Projeto
- **Frontend**:
```bash
 flutter run
```
- **Backend**:
```bash
 node server.js
```

## 7. Segurança de Dados
O projeto lida com dados sensíveis, por isso é essencial adotar as melhores práticas de segurança durante o desenvolvimento e manutenção. 

Recomenda-se o uso de variáveis de ambiente para armazenar informações confidenciais, evitando que chaves de acesso e credenciais sejam expostas em arquivos de configuração. Além disso, mantenha revisões periódicas no código para garantir a proteção de dados e evitar vazamentos.

## 8. Documentação do Projeto
Os seguintes documentos foram incluídos para consulta:
- **Documento de Visão**: Detalha os objetivos e funcionalidades do projeto.
- **Manual do Usuário**: Guia para utilizar o aplicativo.
- **Plano de Testes**: Estratégias e casos de teste utilizados.

## 9. Contribuições
Sinta-se à vontade para clonar o repositório, fazer suas alterações e contribuir com melhorias.

Se deseja contribuir:
1. Crie um fork do projeto.
2. Crie uma branch com sua feature:
```bash
 git checkout -b minha-feature
```
3. Faça um commit com suas alterações:
```bash
 git commit -m "Adiciona nova feature"
```
4. Faça o push para a branch:
```bash
 git push origin minha-feature
```
5. Abra um Pull Request.

## 10. Convite e Mensagem de Incentivo

Se você gosta de desafios, este projeto é para você! Algumas ideias de melhorias incluem:
- Desenvolver um painel web de gestão para a USF.
- Implementar integração com o sistema de prontuário eletrônico.
- Criar um sistema robusto de validação de presença com geolocalização e tokens dinâmicos.

Vamos construir juntos algo que possa fazer a diferença!

## 11. Licença
Este projeto está sob a licença MIT. Consulte o arquivo `LICENSE` para mais detalhes.

Espero que aproveite o projeto e que ele seja útil para inspirar novas ideias e soluções!

---

Sinta-se livre para explorar e contribuir!
