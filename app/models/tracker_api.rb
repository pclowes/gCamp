class TrackerAPI
  #state
  def initialize
    @conn = Faraday.new(:url => 'https://www.pivotaltracker.com')
  end

  #behavior
  def get_projects(tracker_token)
    response = @conn.get do |req|
      req.url "/services/v5/projects"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = tracker_token
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_stories(project_id, tracker_token)
    response = @conn.get do |req|
      req.url "/services/v5/projects/#{project_id}/stories"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = tracker_token
    end
    JSON.parse(response.body, symbolize_names: true)
  end

end
