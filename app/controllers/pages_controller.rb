class PagesController < ApplicationController
  def index
    @images = ['mountain1.jpg','mountain2.jpg','mountain3.jpg']
    @columns = {Tasks:['Grouped by projects and lists, just the way you like\'em'],
                Documents:['Upload','Comment','Revise'],
                Comments:['Comment on task and documents','Get email notifications']
                }
    render :homepage
    end
end
