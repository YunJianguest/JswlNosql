package com.lsp.pub.util;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.security.SecureRandom;
import java.util.Random;
/**
 * 工具
 * @author lsp 
 *   
 */
public class UUIDGenerator {
	
	private static byte serverIP[] = null;
	private static SecureRandom secureRand;

	static {
		
		System.out.println("static");
		
		secureRand = new SecureRandom();
		
		try {
			
			serverIP = InetAddress.getLocalHost().getAddress();
			
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}

	}

	public UUIDGenerator() {
		
	}

	public final String getNextValue(String TBName) {
		
		String hexServerIP = hexFormat(getInt(serverIP), 8);
		
		String hexTBName = hexFormat(System.identityHashCode(TBName), 8);
		
		long timeNow = System.currentTimeMillis();
		int timeLow = (int) timeNow & -1;
		
		String hexTime = hexFormat(timeLow, 8);
		
		int rand = secureRand.nextInt();
		
		String hexRand = hexFormat(rand, 8);
		
		//
		
		StringBuffer guid = new StringBuffer(32);

		guid.append(hexTime);
		guid.append(hexServerIP);
		guid.append(hexRand);
		guid.append(hexTBName);
		
		return guid.toString();
		
	}

	public final String getNextValue() {
		
		String hexServerIP = hexFormat(getInt(serverIP), 8);
		
		String hexThis = hexFormat(System.identityHashCode(this), 8);
		
		long timeNow = System.currentTimeMillis();
		int timeLow = (int) timeNow & -1;
		
		String hexTime = hexFormat(timeLow, 8);
		
		int rand = secureRand.nextInt();
		
		String hexRand = hexFormat(rand, 8);
		
		//
		
		StringBuffer guid = new StringBuffer(32);

		guid.append(hexTime);
		guid.append(hexServerIP);
		guid.append(hexRand);
		guid.append(hexThis);
		
		return guid.toString();
	}
	
	/*
	 * 
	 */

	private int getInt(byte bytes[]) {
		
		int i = 0;
		int j = 24;
		
		for (int k = 0; j >= 0; k++) {
			
			int l = bytes[k] & 0xff;
			
			i += l << j;
			
			j -= 8;
			
		}
		
		return i;
		
	}

	private String hexFormat(int i, int j) {
		
		String s = Integer.toHexString(i);
		
		return padHex(s, j) + s;
		
	}

	private String padHex(String s, int i) {
		
		StringBuffer tmpBuffer = new StringBuffer();
		
		if (s.length() < i) {
			
			for (int j = 0; j < i - s.length(); j++){
			
				tmpBuffer.append('0');
				
			}

		}
		
		return tmpBuffer.toString();
		
	}
	
}
