require 'ruby-spacy'

require 'json'

nlp = Spacy::Language.new('en_core_web_sm')


file = File.open("itinerary.txt", "r")

input_text = file.read

puts input_text

doc = nlp.read(input_text)

  # Get the sentence tokens from the response
sentence_tokens = []
doc.sents.each do |sentence|
  sentence_tokens << sentence.text
end

# sentence_tokens.each do |tokens|
#   puts tokens + "\n"
# end

response = []

sentence_tokens.each do |sentence|
  doc = nlp.read(sentence)

  entities = []
  doc.ents.each do |entity|
    entities << {text: entity.text, label: entity.label}
  end

  # puts entities

  sentence_response = {}
  sentence_response[:day] = entities.select { |e| e[:label] == 'DATE' }.map { |e| e[:text] }
  sentence_response[:places] = entities.select { |e| e[:label] == 'GPE' }.map { |e| e[:text] }
  sentence_response[:attractions] = entities.select { |e| e[:label] == 'FAC' || e[:label] == 'ORG' || e[:label] == 'PERSON'}.map { |e| e[:text] }

  response << sentence_response
end

puts JSON.pretty_generate(response)




