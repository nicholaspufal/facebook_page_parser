require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe "Parser" do
  it "should parse the given URL" do    
    fb = FacebookPageParser::Parser.new("http://www.facebook.com/pages/CAIXA-DE-IDEIAS/89888524723")
    fb.page.should == "https://graph.facebook.com/89888524723"
    
    fb = FacebookPageParser::Parser.new("http://www.facebook.com/belvita")
    fb.page.should == "https://graph.facebook.com/belvita"
  end
  
  it "should raise an exception when the response is not success" do
    VCR.use_cassette('fb_bad_response') do
      fb = FacebookPageParser::Parser.new("http://www.facebook.com/pages/CAIXA-DE-IDEIAS/89888524723abc")
      expect { fb.get["description"] }.to raise_error
    end
  end
  
  it "should return the content when is a valid response" do
    VCR.use_cassette('fb_good_response') do
      fb = FacebookPageParser::Parser.new("http://www.facebook.com/pages/CAIXA-DE-IDEIAS/89888524723")
      fb.get["website"].should == "www.caixadeideias.com.br"
      fb.get["phone"].should == "51 32099233"
      fb.get["description"].should == "Somos inovadores. Cada um de nossa equipe compartilha a mesma paix\u00e3o: queremos que voc\u00ea seja mais produtivo.\nCriamos Software que voc\u00ea vai gostar de usar, de forma simples e \u00e1gil."
      fb.get["name"].should == "CAIXA DE IDEIAS"
    end
  end
end