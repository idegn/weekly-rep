class SaveProcessedConetent
  def call
    WeeklyReport.find_each do |wr|
      processed_content = Qiita::Markdown::Processor.new.call(wr.content)[:output].to_s
      wr.update_attributes(
        processed_content: processed_content
      )
    end
  end
end

SaveProcessedConetent.new.call
