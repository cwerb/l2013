# -*- encoding : utf-8 -*-
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "HHPM3KuA3Q3G7W5s9qTOLw", "HBUJxOUo7YLlfskUPDJQnJZeFrJCjDLDqhhGVCBJs"
  provider :vkontakte, '3262323', '0ojJkHSZStbSLi7bcHHb', :scope => 'notify'
  provider :facebook, "111888468977293", "5f0eda9970fa9788076a86f1a7f327ca"
end
