get '/' do
  @urls = Url.last(3).reverse

  erb :"static/index" 
end  

post '/urls' do
  @url = Url.new(long_url: params[:long_url]) 
  if @url.save
    # redirect '/' <-non ajax way
    return @url.to_json
  else
    status 400
    @url.errors.full_messages.join(".")
  #  @error = @url.errors.full_messages    #flash[:msg] 
  #   @urls = Url.last(3).reverse
  #   erb :"static/index"
  # return "DID . NOT. SAVE"
  end
end

get '/:short_url' do
    @url = Url.find_by(short_url: params[:short_url]) #flash[:msg] 
    p @url.click_count 
    @url.click_count += 1
    @url.save
    p @url.errors
    p @url.click_count
    redirect "#{@url.long_url}"
end


