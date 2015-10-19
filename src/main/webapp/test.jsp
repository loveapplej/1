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
InitialContext ctx;
DataSource ds;
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

try {
	ctx = new InitialContext();
	ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mydb");
	conn = ds.getConnection();
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
} catch (NamingException ne) {
%>
	<%= ne.getMessage() %>
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

