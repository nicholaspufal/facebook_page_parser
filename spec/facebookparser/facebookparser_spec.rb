require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe "FacebookParser" do
  it "should parse the given URL" do    
    fb = FacebookParser.new("http://www.facebook.com/pages/CAIXA-DE-IDEIAS/89888524723")
    fb.page.should == "https://graph.facebook.com/89888524723"
    
    fb = FacebookParser.new("http://www.facebook.com/belvita")
    fb.page.should == "https://graph.facebook.com/belvita"
  end
end