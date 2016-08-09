package dao;

// Copyright 2012 Voltage Security, Inc.

//package com.voltage.report.manager;

import java.util.HashMap;
import java.util.Map;


public enum Severity 
{
	CRITICAL,HIGH,MEDIUM,LOW,FAILED,WARNING,PASSED,ERROR,INFO;
	
	public static Map<String, Severity> severityMap;
	static
	{
		severityMap = new HashMap<String, Severity>();
		severityMap.put("Critical", Severity.CRITICAL);
		severityMap.put("High", Severity.HIGH);
		severityMap.put("Medium", Severity.MEDIUM);
		severityMap.put("Low", Severity.LOW);
		severityMap.put("1", Severity.LOW);
		severityMap.put("2", Severity.MEDIUM);
		severityMap.put("3", Severity.MEDIUM);
		severityMap.put("4", Severity.HIGH);
		severityMap.put("5", Severity.HIGH);
		severityMap.put("None", Severity.LOW);
		
		//Compliance results 
		severityMap.put("FAILED", Severity.FAILED);
		severityMap.put("WARNING", Severity.WARNING);
		severityMap.put("PASSED", Severity.PASSED);
	}
}
