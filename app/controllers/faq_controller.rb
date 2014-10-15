class FaqController < ApplicationController
  def faq

  @what = Faq.new("What is gCamp?","gCamp is an awesome tool that is about to change your life. gCamp is your one stop shop to organize all your tasks and documents. You'll also be able to track comments that you and others make. gCamp may eventually replace all need for paper and pens in the entire world. Well, maybe not, but it's goint to be pretty cool.")

  @how = Faq.new("How do I join gCamp?","Right now, gCamp is still in production. So, there is not a sign up page opent to the public, yet! Your best option is to become super best friends with a gCamp developer. Tehy can be found haning around gSchool during the day and hitting the hottest clubs at night")

  @when = Faq.new("When will gCamp be finished?","gCam is a work in progress. That being said, it should be fully functional by December 2014. Function, but our developers are going to continue to improve the sight for the foreseeable future. Check in daily for new features and awesome functionality. It's going to blow your mind. Organization is only (well, will only) be a click away. Amazing!")


  @faqs = [
          @what,
          @how,
          @when,
          ]
  render :faq
  end
end
