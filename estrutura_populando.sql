-- Exemplo de como inserir dados em 'categorias_palavras'
INSERT INTO categorias_palavras (nome_categoria, classe_gramatical) VALUES
('Categoria Exemplo 1 (ex: Animal)', 'Substantivo'),
('Categoria Exemplo 2 (ex: Ação)', 'Verbo');

-- Exemplo de como inserir dados em 'regras_gramaticas'
INSERT INTO regras_gramaticas (nome_regra, descricao_regra) VALUES
('Nome Regra Exemplo 1 (ex: Substantivo Comum)', 'Descrição da regra exemplo 1...'),
('Nome Regra Exemplo 2 (ex: Verbo Transitivo)', 'Descrição da regra exemplo 2...');

-- Exemplo de como inserir dados na tabela 'lexico'
-- NOTA: Os valores para fk_id_categoria e fk_id_regra devem existir
--       nas tabelas 'categorias_palavras' e 'regras_gramaticas'.
--       Para este exemplo, vamos supor que o ID 1 em ambas existe.

INSERT INTO lexico (
    palavra_kanoe,
    transcricao_fonetica,
    trad_port,
    fk_id_categoria,  -- ID de 'Categoria Exemplo 1' (Substantivo)
    fk_id_regra,      -- ID de 'Nome Regra Exemplo 1'
    nota_uso_cultural,
    fonte_info
) VALUES (
    'Palavra Kanoé Genérica 1',
    '[transkrisãw ʒeneɾika 1]',
    'Tradução Genérica 1',
    1, -- Supondo que o ID 1 em 'categorias_palavras' é 'Categoria Exemplo 1'
    1, -- Supondo que o ID 1 em 'regras_gramaticas' é 'Nome Regra Exemplo 1'
    'Nota cultural genérica para a palavra 1.',
    'Fonte genérica 1'
);

INSERT INTO lexico (
    palavra_kanoe,
    transcricao_fonetica,
    trad_port,
    fk_id_categoria, -- ID de 'Categoria Exemplo 2' (Verbo)
    fk_id_regra      -- ID de 'Nome Regra Exemplo 2'
) VALUES (
    'Outra Palavra Kanoé 2',
    '[owtra transkrisãw 2]',
    'Outra Tradução 2',
    2, -- Supondo que o ID 2 em 'categorias_palavras' é 'Categoria Exemplo 2'
    2  -- Supondo que o ID 2 em 'regras_gramaticas' é 'Nome Regra Exemplo 2'
);

-- Exemplo de como inserir dados na tabela 'frase'
-- NOTA: O valor para fk_id_palavra deve existir na tabela 'lexico'.
--       Para este exemplo, vamos supor que o ID 1 em 'lexico' existe.

INSERT INTO frase (
    fk_id_palavra, -- ID da 'Palavra Kanoé Genérica 1'
    frase_kanoe,
    trad_frase_port,
    contexto_uso,
    fonte_info
) VALUES (
    1, -- Supondo que o ID 1 na tabela 'lexico' é 'Palavra Kanoé Genérica 1'
    'Frase exemplo genérica em Kanoé contendo a palavra 1.',
    'Tradução da frase exemplo genérica.',
    'Contexto de uso genérico.',
    'Fonte genérica da frase.'
);