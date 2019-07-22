package com.zzb.core.utils;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.converter.PicturesManager;
import org.apache.poi.hwpf.converter.WordToHtmlConverter;
import org.apache.poi.hwpf.usermodel.PictureType;
import org.apache.poi.xwpf.converter.core.BasicURIResolver;
import org.apache.poi.xwpf.converter.core.FileImageExtractor;
import org.apache.poi.xwpf.converter.xhtml.XHTMLConverter;
import org.apache.poi.xwpf.converter.xhtml.XHTMLOptions;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.w3c.dom.Document;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Utils StringUtils 字符串工具
 * 
 */
public class OfficeUtils  {

	public OfficeUtils(){

	}
	public static String word2007ToHtml(String file) throws Exception {
		String out = "";
		file = file.replaceAll("\\\\","\\//");
		String filepath = file.substring(0,file.lastIndexOf("//"));
		String sourceFileName =file;
		String date = DateUtils.getDate("yyyyMMddHHmmss");
		String targetFileName = filepath + "/" +date + ".html";
		String imagePathStr = filepath+"/image/";
		OutputStreamWriter outputStreamWriter = null;
		try {
			XWPFDocument document = new XWPFDocument(new FileInputStream(sourceFileName));
			XHTMLOptions options = XHTMLOptions.create();
			// 存放图片的文件夹
			options.setExtractor(new FileImageExtractor(new File(imagePathStr)));
			// html中图片的路径
			options.URIResolver(new BasicURIResolver("image"));
			outputStreamWriter = new OutputStreamWriter(new FileOutputStream(targetFileName), "utf-8");
			XHTMLConverter xhtmlConverter = (XHTMLConverter) XHTMLConverter.getInstance();
			xhtmlConverter.convert(document, outputStreamWriter, options);
		} finally {
			if (outputStreamWriter != null) {
				outputStreamWriter.close();
			}
		}
		return date;
	}


	public static String DocxToHtml(String file){
		HWPFDocument wordDocument;
		String outPutFile = "";
		String date = "";
		try {

			file = file.replaceAll("\\\\","\\//");
			String filepath = file.substring(0,file.lastIndexOf("//") );
			String fileAllName =file;
			date = DateUtils.getDate("yyyyMMddHHmmss");
			outPutFile = filepath + "//" + date + ".html";

			//根据输入文件路径与名称读取文件流
			InputStream in=new FileInputStream(fileAllName);
			//把文件流转化为输入wordDom对象
			wordDocument = new HWPFDocument(in);
			//通过反射构建dom创建者工厂
			DocumentBuilderFactory domBuilderFactory=DocumentBuilderFactory.newInstance();
			//生成dom创建者
			DocumentBuilder domBuilder=domBuilderFactory.newDocumentBuilder();
			//生成dom对象
			Document dom=domBuilder.newDocument();
			//生成针对Dom对象的转化器
			WordToHtmlConverter wordToHtmlConverter = new WordToHtmlConverter(dom);
			//转化器重写内部方法
			wordToHtmlConverter.setPicturesManager( new PicturesManager()
			{
				public String savePicture(byte[] content,
										  PictureType pictureType, String suggestedName,
										  float widthInches, float heightInches )
				{
					return suggestedName;
				}
			} );
			//转化器开始转化接收到的dom对象
			wordToHtmlConverter.processDocument(wordDocument);
			//保存文档中的图片
        /*    List<?> pics=wordDocument.getPicturesTable().getAllPictures();
            if(pics!=null){
                for(int i=0;i<pics.size();i++){
                    Picture pic = (Picture)pics.get(i);
                    try {
                        pic.writeImageContent(new FileOutputStream("E:/test/"+ pic.suggestFullFileName()));
                    } catch (FileNotFoundException e) {
                        e.printStackTrace();
                    }
                }
            } */
			//从加载了输入文件中的转换器中提取DOM节点
			Document htmlDocument = wordToHtmlConverter.getDocument();
			//从提取的DOM节点中获得内容
			DOMSource domSource = new DOMSource(htmlDocument);

			//字节码输出流
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			//输出流的源头
			StreamResult streamResult = new StreamResult(out);
			//转化工厂生成序列转化器
			TransformerFactory tf = TransformerFactory.newInstance();
			Transformer serializer = tf.newTransformer();
			//设置序列化内容格式
			serializer.setOutputProperty(OutputKeys.ENCODING, "GB2312");
			serializer.setOutputProperty(OutputKeys.INDENT, "yes");
			serializer.setOutputProperty(OutputKeys.METHOD, "html");

			serializer.transform(domSource, streamResult);
			//生成文件方法
			writeFile(new String(out.toByteArray()), outPutFile);
			out.close();
			return date;
		} catch (FileNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (TransformerConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (TransformerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return date;
	}


	public static void writeFile(String content, String path) {
		FileOutputStream fos = null;
		BufferedWriter bw = null;
		try {
			File file = new File(path);
			fos = new FileOutputStream(file);
			bw = new BufferedWriter(new OutputStreamWriter(fos,"GB2312"));
			bw.write(content);
		} catch (FileNotFoundException fnfe) {
			fnfe.printStackTrace();
		} catch (IOException ioe) {
			ioe.printStackTrace();
		} finally {
			try {
				if (bw != null)
					bw.close();
				if (fos != null)
					fos.close();
			} catch (IOException ie) {
			}
		}
	}

}
