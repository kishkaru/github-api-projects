#!/usr/bin/ruby

require 'octokit'
require 'yaml'

# Connect and log into Github API
client = Octokit::Client.new(:access_token => ENV['GITHUB_API_TOKEN'])

user = client.user
user.login

# Get some basic info
puts "Welcome, " + user.name
puts ""

# Remove subscription
Octokit.auto_paginate = true
subscriptions = client.subscriptions

racker_regex = Regexp.new(/^rackerlabs/)

subscriptions.each do |subscription|
	if subscription[:full_name] =~ racker_regex 
		puts "deleting: " + subscription[:full_name]
		result = client.delete_subscription(Octokit::Repository.from_url(subscription[:html_url]))
		puts "deleted?: " + result.to_s
		puts ""
	end	
end

