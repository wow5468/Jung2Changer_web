<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.util.List" %>
<%@ page import = "javax.naming.*,javax.sql.*" %>
<%!


	public Map<String, Object> MT0001execute(Map<String, Object> mapRes){
		Map<String, Object> mapResData = new HashMap<String, Object>();
		
		Connection conn = null;
		PreparedStatement pstm = null;
		PreparedStatement pstm1 = null;
		ResultSet rs = null;
		
		String strReqMsg = ((String) mapRes.get("msg")).trim();
		String strReqCate = (String) mapRes.get("category");
		
		String strMsgNo = "";
		
		int intRsltCnt = 0;
		
        try {
    		String strSql = "INSERT INTO jw_procmsg(no, cate, beforemsg) VALUES (?, ?, ?);";
    		String strSql1 = "SELECT \"getMsgNo\"() as msgno;";

        	Context ctx = new InitialContext();
        	DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/PosJung21");
        	
        	conn = ds.getConnection();
        	pstm1 = conn.prepareStatement(strSql1);
        	rs = pstm1.executeQuery();
        	
        	if(rs.next()) {
        		strMsgNo = rs.getString("msgno");
        		
        		pstm = conn.prepareStatement(strSql);
            	pstm.setString(1, strMsgNo);
            	pstm.setString(2, strReqCate);
            	pstm.setString(3, strReqMsg);
            	
            	intRsltCnt = pstm.executeUpdate();
        	}
        } catch(Exception e) {
        	e.printStackTrace();
        } finally {
        	try { if(rs!=null) rs.close(); } catch (Exception e) {}
			try { if(pstm!=null) pstm.close(); } catch (Exception e) {}
			try { if(pstm1!=null) pstm1.close(); } catch (Exception e) {}
            try { if(conn!=null) conn.close(); } catch (Exception e) {}
        }
        
        mapResData.put("req_cnt", intRsltCnt);
        mapResData.put("req_no", strMsgNo);
        
        return mapResData;
	}
%>
