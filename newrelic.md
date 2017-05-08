---
order: 50
---
# New Relic for DSpace

The task involves downloading the New Relic agent and attaching it to Tomcat. Consult the [New Relic Java Agent](https://docs.newrelic.com/docs/agents/java-agent/installation/install-java-agent) insturctions if you run into any issues. 

## Steps

- Download and unzip the New Relic Java agent to `/etc/newrelic`.
- Make `tomcat` user/group the owner (as on dspace-staging) and verify file permissions.
- Open `newrelic.yml`: update the `license_key` (from account settings in New Relic), `app_name` (e.g., dspace_prod), and `log_file_path` (e.g., `/var/log/newrelic`) references.
- Edit `/usr/share/tomcat6/conf/tomcat6.cnf`, and append to JAVA_OPTS variable, the path to the agent JAR (make sure there's only one line for JAVA_OPTS):
```
-javaagent:/usr/share/tomcat6/newrelic/newrelic.jar
```
- Create the log directory `/var/log/newrelic` (to allow the agent to write its log file), and change the owner of `/var/log/newrelic` to user `tomcat`.
- Restart Tomcat
- Confirm by doing `ps -elf  | grep java`. It should mention the javaagent in the output. Tomcat log files (catalina.out) should
also emit messages (of joy) from the agent.

Confirm that the application appears under APM in New Relic. It typically takes a few minutes before the agent starts reporting.



