//
//
//  Generated by StarUML(tm) Java Add-In
//
//  @ Project : Untitled
//  @ File Name : LazySingleton.java
//  @ Date : 2012/11/14
//  @ Author : 
//
//

package org.redtroy.study.pattern.singleton;

public class LazySingleton {
	public static LazySingleton instance = null;

	public static LazySingleton newInstance() {
		if (instance == null)
			instance = new LazySingleton();
		return instance;
	}
}
