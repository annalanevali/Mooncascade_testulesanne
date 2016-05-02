require 'spec_helper'

feature 'Feedback' do
	# I want able to run tests several times, but I dont have access to database to clear the previous test data. 
	# To work around that problem I create an unique feedback for every test run.
	let(:feedback) { Random.new.rand(1..1000000) }

	def give_feedback
		page.visit('http://kask6iktundubkorras.sayat.me/madismets')
		page.within('.give-feedback') do
			fill_in'write', with: feedback
			page.find('.btn-primary').click
		end
	end

	def log_in
		page.visit('http://kask6iktundubkorras.sayat.me/')
		page.find('.toggle').click
		page.within('.front-form') do 
			fill_in('url', with: 'karinmets')
			fill_in('password', with: 'Test12')
			page.find('.btn-primary').click
		end
	end
	
	context "when logged in" do
	
		before { log_in }

		it 'can give and view feedback' do
			give_feedback
			expect(page.all(".feed-item")[0]).to have_content(feedback)
		end
	end

	context "when not logged in" do
		it 'give feedback' do
			give_feedback
			expect(page.find(".wrap-words")).to have_content('Sinu arvamus on Madis Mets jaoks salvestatud')
			expect(page.find("#signup_right")).to have_content('Registreeri 20 sekundiga')
		end
	end
end