class FaqController < ApplicationController
  def faq

  what = Faq.new("What is gCamp?","gCamp is an awesome tool that is about to change your life. gCamp is your one stop shop to organize all your tasks and documents. You'll also be able to track comments that you and others make. gCamp may eventually replace all need for paper and pens in the entire world. Well, maybe not, but it's goint to be pretty cool.")
  how = Faq.new("How do I join gCamp?","Right now, gCamp is still in production. So, there is not a sign up page opent to the public, yet! Your best option is to become super best friends with a gCamp developer. Tehy can be found haning around gSchool during the day and hitting the hottest clubs at night")
  when1 = Faq.new("When will gCamp be finished?","gCam is a work in progress. That being said, it should be fully functional by December 2014. Function, but our developers are going to continue to improve the sight for the foreseeable future. Check in daily for new features and awesome functionality. It's going to blow your mind. Organization is only (well, will only) be a click away. Amazing!")
  scared = Faq.new("I'm scared, is it goint to be too hard?","This is a funny question we get a lot. It's not going to be ahrd. Your life will be different. That's right, gCamp is going to change your life. You wil wake up and no longer wonder what your tasks for the day are. You will have one place to check the lists of tasks that you have given yourself and the tasks those lists contain. Your documents will no longer be splayed across your bedroom like a child. You will have access to a central palce where those documents will be organized. That'll be gCamp!")
  alternatives = Faq.new("What are the alternatives?","The alternatives are simple. You can live your life in an unorganized mess. Wake up not knowing what to do that day, not knowing where your documents are, and having no idea what comments you've made about those tasks or documents. Or you can check out gCam and organize those documents, tasks, and comments.")

  @faqs = Faq.all
  render :faq
  @faqs.clear
  end
end