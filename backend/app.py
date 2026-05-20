from flask import Flask, request, jsonify
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity
from dotenv import load_dotenv

import pymysql
import os
import bcrypt as cpt

load_dotenv()

app = Flask(__name__)
app.config[] = os.getenv('JWT_SECRET_KEY')
jwt = JWTManager(app)

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
    bytes_senha = senha_digitada.encode('utf-8')
    salt = cpt.gensalt()
    senha_hash = cpt.hashpw(bytes_senha, salt).decode('utf-8')

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

    senha_banco = conn.cursor.execute("SELECT senha FROM usuarios WHERE email = %s", (email,))
    senha_banco = conn.cursor.fetchone()
    if senha_banco is None:
        return jsonify(
            {
                "mensagem": "Email ou senha incorretos ou a conta não existe!"  
            }
        ), 401
    
    senha_banco, = senha_banco
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
            "token": access_token  
        }
    ), 201

# Rodar
if __name__ == '__main__':
    con = Conn().init()
    con.deinit()

    app.run(debug=True)
