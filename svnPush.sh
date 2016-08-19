#!/bin/bash
svn delete -m "deleting old file" https://svn.persistent.co.in/svn/DevOps_Compt/Hemant_Chaudhari/CaseStudyFolder/CaseStudyVulnerability.war --non-interactive --trust-server-cert --username $1 --password $2

svn import -m "Importing latest file" /var/lib/jenkins/workspace/hemdumy/app/CaseStudyVulnerability.war https://svn.persistent.co.in/svn/DevOps_Compt/Hemant_Chaudhari/CaseStudyFolder/CaseStudyVulnerability.war --non-interactive --trust-server-cert --username $1 --password $2
