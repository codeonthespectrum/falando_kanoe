CREATE TABLE categorias_palavras (
    id_categoria SERIAL PRIMARY KEY,
    nome_categoria VARCHAR(255) NOT NULL,
    classe_gramatical VARCHAR(100) NOT NULL
);

CREATE TABLE regras_gramaticais (
    id_regra SERIAL PRIMARY KEY,
    nome_regra VARCHAR(255) NOT NULL,
    descricao_regra TEXT
);

CREATE TABLE lexico (
    id_palavra SERIAL PRIMARY KEY, 
    palavra_kanoe TEXT NOT NULL,
    transcricao_fonetica TEXT,
    trad_port TEXT NOT NULL,
    trad_port_secundario TEXT,
    nota_uso_cultural TEXT,
    fonte_info VARCHAR(255),
    fk_id_categoria INTEGER REFERENCES categorias_palavras(id_categoria),
    fk_id_regra INTEGER REFERENCES regras_gramaticais(id_regra)
);

CREATE TABLE frase (
    id_frase SERIAL PRIMARY KEY, 
    fk_id_palavra INTEGER REFERENCES lexico(id_palavra),
    frase_kanoe TEXT NOT NULL,
    trad_frase_port TEXT NOT NULL,
    contexto_uso TEXT,
    fonte_info VARCHAR(255)
);