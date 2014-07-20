#!/usr/bin/ruby

require 'octokit'

# Preqs
org_name = ARGV[0]
if org_name == nil
	puts "ERROR: Must input GitHub org to delete subscriptions from"
	puts "Usage: #{$PROGRAM_NAME} org_name"
	exit
end
org_regex = Regexp.new(/^#{org_name}/)

if ENV['GITHUB_API_TOKEN'] == nil
	puts "ERROR: Must have GITHUB_API_TOKEN variable in the environment"
	puts "Edit your .bash_profile or .bash_rc and add this variable"
	puts "Example: 'export GITHUB_API_TOKEN=xxxxyyyyyzzzz'"
	exit
end

# Connect and log into Github API
client = Octokit::Client.new(:access_token => ENV['GITHUB_API_TOKEN'])
user = client.user
user.login

# Get some basic info
puts "Connected to GitHub as " + "'#{user.name}'"
puts ""

# Remove subscription
Octokit.auto_paginate = true
subscriptions = client.subscriptions
found = false

subscriptions.each do |subscription|
	if subscription[:full_name] =~ org_regex 
		puts "deleting: " + subscription[:full_name]
		result = client.delete_subscription(Octokit::Repository.from_url(subscription[:html_url]))
		puts "deleted?: " + result.to_s
		puts ""
		found = true
	end	
end

if found == false
	puts "Not subscribed to any repos with the given org '#{org_name}'"
end