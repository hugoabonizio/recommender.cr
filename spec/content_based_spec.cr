require "./spec_helper"

describe Recommender::ContentBased do
  it "recomends similar documents" do
    recommender = Recommender::ContentBased.new
    recommender << "aaa"
    recommender << "bbb"
    recommender << "ccc"
    recommender << "aaa ccc"
    result = recommender.similar_to(0)
    result[0].should eq(3)
  end

  it "don't recommends different documents first" do
    recommender = Recommender::ContentBased.new
    recommender << "aaa"
    recommender << "bbb"
    recommender << "ccc"
    recommender << "aaa ccc"
    result = recommender.similar_to(1)
    result[0].should_not eq(0)
  end
end
