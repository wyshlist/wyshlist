

client = AsanaApi::SendTask.new('1/1204496492204507:6be47a9c4b4fee3f78d359d69f4943a9').client
workspaces = client.workspaces.find_all
p projects = client.projects.get_projects(workspace: workspaces.first.gid)