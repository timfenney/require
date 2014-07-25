require 'rubygems'
require 'chunky_png'
require 'redis'
require 'rqrcode_png'
require 'sinatra'

APP = "require"
APP_INST = 1
PORT = 49153
URL = "http://104.131.228.159:#{PORT}"

redis = Redis.new

before do
  puts '[Params]'
  p params
end

get '/' do
  erb :index
end

get '/about' do
  erb :about
end

get '/contact' do
  erb :contact
end

post '/qr_codes' do
  if params[:input_url] and not params[:input_url].empty? and params[:qr_quantity] =~ /\A\d+\z/ and (1..6).include? params[:qr_quantity].to_i

    # create the qr code from the url
    url = params[:input_url]

    num_left = params[:qr_quantity].to_i
    while num_left > 0
      qr = RQRCode::QRCode.new url, size: 10, level: :h
      qr_str = qr.to_img.to_s
      sha = (Digest::SHA1.new << url).to_s
      puts "sha: #{sha}"
      redis.set "#{APP}:#{APP_INST}:#{sha}", qr_str
      url = "#{URL}/qr_codes/#{sha}"
      num_left -= 1
    end

    # render the qr code page.
    puts "redirecting to /qr_codes/#{sha}"
    redirect "/qr_codes/#{sha}"
  end
end

get '/qr_codes/:id' do
  unless :id.nil?
    # fetch the qr PNG from the db, and render the page displaying it
    qr_blob = redis.get "#{APP}:#{APP_INST}:#{params[:id]}"
    @qr_png = ChunkyPNG::Image.from_blob(qr_blob)

    erb :qr_code
  else
    raise Error
  end
end
