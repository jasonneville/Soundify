Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post '/users/dog', to: 'users#dog'
      get '/users/me', to: 'users#me'
      resources :users do
        member do
          get :playlists, to: 'users#playlists'
        end
      end

      resources :playlists do
        member do
          put :addSong, to: 'playlists#add_song'
          get :songs, to: 'playlists#get_songs'
        end
      end

      resources :spotify

      get '/callback', to: 'auth#callback'
      get '/spotifyLogin', to: 'auth#spotify_login'
      post '/auth/login', to: 'auth#login'
    end
  end
end
