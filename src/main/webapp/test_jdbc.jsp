<HTML>
<HEAD>
	<TITLE>MySQL Test JSP page</TITLE>
	<%@ page import="java.util.*" %>
	<%@ page import="java.io.*" %>
	<%@ page import="java.sql.*" %>
	<%@ page import="javax.sql.*" %>
	<%@ page import="javax.naming.*" %>
</HEAD>
<BODY>

<H1>MySQL JSP Test page</H1>
<img src="images/jbosscorp_logo.png">

<H2>Pet Table Data</H2>
<TABLE>
<TR valign=top>
	<TH align=left>Name</TH>
	<TH align=left>Owner</TH>
	<TH align=left>Species</TH>
	<TH align=left>sex</TH>
</TR>
<%
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

try {
	String driver = "com.mysql.jdbc.Driver";
	Class.forName(driver); 

	String host = System.getenv("SKT_APP_MYSQL_SERVICE_HOST");
	String port = System.getenv("SKT_APP_MYSQL_SERVICE_PORT");
	String dbName = System.getenv("DB_DATABASE");
	String userName = System.getenv("DB_USERNAME");
	String password = System.getenv("DB_PASSWORD");
	String url = "jdbc:mysql://"+host+":"+port+"/";

	conn  = DriverManager.getConnection(url + dbName, userName, password);
	stmt = conn.createStatement();
	rs = stmt.executeQuery("select * from pet");

	while(rs.next()) {
		String name = (String) rs.getString("name");
		String owner = (String) rs.getString("owner");
		String species = (String) rs.getString("species");
		String sex = (String) rs.getString("sex");
%>
<TR valign=top>
	<TD><%= name.replaceAll("<", "&lt;").replaceAll(">","&gt;") %></TD>
	<TD><%= owner.replaceAll("<", "&lt;").replaceAll(">","&gt;") %></TD>
	<TD><%= species.replaceAll("<", "&lt;").replaceAll(">","&gt;") %></TD>
	<TD><%= sex.replaceAll("<", "&lt;").replaceAll(">","&gt;") %></TD>
</TR>
<%
	}
} catch (SQLException sqle) {
%>
	<%= sqle.getMessage() %>
<%
} finally {
	try {
		if (rs != null) {
			rs.close();
		}
		if (stmt != null) {
			stmt.close();
		}
		if (conn != null) {
			conn.close();
		}
	} catch (Exception e) {
%>
		<%= e.getMessage() %>
<%
	}
}
%>

</TABLE>

</BODY>
</HTML>

