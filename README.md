github-api-projects
===================

A repository for my GitHub API projects.

**General requirements:**  
1. Install Ruby
```
sudo apt-get install ruby
```
2. Install Octokit  
```gem install octokit```
3. Add environment variable `GITHUB_API_TOKEN` in your `.bash_profile` or `.bash_rc`  
[See here how to set create a GitHub Access Token](https://help.github.com/articles/creating-an-access-token-for-command-line-use)

## delete_repo_subscriptions.rb

This script will go through all the repos with the given org_name and unsubscribe from them (unwatch). This is useful, for example, when leaving an org, but all the public repos are still watched by default. This will clear up the clutter on the newsfeed/dashboard. In the case where no such repos were found with the given org_name, it will say so.  
**Usage:**
```
./delete_repo_subscriptions.rb org_name
```
