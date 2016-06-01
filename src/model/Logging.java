package model;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class Logging {
	public static void appendLogTS(String value) {
		appendLog("TS " + value + "\n");
	}
	
	public static void appendLogTJ(String value) {
		appendLog("TJ " + value + " ");
	}
	
	public static void appendLog(String value) {
		try {

	    	File file = new File("/Users/Max/Development/cs122b/FabFlix/logFile.txt");

	    	if(!file.exists()){
	    	   file.createNewFile();
	    	}

	    	//Here true is to append the content to file
	    	FileWriter fw = new FileWriter(file,true);
	    	//BufferedWriter writer give better performance
	    	BufferedWriter bw = new BufferedWriter(fw);
	    	bw.write(value);
	    	//Closing BufferedWriter Stream
	    	bw.close();

//	    	System.out.println("Data successfully appended at the end of file " + System.getProperty("user.dir"));
	    } catch(IOException ioe){
	         System.out.println("Exception occurred:");
	    	 ioe.printStackTrace();
	    }
	}
}
