require "./spec_helper"

describe Recommender::Metrics do
  it ".cosine_similarity" do
    vec1 = [1, 2, 3]
    vec2 = [0, 0, 0]
    vec3 = [1, 0, 3]
    Recommender::Metrics.cosine_similarity(vec1, vec1).should eq 1.0
    Recommender::Metrics.cosine_similarity(vec1, vec2).should eq 0.0
    (Recommender::Metrics.cosine_similarity(vec1, vec3) > 0).should be_true
    (Recommender::Metrics.cosine_similarity(vec1, vec3) < 1).should be_true
  end
end
