from flask import Flask, request, jsonify
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity
from flask_mail import Mail,  Message
from dotenv import load_dotenv
from flask_cors import CORS

import pymysql
import os
import bcrypt as cpt
import random as r

load_dotenv()

app = Flask(__name__)
CORS(app)

# cofigs
app.config["JWT_SECRET_KEY"] = os.getenv('JWT_SECRET_KEY')

app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] = 587
app.config['MAIL_USERNAME'] = 'paulinolucas668@gmail.com'
app.config['MAIL_PASSWORD'] = os.getenv("MAIL_PASSWD")
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USE_SSL'] = False

jwt = JWTManager(app)
mail = Mail(app)

# Banco
class Conn:
    def __init__(self):
        self.connection = ""
        self.cursor = ""

    def init(self):
        self.connection = pymysql.connect(host='localhost', user='root', password='12345678', database='rpg')
        self.cursor = self.connection.cursor()

        return self

    def deinit(self):
        self.cursor.close()
        self.connection.close()

# API
@app.route('/')
def home():
    return jsonify (
        {
            "status": "online",
            "mensagem": "API de RPG funcionando!"
        }
    )

@app.route("/registrar", methods=["POST"])
def registrar():
    """
        A Rota espera o seguinte json:

        {
            "nome": "",
            "email": "",
            "senha": ""
        }    
    """

    data = request.get_json()

    nome = data["nome"]
    email = data["email"]
    senha_digitada = data["senha"]

    # verificações de segurança
    if (nome is None or email is None or senha_digitada is None) or (len(nome) == 0 or len(email) == 0 or len(senha_digitada) == 0 ):
        return jsonify(
            {
                "mensagem": "O nome, email e senha são obrigatórios!"
            }
        ), 400

    # gera hash seguro da senha
    senha_hash = hashear(senha_digitada)

    # conecta com o banco e fecha conexões de forma segura
    conn = Conn().init()

    sql = "INSERT INTO usuarios (nome, email, senha) VALUES (%s, %s, %s)"
    conn.cursor.execute(sql, (nome, email, senha_hash))
    conn.connection.commit()

    conn.deinit()

    return jsonify(
        {
            "mensagem": "Usuário criado com sucesso"  
        }
    ), 201

@app.route("/entrar", methods=["POST"])
def entrar():
    """
        A Rota espera o seguinte json:

        {
            "email": "",
            "senha": ""
        }    
    """

    data = request.get_json()

    email = data["email"]
    senha_digitada = data["senha"]

    if (email is None or senha_digitada is None) or (len(email) == 0 or len(senha_digitada) == 0 ):
        return jsonify(
            {
                "mensagem": "O email e senha são obrigatórios!"
            }
        ), 400

    conn = Conn().init()

    conn.cursor.execute("SELECT id, nome, senha FROM usuarios WHERE email = %s", (email,))
    usuario = conn.cursor.fetchone()
    if usuario is None:
        return jsonify(
            {
                "mensagem": "Email ou senha incorretos ou a conta não existe!"  
            }
        ), 401
    
    id, nome, senha_banco = usuario
    senha_banco = senha_banco.encode('utf-8')

    bytes_senha = senha_digitada.encode('utf-8')
    conn.deinit()

    if not cpt.checkpw(bytes_senha, senha_banco):
        return jsonify(
            {
                "mensagem": "Email ou senha incorretos ou a conta não existe!"  
            }
        ), 401

    access_token = create_access_token(identity=email)

    return jsonify(
        {
            "mensagem": "Logado com sucesso",
            "id": id,
            "nome": nome,
            "token": access_token
        }
    ), 201

@app.route("/recuperar-senha", methods=["POST"])
def rec_senha():
    """
        A Rota espera o seguinte json:

        {
            "email": ""
        }
    """

    dados = request.get_json()
    email = dados["email"]

    code_gen = __rec_envia_codigo(email)

    if code_gen == 1:
        raise Exception("Err")

    return jsonify(
        {
            "mensagem": "Codigo enviada com sucesso",
            "codigo": code_gen
        }
    )


@app.route("/utils/verifica-codigo", methods=["POST"])
def rec_verifica_codigo():
    """
        A Rota espera o seguinte json:

        {
            "codigo_digitado": "",
            "codigo-real": ""
        }
    """

    dados = request.get_json()

    try:
        code = dados["codigo_digitado"]
        if code is None or len(code) == 0:
            return jsonify(
                {
                    "mensagem": "O Código é obrigatório"
                }
            ), 400
        
        code_d = int(code)
        code_r = int(dados["codigo_real"])
        
    except Exception as e:
        raise Exception(f"Erro: {e}")

    r = code_d == code_r

    if not r:
        return jsonify(
            {
                "mensagem": "Código inválido"
            }
        ), 401
    
    return jsonify(
        {
            "mensagem": "Código confimado"
        }
    ), 200

@app.route("/utils/atualizar-senha", methods=["PATCH"])
def atualizar_senha():
    dados = request.json

    # assume que o front mandou o email tbm
    if "senha" not in dados:
        return jsonify(
            {
                "mensagem": "A nova senha é obrigatória!"
            }
        ), 400

    sql = "UPDATE usuarios SET senha = %s WHERE email = %s"
    conn = Conn().init()
    conn.cursor.execute(sql, (hashear(dados["senha"]), dados["email"]))
    conn.connection.commit()

    conn.deinit()

    return jsonify(
        {
            "mensagem": "Nova senha atualizada com sucesso!"
        }
    ), 200


