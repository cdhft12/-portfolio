package java142.todak.common;

import java.io.File;

public class FileDelete {
	public boolean deleteFile(String fileName, String path){
		boolean flag=false;
		String dir=path+"/"+fileName;
		File dfile=new File(dir);
		if(dfile.exists()){
			flag=dfile.delete();
		}
		return flag;
	}
}
