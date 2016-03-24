require './lib/stanford-core-nlp'
require 'pry'

# Use the model files for a different language than English.
# StanfordCoreNLP.use :french # or :german, :english
StanfordCoreNLP.jar_path = '/Users/frankel/Downloads/stanford/'
StanfordCoreNLP.model_files = {}
StanfordCoreNLP.default_jars = [
  'joda-time-2.6.jar',
  'xom.jar',
  'stanford-corenlp-3.6.0.jar',
  'stanford-corenlp-3.6.0-models.jar',
  'jollyday.jar',
  'bridge.jar',
  'slf4j-simple.jar',
  'slf4j-api.jar',
]

text = 'Angela Merkel met Nicolas Sarkozy on January 25th in ' +
   'Berlin to discuss a new austerity package. Sarkozy ' +
   'looked pleased, but Merkel was dismayed.'

pipeline =  StanfordCoreNLP.load(:tokenize, :ssplit, :pos, :lemma, :parse, :ner, :dcoref)
text = StanfordCoreNLP::Annotation.new(text)
pipeline.annotate(text)

text.get(:sentences).each do |sentence|
  # Syntatical dependencies
  puts sentence.get(:basic_dependencies).to_s
  sentence.get(:tokens).each do |token|
    # Default annotations for all tokens
    puts token.get(:value).to_s
    puts token.get(:original_text).to_s
    puts token.get(:character_offset_begin).to_s
    puts token.get(:character_offset_end).to_s
    # POS returned by the tagger
    puts token.get(:part_of_speech).to_s
    # Lemma (base form of the token)
    puts token.get(:lemma).to_s
    # Named entity tag
    puts token.get(:named_entity_tag).to_s
    # Coreference
    puts token.get(:coref_cluster_id).to_s
    # Also of interest: coref, coref_chain,
    # coref_cluster, coref_dest, coref_graph.
  end
end