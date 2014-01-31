BulletProof::Application.routes.draw do 
  

  api_version(:module => "V1", :path => {:value => "v1"}) do     
    
    resources :videos

  end



end