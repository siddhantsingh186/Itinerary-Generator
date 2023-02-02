require 'engtagger'

require 'csv'

tgr = EngTagger.new

file = File.open("itinerary.txt", "r")

input = file.read

worldcities =[]

citiescsv = CSV.read('C:\Users\SID\Documents\itinerary_generator\cities.csv', headers: true)

citiescsv.each do |row|
  worldcities << row['name']
end


def concatenate_nnp_words(text)
  tagger = EngTagger.new
  tagged_text = tagger.add_tags(text)
  # extract all proper nouns from the tagged text
  proper_nouns = tagger.get_proper_nouns(tagged_text)
  puts proper_nouns 
  
  proper_nouns
end

sentence = []

input.split('.').each do |sent|
  sentence << sent
end


sentence.each do |sent|
  concatenated_nnp_words = concatenate_nnp_words(sent)
  concatenated_nnp_words
end


