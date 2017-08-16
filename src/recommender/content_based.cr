module Recommender
  class ContentBased
    @tfidfs : Array(Array(Float64))?

    def initialize(@documents : Array(String))
    end

    def initialize
      @documents = [] of String
    end

    def documents=(@documents)
    end

    def <<(document)
      @documents << document
      @tfidfs = nil
    end

    def fit
      @tfidfs = FeatureExtraction::TFIDF.new(@documents).vectorize
    end

    def similar_to(document_index : Int32)
      fit unless @tfidfs

      if tfidfs = @tfidfs
        tfidf = tfidfs[document_index]
        similarities = [] of NamedTuple(i: Int32, similarity: Float64)
        tfidfs.each_with_index do |doc, i|
          next if i == document_index
          similarities << {i: i, similarity: Metrics.cosine_similarity(tfidf, doc)}
        end
        return similarities.sort_by(&.[:similarity]).reverse.map(&.[:i])
      end

      [] of Int32
    end
  end
end
