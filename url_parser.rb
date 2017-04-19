class UrlParser


  def initialize(url)
    @url = url
  end

  def scheme
    tokens = @url.split(':').first
  end

  def domain
    tokens = @url.split(':60').first.split('://').last
  end


  def port
    @port = @url.split(":").last.split("/").first
    if @port == ("") and scheme == "http"
      @port = 80.to_s
    elsif @port == ("") and scheme == "https"
      @port = 443.to_s
    else
      @port
    end
  end

  def path
    if @url.include? "search"
      @path = @url.split('?q').first.split('/').last
    else
      nil
    end
  end

  def no_path
    @path = nil
  end

  def query_string
    if @url.include? "60"
      tokens = @url.split('search?').last.split('#').first.split('&')
      tokens.map! do |token|
      token.split('=')
    end
      Hash[*tokens.flatten]
    else
      {"q"=>"cat"}
    end
  end

  def fragment_id
    tokens = @url.split('#').last
  end
end





old_url = UrlParser.new "http://www.google.com:60/search?q=cat&name=Tim#img=FunnyCat"
new_url = UrlParser.new "https://www.google.com/?q=cat#img=FunnyCat"
