require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe "Parser" do
  
  context "regex" do
    it "should parse the given URL in various cases" do    
      fb = FacebookPageParser::Parser.new("http://www.facebook.com/pages/CAIXA-DE-IDEIAS/89888524723")
      fb.page.should == "https://graph.facebook.com/89888524723"

      fb = FacebookPageParser::Parser.new("http://facebook.com/pages/CAIXA-DE-IDEIAS/89888524723")
      fb.page.should == "https://graph.facebook.com/89888524723"
      
      fb = FacebookPageParser::Parser.new("http://facebook.com/pages/CAIXA-DE-IDEIAS/89888524723?abc=abc")
      fb.page.should == "https://graph.facebook.com/89888524723"
      
      fb = FacebookPageParser::Parser.new("http://facebook.com/pages/CAIXA-DE-IDEIAS/89888524723#123abc")
      fb.page.should == "https://graph.facebook.com/89888524723"

      fb = FacebookPageParser::Parser.new("https://www.facebook.com/pages/CAIXA-DE-IDEIAS/89888524723")
      fb.page.should == "https://graph.facebook.com/89888524723"

      fb = FacebookPageParser::Parser.new("http://www.facebook.com/belvita")
      fb.page.should == "https://graph.facebook.com/belvita"

      fb = FacebookPageParser::Parser.new("http://pt-br.facebook.com/NovoPalio")
      fb.page.should == "https://graph.facebook.com/NovoPalio"
    end    
  end
  
  context "responses" do
    it "should raise ResourceNotAvailableError when it's a 404" do
      VCR.use_cassette('fb_bad_response') do
        fb = FacebookPageParser::Parser.new("http://www.facebook.com/pages/CAIXA-DE-IDEIAS/89888524723abc")
        expect { fb.get["description"] }.to raise_error(FacebookPageParser::Exceptions::ResourceNotAvailableError)
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
    
    it "should return the website containing the http:// correctly" do
      VCR.use_cassette('fb_page_containing_http_in_website') do
        fb = FacebookPageParser::Parser.new("http://www.facebook.com/viagemmania")
        fb.get["website"].should == "http://www.viagemmania.com.br"
      end  
    end
  end
end