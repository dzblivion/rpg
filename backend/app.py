from flask import Flask, request, jsonify
import pymysql

app = Flask(__name__)

def connect():
    db = pymysql.connect(host='localhost', user='root', password='12345678', db='rpg')
    return db


@app.route('/')
def home():
    return {
        "mensagem": "API de RPG funcionando!"
    }
if __name__ == '__main__':
    app.run(debug=True)