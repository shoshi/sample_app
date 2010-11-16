SampleApp::Application.routes.draw do
	match '/contact', :to => 'pages#contact'
	match '/about', :to => 'pages#about'
	match '/help', :to => 'pages#help'
	match '/', :to => 'pages#home'
	
	root :to => 'pages#home'
end