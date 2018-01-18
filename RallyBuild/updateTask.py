import sys, os

from pyral import Rally, rallyWorkset

options = [opt for opt in sys.argv[1:] if opt.startswith('--')]
server, user, password, apikey, workspace, project = rallyWorkset(options)
rally = Rally('rally1.rallydev.com', apikey="_t12c4rseRPy2LJzzdfyEZKNDAyJuIUS9lfzIoLCuxRs", workspace = 'Workspace 1', project='Sample Project', server_ping=False
#rally = Rally(server, user, password, workspace=workspace, project=project)
rally.enableLogging('rally.simple-use.log')

args = sys.argv

proj = rally.getProject()

taskID = sys.argv[1]
notes = sys.argv[2] + '   ;build-url: ' + sys.argv[3]

task_data = {   "FormattedID" : taskID,
				"State" : 'Completed',
                "Notes"       : notes
               }
try:
	#response = rally.get('Task', fetch="Notes,Description", query='FormattedID = '+taskID)
	#task_data['Notes'] = response.next().Notes+ '\n' + task_data['Notes']
	task = rally.update('Task', task_data)
except Exception as details:
    sys.stderr.write('ERROR: %s \n' % details)
    sys.exit(1)

print("Defect %s updated" % task.FormattedID)
