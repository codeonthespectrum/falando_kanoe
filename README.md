# Banco de Dados do Idioma Kanoé - Povo Originário Indígena Brasileiro

## Descrição

Este repositório contém os artefatos e a documentação do banco de dados desenvolvido para o registro e preservação de informações sobre o idioma Kanoé, uma língua indígena brasileira classificada como isolada e ameaçada de extinção, falada por remanescentes que vivem no estado de Rondônia, Brasil.

O objetivo principal deste projeto é criar uma base de dados estruturada que armazene o léxico, frases de exemplo, regras gramaticais e notas culturais do idioma Kanoé, contribuindo para sua documentação e facilitando futuros estudos e iniciativas de revitalização.

## Objetivos do Banco de Dados

* Armazenar de forma organizada o vocabulário (léxico) da língua Kanoé, incluindo traduções, transcrições fonéticas e notas de uso.
* Registrar frases de exemplo que ilustrem o uso das palavras em diferentes contextos.
* Catalogar regras gramaticais, tanto específicas quanto descrições gerais (princípios) da língua.
* Permitir a classificação das palavras do léxico em categorias semânticas e classes gramaticais.
* Servir como uma fonte de consulta para pesquisadores, membros da comunidade Kanoé e interessados na língua.


## Modelo do Banco de Dados

O banco de dados é composto por quatro tabelas principais, desenvolvidas para capturar os aspectos centrais do idioma:

* **`lexico`**: Armazena as palavras individuais, suas traduções, transcrições fonéticas, notas culturais e links para sua categoria e regra gramatical principal.
* **`frase`**: Contém frases de exemplo, suas traduções, contexto de uso e o link para a palavra principal do léxico que ela exemplifica.
* **`regras_gramaticas`**: Repositório de regras gramaticais específicas do Kanoé e também de princípios linguísticos gerais (meta-regras) sobre o idioma.
* **`categorias_palavras`**: Classifica as palavras do léxico em categorias semânticas (ex: "Animal", "Comida") e classes gramaticais principais (ex: "Substantivo", "Verbo").

### Diagrama Entidade-Relacionamento (Mermaid)

```mermaid
erDiagram
    lexico {
        int id_palavra PK
        string palavra_kanoe
        string transcricao_fonetica
        string trad_port
        string trad_port_secundario
        string nota_uso_cultural
        string fonte_info
        int fk_id_categoria FK "Ref: categorias_palavras.id_categoria"
        int fk_id_regra FK "Ref: regras_gramaticas.id_regra"
    }

    frase {
        int id_frase PK
        int fk_id_palavra FK "Ref: lexico.id_palavra"
        string frase_kanoe
        string trad_frase_port
        string contexto_uso
        string fonte_info
    }

    regras_gramaticais {
        int id_regra PK
        string nome_regra "Ex: Substantivo contável, Verbo irregular tipo A"
        string descricao_regra
    }

    categorias_palavras {
        int id_categoria PK
        string nome_categoria "Ex: Animal, Ferramenta, Cor, Ação"
        string classe_gramatical "Ex: Substantivo, Verbo, Adjetivo"
    }

    lexico ||--o{ frase : "palavra_contida_em_frase"
    lexico }o--|| categorias_palavras : "pertence_a_categoria_e_classe"
    lexico }o--|| regras_gramaticas : "segue_regra_especifica"
