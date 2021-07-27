<%@ include file="koneksi.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Bootstrap Form</title>
    <meta charset="utf-8">
    <meta  name="viewport"  content="width=device-width,  initial-scale=1">
    <link rel="stylesheet" href="bootstrap.min.css">
    <script src="jquery.min.js"></script>
    <script src="bootstrap.min.js"></script>
</head>
<body>
    <div class="container">
        <h2>Input Data Anggota</h2>
        <form class="form-horizontal" method="post" action="input.jsp">
            <div class="form-group">
                <label  class="control-label  col-sm-2" for="nama">Nama:</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="nama" placeholder="Masukkan Nama" name="nama">
                </div>
                <label  class="control-label  col-sm-2" for="nama">Kota:</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="kota" placeholder="Masukkan Kota" name="kota">
                    </div>
                </div>
                <div class="form-group text-left">
                    <label  class="control-label  col-sm-2" for="email">Email:</label>
                    <div class="col-sm-10">          
                        <input type="email" class="form-control" id="email" placeholder="Masukkan Email" name="email">
                    </div>
                </div>
                <div class="form-group">   
                    <label class="control-label  col-sm-2" for="jk">Jenis Kelamin:</label>
                    <div class="col-sm-10">          
                        <label class="radio-inline"><input type="radio" id="jk" name="jk" value="Pria"> Pria</label>
                        <label class="radio-inline"><input  type="radio"  id="jk"  name="jk"  value="Wanita"> Wanita</label>
                    </div>
                </div>
                <div class="form-group">        
                    <label class="control-label col-sm-2" for="pendidikan">Pendidikan:</label>
                    <div class="col-sm-10">          
                        <select  class="form-control" id="pendidikan" name="pendidikan">
                            <option value='-'>--Masukkan Pendidikan--</option>
                            <option value='S1'>S1</option>
                            <option value='S2'>S2</option>
                            <option value='S3'>S3</option>
                            <option value='lainnya'>Lainnya</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">        
                    <label class="control-label col-sm-2" for="ahli">Keahlian:</label>
                    <div class="col-sm-10">          
                        <label class="checkbox-inline"><input type='checkbox' name='ahli1' value='Programming' id="ahli"> Programming</label>
                        <label class="checkbox-inline"><input type='checkbox' name='ahli2' value='Networking' id="ahli"> Networking</label>
                        <label class="checkbox-inline"><input type='checkbox' name='ahli3' value='Database' id="ahli"> Database</label>
                        <label class="checkbox-inline"><input type='checkbox' name='ahli4' value='System' id="ahli"> System</label>
                    </div>
                </div>
                <div class="form-group">        
                    <label class="control-label col-sm-2" for="pengalaman">Pengalaman:</label>
                    <div class="col-sm-10">          
                        <textarea class="form-control" rows="5" style="resize: none" id="pengalaman" name="pengalaman"></textarea>
                    </div>
                </div>
                <div class="form-group"> 
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="submit" class="btn btn-success" name="submit">Submit</button>
                        <button type="reset" class="btn btn-warning">Reset</button>
                    </div>
                </div>
            </div>
        </form>
        <div class="col-sm-10 col-sm-offset-1">
            <%
                if (request.getParameter("submit") != null){
                    Connection koneksi = DriverManager.getConnection("jdbc:mysql://localhost/anggota","root","");
                    String nama = request.getParameter("nama");
                    String kota = request.getParameter("kota");
                    String email = request.getParameter("email");
                    String jk = request.getParameter("jk");     
                    String pendidikan = request.getParameter("pendidikan");  
                    String pengalaman = request.getParameter("pengalaman");

                    String keahlian = "";
                    String ahli;
                    for (int i=1; i<=4; i++){
                        ahli  =  request.getParameter("ahli"  + i);
                        if (ahli != null){
                            keahlian += ahli + ", ";
                        }
                    }
                    
                    boolean berhasil = true;
                    String query = "INSERT INTO tabel_anggota (nama, kota, email, jenis_kelamin, pendidikan, keahlian, pengalaman) VALUES ('"  +  nama  +  "','"  +  kota  +  "','"  +  email  + "','"  +  jk  +  "','"  +  pendidikan  +  "','"  +  keahlian  +  "','"  + pengalaman + "')";
                    try{
                        Statement stm = koneksi.createStatement();
                        stm.executeUpdate(query);
                    }
                    catch (Exception ex){
                        out.println("Kesalahan " + ex);berhasil = false;
                    }
                    if (berhasil){
                        out.println("<div class='alert alert-success alert-dismissable'><a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a><strong>Success!</strong> Data Anggota Berhasil Diinput.</div>");
                    }
                    else{
                        out.println("<div class='alert alert-danger alert-dismissable'><a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a><strong>Failed!</strong> Data Anggota Gagal Diinput.</div>");
                    }
                }
                
                if (request.getParameter("hapus") != null){
                    Connection koneksi = DriverManager.getConnection("jdbc:mysql://localhost/anggota","root","");
                    String id = request.getParameter("id");
                    boolean berhasil = true;
                    String query = "DELETE  FROM  tabel_anggota WHERE id='" + id + "'";
                    try{
                        Statement stm = koneksi.createStatement();
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
                            <strong>Success!</strong>Data Anggota Berhasil Dihapus.
                        </div>
                        <%
                    }
                    else{
                        %>
                        <div class="alert alert-ddanger alert-dismissable">
                            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                            <strong>Failed!</strong>Data Anggota Gagal Dihapus.
                        </div>
                        <%
                    }
                }
            %>
        </div>
        <div class="table-responsive col-sm-10 col-sm-offset-1">
            <h2>List Data Anggota</h2>
            <table class="table table-striped ">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nama</th>
                        <th>Kota</th>
                        <th>Email</th>
                        <th>Jenis Kelamin</th>
                        <th>Pendidikan</th>
                        <th>Keahlian</th>
                        <th>Pengalaman</th>
                    </tr>
                </thead>
                <tbody>
            <%
                ResultSet hasil = null;
                Connection koneksi = DriverManager.getConnection("jdbc:mysql://localhost/anggota","root","");
                Statement stm = koneksi.createStatement();
                hasil = stm.executeQuery("SELECT COUNT(*) AS jum FROM tabel_anggota ORDER BY nama");
                hasil.next();
                int rowCount = hasil.getInt("jum");
                if (rowCount == 0){
            %>
            <tr>
                <td colspan="8" class="danger">Data Anggota Masih Kosong</td>
            </tr>
            <%
                }
                else{
                    stm = koneksi.createStatement();
                    hasil = stm.executeQuery("SELECT * FROM tabel_anggota ORDER BY nama");
                    int i = 0;
                    while (hasil.next()){
                        i++;
                        String id = hasil.getString("id");
                        String nama = hasil.getString("nama");
                        String kota = hasil.getString("kota");
                        String email = hasil.getString("email");
                        String jenis = hasil.getString("jenis_kelamin");
                        String pendidikan = hasil.getString("pendidikan");
                        String keahlian = hasil.getString("keahlian");
                        String pengalaman = hasil.getString("pengalaman");
            %>
            <tr>
                <td><%=i%></td>
                <td><%=nama%></td>
                <td><%=kota%></td>
                <td><%=email%></td>
                <td><%=jenis%></td>
                <td><%=pendidikan%></td>
                <td><%=keahlian%></td>
                <td><%=pengalaman%></td>
                <td><a href='edit.jsp?id=<%=id%>'><button type='button' class='btn btn-sm btn-info'>Edit</button></a></td>
                <td><a href='input.jsp?hapus=ok&id=<%=id%>'><button type='button' class='btn btn-sm  btn-danger'>Hapus</button></a></td>
            </tr>
            <%
                    }
                }
            %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>