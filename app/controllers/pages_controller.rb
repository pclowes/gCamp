class PagesController < MarketingController
  def homepage
    @images = ['Projects.png','Tasks.png','Comments.png']
    @columns = {Projects:['Upload, Comment, Revise','Pivotal Tracker Integration'],
                Tasks:['Grouped by projects just the way you like\'em'],
                Comments:['Comment on task and projects']
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
