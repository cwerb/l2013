# -*- encoding : utf-8 -*-
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "HHPM3KuA3Q3G7W5s9qTOLw", "HBUJxOUo7YLlfskUPDJQnJZeFrJCjDLDqhhGVCBJs"
  provider :instagram, "580641186085420685b99379e5d5925d", "fda6485cd1a44091ac70560dd2d7b8dc"
  provider :facebook, "111888468977293", "5f0eda9970fa9788076a86f1a7f327ca"
end
