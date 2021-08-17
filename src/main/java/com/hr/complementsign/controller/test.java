package com.hr.complementsign.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class test {

	public static void main(String[] args) throws ParseException {
		Date date = new Date();
		Date dateTime = new Date();
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm:ss");
		String sDate = sdfDate.format(date);
		String sTime = sdfTime.format(dateTime);
		date = sdfDate.parse(sDate);
		dateTime = sdfTime.parse(sTime);
		System.out.println(date);
		System.out.println(dateTime);

	}

}
