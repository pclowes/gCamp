module ProjectsHelper
  def label_join(story)
    story[:labels].map do |label|
      label[:name]
    end.join(', ')
  end
end
