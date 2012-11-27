Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "HHPM3KuA3Q3G7W5s9qTOLw", "HBUJxOUo7YLlfskUPDJQnJZeFrJCjDLDqhhGVCBJs"
  provider :vkontakte, '3262323', 'AY7hQR0yVAilBqgRezbv', :scope => 'notify'
  provider :instagram, "66f96c768dd64b8887d10ae2feb6d1d6", "1906cbd03e674cca92a4480e7bb64adb"
end