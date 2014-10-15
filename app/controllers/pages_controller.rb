class PagesController < ApplicationController
  def homepage
    @images = ['mountain1.jpg','mountain2.jpg','mountain3.jpg']
    @columns = {Tasks:['Grouped by projects and lists, just the way you like\'em'],
                Documents:['Upload','Comment','Revise'],
                Comments:['Comment on task and documents','Get email notifications']
                }


    patton = Quote.new("Always do more than is required of you.","Patton")

    bonaparte = Quote.new("He who fears being conquered is sure of defeat.","Bonaparte")

    macarthur = Quote.new("Age wrinkles the body. Quitting wrinkles the soul.","MacArthur")

    @quotes = [
              patton,
              bonaparte,
              macarthur
              ]

    render :homepage
    end
end
