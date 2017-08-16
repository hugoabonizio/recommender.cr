module Recommender
  module Metrics
    extend self

    def cosine_similarity(vector1, vector2)
      product = vector1.zip(vector2).map { |(a, b)| a * b }.sum
      magnitude = Math.sqrt(vector1.map { |i| i ** 2 }.sum * vector2.map { |i| i ** 2 }.sum)
      return 0.0 if magnitude == 0
      product.to_f / magnitude
    end
  end
end
