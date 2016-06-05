package model;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.EnumSet;

import java.nio.file.attribute.PosixFilePermission;

public class Logging {
	public static void appendLogTS(String value) {
		appendLog("TS " + value + "\n");
	}
	
	public static void appendLogTJ(String value) {
		appendLog("TJ " + value + " ");
	}
	
	public static void appendLog(String value) {
		try {

			
			Files.setPosixFilePermissions(Paths.get(System.getProperty("user.home")), 
				    EnumSet.of(PosixFilePermission.OWNER_READ, PosixFilePermission.OWNER_WRITE, PosixFilePermission.OWNER_EXECUTE, PosixFilePermission.GROUP_READ, PosixFilePermission.GROUP_EXECUTE));
			
//	    	File file = new File(getServletContext().getRealPath("/") + "logFile.txt");

	    	File file = new File(System.getProperty("user.home") + "/logFile.txt");

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
