require 'ruby-spacy'

require 'json'

require 'engtagger'

require 'csv'

worldcities =[]

citiescsv = CSV.read('C:\Users\SID\Documents\itinerary_generator\cities.csv', headers: true)

tgr = EngTagger.new

nlp = Spacy::Language.new('en_core_web_sm')

file = File.open("itinerary.txt", "r")

input_text = file.read

doc = nlp.read(input_text)

def concatenate_nnp_words(text)
  tagger = EngTagger.new
  tagged_text = tagger.add_tags(text)
  # puts tagged_text
  # extract all proper nouns from the tagged text
  # proper_nouns = tagger.get_proper_nouns(tagged_text)
  # proper_nouns
  tagged_text
end

  # Get the sentence tokens from the response
sentence_tokens = []
doc.sents.each do |sentence|
  sentence_tokens << sentence.text
end

# sentence_tokens.each do |tokens|
#   puts tokens + "\n"
# end
sentence_tokens.each do |sent|
  concatenate_nnp_words(sent)
end

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




