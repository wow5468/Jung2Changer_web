<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.util.List" %>
<%@ page import = "javax.naming.*,javax.sql.*" %>
<%!


	public Map<String, Object> MT0002execute(Map<String, Object> mapRes){
		Map<String, Object> mapResData = new HashMap<String, Object>();

		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		String strReqNo = (String) mapRes.get("no");
		
		String strRsltNo = "";
		String strBeforeMsg = "";
		String strAfterMsg = "";

        
        try {
    		String strSql = "SELECT AFTERMSG, BEFOREMSG, NO FROM JW_PROCMSG WHERE NO = ? AND AFTERMSG <> ''  ";

        	Context ctx = new InitialContext();
        	DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/PosJung21");
        	
        	conn = ds.getConnection();
        	pstm = conn.prepareStatement(strSql);
        	pstm.setString(1, strReqNo);
        	rs = pstm.executeQuery();
        	
        	if(rs.next()) {
        		strRsltNo = rs.getString("NO");
        		strBeforeMsg = rs.getString("BEFOREMSG");
        		strAfterMsg = rs.getString("AFTERMSG");
        	}

        } catch(Exception e) {
        	e.printStackTrace();
        } finally {
        	try { if(rs!=null) rs.close(); } catch (Exception e) {}
			try { if(pstm!=null) pstm.close(); } catch (Exception e) {}
            try { if(conn!=null) conn.close(); } catch (Exception e) {}
        }
        
        mapResData.put("afterMsg", strAfterMsg);
		mapResData.put("beforeMsg", strBeforeMsg);
		mapResData.put("No", strRsltNo);
		
        return mapResData;
	}
%>
