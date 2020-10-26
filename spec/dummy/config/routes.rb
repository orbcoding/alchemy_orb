Rails.application.routes.draw do
  mount Alchemy::Engine => '/'

  mount AlchemyOrb::Engine => "/alchemy_orb"
end
