# -*- encoding : utf-8 -*-
module FrontendHelper
  def time_remaining
    diff = (Time.now - @tag.start_time).round
    if diff < 60
      raw %(<b>#{diff}</b> #{Russian.p diff, "секунда", "секунды", "секунд"})
    elsif diff < 3600
      raw %(<b>#{(diff.to_f/60).round}</b> #{Russian.p diff/60, "минута", "минуты", "минут"})
    elsif diff < 86400
      raw %(<b>#{(diff.to_f/3600).round}</b> #{Russian.p (diff.to_f/3600).round, "час", "часа", "часов"})
    else
      raw %(<b>#{(diff.to_f/86400).round}</b> #{Russian.p (diff.to_f/86400).round, "день", "дня", "дней"})
    end
  end
end
