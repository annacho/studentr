require 'sinatra'
require 'sinatra/activerecord'

set :database, "sqlite3:///schools.db"
set :database, "sqlite3:///awards.db"

get "/student" do
	@schools = School.all
	@awards = Award.all
	erb :"/home"
end

get "/student/schools" do
	@example_schools = School.schools
	@schools = School.all
	erb :"/schools/index"
end

get "/student/schools/new" do
	@new_student_schools = School.new
	erb :"/schools/new"
end

get "/student/schools/:id" do
	@school = School.find(params[:id])
	erb :"/schools/show"
end

put "/student/schools/:id" do
	@school = School.find(params[:id])
	if @student_school.update_attributes(params[:school])
		redirect "/schools/#{@school.id}"
	else
		redirect "/schools/Error"
	end
end

get "/student/schools/error" do
	redirect "/Error"
end

get "/student/schools/Error" do
	@schools = School.schools
	erb :"/schools/error"
end

get "/student/schools/:id/edit" do
	@schools = School.find(params[:id])
	erb :"/schools/edit"
end

delete "student/schools/:id" do
	school = School.find(params[:id])
	if school.delete
		redirect "/schools"
	else
		redirect "/schools/:id"
	end
end

post "student/schools" do
	new_school = School.new
	new_school[:level] = params[:level]
	new_school[:name] = params[:name]
	new_school[:date] = params[:date]
	if new_school.save
		redirect "/schools"
	else
		redirect "/schools/Error"
	end
end

get "/student/awards" do
	@example_awards = Award.awards
	@awards = Award.all
	erb :"/awards/index"
end

get "student/awards/new" do
	@new_awards = Award.new
	erb :"/awards/new"
end

get "student/awards/:id" do
	@award = Award.find(params[:id])
	erb :"/awards/show"
end

put "student/awards/:id" do
	@award = Award.find(params[:id])
	if @award.update_attributes(params[:award])
		redirect "/awards/#{@award.id}"
	else
		redirect "/awards/Error"
	end
end

get "student/awards/error" do
	redirect "/Error"
end

get "student/awards/Error" do
	@awards = Award.awards
	erb :"/awards/error"
end

get "student/awards/:id/edit" do
	@awards = Award.find(params[:id])
	erb :"/awards/edit"
end

delete "/student/awards/:id" do
	award = Award.find(params[:id])
	if award.delete
		redirect "/student/awards/"
	else
		redirect "/student/awards/:id"
	end
end

post "student/awards" do
	new_award = Award.new
	new_award[:name] = params[:name]
	new_award[:organization] = params[:organization]
	new_award[:description] = params[:description]
	new_award[:date] = params[:date]
	if new_award.save
		redirect "/awards"
	else
		redirect "/awards/Error"
	end
end

class School < ActiveRecord::Base 
	@@schools = ["Example: Graduated from Vanderlyn Elementary School"]

	def self.schools
		@@schools
	end

	def self.add_to_schools(school)
		if school == ""
			return false
		elsif school == " "
			return false
		else
			@@schools.push(school)
		end
	end

end

class Award < ActiveRecord::Base 
	@@awards = ["Example: Received the Faculty Superlative Award"]

	def self.awards
		@@awards
	end

	def self.add_to_awards(award)
		if award == ""
			return false
		elsif award == " "
			return false
		else
			@@awards.push(award)
		end
	end
end

