package com.zzb.core.utils;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.RenderingHints;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import javax.imageio.ImageIO;
import javax.swing.ImageIcon;

import org.apache.commons.httpclient.Header;

public class ImageRemarkUtil {

	// 姘村嵃閫忔槑搴�
	private static float alpha = 0.5f;
	// 姘村嵃妯悜浣嶇疆
	private static int positionWidth = 150;
	// 姘村嵃绾靛悜浣嶇疆
	private static int positionHeight = 300;
	// 姘村嵃鏂囧瓧瀛椾綋
	private static Font font = new Font("榛戜綋", Font.BOLD, 36);
	// 姘村嵃鏂囧瓧棰滆壊
	private static Color color = Color.white;

	/**
	 * 
	 * @param alpha
	 *            姘村嵃閫忔槑搴�
	 * @param positionWidth
	 *            姘村嵃妯悜浣嶇疆
	 * @param positionHeight
	 *            姘村嵃绾靛悜浣嶇疆
	 * @param font
	 *            姘村嵃鏂囧瓧瀛椾綋
	 * @param color
	 *            姘村嵃鏂囧瓧棰滆壊
	 */
	public static void setImageMarkOptions(float alpha, int positionWidth, int positionHeight, Font font, Color color) {
		if (alpha != 0.0f)
			ImageRemarkUtil.alpha = alpha;
		if (positionWidth != 0)
			ImageRemarkUtil.positionWidth = positionWidth;
		if (positionHeight != 0)
			ImageRemarkUtil.positionHeight = positionHeight;
		if (font != null)
			ImageRemarkUtil.font = font;
		if (color != null)
			ImageRemarkUtil.color = color;
	}

	public static void setImageMarkOptions(BufferedImage bufferedImage, float alpha, int positionWidth,
			int positionHeight, Font font, Color color, String str) {
		if (alpha != 0.0f)
			ImageRemarkUtil.alpha = alpha;
		if (positionWidth != 0)
			ImageRemarkUtil.positionWidth = positionWidth;
		if (positionHeight != 0)
			ImageRemarkUtil.positionHeight = positionHeight;
		if (font != null)
			ImageRemarkUtil.font = font;
		if (color != null)
			ImageRemarkUtil.color = color;
		int height = bufferedImage.getHeight();
		int width = bufferedImage.getWidth();
		int fontSize = 12;
		if (width > 1000) {
			fontSize = 84;
		} else if (width > 800 && width <= 1000) {
			fontSize = 72;
		} else if (width > 600 && width <= 800) {
			fontSize = 60;
		} else if (width > 400 && width <= 600) {
			fontSize = 48;
		} else if (width > 200 && width <= 400) {
			fontSize = 36;
		} else if (width > 100 && width <= 200) {
			fontSize = 24;
		} else if (width > 0 && width <= 100) {
			fontSize = 12;
		}
		positionHeight = height - fontSize - 10;
		positionWidth = width - (fontSize * str.length() + 20);
		font = new Font("瀹嬩綋", Font.BOLD, fontSize);
	}

	/**
	 * 缁欏浘鐗囨坊鍔犳按鍗板浘鐗�
	 * 
	 * @param iconPath
	 *            姘村嵃鍥剧墖璺緞
	 * @param srcImgPath
	 *            婧愬浘鐗囪矾寰�
	 * @param targerPath
	 *            鐩爣鍥剧墖璺緞
	 */
	public static void markImageByIcon(String iconPath, String srcImgPath, String targerPath) {
		markImageByIcon(iconPath, srcImgPath, targerPath, null);
	}

