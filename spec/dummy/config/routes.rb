Rails.application.routes.draw do

  if Rails.env.development?
    mount MrVideo::Engine => '/mr_video'
  end
  
end