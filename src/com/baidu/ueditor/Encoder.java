package com.baidu.ueditor;
/**
 * 资源管理
 * @author lsp 
 *   
 */
public class Encoder {

	public static String toUnicode ( String input ) {
		
		StringBuilder builder = new StringBuilder();
		char[] chars = input.toCharArray();
		
		for ( char ch : chars ) {
			
			if ( ch < 256 ) {
				builder.append( ch );
			} else {
				builder.append( "\\u" +  Integer.toHexString( ch& 0xffff ) );
			}
			
		}
		
		return builder.toString();
		
	}
	
}