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
