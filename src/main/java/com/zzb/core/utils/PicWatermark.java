package com.zzb.core.utils;

import java.awt.Color;
import java.awt.Font;
import java.awt.FontFormatException;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URL;

import javax.imageio.ImageIO;

public class PicWatermark {

	public PicWatermark(String path) {
		/*File file = new java.io.File(path + "/html/font/FZQTJW.TTF");
		FileInputStream fi = null;
		try {
			fi = new FileInputStream(file);
		} catch (FileNotFoundException e) {
			// 寮傚父澶勭悊
		}
		java.io.BufferedInputStream fb = new java.io.BufferedInputStream(fi);*/
		try {
			/*font = Font.createFont(Font.TRUETYPE_FONT, fb);*/
			font=new Font("瀹嬩綋", Font.BOLD, 30);
		} catch (Exception exception) {
			// 寮傚父澶勭悊
		}
		/*font = font.deriveFont(Font.PLAIN, 40);*/
	}

	// 鍙栧緱鏍圭洰褰曡矾寰�
	private Font font = null;

	private Graphics2D g = null;

	private int fontsize = 0;

	private int x = 0;

	private int y = 0;

	/**
	 * 瀵煎叆鏈湴鍥剧墖鍒扮紦鍐插尯
	 */
	public BufferedImage loadImageLocal(String imgName) {
		try {
			return ImageIO.read(new File(imgName));
		} catch (IOException e) {
			try {
				return ImageIO.read(new File(imgName));
			} catch (IOException e1) {
				return null;
			}
		}
	}

	/**
	 * 瀵煎叆缃戠粶鍥剧墖鍒扮紦鍐插尯
	 */
	public BufferedImage loadImageUrl(String imgName) {
		try {
			URL url = new URL(imgName);
			return ImageIO.read(url);
		} catch (IOException e) {
			System.out.println(e.getMessage());
		}
		return null;
	}

	/**
	 * 鐢熸垚鏂板浘鐗囧埌鏈湴
	 */
	public void writeImageLocal(String newImage, BufferedImage img,String extName) {
		if (newImage != null && img != null) {
			try {
				File outputfile = new File(newImage);
				ImageIO.write(img, extName, outputfile);
			} catch (IOException e) {
				File outputfile = new File(newImage);
				try {
					ImageIO.write(img, extName, outputfile);
				} catch (IOException e1) {
					// 寮傚父澶勭悊
					System.out.println(e1.getMessage());
				}
			}
		}
	}

	/**
	 * 璁惧畾鏂囧瓧鐨勫瓧浣撶瓑
	 */
	public void setFont(String fontStyle, int fontSize) {
		this.fontsize = fontSize;
		this.font = new Font(fontStyle, Font.PLAIN, fontSize);
	}

	/**
	 * 淇敼鍥剧墖,杩斿洖淇敼鍚庣殑鍥剧墖缂撳啿鍖猴紙鍙緭鍑轰竴琛屾枃鏈級
	 */
	public BufferedImage modifyImage(BufferedImage img, Object content, int x, int y) {

		try {
			int w = img.getWidth();
			int h = img.getHeight();
			g = img.createGraphics();
			// g.setBackground(Color.WHITE);
			g.setColor(new Color(203, 93, 90));// 璁剧疆瀛椾綋棰滆壊
			if (this.font != null)
				g.setFont(this.font);
			// 楠岃瘉杈撳嚭浣嶇疆鐨勭旱鍧愭爣鍜屾í鍧愭爣
			if (x >= h || y >= w) {
				this.x = h - this.fontsize + 2;
				this.y = w;
			} else {
				this.x = x;
				this.y = y;
			}
			if (content != null) {
				g.drawString(content.toString(), this.x, this.y);
			}
			g.dispose();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return img;
	}

	/**
	 * 淇敼鍥剧墖,杩斿洖淇敼鍚庣殑鍥剧墖缂撳啿鍖猴紙杈撳嚭澶氫釜鏂囨湰娈碉級 xory锛歵rue琛ㄧず灏嗗唴瀹瑰湪涓�琛屼腑杈撳嚭锛沠alse琛ㄧず灏嗗唴瀹瑰琛岃緭鍑�
	 */
	public BufferedImage modifyImage(BufferedImage img, Object[] contentArr, int x, int y, boolean xory) {
		try {
			int w = img.getWidth();
			int h = img.getHeight();
			g = img.createGraphics();
			g.setBackground(Color.WHITE);
			g.setColor(Color.RED);
			if (this.font != null)
				g.setFont(this.font);
			// 楠岃瘉杈撳嚭浣嶇疆鐨勭旱鍧愭爣鍜屾í鍧愭爣
			if (x >= h || y >= w) {
				this.x = h - this.fontsize + 2;
				this.y = w;
			} else {
				this.x = x;
				this.y = y;
			}
			if (contentArr != null) {
				int arrlen = contentArr.length;
				if (xory) {
					for (int i = 0; i < arrlen; i++) {
						g.drawString(contentArr[i].toString(), this.x, this.y);
						this.x += contentArr[i].toString().length() * this.fontsize / 2 + 5;// 閲嶆柊璁＄畻鏂囨湰杈撳嚭浣嶇疆
					}
				} else {
					for (int i = 0; i < arrlen; i++) {
						g.drawString(contentArr[i].toString(), this.x, this.y);
						this.y += this.fontsize + 2;// 閲嶆柊璁＄畻鏂囨湰杈撳嚭浣嶇疆
					}
				}
			}
			g.dispose();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return img;
	}

	/**
	 * 淇敼鍥剧墖,杩斿洖淇敼鍚庣殑鍥剧墖缂撳啿鍖猴紙鍙緭鍑轰竴琛屾枃鏈級
	 * 
	 * 鏃堕棿:2007-10-8
	 * 
	 * @param img
	 * @return
	 */
	public BufferedImage modifyImageYe(BufferedImage img) {

		try {
			int w = img.getWidth();
			int h = img.getHeight();
			g = img.createGraphics();
			g.setBackground(Color.WHITE);
			g.setColor(Color.blue);// 璁剧疆瀛椾綋棰滆壊
			if (this.font != null)
				g.setFont(this.font);
			g.drawString("reyo.cn", w - 85, h - 5);
			g.dispose();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return img;
	}

	public BufferedImage modifyImagetogeter(BufferedImage b, BufferedImage d, int x, int y, int width, int height) {

		try {
			int w = b.getWidth();
			if (width != 0) {
				w = width;
			}
			int h = b.getHeight();
			if (height != 0) {
				h = height;
			}
			g = d.createGraphics();
			g.drawImage(b, x, y, w, h, null);
			g.dispose();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return d;
	}
}
