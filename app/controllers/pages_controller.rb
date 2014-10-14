class PagesController < ApplicationController
  def homepage
    @images = ['mountain1.jpg','mountain2.jpg','mountain3.jpg']
    @columns = {Tasks:['Grouped by projects and lists, just the way you like\'em'],
                Documents:['Upload','Comment','Revise'],
                Comments:['Comment on task and documents','Get email notifications']
                }
    @quotes = [
              ['Vini Vidi Vici.','Ceasar'],
              ['The point of war is not to die for your country, it is to make the other son of a bitch die for his.','Patton'],
              ['Age wrinkles the body. Quitting wrinkles the soul.','MacArthur']
              ]
    render :homepage
    end
end
