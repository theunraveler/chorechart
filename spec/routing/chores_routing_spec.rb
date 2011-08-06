require "spec_helper"

describe ChoresController do
  describe "routing" do

    it "routes to #index" do
      get("/chores").should route_to("chores#index")
    end

    it "routes to #new" do
      get("/chores/new").should route_to("chores#new")
    end

    it "routes to #show" do
      get("/chores/1").should route_to("chores#show", :id => "1")
    end

    it "routes to #edit" do
      get("/chores/1/edit").should route_to("chores#edit", :id => "1")
    end

    it "routes to #create" do
      post("/chores").should route_to("chores#create")
    end

    it "routes to #update" do
      put("/chores/1").should route_to("chores#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/chores/1").should route_to("chores#destroy", :id => "1")
    end

  end
end
