package com.controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.naming.*;

import org.apache.tomcat.jdbc.pool.DataSource;

import java.util.*;
import java.sql.*;

import com.controller.*;

import com.google.gson.Gson;


/**
 * Servlet implementation class CreateServlet
 */

public class CreateServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

    final String JDBC_DRIVER="com.mysql.jdbc.Driver";  
    final String DB_URL="jdbc:mysql://localhost:3306/projectDB";

    //  Database credentials
    final String USER = "root";
    final String PASS = "";
    String s  = "";// to write sql
	  Statement st ;
    PreparedStatement stmt =null;
    ResultSet rs = null;
    Connection conn=null;
    String reply="" ;// send a comment back to the calling jsp page  
    private DataSource dataSource;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @throws NamingException 
	 * @throws SQLException 
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	/* (non-Javadoc)
	 * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
// assigning a data source
    
    public void connectionManager(String jndi) throws NamingException,SQLException
    {
    	Context ct= new InitialContext();
    	System.out.println(ct.getNameInNamespace());
    	dataSource = (DataSource)ct.lookup("java:/comp/env/"+jndi);
        conn = dataSource.getConnection();
        return ;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws NumberFormatException,ServletException, IOException {
		// TODO Auto-generated method stub

    	// create a connection
    try{
    	connectionManager("jdbc/projectDB");
    }
    catch(NamingException n){n.printStackTrace();}
    catch(SQLException s){s.printStackTrace();}

        response.setContentType("text/html");
	    PrintWriter out = response.getWriter();
    	HttpSession session = request.getSession();    	
	      try{

if(request.getParameterMap().containsKey("duplicate"))
	{
	 // to validate that the employee being added doesnot already exist in the team
	
	String tablename = request.getParameter("tags");
	String id = request.getParameter("id");
	String msg;
	// check in the map table
	
	System.out.println(tablename);
System.out.println(" " + id);
	stmt = conn.prepareStatement("SELECT * FROM MAP WHERE TEAMID=? AND EMPLOYEEID=?");
	stmt.setString(1, tablename);
	stmt.setString(2,id);
	rs = stmt.executeQuery();
	if(rs.next())
	{
		msg = "This is a duplicate id";
	}
	else msg=null; 
	
	
	String json = new Gson().toJson(msg);
	System.out.println(json);
    response.setContentType("application/json");
    response.getWriter().write(json);
    
    System.out.println("duplicate");
return;	    		 

}


if(request.getParameterMap().containsKey("byloc"))
{
	System.out.println("loc");
	
	stmt =  conn.prepareStatement("SELECT LOCATION,COUNT(*) AS NO FROM TEAMINFO GROUP BY LOCATION");	
	rs = stmt.executeQuery();
	
	List<LocBean> list = new ArrayList<LocBean>();
	
	while(rs.next())
	{
		String p = rs.getString("LOCATION");
    	int q= rs.getInt("NO");
    	LocBean d = new LocBean(p,q);
    	list.add(d);
    }
	

	String json = new Gson().toJson(list);
	response.setContentType("application/json");
	response.getWriter().write(json);
    System.out.println(json);	
	
return;	
}
//fine	         
	         
if(request.getParameterMap().containsKey("bydm"))
{
	// get data from server via json
	
	// select the data by dm
	System.out.println("dm");
	stmt = conn.prepareStatement("SELECT DM,COUNT(*) AS NO FROM TEAMINFO GROUP BY DM");
	
    rs = stmt.executeQuery();
    
    List<DmBean> list  = new ArrayList<DmBean>();
    
    while(rs.next())
    {
    	String p = rs.getString("DM");
    	int q= rs.getInt("NO");
    	DmBean d = new DmBean(p,q);
    	list.add(d);
    }
    
    // convert to json
    
    String json = new Gson().toJson(list);
    response.setContentType("application/json");
    response.getWriter().write(json);
    System.out.println(json);
    
return ;
}
//fine

if(request.getParameterMap().containsKey("loadtable"))
{
	stmt = conn.prepareStatement("SELECT * FROM TEAMINFO");
	rs = stmt.executeQuery();
   System.out.println("loading");	
    List<TeamBean> teams =  new ArrayList<TeamBean>();

   
         while(rs.next())
         {
       	  
       	  TeamBean t=new TeamBean();
         
   	t.setTeamname(rs.getString("TEAMID"));
   	t.setAccname(rs.getString("ACCOUNTNAME"));
   	t.setDate(rs.getString("PROJECTCODE"));
   	t.setProjectcode(rs.getString("STARTDATE"));
   	t.setSize(rs.getInt("SIZE"));
	        t.setDm(rs.getString("DM"));
	    t.setLoc(rs.getString("LOCATION"));
   
  out.println(t.teamname);	
	teams.add(t);
	
    }
         
  String json = new Gson().toJson(teams);
  response.setContentType("application/json");
  response.setCharacterEncoding("UTF-8");
  response.getWriter().write(json);
  System.out.println(json);

// team addition       
	
	return;
}


if(request.getParameterMap().containsKey("showtable"))
	     	{
	     		 // display a table 
	     		 System.out.println("executed");
	     		 // if a table doesnot exist create a table
	     	  
	     		 String tablename = request.getParameter("tags");
	     		 //  System.out.println(tablename);
	     		 
	     		 DatabaseMetaData metadata = conn.getMetaData();
	     		 rs = metadata.getTables(null, null, tablename, null);
	     		 st = conn.createStatement();
	     		 
	     		 
	     		 if(!rs.next()){
	     			 // table not exists
	     			 s = "CREATE TABLE "+tablename+"(EMPLOYEEID VARCHAR(20) NOT NULL PRIMARY KEY)";
	     			
	     			 st.executeUpdate(s);
	     		 }
	     		 
	     		 s = "SELECT * FROM "+tablename+" INNER JOIN EMPLOYEE ON "+tablename+".EMPLOYEEID=EMPLOYEE.ID";
	     		 rs = st.executeQuery(s);
	     		 List<EmpBean> members = new ArrayList<EmpBean>();
	              
	     		 while(rs.next())
	     		 {
	     		 //System.out.println(rs.getString("ID"));
	     		 members.add(new EmpBean(rs.getString("ID"),rs.getString("NAME"),rs.getString("EMAIL"),rs.getString("ROLE")
	     				 ,rs.getDouble("EXPERIENCE"),rs.getString("TECH")));
	     		 
	     		 }
	     		 
	     		 // java obj containing members created
	     		 // convert java obj into json obj
	     		 
	     		 String json = new Gson().toJson(members);
	     		 System.out.println(json);
	     		 response.setContentType("application/json");
	     	     response.setCharacterEncoding("UTF-8");
	     		 response.getWriter().write(json);
	
	     		 // session.setAttribute("members", members);

	     		 // show table 
	       
	     	      return;	      
}
//fine


	 	       if(request.getParameterMap().containsKey("addteam"))
	         {
	 	    	   //add
	        	 System.out.println("teams");
	         String teamname=request.getParameter("name");
	         String accname=request.getParameter("account");
	         String procode=request.getParameter("projectcode");
	         String size= request.getParameter(("size").trim());
	         String date=request.getParameter("date");
	         String dm=request.getParameter("dm");
	         String location=request.getParameter("location");
	
	         int sam=0;
	         if(size!=null){sam = Integer.parseInt(size); }
	         
	        // Execute SQL query
	        stmt = conn.prepareStatement("INSERT INTO TEAMINFO VALUES(?,?,?,?,?,?,?)");
	        stmt.setString(1,teamname);
	        stmt.setString(2,accname);
	        stmt.setString(3,procode);
            stmt.setString(4,date);
	        stmt.setInt(5,sam);
	        stmt.setString(6,dm);
	        stmt.setString(7,location);

	        stmt.executeUpdate();

 	        s = "SELECT * FROM TEAMINFO";
            stmt = conn.prepareStatement(s);
 	        stmt.executeQuery(s);

  	        rs= stmt.getResultSet();
    
	         List<TeamBean> teams =  new ArrayList<TeamBean>();
        
	        
                  while(rs.next())
                  {
                	  
                	  TeamBean t=new TeamBean();
                  
	        	t.setTeamname(rs.getString("TEAMID"));
	        	t.setAccname(rs.getString("ACCOUNTNAME"));
	        	t.setDate(rs.getString("PROJECTCODE"));
	        	t.setProjectcode(rs.getString("STARTDATE"));
	        	t.setSize(rs.getInt("SIZE"));
      	        t.setDm(rs.getString("DM"));
        	    t.setLoc(rs.getString("LOCATION"));
	        
           out.println(t.teamname);	
        	teams.add(t);
        	
	         }
                  
	       String json = new Gson().toJson(teams);
	       response.setContentType("application/json");
	       response.getWriter().write(json);
	       System.out.println(json);

	  // team addition       
	    return;
}
//submit
	 	       
if(request.getParameterMap().containsKey("updateteam"))
{

	 System.out.println("updateteam");
	 
String teamname=request.getParameter("name");
String accname=request.getParameter("account");
String procode=request.getParameter("projectcode");
String size= request.getParameter(("size").trim());
String date=request.getParameter("date");
String dm=request.getParameter("dm");
String location=request.getParameter("location");

System.out.println(teamname);
System.out.println(accname);
System.out.println(size);
int sam = 0;



// Execute SQL query
stmt = conn.prepareStatement("UPDATE TEAMINFO SET ACCOUNTNAME=?,PROJECTCODE=?,STARTDATE=?,SIZE=?,DM=?,LOCATION=? WHERE TEAMID=?");

stmt.setString(1,accname);
stmt.setString(2,procode);
stmt.setString(3,date);
stmt.setInt(4,sam);
stmt.setString(5,dm);
stmt.setString(6,location);
stmt.setString(7,teamname);
// autocommit is true
stmt.executeUpdate();


stmt = conn.prepareStatement("SELECT * FROM TEAMINFO");
stmt.executeQuery();

 rs= stmt.getResultSet();

List<TeamBean> teams =  new ArrayList<TeamBean>();


     while(rs.next())
     {
   	  
   	  TeamBean t=new TeamBean();
     
	t.setTeamname(rs.getString("TEAMID"));
	t.setAccname(rs.getString("ACCOUNTNAME"));
	t.setDate(rs.getString("PROJECTCODE"));
	t.setProjectcode(rs.getString("STARTDATE"));
	t.setSize(rs.getInt("SIZE"));
     t.setDm(rs.getString("DM"));
   t.setLoc(rs.getString("LOCATION"));

out.println(t.teamname);	
teams.add(t);

}
  
String json = new Gson().toJson(teams);
response.setContentType("application/json");
response.getWriter().write(json);
System.out.println(json);
return;
}
//fine

if(request.getParameterMap().containsKey("ndel"))
{
	// when a team is deleted the record of employees is not deleted as they may be involved in another team later on

	String tablename = request.getParameter("ndel");
	System.out.println(tablename);
	// delete from teaminfo first
	
	
	stmt = conn.prepareStatement("DELETE FROM TEAMINFO WHERE TEAMID=?");
	
    stmt.setString(1, tablename);
    
    stmt.executeUpdate();
	// deleted from teaminfo
    
    
    // if team has any employee
    
    stmt =  conn.prepareStatement("DELETE FROM MAP WHERE TEAMID=?");
    stmt.setString(1, tablename);
    stmt.executeUpdate();
    
    // deleting all members from a team is difft from deleting a team
    // on deleting or adding a team always update the list of teams
    
    
	// select new table of teams
	
	stmt  =  conn.prepareStatement("SELECT * FROM TEAMINFO");
	rs  = stmt.executeQuery();
	
	List<TeamBean> teams =  new ArrayList<TeamBean>();


    while(rs.next())
    {
  	  
  	  TeamBean t=new TeamBean();
    
	t.setTeamname(rs.getString("TEAMID"));
	t.setAccname(rs.getString("ACCOUNTNAME"));
	t.setDate(rs.getString("PROJECTCODE"));
	t.setProjectcode(rs.getString("STARTDATE"));
	t.setSize(rs.getInt("SIZE"));
    t.setDm(rs.getString("DM"));
  t.setLoc(rs.getString("LOCATION"));

out.println(t.teamname);	
teams.add(t);

}
String json = new Gson().toJson(teams);
response.setContentType("application/json");
response.getWriter().write(json);
System.out.print(json);
System.out.println("exec");
	return;


}


// implementing update details option using update parameter
	 if(request.getParameterMap().containsKey("memupdate"))
	 {
		 // update existing record
		 System.out.println("updated");
		 String tablename=request.getParameter("tags");
		 String id=request.getParameter("eid");
		 String name=request.getParameter("ename");
		 String email=request.getParameter("email");
		 String role=request.getParameter("role");
		 String ex=request.getParameter(("experience").trim());
		 String tech=request.getParameter("tech");
		 double exe=0;
		 if(ex!=null){exe = Double.parseDouble(ex);}
         
		 stmt = conn.prepareStatement("UPDATE EMPLOYEE SET NAME=?, EMAIL=?, ROLE=?, EXPERIENCE=?, TECH=? WHERE ID=?") ;
		 stmt.setString(1, name);
		 stmt.setString(2, email);
		 stmt.setString(3, role);
		 stmt.setDouble(4, exe);
		 stmt.setString(5, tech);
		 stmt.setString(6, id);
		 
		 
		 stmt.executeUpdate();
		 System.out.println("happening");
		 // fetch again from db	
		 
		 s = "SELECT * FROM "+tablename+" INNER JOIN EMPLOYEE ON "+ tablename+".EMPLOYEEID=EMPLOYEE.ID";
		 stmt = conn.prepareStatement(s);

		 
		 rs = stmt.executeQuery();
		 
		 List<EmpBean> members = new ArrayList<EmpBean>();
         
		 while(rs.next())
		 {
		 //System.out.println(rs.getString("ID"));
		 members.add(new EmpBean(rs.getString("ID"),rs.getString("NAME"),rs.getString("EMAIL"),rs.getString("ROLE")
				 ,rs.getDouble("EXPERIENCE"),rs.getString("TECH")));
		 
		 }
		 
		 //session.setAttribute("members", members);
		 String json = new Gson().toJson(members);
		 response.setContentType("application/json");
		 response.getWriter().write(json);
		 return;
}
	         
	 if(request.getParameterMap().containsKey("eid")&&!request.getParameterMap().containsKey("update"))
	 {

		 // while adding a member to a table add the teamname
		 
		 String tablename=request.getParameter("tags");
		 System.out.println("ADDING");
		 String id=request.getParameter("eid");
		 String name=request.getParameter("ename");
		 String email=request.getParameter("email");
		 String role=request.getParameter("role");
		 String ex=request.getParameter(("experience").trim());
		 String tech=request.getParameter("tech");

			 double exe=0;
			 if(ex!=null){exe = Double.parseDouble(ex);}

	
		// first we will add employee to the employee table
		stmt = conn.prepareStatement("SELECT * FROM EMPLOYEE WHERE ID=?");
		stmt.setString(1, id);
		rs = stmt.executeQuery();
		
		if(rs.next())
		{// employee entry present no need to add him to the table 
		    
		}
		
		else{
		 stmt = conn.prepareStatement("INSERT INTO EMPLOYEE VALUES(?,?,?,?,?,?)");
		 stmt.setString(1, id);
		 stmt.setString(2, name);
		 stmt.setString(3, email);
		 stmt.setString(4, role);
		 stmt.setDouble(5, exe);
		 stmt.setString(6, tech);
		 
		 reply = "Member added to the Team";
		 // an entry added to table employee, at this stage you need to check if employee id is a duplicate
		 stmt.executeUpdate();
		// check if the table is already created for the team, if not create a table
		// entry created
		
		}

		//create a mapping for the employee in the map table
        
		stmt = conn.prepareStatement("INSERT INTO MAP VALUES(?,?)");
		stmt.setString(1,tablename);
		stmt.setString(2,id);
		stmt.executeQuery();
		
		 // select all employees belonging to the team
   stmt = conn.prepareStatement("SELECT * FROM EMPLOYEE WHERE ID IN(SELECT TEAMID FROM MAP WHERE TEAMID=? AND EMPLOYEEID=?)");
   stmt.setString(1, tablename);
   stmt.setString(2, id);
		
   rs = stmt.executeQuery();
   
   List<EmpBean> list = new ArrayList<EmpBean>();
   
   while(rs.next())
   {
	   list.add(new EmpBean(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getDouble(5), rs.getString(6)));
   }
   
		
	     String json = new Gson().toJson(list);
		 response.setContentType("application/json");
		 response.getWriter().write(json);

		 
		 // show table 
		 System.out.println("member added");
	     System.out.println(json);
		 return;
	}
	 
	 //adding delete option
	 
	 if(request.getParameterMap().containsKey("del"))
	 {
		 // if an employee deleted from team 
		 // his id deleted from tablename
		 // still his record remains in table employee
		 // his teamid will be set to empty
		 // using same script as update
		 
		 String tablename = request.getParameter("tags");
		 String id = request.getParameter("del");
		 System.out.println(tablename);
		 System.out.println(id);
		 
		 s= "DELETE FROM "+tablename+" WHERE EMPLOYEEID=?";
		 stmt = conn.prepareStatement(s);
		stmt.setString(1, id);
		 
		 stmt.executeUpdate();
	
		 
	// Also the teamid entry corresponding to that employee shoulb be set to null
		 s= "DELETE FROM EMPLOYEE WHERE ID=?";
		 stmt = conn.prepareStatement(s);
		stmt.setString(1, id);
		 
		 stmt.executeUpdate();
	   
	// again obtain the new table
	   s = "SELECT * FROM "+tablename+" INNER JOIN EMPLOYEE ON "+tablename+".EMPLOYEEID=EMPLOYEE.ID";
		 
	   stmt = conn.prepareStatement(s);
	   
	   rs = stmt.executeQuery(s);
	   
	   List<EmpBean> members = new ArrayList<EmpBean>();
       
		 while(rs.next())
		 {
		 //System.out.println(rs.getString("ID"));
		 members.add(new EmpBean(rs.getString("ID"),rs.getString("NAME"),rs.getString("EMAIL"),rs.getString("ROLE")
				 ,rs.getDouble("EXPERIENCE"),rs.getString("TECH")));
		 
		 }
		System.out.println(members);
		 
		 String json = new Gson().toJson(members);
		 response.setContentType("application/json");
		 response.getWriter().write(json);
		
	return;
	 }
	 
	 	 
	// duplicate checking to be done later
	//default code to load a table should
	 
	  	        
	             stmt = conn.prepareStatement("SELECT * FROM TEAMINFO");
	  	        stmt.executeQuery();

	   	        rs= stmt.getResultSet();
	     
	 	         List<TeamBean> teamss =  new ArrayList<TeamBean>();
	         
	 	        
	                   while(rs.next())
	                   {
	                 	  
	                 	  TeamBean t=new TeamBean();
	                   
	 	        	t.setTeamname(rs.getString("TEAMID"));
	 	        	t.setAccname(rs.getString("ACCOUNTNAME"));
	 	        	t.setDate(rs.getString("PROJECTCODE"));
	 	        	t.setProjectcode(rs.getString("STARTDATE"));
	 	        	t.setSize(rs.getInt("SIZE"));
	       	        t.setDm(rs.getString("DM"));
	         	    t.setLoc(rs.getString("LOCATION"));
	 	        
	            out.println(t.teamname);	
	         	teamss.add(t);
	         	
	 	         }
	 	       /* Gson gson = new Gson();
	 	       JsonElement element = gson.toJsonTree(teams, new TypeToken<List<TeamBean>>() {}.getType());
	 	       JsonArray jsonArray = element.getAsJsonArray();
	 	       response.setContentType("application/json");
	 	       response.getWriter().print(jsonArray);*/
	 	     
	 	       request.setAttribute("teams", teamss);
	 	             
       // this is a by default code
	 	  // team form ends here       
		 
	 
		         
	         
	    request.getRequestDispatcher("/WEB-INF/home.jsp").forward(request, response);
      return;	      


	      
	      }
	       catch(NumberFormatException n)
	      {
	    	  n.printStackTrace();
	      }
	catch(Exception e){
	         //Handle errors for Class.forName
	         e.printStackTrace();
	      }finally{
	         //finally block used to close resources
	    
	     
	      } //end try


	
	}	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		
			
	}
	
	
	
public static void main(String s)
{
	CreateServlet c = new CreateServlet();
	System.out.print("hoothtere");
}




}
