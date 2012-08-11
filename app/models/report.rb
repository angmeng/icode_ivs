class Report < Prawn::Document
  
    
    def contact  
      headers = %w[Code Email Mobile Bank Birthday]
      data = []
      count = 0
      Agent.all(:order => "code").each do |a|
        count += 1
        data << [a.screen_name, a.email, a.mobile_number, a.bank_status, a.birthday_status]
      end
      text "Total Contact : #{count.to_s}"
      table([headers] + data, :header => true, :row_colors => %w[cccccc ffffff]) do |t|
               t.row(0).style :background_color => '000000', :text_color => 'ffffff'
               t.cells.style :borders => []
      end
      move_down 12
      text "End Of Report"
      render
    end
    
    def agent_list(agents, from, to)
      self.font_size = 9
      headers = %w[Agent Bank\ Account Basic\ Commission Overriding\ Commission Misc Total]
      data = []
      total = 0.0
      agents.each do |a|
        total += a.total
        data << [a.code, a.bank_account, ("%.2f" % a.basic_commission), ("%.2f" % a.sub_commission), ("%.2f" % a.misc_amount), ("%.2f" % a.total)]
      end
      data << ["", "", "", "", "", "Grand Total : #{("%.2f" % total)}"]
      text "List of agents for printing commission " + from.to_s + " - " + to.to_s
      table([headers] + data, :header => true, :row_colors => %w[cccccc ffffff]) do |t|
               t.row(0).style :background_color => '000000', :text_color => 'ffffff'
               t.cells.style :borders => []
               t.columns(2..6).align = :right
      end
      move_down 12
      text "End Of Report"
      render
      
    end
end
