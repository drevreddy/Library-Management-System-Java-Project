<%@ page import="sjservlets.*, java.sql.*" %>

<%	
      System.err.println();
      System.err.println();
      System.err.println();
      System.err.println();
      System.err.println();
      System.err.println();
      System.err.println();
      System.err.println();

  	ConnectionPool connectionPool;  
	int vendor = DriverUtilities.ORACLE;
    String driver = DriverUtilities.getDriver(vendor);
    String host = "localhost";
    String dbName = "xe";
    String url = DriverUtilities.makeURL(host, dbName, vendor);
    String username = "library";
    String password = "library";    
    
	try {
		System.err.println("before connection pool in dbconnect.jsp");
   		connectionPool =
        new ConnectionPool("oracle.jdbc.driver.OracleDriver", "jdbc:oracle:thin:@localhost:1521:xe", "library", "library", 10, 100, true);
		System.err.println("After connection pool in dbconnect.jsp");
    } catch(SQLException sqle) {
      System.err.println("Error making pool in dbconnect.jsp :   "  + sqle);
      System.err.println();
      getServletContext().log("Error making pool: " + sqle);
      connectionPool = null;
    }    

    // connectionPool.closeAllConnections();  

%>