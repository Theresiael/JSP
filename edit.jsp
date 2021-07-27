<%@ include file="koneksi.jsp" %>

<%
    Connection koneksi = DriverManager.getConnection("jdbc:mysql://localhost/anggota","root","");
    String id = request.getParameter("id");
    ResultSet hasil = null;
    Statement stm = koneksi.createStatement();
    hasil = stm.executeQuery("SELECT * FROM tabel_anggota WHERE id='"+id+"'");
    hasil.next();
    
    String nama = hasil.getString("nama");
    String kota = hasil.getString("kota");
    String email = hasil.getString("email");
    String jenis = hasil.getString("jenis_kelamin");
    String pendidikan = hasil.getString("pendidikan");
    String keahlian = hasil.getString("keahlian");
    String pengalaman = hasil.getString("pengalaman");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Bootstrap Form</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="bootstrap.min.css">
    <script src="jquery.min.js"></script>
    <script src="bootstrap.min.js"></script>
</head>
<body>
    <div class="container">
        <h2>Input Data Anggota</h2>
        <form class="form-horizontal" method="post" action="edit.jsp">
            <div class="form-group">
                <label class="control-label col-sm-2" for="nama">Nama:</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="nama" placeholder="Masukkan Nama" name="nama" value="<%=nama%>">
                </div>
                <label class="control-label col-sm-2" for="nama">Kota:</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="kota" placeholder="MasukkanKota" name="kota" value="<%=kota%>">
                </div>
            </div>
            <div class="form-group text-left">
                <label class="control-label col-sm-2" for="email">Email:</label>
                <div class="col-sm-10">          
                    <input type="email" class="form-control" id="email" placeholder="Masukkan Email" name="email" value="<%=email%>">
                </div>
            </div>
            <div class="form-group">        
                <label class="control-label col-sm-2" for="jk">Jenis Kelamin:</label>
                <div class="col-sm-10">          
                    <label class="radio-inline"><input type="radio" id="jk" name="jk" value="Pria"<% if (jenis.equals("Pria")) out.println("checked"); %>> Pria</label>
                    <label class="radio-inline"><input type="radio"  id="jk" name="jk" value="Wanita"<% if (jenis.equals("Wanita")) out.println("checked"); %>> Wanita</label>
                </div>
            </div>
            <div class="form-group">        
                <label  class="control-label  col-sm-2" for="pendidikan">Pendidikan:</label>
                <div class="col-sm-10">          
                    <select class="form-control" id="pendidikan" name="pendidikan">
                        <option value='-' <%  if (pendidikan.equals("-")) out.println("selected"); %>>--Masukkan Pendidikan--</option>
                        <option value='S1' <%  if (pendidikan.equals("S1")) out.println("selected"); %>>S1</option>
                        <option value='S2' <%  if (pendidikan.equals("S2")) out.println("selected"); %>>S2</option>
                        <option value='S3' <%  if (pendidikan.equals("S3")) out.println("selected"); %>>S3</option>
                        <option value='lainnya' <% if (pendidikan.equals("lainnya")) out.println("selected"); %>>Lainnya</option>
                    </select>
                </div>
            </div>
            <div class="form-group">        
                <label class="control-label col-sm-2" for="ahli">Keahlian:</label>
                <div class="col-sm-10"> 
                    <label class="checkbox-inline" ><input type='checkbox'  name='ahli1'  value='Programming'  id="ahli"  <%  if (keahlian.contains("Programming"))   out.println("checked");   %>> Programming</label>
                    <label class="checkbox-inline" ><input type='checkbox' name='ahli2' value='Networking' id="ahli" <%  if  (keahlian.contains("Networking"))  out.println("checked"); %>> Networking</label>
                    <label class="checkbox-inline" ><input type='checkbox'  name='ahli3'  value='Database'  id="ahli"  <% if (keahlian.contains("Database")) out.println("checked"); %>> Database</label>
                    <label class="checkbox-inline" ><input type='checkbox' name='ahli4' value='System' id="ahli"  <% if (keahlian.contains("System"))   out.println("checked");   %>> System</label>
                </div>
            </div>
            <div class="form-group">        
                <label class="control-label col-sm-2" for="pengalaman">Pengalaman:</label>
                <div class="col-sm-10">          
                    <textarea class="form-control" rows="5" style="resize: none" id="pengalaman" name="pengalaman"><%=pengalaman%></textarea>
                </div>
            </div>
            <div class="form-group">        
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="submit" class="btn btn-success" name="edit">Edit</button>
                    <button type="reset" class="btn btn-warning">Reset</button>
                    <input type="hidden"  name="id" value="<%=id%>">
                </div>
            </div>
        </div>
        </form>
        <div class="col-sm-10 col-sm-offset-1">
        <%
        if (request.getParameter("edit") != null){
            nama = request.getParameter("nama");
            kota = request.getParameter("kota");
            email = request.getParameter("email");
            jenis = request.getParameter("jk");     
            pendidikan = request.getParameter("pendidikan");  
            pengalaman = request.getParameter("pengalaman"); 

            keahlian = "";String ahli;
            for (int i=1; i<=4; i++){
                ahli  =  request.getParameter("ahli"  + i);
                if (ahli != null){
                    keahlian += ahli + ", ";
                }
            }
            boolean berhasil = true;
            String query = "UPDATE tabel_anggota SET nama='" + nama + "', kota='" + kota +"', email='" + email + "', jenis_kelamin='" + jenis + "', pendidikan='" + pendidikan + "', keahlian='"  +  keahlian  +  "',  pengalaman='"  +  pengalaman  +  "' WHERE id='" + id + "'";
            try{
                stm = koneksi.createStatement();
                stm.executeUpdate(query);
            }
            catch (Exception ex){
                out.println("Kesalahan " + ex);
                berhasil = false;
            }
            if (berhasil){
                %>
                <div class="alert alert-success alert-dismissable">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <strong>Success!</strong>Data Anggota Berhasil Diedit. Klik  <a  href="input.jsp">disini</a> untuk Input Data Baru.
                </div>
                <%
            }
            else{
                %>
                <div class="alert alert-ddanger alert-dismissable">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <strong>Failed!</strong>Data Anggota Gagal Diedit.
                </div>
                <%
            }
        }
        %>
    </div>
</div>
</body>
</html>