# ──────────────────────────────────────────────
# CRUD – Personagens (fichas)
# ──────────────────────────────────────────────

@app.route("/personagens", methods=["POST"])
def criar_personagem():
    """
    Cria um novo personagem.

    JSON esperado:
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
    """
    data = request.get_json()

    campos = ["usuario_id", "nome", "classe"]
    for campo in campos:
        if campo not in data or data[campo] is None or str(data[campo]) == "":
            return jsonify({"mensagem": f"O campo '{campo}' é obrigatório!"}), 400

    conn = Conn().init()
    sql = """
        INSERT INTO personagens (usuario_id, nome, classe, nivel, nex, hp, sanidade, forca, agilidade, intelecto, presenca, vigor)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """
    conn.cursor.execute(sql, (
        data["usuario_id"],
        data["nome"],
        data["classe"],
        data.get("nivel", 1),
        data.get("nex", 0),
        data.get("hp", 100),
        data.get("sanidade", 100),
        data.get("forca", 1),
        data.get("agilidade", 1),
        data.get("intelecto", 1),
        data.get("presenca", 1),
        data.get("vigor", 1)
    ))
    conn.connection.commit()
    personagem_id = conn.cursor.lastrowid
    conn.deinit()

    return jsonify({"mensagem": "Personagem criado com sucesso!", "id": personagem_id}), 201


@app.route("/personagens", methods=["GET"])
def listar_personagens():
    """
    Lista todos os personagens.
    Query param opcional: ?usuario_id=1  (filtra por usuário)
    """
    usuario_id = request.args.get("usuario_id")

    conn = Conn().init()

    if usuario_id:
        conn.cursor.execute("SELECT * FROM personagens WHERE usuario_id = %s", (usuario_id,))
    else:
        conn.cursor.execute("SELECT * FROM personagens")

    rows = conn.cursor.fetchall()
    colunas = [desc[0] for desc in conn.cursor.description]
    conn.deinit()

    personagens = [dict(zip(colunas, row)) for row in rows]

    return jsonify({"personagens": personagens}), 200


@app.route("/personagens/<int:personagem_id>", methods=["GET"])
def buscar_personagem(personagem_id):
    """
    Retorna um personagem pelo ID.
    """
    conn = Conn().init()
    conn.cursor.execute("SELECT * FROM personagens WHERE id = %s", (personagem_id,))
    row = conn.cursor.fetchone()
    colunas = [desc[0] for desc in conn.cursor.description]
    conn.deinit()

    if row is None:
        return jsonify({"mensagem": "Personagem não encontrado!"}), 404

    personagem = dict(zip(colunas, row))
    return jsonify({"personagem": personagem}), 200


@app.route("/personagens/<int:personagem_id>", methods=["PUT"])
def atualizar_personagem(personagem_id):
    """
    Atualiza os dados de um personagem existente.

    JSON esperado:
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
    """
    data = request.get_json()

    conn = Conn().init()
    conn.cursor.execute("SELECT id FROM personagens WHERE id = %s", (personagem_id,))
    if conn.cursor.fetchone() is None:
        conn.deinit()
        return jsonify({"mensagem": "Personagem não encontrado!"}), 404

    campos = ["nome", "classe", "nivel", "nex", "hp", "sanidade", "forca", "agilidade", "intelecto", "presenca", "vigor"]
    for campo in campos:
        if campo not in data or data[campo] is None or str(data[campo]) == "":
            conn.deinit()
            return jsonify({"mensagem": f"O campo '{campo}' é obrigatório!"}), 400

    sql = """
        UPDATE personagens
        SET nome = %s, classe = %s, nivel = %s, nex = %s,
            hp = %s, sanidade = %s, forca = %s, agilidade = %s,
            intelecto = %s, presenca = %s, vigor = %s
        WHERE id = %s
    """
    conn.cursor.execute(sql, (
        data["nome"], data["classe"], data["nivel"], data["nex"],
        data["hp"], data["sanidade"], data["forca"], data["agilidade"],
        data["intelecto"], data["presenca"], data["vigor"],
        personagem_id
    ))
    conn.connection.commit()
    conn.deinit()

    return jsonify({"mensagem": "Personagem atualizado com sucesso!"}), 200


@app.route("/personagens/<int:personagem_id>", methods=["DELETE"])
def deletar_personagem(personagem_id):
    """
    Deleta um personagem pelo ID.
    """
    conn = Conn().init()
    conn.cursor.execute("SELECT id FROM personagens WHERE id = %s", (personagem_id,))
    if conn.cursor.fetchone() is None:
        conn.deinit()
        return jsonify({"mensagem": "Personagem não encontrado!"}), 404

    conn.cursor.execute("DELETE FROM personagens WHERE id = %s", (personagem_id,))
    conn.connection.commit()
    conn.deinit()

    return jsonify({"mensagem": "Personagem deletado com sucesso!"}), 200


# utils
def __rec_envia_codigo(email: str):
    msg = Message(
        subject='Código de Confirmação',
        sender='paulinolucas668@gmail.com',
         recipients=[email]
    )

    code = r.randint(1000, 9999)
    msg.body = f"O seu código de confirmação é: {code}"

    try: 
        mail.send(msg)
        return code
    except Exception as e:
        print(e)
        return 1

def hashear(senha_digitada):
    bytes_senha = senha_digitada.encode('utf-8')
    salt = cpt.gensalt()
    return cpt.hashpw(bytes_senha, salt).decode('utf-8')


# Rodar
if __name__ == '__main__':
    con = Conn().init()
    con.deinit()
    
    app.run(debug=True)
