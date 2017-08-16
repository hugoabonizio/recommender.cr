module Recommender
  module FeatureExtraction
    class TFIDF
      @tokenized_documents : Array(Array(String))
      @all_tokens : Set(String)

      def initialize(@documents : Array(String), stemming = true)
        @tokenized_documents = @documents.map { |doc| Tokenizer.tokenize(doc, stemming) }
        @all_tokens = Set(String).new.tap do |tokens|
          @tokenized_documents.each { |doc| doc.each { |token| tokens << token } }
        end
      end

      def documents=(@documents, stemming = true)
        @tokenized_documents = @documents.map { |doc| Tokenizer.tokenize(doc, stemming) }
        @all_tokens = Set(String).new.tap do |tokens|
          @tokenized_documents.each { |doc| doc.each { |token| tokens << token } }
        end
      end

      def sublinear_term_frequency(term, tokenized_document)
        return 0 if tokenized_document.count(term) == 0
        1 + Math.log(tokenized_document.count(term))
      end

      def inverse_document_frequencies
        values = {} of String => Float64
        @all_tokens.each do |token|
          contains_token = @tokenized_documents.select { |doc| doc.includes? token }.size
          values[token] = 1 + Math.log(@tokenized_documents.size.to_f / contains_token)
        end
        values
      end

      def vectorize
        idf = inverse_document_frequencies
        tfidf_list = [] of Array(Float64)
        @tokenized_documents.each do |document|
          tfidf = [] of Float64
          idf.keys.each do |term|
            tf = sublinear_term_frequency(term, document)
            tfidf << tf * idf[term]
          end
          tfidf_list << tfidf
        end
        tfidf_list
      end
    end
  end
end
