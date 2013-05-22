class Workspace < ActiveRecord::Base
  attr_accessible :title, :description

  validates :title, :description, :presence => true

  def self.latest
    Workspace.order('updated_at desc').limit(1).first
  end

  def index
    latest = Workspace.latest
    if stale?(:etag => latest, :last_modified => latest.updated_at.utc)
    end
  end

end
