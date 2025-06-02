# Notas sobre o Design do Banco de Dados - Idioma Kanoé

## Introdução

Este documento descreve as principais decisões de design e a lógica por trás da estrutura do banco de dados do projeto "Idioma Kanoé - Povo Originário Indígena Brasileiro". O objetivo é centralizar informações lexicais, frasais, gramaticais e culturais da língua Kanoé, facilitando sua consulta, estudo e preservação. A estrutura foi desenvolvida de forma iterativa, considerando a necessidade de armazenar diferentes tipos de informação e os relacionamentos entre elas.

## Visão Geral das Tabelas

O banco de dados é composto por quatro tabelas principais:

1.  **`lexico`**: Armazena as palavras individuais do idioma Kanoé, suas traduções, transcrições fonéticas, notas culturais e outras informações relevantes. É a tabela central do dicionário.
2.  **`frase`**: Contém frases de exemplo no idioma Kanoé, suas traduções e contextos de uso, vinculadas às palavras da tabela `lexico`.
3.  **`regras_gramaticas`**: Destinada a armazenar tanto regras gramaticais específicas da língua Kanoé (que podem ser associadas a palavras do léxico) quanto descrições mais gerais sobre a estrutura e funcionamento do idioma (regras essenciais/meta-regras).
4.  **`categorias_palavras`**: Utilizada para classificar as palavras do léxico segundo categorias semânticas (ex: "Animal", "Comida") e classes gramaticais principais (ex: "Substantivo", "Verbo").

## Principais Decisões e Evolução do Esquema

A estrutura atual do banco de dados é resultado de um processo de discussão e refinamento. Algumas das principais decisões incluem:

### 1. Categorização de Palavras do Léxico

* **Decisão Inicial:** A ideia original considerava tabelas separadas para diferentes tipos de palavras (ex: `aves`, `animais`).
* **Refinamento:** Optou-se por uma abordagem mais centralizada e flexível com a criação da tabela `categorias_palavras`. Esta tabela possui colunas para `nome_categoria` (agrupamento semântico, como "Animal", "Planta", "Parte do Corpo", "Comida") e `classe_gramatical` ("Substantivo", "Verbo", etc.).
* **Implementação:** A tabela `lexico` agora possui uma coluna `fk_id_categoria` que referencia `categorias_palavras.id_categoria`. Isso permite que cada palavra seja associada a uma categoria semântica e a uma classe gramatical principal através de uma única referência.
* **Tabelas de Atributos Específicos:** A ideia de ter tabelas adicionais para atributos específicos de certas categorias (ex: `detalhes_aves` com colunas como `nome_cientifico_ave`) foi considerada, mas adiada para uma possível expansão futura, a fim de manter o esquema inicial mais simples.

### 2. Armazenamento de Regras Gramaticais

* **Decisão:** A tabela `regras_gramaticas` foi projetada para ser flexível.
    * Ela armazena **regras gramaticais específicas** (ex: "Substantivo Comum", "Verbo Transitivo Grupo 1") que podem ser diretamente associadas a palavras individuais na tabela `lexico` através da coluna `lexico.fk_id_regra`.
    * Ela também serve como um repositório para **"regras essenciais" ou meta-regras descritivas** sobre a fonologia, morfologia e sintaxe do Kanoé (ex: "Acento Tônico (Padrão)", "Ordem dos Constituintes (SOV)"). Estas últimas fornecem um contexto geral sobre a língua.

### 3. Informação Fonética

* **Decisão:** A informação de `transcricao_fonetica` para cada palavra é armazenada diretamente como uma coluna na tabela `lexico`.
* **Refinamento:** Uma ideia inicial de criar uma tabela `fonetica` separada foi descartada na fase atual para evitar redundância com os dados já presentes em `lexico` e simplificar o modelo.

### 4. Relacionamentos Chave e Chaves Estrangeiras

Os principais relacionamentos implementados são:

* **`lexico` e `categorias_palavras`**: Muitas palavras (`lexico`) pertencem a uma (`categorias_palavras`). Implementado com `lexico.fk_id_categoria` referenciando `categorias_palavras.id_categoria`.
* **`lexico` e `regras_gramaticas`**: Muitas palavras (`lexico`) podem seguir uma regra gramatical principal (`regras_gramaticas`). Implementado com `lexico.fk_id_regra` referenciando `regras_gramaticas.id_regra`.
* **`frase` e `lexico`**: Muitas frases (`frase`) estão associadas a uma palavra principal (`lexico`). Implementado com `frase.fk_id_palavra` referenciando `lexico.id_palavra`.
* **Conexão `frase` e `regras_gramaticas`**: Foi decidido *não* adicionar uma chave estrangeira direta de `frase` para `regras_gramaticas` neste momento, mas isso pode ser reconsiderado no futuro.

### 5. Chaves Primárias

* Para todas as tabelas, as colunas de identificação (`id_palavra`, `id_frase`, `id_regra`, `id_categoria`) foram definidas como `SERIAL PRIMARY KEY` (no PostgreSQL), garantindo IDs únicos e auto-incrementais para novas entradas.

## Diagrama do Banco de Dados

(Para a estrutura detalhada![mermaid-diagram-2025-06-01-200445](https://github.com/user-attachments/assets/867e12ab-0b5d-40ef-9f85-a9058015dcc7)


## Considerações Futuras

* Implementação de tabelas de atributos específicos para certas categorias de palavras, se necessário.
* Expansão dos tipos de regras e detalhes na tabela `regras_gramaticas`.
* Adição de mais campos à tabela `lexico` ou `frase` conforme a pesquisa avance (ex: informações etimológicas, variações dialetais, etc.).

Este documento reflete o estado do design do banco de dados até a presente data e pode ser atualizado conforme o projeto evolui.
