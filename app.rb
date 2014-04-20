require 'sinatra'
require 'sinatra/activerecord'

set :database, "sqlite3:///schools.db"

get "/student" do
	@schools = School.all
	@awards = Award.all
	erb :"/home"
end

get "/student/schools" do
	@example_schools = School.example_schools
	@schools = School.all
	erb :"/schools/index"
end

get "/student/schools/new" do
	@example_schools = School.example_schools
	@new_school = School.new
	erb :"/schools/new"
end

get "/student/schools/:id" do
	@example_schools = School.example_schools
	@school = School.find(params[:id])
	erb :"/schools/show"
end

put "/schools/:id" do # needs to match form action. think of action as the address to send information
	@school = School.find(params[:id])
	if @school.update_attributes(params[:school]) # giant params pool that is being sent. this corresponds to first part of name in form inputs name.
		redirect "/student/schools" # shows information
	else
		redirect "/student/schools/Error"
	end
end

get "/student/schools/error" do
	redirect "/student/Error"
end

get "/student/schools/Error" do
	@example_schools = School.example_schools
	@schools = School.schools
	erb :"/schools/error"
end

# get "/student/schools/edit" do
# 	@schools = School.schools
# 	erb :"/student/schools/edit"
# end

get "/student/schools/:id/edit" do
	@example_schools = School.example_schools
	@school = School.find(params[:id])
	erb :"/schools/edit"
end

delete "/schools/:id" do # member although "/student/schools/:id" works too
	@school = School.find(params[:id])
	if @school.delete
		redirect "/student/schools"
	else
		redirect "/student/schools/:id"
	end
end

post "/schools" do # posting to resource as a whole - applicable to post. put and delete is to a member. get can be to both (index (resource), show (member)). 
	@new_school = School.new(params[:schools])
	if @new_school.save
		redirect "/student/schools"
	else
		redirect "/student/schools/Error"
	end
	# @new_school.save
  # redirect "/student/schools"
end

get "/student/awards" do
	@example_awards = Award.example_awards
	@awards = Award.all
	erb :"/awards/index"
end

get "/student/awards/new" do
	@example_awards = Award.example_awards
	@new_award = Award.new
	erb :"/awards/new"
end

get "/student/awards/:id" do
	@example_awards = Award.example_awards
	@award = Award.find(params[:id])
	erb :"/awards/show"
end

put "/awards/:id" do
	@award = Award.find(params[:id])
	if @award.update_attributes(params[:award])
		redirect "/student/awards"
	else
		redirect "/student/awards/Error"
	end
end

get "/student/awards/error" do
	redirect "/student/Error"
end

get "/student/awards/Error" do
	@example_awards = Award.example_awards
	@awards = Award.awards
	erb :"/awards/error"
end

get "/student/awards/:id/edit" do
	@example_awards = Award.example_awards
	@award = Award.find(params[:id])
	erb :"/awards/edit"
end

delete "/awards/:id" do
	@award = Award.find(params[:id])
	if @award.delete
		redirect "/student/awards"
	else
		redirect "/student/awards/:id"
	end
end

post "/awards" do
	@new_award = Award.new(params[:awards])
	if @new_award.save
		redirect "/student/awards"
	else
		redirect "/student/awards/Error"
	end
end

class School < ActiveRecord::Base # all other info not necessary because of database
	@@example_schools = "High School: Phillips Academy High School 2002-05-15"

	def self.example_schools
		@@example_schools
	end

	# def self.add_to_schools(school) # post adds entries automatically to database
	# 	if school == ""
	# 		return false
	# 	elsif school == " "
	# 		return false
	# 	else
	# 		@@schools.push(school)
	# 	end
	# end

end

class Award < ActiveRecord::Base 
	@@example_awards = "Most Likely To Succeed Award by Dunwoody High School Senior Class - Voted by senior class for having the greatest potential for success 2004-03-27"

	def self.example_awards
		@@example_awards
	end

	# def self.add_to_awards(award)
	# 	if award == ""
	# 		return false
	# 	elsif award == " "
	# 		return false
	# 	else
	# 		@@awards.push(award)
	# 	end
	# end
end

