-- Tabela de fichas de personagem
CREATE TABLE IF NOT EXISTS fichas (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id   INT NOT NULL,
    nome         VARCHAR(100) NOT NULL,
    classe       VARCHAR(50)  NOT NULL,
    raca         VARCHAR(50)  NOT NULL,
    nivel        INT          NOT NULL DEFAULT 1,
    vida         INT          NOT NULL DEFAULT 10,
    forca        INT          NOT NULL DEFAULT 8,
    destreza     INT          NOT NULL DEFAULT 8,
    inteligencia INT          NOT NULL DEFAULT 8,
    criado_em    TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);
