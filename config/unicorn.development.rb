# Ansible managed: /Users/Peter/.Trash/railsbox/ansible/roles/unicorn/templates/unicorn.rb.j2 modified on 2015-03-14 06:15:20 by Peter on Celestia

working_directory '/nwhacks-project'

pid '/nwhacks-project/tmp/unicorn.development.pid'

stderr_path '/nwhacks-project/log/unicorn.err.log'
stdout_path '/nwhacks-project/log/unicorn.log'

listen '/tmp/unicorn.development.sock'

worker_processes 2

timeout 30
