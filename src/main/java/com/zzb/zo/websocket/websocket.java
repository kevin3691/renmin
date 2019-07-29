package com.zzb.zo.websocket;

import com.google.gson.Gson;
import com.zzb.base.entity.BaseUser;
import com.zzb.base.service.BaseUserService;
import com.zzb.zo.entity.Chat;
import com.zzb.zo.service.ChatService;
import netscape.javascript.JSObject;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.kohsuke.rngom.parse.host.Base;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.ContextLoader;


import javax.annotation.Resource;
import javax.json.Json;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.concurrent.atomic.AtomicInteger;


// 进行配置  websocket 通过下面的地址链接服务器
@ServerEndpoint(value = "/ws/chat")
public class Websocket {


    private static Integer onlineNum = 0; //当前在线人数，线程必须设计成安全的
    private static CopyOnWriteArraySet<Websocket> arraySet = new CopyOnWriteArraySet<Websocket>(); //存放每一个客户的的WebScoketServer对象，线程安全
    private Session session;
    private int userId;
    //private BaseUserService baseUserService = new BaseUserService();
    private BaseUserService baseUserService = (BaseUserService) ContextLoader.getCurrentWebApplicationContext().getBean("baseUserService");
    public Websocket() {
        System.out.println("构造方法。。。");

    }

    /**
     * 连接成功
     * @param session 会话信息
     */
    @OnOpen
    public void onOpen(Session session) {
        String idStr = session.getQueryString();
        userId = Integer.valueOf(idStr);
        baseUserService.onLineStateUp(1,userId);//状态在线
        this.session =session;
        arraySet.add(this);
        this.addOnlineNum();
        System.out.println("有一个新连接加入，当前在线 "+this.getOnLineNum()+" 人");
    }

    /**
     * 连接关闭
     */
    @OnClose
    public void onClose() {
        arraySet.remove(this);
        baseUserService.onLineStateUp(0,userId);//状态下线
        this.subOnlineNum();
        System.out.println("有一个连接断开，当前在线 "+this.getOnLineNum()+" 人");
    }

    /**
     * 连接错误
     * @param session
     * @param error
     */
    @OnError
    public void onError(Session session, Throwable error) {
        System.err.println("发生错误！");
        error.printStackTrace();
    }

    /**
     * 发送消息,不加注解，自己选择实现
     * @param msg
     * @throws IOException
     */
    public void onSend(String msg) throws IOException {
        this.session.getBasicRemote().sendText(msg);
    }

    /**
     * 收到客户端消息回调方法
     * @param session
     * @param msg
     */
    @OnMessage
    public void onMessage(Session session, String msg) {
        System.out.println("消息监控："+msg);
        Chat chat = new Chat();
        Gson gson = new Gson();
        String sendText = "";
        if(!msg.equals("心跳检测")){
            chat = gson.fromJson(msg,Chat.class);
            sendText = gson.toJson(chat);
        }else{
            sendText = msg;
        }
        int bUserId = chat.getSendToId();
        for (Websocket websocket : arraySet) {
            try {
                if(bUserId == websocket.userId){
                    websocket.session.getBasicRemote().sendText(sendText);
                }
            } catch (IOException e) {
                e.printStackTrace();
                continue;
            }
        }
    }



    /**
     * 增加一个在线人数
     */
    private synchronized void addOnlineNum() {
        onlineNum++;
    }

    /**
     * 减少一个在线人数
     */
    private synchronized void subOnlineNum() {
        onlineNum--;
    }

    private Integer getOnLineNum() {
        return onlineNum;
    }


}