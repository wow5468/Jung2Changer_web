<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.util.List" %>
<%@ page import="javax.naming.*,javax.sql.*" %>

<%!


	public Map<String, Object> CT0001execute(Map<String, Object> mapRes){
		Map<String, Object> mapResData = new HashMap<String, Object>();
		Map<String, Object> mapCategory = new HashMap<String, Object>();
		ArrayList<Map<String, Object>> arrayResData = new ArrayList<Map<String, Object>>();
		
		String strSql = "SELECT ID, VALUE FROM JW_CATE WHERE USE_YN = 'Y'";
		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {

        	    Context ctx = new InitialContext();
	            DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/PosJung21");
 
		    conn = ds.getConnection();
		    pstm = conn.prepareStatement(strSql);
		    
		    rs = pstm.executeQuery();
		    
		    
		    while(rs.next()) {
		    	mapCategory.put(rs.getString("id"), rs.getString("value"));
		    }
			
			arrayResData.add(mapCategory);
		} catch (Exception e) {
			e.printStackTrace();
		} finally  {
                        try { if(rs!=null) rs.close(); } catch (Exception e) {}
			try { if(pstm!=null) pstm.close(); } catch (Exception e) {}
                        try { if(conn!=null) conn.close(); } catch (Exception e) {}

		}

        mapResData.put("category", arrayResData);
        

        
        return mapResData;
	}
%>
