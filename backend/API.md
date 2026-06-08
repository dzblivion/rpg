# Rotas

## /registrar

Método > POST

JSON *`esperado`*:

```json
{
    "nome": "<nome do usuario aqui>",
    "email": "<email do usuario aqui>",
    "senha": "<senha do usuario aqui>"
}    
```

___

JSONs *`retornado`*:

Caso *`perfeito`*:
```json
{
    "mensagem": "Usuário criado com sucesso"  
}
```

Código http: *`201`* (*`Created`*)

--

Caso *`erro`*:
```json
{
    "mensagem": "O nome, email e senha são obrigatórios!"
}
```


Código http: *`400`* (*`BadRequest`*)

## /entrar

Método > POST

JSON *`esperado`*:

```json
{
    "nome": "<nome do usuario aqui>",
    "email": "<email do usuario aqui>",
}    
```
___

JSONs *`retornado`*:

Caso *`perfeito`*:
```json
{
    "mensagem": "Logado com sucesso",
    "token": "<token_acesso>"  
}
```

Código http: *`201`* (*`Created`*)

--

Caso *`erro`*:
```json
{
    "mensagem": "Email ou senha incorretos ou a conta não existe!"  
}       
```

Código http: *`401`* (*`Unauthorized `*)

---

---

## /personagens

### POST /personagens — Criar personagem

JSON *`esperado`* (`nivel`, `nex`, `hp`, `sanidade` e atributos são opcionais — usam os defaults do banco):

```json
{
    "usuario_id": 1,
    "nome": "Aragorn",
    "classe": "Guerreiro",
    "nivel": 1,
    "nex": 0,
    "hp": 100,
    "sanidade": 100,
    "forca": 1,
    "agilidade": 1,
    "intelecto": 1,
    "presenca": 1,
    "vigor": 1
}
```

JSON *`retornado`* (sucesso):
```json
{
    "mensagem": "Personagem criado com sucesso!",
    "id": 1
}
```
Código http: `201`

---

### GET /personagens — Listar personagens

Query param opcional: `?usuario_id=1` (filtra por usuário)

JSON *`retornado`*:
```json
{
    "personagens": [
        { "id": 1, "usuario_id": 1, "nome": "Aragorn", "classe": "Guerreiro", ... }
    ]
}
```
Código http: `200`

---

### GET /personagens/<id> — Buscar personagem por ID

JSON *`retornado`* (sucesso):
```json
{
    "personagem": { "id": 1, "usuario_id": 1, "nome": "Aragorn", ... }
}
```
Código http: `200`

Caso *`não encontrado`*:
```json
{ "mensagem": "Personagem não encontrado!" }
```
Código http: `404`

---

### PUT /personagens/<id> — Atualizar personagem

JSON *`esperado`* (todos os campos obrigatórios):

```json
{
    "nome": "Aragorn",
    "classe": "Guerreiro",
    "nivel": 5,
    "nex": 50,
    "hp": 150,
    "sanidade": 80,
    "forca": 3,
    "agilidade": 2,
    "intelecto": 1,
    "presenca": 2,
    "vigor": 3
}
```

JSON *`retornado`* (sucesso):
```json
{ "mensagem": "Personagem atualizado com sucesso!" }
```
Código http: `200`

---

### DELETE /personagens/<id> — Deletar personagem

JSON *`retornado`* (sucesso):
```json
{ "mensagem": "Personagem deletado com sucesso!" }
```
Código http: `200`

Caso *`não encontrado`*:
```json
{ "mensagem": "Personagem não encontrado!" }
```
Código http: `404`
