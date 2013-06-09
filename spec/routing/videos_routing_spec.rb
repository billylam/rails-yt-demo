require "spec_helper"

describe VideosController do
  describe "routing" do

    it "routes to #index" do
      get("/videos").should route_to("videos#index")
    end

    it "routes to #create" do
      post("/videos").should route_to("videos#create")
    end
  end
end
