<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<script type="text/javascript" src="<%=basePath%>/js/jquery-2.1.1.js"></script>
	<script type="text/javascript" src="http://serverPath:3000/socket.io/socket.io.js"></script>	
	
<script type="text/javascript">
$(function(){

		var groupId = "2";//分组ID 可以更换分组ID后，再打开两个浏览器，测试是否互相影响,是否可以正常聊天
		
		//连接服务器
		var connection = io.connect('ws://serverPath:3000',{'reconnect':true,'auto connect':true}); 
		//向服务器发送事件
		connection.emit('new user',groupId);
		//监听事件event_name
		connection.on('event_name', showResult);

		function showResult(msg){//返回信息,显示
			$("#showMsg").append("<p>"+msg+"</p>");
		}

		//发送信息方法
		$("#sendMsgBtn").unbind().click(function(){
			var msg = $("#msgText").val();
			connection.emit('private message',groupId,msg);
		});

})

</script>	
	
  </head>
  
  <body>

		发送信息:<input type="text" id="msgText"> <input type="button" value="发送" id="sendMsgBtn">
		
		<div id="showMsg">
			
		</div>
				
  </body>
</html>
