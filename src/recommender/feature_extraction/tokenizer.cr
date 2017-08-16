require "stemmer"

module Recommender
  module FeatureExtraction
    module Tokenizer
      extend self

      def tokenize(document, stemming = true)
        doc = document
          .downcase
          .split(/(\s)|([\[\]\(\)])/)
          .map { |s| s.gsub(/[^\w\s]/, "") }
          .reject { |s| s.empty? || s.blank? }
          .map(&.chomp)

        return doc.map(&.stem) if stemming
        doc
      end
    end
  end
end
