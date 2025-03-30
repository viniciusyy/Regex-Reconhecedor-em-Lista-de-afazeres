# encoding: utf-8
require 'date'

# Exemplo de entrada
entrada = "Agendar com José reunião às 10:00 amanhã #trabalho"


# ===== Expressões Regulares =====

# Horários: aceita formatos como "10:30", "10 30", "10 horas", "1 hora", "às 10"
regex_horario = /
  (?:às?\s*)?                   # opcional: "às" ou "a"
  (\d{1,2}(?::\d{2})?)           # hora com ou sem minutos (ex.: 10 ou 10:00)
  (?:\s*(?:horas?|hora))?        # opcional: "hora(s)"
/ix

# Datas: aceita "28 de Fevereiro", "13 de agosto de 2021", "30/01", "20/04/2022"
# e também palavras-chave: hoje, amanhã, depois de amanhã.
# encoding: utf-8

regex_data = %r{
  (
    \d{1,2}                      # dia com 1 ou 2 dígitos
    (?:\s*(?:de)?\s*
      (?:janeiro|fevereiro|março|abril|maio|junho|julho|agosto|setembro|outubro|novembro|dezembro)
    )                          # nome do mês
    (?:\s*\d{4})?              # opcional: ano com 4 dígitos
  )
  |
  (\d{1,2}\/\d{1,2}(?:\/\d{2,4})?)   # datas numéricas (ex.: 30/01 ou 20/04/2022)
  |
  (\bhoje\b|\bamanhã\b|\bdepois\s+de\s+amanhã\b)   # palavras-chave (case-insensitive)
}ix


# Tags: reconhece palavras iniciadas por "#"
regex_tag = /#\w+/

# URLs: reconhece padrões que comecem com http(s)
regex_url = /https?:\/\/[\w\.-]+(?:\/[\w\.-]*)*(?:\?[\w=&]+)?(?:#[\w-]+)?/

# Emails: padrão simples para emails
regex_email = /\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b/

# Ação: verbos sugeridos para identificar a ação (ex.: agendar, marcar, ligar)
regex_acao = /\b(agendar|marcar|ligar)\b/i

# Pessoa: procura o padrão "com Nome", onde o nome inicia com letra maiúscula
regex_pessoa = /(?:com\s+)([A-ZÁÉÍÓÚÇ][a-záéíóúç]+(?:\s+[A-ZÁÉÍÓÚÇ][a-záéíóúç]+)*)/

# ===== Extração dos Dados =====

# Extrair horário (captura o primeiro grupo com número e possível ":00")
horario = entrada[regex_horario, 1]

# Extrair data (buscando os três possíveis grupos; priorizamos o relativo se houver)
data_capturada = entrada.match(regex_data)
data_extraida = nil
if data_capturada
  if data_capturada[3]  # "hoje", "amanhã" ou "depois de amanhã"
    palavra = data_capturada[3].downcase
    hoje = Date.today
    dia = case palavra
          when "hoje" then hoje
          when "amanhã" then hoje + 1
          when "depois de amanhã" then hoje + 2
          end
    data_extraida = dia.strftime("%d/%m/%Y")
  elsif data_capturada[2]  # datas no formato numérico
    data_extraida = data_capturada[2]
  elsif data_capturada[1]  # datas com dia, mês (e opcional ano)
    data_extraida = data_capturada[1]
  end
end

# Extrair tag (primeira ocorrência)
tag = entrada[regex_tag]

# Extrair URL (primeira ocorrência)
url = entrada[regex_url]

# Extrair email (primeira ocorrência)
email = entrada[regex_email]

# Extrair ação (primeiro verbo identificado)
acao = entrada[regex_acao, 1]

# Extrair pessoa (após "com")
pessoa = entrada[regex_pessoa, 1]

# ===== Exibição dos Resultados =====

puts "Dia: #{data_extraida}" if data_extraida
puts "Horário: #{horario}" if horario
puts "Pessoa: #{pessoa}" if pessoa
puts "Ação: #{acao}" if acao
puts "Tag: #{tag}" if tag
puts "URL: #{url}" if url
puts "Email: #{email}" if email
