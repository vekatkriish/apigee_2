import sys, os

from pyral import Rally, rallyWorkset

options = [opt for opt in sys.argv[1:] if opt.startswith('--')]
server, user, password, apikey, workspace, project = rallyWorkset(options)
rally = Rally('rally1.rallydev.com', apikey="_t12c4rseRPy2LJzzdfyEZKNDAyJuIUS9lfzIoLCuxRs" , workspace = 'Workspace 1', project='Sample Project', server_ping=True)
#rally = Rally(server, user, password, workspace=workspace, project=project)
rally.enableLogging('rally.simple-use.log')

os.environ['runame']='venkatkriish'
os.environ['rtoken']='f1d8616e8d8fcd48ecf5f721361b4a21'

args = sys.argv
usID = sys.argv[1]
pipelineUrl = 'http://localhost:8080/job/Apigee_proj/job/RallyBuild/build '

#response = rally.get('UserStory', fetch=True, query='State != "Closed"')

response = rally.get('UserStory', fetch=True, query='FormattedID = '+usID)

if not response.errors:
    for story in response:
        for task in story.Tasks:
        	if task.State == 'Defined':
        		taskType = task.Description.split(";")[0].split(":")[0]
        		if (taskType == 'merge'):
        			branch = task.Description.split(";")[1].split(":")[1]
        			print task.oid, task.Name, task.Notes, branch, task.State, task.FormattedID
        			initstr = "./startPipeline.sh "+'pipelineUrl'+os.environ['runame']+':'+os.environ['rtoken']+" "+task.Notes+" "+task.FormattedID+" "+branch+" "+"NA"
        			print initstr
        			os.system(initstr)
        		elif (taskType == 'createBranch'):
        			fromBranch = task.Description.split(";")[1].split(":")[1]
        			toBranch = task.Description.split(";")[2].split(":")[1]
        			print task.oid, task.Name, task.Notes, task.State, task.FormattedID, fromBranch, toBranch
        			initstr = "./startPipeline.sh "+pipelineUrl+ ' ' + os.environ['runame']+':'+os.environ['rtoken']+" "+task.Notes+" "+task.FormattedID+" "+fromBranch+" "+toBranch
        			print initstr
        			os.system(initstr)
