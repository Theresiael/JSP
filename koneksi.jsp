<%@ page import="java.sql.*" %> 
<%
    boolean cek = false;
    
    try{
        Class.forName("com.mysql.jdbc.Driver");
    }
    catch (Exception ex){
        out.println("Kesalahan " + ex);
        cek = true;
    }
    if (!cek){
        Connection koneksi = null;
        try{
            koneksi = DriverManager.getConnection ("jdbc:mysql://localhost/anggota","root","");
        }
        catch(Exception ex){
            out.println("Kesalahan " + ex);
            cek = true;
        }
    }
    if (cek){
        out.println("Koneksi Gagal");
    }
%>