	/**
	 * 缁欏浘鐗囨坊鍔犳按鍗板浘鐗囥�佸彲璁剧疆姘村嵃鍥剧墖鏃嬭浆瑙掑害
	 * 
	 * @param iconPath
	 *            姘村嵃鍥剧墖璺緞
	 * @param srcImgPath
	 *            婧愬浘鐗囪矾寰�
	 * @param targerPath
	 *            鐩爣鍥剧墖璺緞
	 * @param degree
	 *            姘村嵃鍥剧墖鏃嬭浆瑙掑害
	 */
	public static void markImageByIcon(String iconPath, String srcImgPath, String targerPath, Integer degree) {
		OutputStream os = null;
		try {

			Image srcImg = ImageIO.read(new File(srcImgPath));

			BufferedImage buffImg = new BufferedImage(srcImg.getWidth(null), srcImg.getHeight(null),
					BufferedImage.TYPE_INT_RGB);

			// 1銆佸緱鍒扮敾绗斿璞�
			Graphics2D g = buffImg.createGraphics();

			// 2銆佽缃绾挎鐨勯敮榻跨姸杈圭紭澶勭悊
			g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);

			g.drawImage(srcImg.getScaledInstance(srcImg.getWidth(null), srcImg.getHeight(null), Image.SCALE_SMOOTH), 0,
					0, null);
			// 3銆佽缃按鍗版棆杞�
			if (null != degree) {
				g.rotate(Math.toRadians(degree), (double) buffImg.getWidth() / 2, (double) buffImg.getHeight() / 2);
			}

			// 4銆佹按鍗板浘鐗囩殑璺緞 姘村嵃鍥剧墖涓�鑸负gif鎴栬�卲ng鐨勶紝杩欐牱鍙缃�忔槑搴�
			ImageIcon imgIcon = new ImageIcon(iconPath);

			// 5銆佸緱鍒癐mage瀵硅薄銆�
			Image img = imgIcon.getImage();

			g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, alpha));

			// 6銆佹按鍗板浘鐗囩殑浣嶇疆
			g.drawImage(img, positionWidth, positionHeight, null);
			g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_OVER));
			// 7銆侀噴鏀捐祫婧�
			g.dispose();

			// 8銆佺敓鎴愬浘鐗�
			os = new FileOutputStream(targerPath);
			ImageIO.write(buffImg, "JPG", os);

			System.out.println("鍥剧墖瀹屾垚娣诲姞姘村嵃鍥剧墖");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (null != os)
					os.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 缁欏浘鐗囨坊鍔犳按鍗版枃瀛�
	 * 
	 * @param logoText
	 *            姘村嵃鏂囧瓧
	 * @param srcImgPath
	 *            婧愬浘鐗囪矾寰�
	 * @param targerPath
	 *            鐩爣鍥剧墖璺緞
	 */
	public static void markImageByText(BufferedImage bufferedImage, String logoText, String srcImgPath,
			String targerPath) {
		markImageByText(bufferedImage, logoText, srcImgPath, targerPath, 0);
	}

	/**
	 * 缁欏浘鐗囨坊鍔犳按鍗版枃瀛椼�佸彲璁剧疆姘村嵃鏂囧瓧鐨勬棆杞搴�
	 * 
	 * @param logoText
	 * @param srcImgPath
	 * @param targerPath
	 * @param degree
	 */
	public static void markImageByText(BufferedImage bufferedImage, String logoText, String srcImgPath,
			String targerPath, Integer degree) {

		InputStream is = null;
		OutputStream os = null;
		try {
			// 1銆佹簮鍥剧墖
			Image srcImg = ImageIO.read(new File(srcImgPath));
			BufferedImage buffImg = new BufferedImage(srcImg.getWidth(null), srcImg.getHeight(null),
					BufferedImage.TYPE_INT_RGB);

			// 2銆佸緱鍒扮敾绗斿璞�
			Graphics2D g = buffImg.createGraphics();
			// 3銆佽缃绾挎鐨勯敮榻跨姸杈圭紭澶勭悊
			g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
			g.drawImage(srcImg.getScaledInstance(srcImg.getWidth(null), srcImg.getHeight(null), Image.SCALE_SMOOTH), 0,
					0, null);
			// 4銆佽缃按鍗版棆杞�
			if (null != degree) {
				g.rotate(Math.toRadians(degree), (double) buffImg.getWidth() / 2, (double) buffImg.getHeight() / 2);
			}
			// 5銆佽缃按鍗版枃瀛楅鑹�
			g.setColor(color);
			// 6銆佽缃按鍗版枃瀛桭ont
			g.setFont(font);
			// 7銆佽缃按鍗版枃瀛楅�忔槑搴�
			g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, alpha));
			int height = bufferedImage.getHeight();
			int width = bufferedImage.getWidth();
			int fontSize = 12;
			if (width > 1000) {
				fontSize = 84;
				//fontSize = 36;
			} else if (width > 800 && width <= 1000) {
				fontSize = 72;
				//fontSize = 36;
			} else if (width > 600 && width <= 800) {
				fontSize = 60;
				//fontSize = 36;
			} else if (width > 400 && width <= 600) {
				fontSize = 48;
				//fontSize = 36;
			} else if (width > 200 && width <= 400) {
				fontSize = 36;
			} else if (width > 100 && width <= 200) {
				fontSize = 24;
			} else if (width > 0 && width <= 100) {
				fontSize = 12;
			}
			FontMetrics fm = g.getFontMetrics();
			double allWidth = 0;
			double allHeight = 0;
			for (int i = 0; i < logoText.length(); i++) {
				Rectangle2D rc = fm.getStringBounds(String.valueOf(logoText.charAt(i)), g);
				// 褰撳墠瀛楃涓茬殑瀹藉害
				double cwidth = rc.getWidth();
				// 瀹藉害绱姞
				allWidth = allWidth + cwidth;
				allHeight = rc.getHeight();
			}
			//positionHeight = height - (int) allHeight;
			//positionWidth = width - (int) allWidth - 10;
			//positionHeight = (height - (int) allHeight)>0?(height - (int) allHeight)/2:0;
			//positionWidth = (width - (int) allWidth)>0?(width - (int) allWidth)/2:0;
			positionHeight = (height - (int) allHeight-20)>0?(height - (int) allHeight-20):0;
			positionWidth = (width - (int) allWidth-20)>0?(width - (int) allWidth-20):0;
			font = new Font("榛戜綋", Font.BOLD, fontSize);
			// 8銆佺涓�鍙傛暟->璁剧疆鐨勫唴瀹癸紝鍚庨潰涓や釜鍙傛暟->鏂囧瓧鍦ㄥ浘鐗囦笂鐨勫潗鏍囦綅缃�(x,y)
			g.drawString(logoText, positionWidth, positionHeight);
			// 9銆侀噴鏀捐祫婧�
			g.dispose();
			// 10銆佺敓鎴愬浘鐗�
			os = new FileOutputStream(targerPath);
			String ext = srcImgPath.substring(srcImgPath.lastIndexOf(".")+1);
			ImageIO.write(buffImg, ext, os);

			System.out.println("鍥剧墖瀹屾垚娣诲姞姘村嵃鏂囧瓧");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (null != is)
					is.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				if (null != os)
					os.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/*
	 * public static void main(String[] args) { String srcImgPath = "d:/1.jpg";
	 * String logoText = "澶� 鍗� 鏃� 鏁�"; String iconPath = "d:/2.jpg";
	 * 
	 * String targerTextPath = "d:/qie_text.jpg"; String targerTextPath2 =
	 * "d:/qie_text_rotate.jpg";
	 * 
	 * String targerIconPath = "d:/qie_icon.jpg"; String targerIconPath2 =
	 * "d:/qie_icon_rotate.jpg";
	 * 
	 * System.out.println("缁欏浘鐗囨坊鍔犳按鍗版枃瀛楀紑濮�..."); // 缁欏浘鐗囨坊鍔犳按鍗版枃瀛�
	 * markImageByText(logoText, srcImgPath, targerTextPath); //
	 * 缁欏浘鐗囨坊鍔犳按鍗版枃瀛�,姘村嵃鏂囧瓧鏃嬭浆-45 markImageByText(logoText, srcImgPath,
	 * targerTextPath2, -45); System.out.println("缁欏浘鐗囨坊鍔犳按鍗版枃瀛楃粨鏉�...");
	 * 
	 * System.out.println("缁欏浘鐗囨坊鍔犳按鍗板浘鐗囧紑濮�..."); setImageMarkOptions(0.3f, 1, 1,
	 * null, null); // 缁欏浘鐗囨坊鍔犳按鍗板浘鐗� markImageByIcon(iconPath, srcImgPath,
	 * targerIconPath); // 缁欏浘鐗囨坊鍔犳按鍗板浘鐗�,姘村嵃鍥剧墖鏃嬭浆-45 markImageByIcon(iconPath,
	 * srcImgPath, targerIconPath2, -45); System.out.println("缁欏浘鐗囨坊鍔犳按鍗板浘鐗囩粨鏉�...");
	 * 
	 * }
	 */

}
