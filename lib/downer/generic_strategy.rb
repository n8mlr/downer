module Downer
 
  class SubclassMethodUndefined < StandardError; end
  
  class GenericStrategy
    
    def initialize(source, search_options = {})
      @url_source = source
      @search_options = search_options
    end
    
    def get_urls
      raise SubclassMethodUndefined
    end
    
    def source_valid?
      raise SubclassMethodUndefined
    end
    
    def source_type
      name = self.class.name.gsub(/Downer::DownloadStrategy::/,'')
      name.gsub(/Strategy/,'').downcase
    end
  end

end
  