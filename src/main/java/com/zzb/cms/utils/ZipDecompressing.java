package com.zzb.cms.utils;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import org.apache.tools.ant.Project;
import org.apache.tools.ant.taskdefs.Expand;
/** 
 * 程序实现了ZIP解压（decompression） 
 * <p> 
 * 大致功能包括用了多态，递归等JAVA核心技术，可以对单个文件和任意级联文件夹进行压缩和解压。 
 * 需在代码中自定义源输入路径和目标输出路径。 
 * <p> 
 * 在本段代码中，实现的是解压部分。 
 * @author wcj 
 * 
 */  
public class ZipDecompressing {  
      
    public static void main(String[] args) {
    	File file = new File("d:\\aa");
    	if(!file.exists()){
    		file.mkdirs();
    	}
    }  
    public static void unzip(String sourceZip,String destDir) throws Exception{     
        try{     
            Project p = new Project();     
            Expand e = new Expand();     
            e.setProject(p);     
            e.setSrc(new File(sourceZip));     
            e.setOverwrite(false);    
            File file = new File(destDir);
            if(!file.exists()){
        		file.mkdirs();
        	}
            e.setDest(file);     
            /*   
            ant下的zip工具默认压缩编码为UTF-8编码，   
            而winRAR软件压缩是用的windows默认的GBK或者GB2312编码   
            所以解压缩时要制定编码格式   
            */    
            e.setEncoding("gbk");     
            e.execute();     
        }catch(Exception e){     
            throw e;     
        }     
    }  
    
    public static void decZip(String inPath, String outPath){
    	  
        long startTime=System.currentTimeMillis();  
        try {  
            ZipInputStream Zin=new ZipInputStream(new FileInputStream(inPath));//输入源zip路径  
            BufferedInputStream Bin=new BufferedInputStream(Zin);  
            String Parent=outPath; //输出路径（文件夹目录）  
            File Fout=null;  
            ZipEntry entry;  
            try {  
                while((entry = Zin.getNextEntry())!=null){  
                    if(entry.isDirectory()){
                    	continue;
                    }  
                    String entryName = entry.getName();
                    Fout=new File(Parent,entryName);  
                    if(!Fout.exists()){  
                        (new File(Fout.getParent())).mkdirs();  
                    }  
                    FileOutputStream out=new FileOutputStream(Fout);  
                    BufferedOutputStream Bout=new BufferedOutputStream(out);  
                    int b;  
                    while((b=Bin.read())!=-1){  
                        Bout.write(b);  
                    }  
                    Bout.close();  
                    out.close();  
                    System.out.println(Fout+"解压成功");      
                }  
                Bin.close();  
                Zin.close();  
            } catch (IOException e) {  
                // TODO Auto-generated catch block  
                e.printStackTrace();  
            }  
        } catch (FileNotFoundException e) {  
            // TODO Auto-generated catch block  
            e.printStackTrace();  
        }  
        long endTime=System.currentTimeMillis();  
        System.out.println("耗费时间： "+(endTime-startTime)+" ms");  
    }
  
}  