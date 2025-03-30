# Reconhecedor em Lista de Afazeres

## Descrição

Este projeto tem como objetivo desenvolver um programa em Ruby que identifica e extrai informações relevantes de listas de afazeres utilizando **expressões regulares**. O programa é capaz de reconhecer e extrair:

- **Horários:** Exemplos – "10:30", "10 horas", "às 10"
- **Datas:** Exemplos – "28 de Fevereiro", "20/04/2022", "hoje", "amanhã", "depois de amanhã"
- **Pessoas:** A partir de padrões como "com José"
- **Tags:** Qualquer palavra iniciada por `#`, como "#trabalho" ou "#casa"
- **Ações:** Verbos essenciais (ex.: agendar, marcar, ligar)
- **URLs:** Ex.: `https://sp.senac.br/pag1#teste?aula=1&teste=4`
- **Emails:** Ex.: `jose.da-silva@sp.senac.br`

O código foi desenvolvido utilizando exclusivamente expressões regulares para reconhecimento dos padrões, sem o uso de combinações de substrings (como `slice`, `split`, etc.). A abordagem é robusta, modular e de fácil manutenção, permitindo que cada tipo de dado seja identificado de forma independente.

## Funcionalidades

- **Reconhecimento de Horários:**  
  Suporta múltiplos formatos de escrita.
- **Reconhecimento de Datas:**  
  Capta datas por extenso, datas numéricas e palavras-chave relativas (como "hoje", "amanhã").
- **Extração de Tags, URLs e Emails:**  
  Identifica e extrai essas informações presentes na lista de afazeres.
- **Identificação de Ações e Pessoas:**  
  Localiza verbos-chave e nomes de pessoas a partir de padrões pré-definidos.

## Pré-Requisitos

- **Ruby:** Versão 2.x ou superior.


