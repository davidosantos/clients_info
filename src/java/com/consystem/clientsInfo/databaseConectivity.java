/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.consystem.clientsInfo;

import com.ibatis.common.jdbc.ScriptRunner;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.Reader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

/**
 *
 * @author David Santos
 */
public class databaseConectivity {

    public enum dataBaseType {

        JavaDB,
        mySql,
        Postgres;
    };

    static Connection conn = null;

    public static void updateCliente(
            String codigo,
            String Nome,
            String Email,
            String Endereco,
            String Cidade,
            String Estado,
            String Cep,
            String Tel1,
            String Tel2,
            String Ramal,
            int codigo_banco) throws Exception {

        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "update clientes set codigo = ?, nome = ?, email = ? , endereco = ?,"
                + "cidade = ?,estado = ?,cep = ?,telefone1 = ?, telefone2 =?, ramal= ?"
                + " where cliente_id = ?;");

        preparedStamnt.setString(1, codigo);
        preparedStamnt.setString(2, Nome);
        preparedStamnt.setString(3, Email);
        preparedStamnt.setString(4, Endereco);
        preparedStamnt.setString(5, Cidade);
        preparedStamnt.setString(6, Estado);
        preparedStamnt.setString(7, Cep);
        preparedStamnt.setString(8, Tel1);
        preparedStamnt.setString(9, Tel2);
        preparedStamnt.setString(10, Ramal);
        preparedStamnt.setInt(11, codigo_banco);

        if (preparedStamnt.executeUpdate() == 0) {
            throw new Exception("No update where made: " + preparedStamnt.toString());
        }

    }
    public static void updateSenha(
            int login_id,
            int password) throws Exception {

        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "update logins set password = ?"
                + " where login_id = ?;");

        preparedStamnt.setInt(1, password);
        preparedStamnt.setInt(2, login_id);

        if (preparedStamnt.executeUpdate() == 0) {
            throw new Exception("No update where made: " + preparedStamnt.toString());
        }

    }

    public static void newCliente(
            String codigo,
            String Nome,
            String Email,
            String Endereco,
            String Cidade,
            String Estado,
            String Cep,
            String Tel1,
            String Tel2,
            String Ramal) throws Exception {

        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "insert into clientes (codigo,nome,email,endereco,cidade,estado,cep,telefone1,telefone2,ramal)"
                + "values("
                + "?,?,?,?,?,"
                + "?,?,?,?,?);");

        preparedStamnt.setString(1, codigo);
        preparedStamnt.setString(2, Nome);
        preparedStamnt.setString(3, Email);
        preparedStamnt.setString(4, Endereco);
        preparedStamnt.setString(5, Cidade);
        preparedStamnt.setString(6, Estado);
        preparedStamnt.setString(7, Cep);
        preparedStamnt.setString(8, Tel1);
        preparedStamnt.setString(9, Tel2);
        preparedStamnt.setString(10, Ramal);

        preparedStamnt.execute();

    }

    public static void criarUsuario(
            String user,
            int senha,
            String nomeCompl,
            String email
    ) throws Exception {

        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement("insert into logins (nome,password,nome_compl,email)"
                + " values("
                + "?,?,?,?);");

        preparedStamnt.setString(1, user);
        preparedStamnt.setInt(2, senha);
        preparedStamnt.setString(3, nomeCompl);
        preparedStamnt.setString(4, email);

        preparedStamnt.executeUpdate();

    }

    public static void newCampoPersonalizado(
            String campo_nome,
            int modulo_id) throws Exception {

        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "select count(nome_campo) from campos_personalizados "
                + "where modulo_id = ? and nome_campo = ? ;");

        preparedStamnt.setInt(1, modulo_id);
        preparedStamnt.setString(2, campo_nome);

        ResultSet rs = preparedStamnt.executeQuery();

        while (rs.next()) {
            if (rs.getInt(1) > 0) {
                throw new SQLException("Campo " + campo_nome + " ja existe para o modulo " + modulo_id + ".");
            }
        }
        preparedStamnt = conn.prepareStatement(
                "insert into campos_personalizados (nome_campo,modulo_id)"
                + "values("
                + "?,?);");

        preparedStamnt.setString(1, campo_nome);
        preparedStamnt.setInt(2, modulo_id);

        preparedStamnt.execute();

    }

    public static InputStream downloadArquivo(
            int modulo_id,
            String arquivo) throws Exception {

        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "select arquivo_dados from arquivos "
                + "where modulo_id = ?"
                + " and arquivo_nome = ?;");

        preparedStamnt.setInt(1, modulo_id);
        preparedStamnt.setString(2, arquivo);

        ResultSet rs = preparedStamnt.executeQuery();
        rs.next();
        return rs.getBinaryStream("arquivo_dados");

    }

    public static Map getLogin_id(
            String email) throws Exception {

       PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "select * from logins "
                + "where email = ?;");

        preparedStamnt.setString(1, email);
       
        ResultSet rs = preparedStamnt.executeQuery();
        Map map = new HashMap();

        while (rs.next()) {

            for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                map.put(rs.getMetaData().getColumnName(i), (rs.getString(i) == null ? "" : rs.getString(i)));
            }

            preparedStamnt.close();

            return map;
        }
        preparedStamnt.close();

        return map;
    }

    public static void updateCampoPersonalizado(
            String campo_nome,
            int modulo_id, String data) throws Exception {

        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "update campos_personalizados set valor_campo = ? "
                + "where nome_campo = ? and modulo_id = ?;");

        preparedStamnt.setString(1, data);
        preparedStamnt.setString(2, campo_nome);
        preparedStamnt.setInt(3, modulo_id);

        preparedStamnt.executeUpdate();

    }
    
    public static void updatePerfil(
            String nome,
            String nome_compl, String email,int login_id) throws Exception {

        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "update logins set nome = ?, nome_compl = ?, email = ? "
                + "where login_id = ?;");

        preparedStamnt.setString(1, nome);
        preparedStamnt.setString(2, nome_compl);
        preparedStamnt.setString(3, email);
        preparedStamnt.setInt(4, login_id);

        preparedStamnt.executeUpdate();

    }

    public static Map validaLogin(
            String nome,
            int senha) throws Exception {

        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "select * from logins "
                + "where nome = ? and password = ?;");

        preparedStamnt.setString(1, nome);
        preparedStamnt.setInt(2, senha);
        ResultSet rs = preparedStamnt.executeQuery();
        Map map = new HashMap();

        while (rs.next()) {

            for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                map.put(rs.getMetaData().getColumnName(i), (rs.getString(i) == null ? "" : rs.getString(i)));
            }

            preparedStamnt.close();

            return map;
        }
        preparedStamnt.close();

        return map;
    }
    public static Map validaLogin(
            int login_id,
            int senha) throws Exception {

        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "select * from logins "
                + "where login_id = ? and password = ?;");

        preparedStamnt.setInt(1, login_id);
        preparedStamnt.setInt(2, senha);
        ResultSet rs = preparedStamnt.executeQuery();
        Map map = new HashMap();

        while (rs.next()) {

            for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                map.put(rs.getMetaData().getColumnName(i), (rs.getString(i) == null ? "" : rs.getString(i)));
            }

            preparedStamnt.close();

            return map;
        }
        preparedStamnt.close();

        return map;
    }

    public static void updateConfigClient(String cliente, int modulo_id, String texto) throws Exception {
        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "delete from config_esp_clientes where cliente_id = "
                + "(select cliente_id from clientes where codigo=?)"
                + " and modulo_id=?; "
                + "insert into config_esp_clientes (cliente_id,modulo_id,config) values((select cliente_id from clientes where codigo=?),?,?);");

        preparedStamnt.setString(1, cliente);
        preparedStamnt.setInt(2, modulo_id);
        preparedStamnt.setString(3, cliente);
        preparedStamnt.setInt(4, modulo_id);
        preparedStamnt.setString(5, texto);

        preparedStamnt.executeUpdate();
    }

    public static String selectConfigClient(String cliente, int modulo_id) throws Exception {

        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "select config from config_esp_clientes "
                + "where cliente_id = (select cliente_id from clientes where codigo = ?) and "
                + "modulo_id = ?");

        preparedStamnt.setString(1, cliente);
        preparedStamnt.setInt(2, modulo_id);

        ResultSet rs = preparedStamnt.executeQuery();
        StringBuilder stb = new StringBuilder();
        //cria strutura de dados em json
        stb.append("<xml version='2.0'><returnType>OK</returnType>");
        while (rs.next()) {

            for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                stb.append("<").append(rs.getMetaData().getColumnName(i)).append(">");
                stb.append(rs.getString(i) == null ? "" : rs.getString(i).replaceAll("<", "&lt;"));
                stb.append("</").append(rs.getMetaData().getColumnName(i)).append(">");
            }

            preparedStamnt.close();

            stb.append("</xml>");
            return stb.toString();
        }
        preparedStamnt.close();
        stb.append("</xml>");
        return stb.toString();
    }

    public static void newModulo(
            String nome,
            String servidor,
            String pasta,
            String arquivos,
            String config,
            String prerequisitos,
            String crontab,
            String psirc
    ) throws Exception {

        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "insert into modulos (nome,servidor,pasta,arquivos,config,prerequisitos,crontab,psirc)"
                + "values(?,?,?,?,?,?,?,?);");

        preparedStamnt.setString(1, nome);
        preparedStamnt.setString(2, servidor);
        preparedStamnt.setString(3, pasta);
        preparedStamnt.setString(4, arquivos);
        preparedStamnt.setString(5, config);
        preparedStamnt.setString(6, prerequisitos);
        preparedStamnt.setString(7, crontab);
        preparedStamnt.setString(8, psirc);
        preparedStamnt.execute();

    }

    public static void updateModulo(
            String nome,
            String servidor,
            String pasta,
            String arquivos,
            String config,
            String prerequisitos,
            String crontab,
            String psirc,
            int modulo_id) throws Exception {

        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "update modulos set nome = ?, servidor = ?,"
                + "pasta = ?, arquivos = ?, config = ?, "
                + "prerequisitos = ?, crontab = ?, psirc = ? "
                + "where modulo_id=?");

        preparedStamnt.setString(1, nome);
        preparedStamnt.setString(2, servidor);
        preparedStamnt.setString(3, pasta);
        preparedStamnt.setString(4, arquivos);
        preparedStamnt.setString(5, config);
        preparedStamnt.setString(6, prerequisitos);
        preparedStamnt.setString(7, crontab);
        preparedStamnt.setString(8, psirc);
        preparedStamnt.setInt(9, modulo_id);

        preparedStamnt.execute();

    }

    public static void updateModuloUpload(
            int modulo_id, String arquivo_nome, InputStream arquivo) throws Exception {

        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "insert into arquivos (modulo_id, arquivo_nome, arquivo_dados) "
                + "values (?,?,?);");

        preparedStamnt.setInt(1, modulo_id);
        preparedStamnt.setString(2, arquivo_nome);

        if (arquivo != null) {
            preparedStamnt.setBinaryStream(3, arquivo);
        }

        preparedStamnt.execute();

    }

    public static void updateModuloremover(
            int modulo_id, String arquivo) throws Exception {

        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "delete from arquivos where "
                + "modulo_id = ? and arquivo_nome = ?;");

        preparedStamnt.setInt(1, modulo_id);
        preparedStamnt.setString(2, arquivo);

        preparedStamnt.execute();

    }
    

    public static String selectCliente(String codigo) throws Exception {

        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "select * from clientes where codigo = ?");

        preparedStamnt.setString(1, codigo);

        ResultSet rs = preparedStamnt.executeQuery();

        while (rs.next()) {

            StringBuilder stb = new StringBuilder();
            //cria strutura de dados em json
            stb.append("{");
            stb.append("\"returnType\":\"OK\",");

            for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                stb.append("\"").append(rs.getMetaData().getColumnName(i)).append("\"");
                stb.append(":");
                stb.append("\"").append(rs.getString(i) == null ? "" : rs.getString(i)).append("\"");
                if (i != rs.getMetaData().getColumnCount()) {
                    stb.append(",");
                }
            }
            stb.append("}");
            return stb.toString();

        }

        preparedStamnt.close();
        throw new Exception("No results: selectCliente(String codigo) =" + codigo);
    }
    
    public static String selectLogin(int login_id) throws Exception {

        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "select login_id, nome, nome_compl, email"
                        + " from logins where login_id = ?");

        preparedStamnt.setInt(1, login_id);

        ResultSet rs = preparedStamnt.executeQuery();

        while (rs.next()) {

            StringBuilder stb = new StringBuilder();
            //cria strutura de dados em json
            stb.append("{");
            stb.append("\"returnType\":\"OK\",");

            for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                stb.append("\"").append(rs.getMetaData().getColumnName(i)).append("\"");
                stb.append(":");
                stb.append("\"").append(rs.getString(i) == null ? "" : rs.getString(i)).append("\"");
                if (i != rs.getMetaData().getColumnCount()) {
                    stb.append(",");
                }
            }
            stb.append("}");
            return stb.toString();

        }

        preparedStamnt.close();
        throw new Exception("No results: selectLogin(int login_id) =" + login_id);
    }

    public static String selectClientes() throws Exception {

        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "select codigo from clientes;");

        ResultSet rs = preparedStamnt.executeQuery();

        StringBuilder stb = new StringBuilder();
        //cria strutura de dados em json
        stb.append("{");
        stb.append("\"returnType\":\"OK\",");
        stb.append("\"").append(rs.getMetaData().getColumnName(1)).append("\"");
        stb.append(":[");
        while (rs.next()) {
            stb.append("\"").append(rs.getString(1) == null ? "" : rs.getString(1)).append("\"");
            if (!rs.isLast()) {
                stb.append(",");
            }
        }
        stb.append("]}");
        preparedStamnt.close();
        return stb.toString();
    }

    public static String selectModulos() throws Exception {

        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "select nome from modulos;");

        ResultSet rs = preparedStamnt.executeQuery();

        StringBuilder stb = new StringBuilder();
        //cria strutura de dados em json
        stb.append("{");
        stb.append("\"returnType\":\"OK\",");
        stb.append("\"").append(rs.getMetaData().getColumnName(1)).append("\"");
        stb.append(":[");
        while (rs.next()) {
            stb.append("\"").append(rs.getString(1) == null ? "" : rs.getString(1)).append("\"");
            if (!rs.isLast()) {
                stb.append(",");
            }
        }
        stb.append("]}");
        preparedStamnt.close();
        return stb.toString();
    }

    public static String selectModuloPorCliente(String codigo) throws Exception {

        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "select nome from modulos where modulo_id in "
                + "(select modulo_id from cliente_vs_modulo where cliente_id="
                + "(select cliente_id from clientes where codigo=?));");

        preparedStamnt.setString(1, codigo);

        ResultSet rs = preparedStamnt.executeQuery();

        StringBuilder stb = new StringBuilder();
        //cria strutura de dados em json
        stb.append("{");
        stb.append("\"returnType\":\"OK\",");
        stb.append("\"").append(rs.getMetaData().getColumnName(1)).append("\"");
        stb.append(":[");
        while (rs.next()) {
            stb.append("\"").append(rs.getString(1) == null ? "" : rs.getString(1)).append("\"");
            if (!rs.isLast()) {
                stb.append(",");
            }
        }
        stb.append("]}");
        preparedStamnt.close();
        return stb.toString();
    }

    public static String selectClientePorModulo(int modulo_id) throws Exception {

        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "select codigo from clientes where cliente_id in (select cliente_id from cliente_vs_modulo where modulo_id=?);");

        preparedStamnt.setInt(1, modulo_id);

        ResultSet rs = preparedStamnt.executeQuery();

        StringBuilder stb = new StringBuilder();
        //cria strutura de dados em json
        stb.append("{");
        stb.append("\"returnType\":\"OK\",");
        stb.append("\"").append(rs.getMetaData().getColumnName(1)).append("\"");
        stb.append(":[");
        while (rs.next()) {
            stb.append("\"").append(rs.getString(1) == null ? "" : rs.getString(1)).append("\"");
            if (!rs.isLast()) {
                stb.append(",");
            }
        }
        stb.append("]}");
        preparedStamnt.close();
        return stb.toString();
    }

    public static String selectClientePorModulo(String modulo_nome) throws Exception {

        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "select codigo from clientes where cliente_id in "
                + "(select cliente_id from cliente_vs_modulo where modulo_id="
                + "(select modulo_id from modulos where nome=?));");

        preparedStamnt.setString(1, modulo_nome);

        ResultSet rs = preparedStamnt.executeQuery();

        StringBuilder stb = new StringBuilder();
        //cria strutura de dados em json
        stb.append("{");
        stb.append("\"returnType\":\"OK\",");
        stb.append("\"").append(rs.getMetaData().getColumnName(1)).append("\"");
        stb.append(":[");
        while (rs.next()) {
            stb.append("\"").append(rs.getString(1) == null ? "" : rs.getString(1)).append("\"");
            if (!rs.isLast()) {
                stb.append(",");
            }
        }
        stb.append("]}");
        preparedStamnt.close();
        return stb.toString();
    }

    public static void deleteClienteFromModulo(String codigo, int modulo_id) throws Exception {

        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "delete from cliente_vs_modulo where cliente_id = "
                + "(select cliente_id from clientes where codigo=?)"
                + " and modulo_id=?;");

        preparedStamnt.setString(1, codigo);
        preparedStamnt.setInt(2, modulo_id);

        preparedStamnt.executeUpdate();

    }

    public static String selectModulo(String nome, String cliente) throws Exception {

        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "select modulo_id, servidor, pasta, arquivos, config,"
                + "prerequisitos, crontab, psirc"
                + " from modulos where nome = ?");

        preparedStamnt.setString(1, nome);

        ResultSet rs = preparedStamnt.executeQuery();

        while (rs.next()) {

            StringBuilder stb = new StringBuilder();
            //cria strutura de dados em json

            stb.append("<xml version='2.0'><returnType>OK</returnType>");
            for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                stb.append("<").append(rs.getMetaData().getColumnName(i)).append(">");
                stb.append(rs.getString(i) == null ? "" : rs.getString(i).replaceAll("<", "&lt;"));
                stb.append("</").append(rs.getMetaData().getColumnName(i)).append(">");
            }

            preparedStamnt = conn.prepareStatement(
                    "select nome_campo, valor_campo "
                    + "from campos_personalizados where modulo_id =?;");

            int modulo_id = rs.getInt("modulo_id");

            preparedStamnt.setInt(1, modulo_id);

            rs = preparedStamnt.executeQuery();

            while (rs.next()) {
                //cria strutura de dados em xml
                stb.append("<campos>");
                stb.append(rs.getString("nome_campo"));
                stb.append("</campos>");
                if (rs.getString("valor_campo") != null) {
                    stb.append("<data_").append(rs.getString("nome_campo")).append(">");
                    stb.append(rs.getString("valor_campo").replaceAll("<", "&lt;"));
                    stb.append("</data_").append(rs.getString("nome_campo")).append(">");
                }
            }

            preparedStamnt = conn.prepareStatement(
                    "select arquivo_nome from arquivos "
                    + "where modulo_id =?;");

            preparedStamnt.setInt(1, modulo_id);

            rs = preparedStamnt.executeQuery();

            while (rs.next()) {
                //cria strutura de dados em xml
                stb.append("<arquivos_anexados>");
                stb.append(rs.getString("arquivo_nome").replaceAll("<", "&lt;"));
                stb.append("</arquivos_anexados>");
            }

            if (!cliente.equals("")) {
                preparedStamnt = conn.prepareStatement(
                        "select config "
                        + "from config_esp_clientes where modulo_id =? "
                        + "and cliente_id = "
                        + "(select cliente_id from clientes where codigo = ?);");

                preparedStamnt.setInt(1, modulo_id);
                preparedStamnt.setString(2, cliente);

                rs = preparedStamnt.executeQuery();

                while (rs.next()) {
                    //cria strutura de dados em xml
                    stb.append("<config_cliente>");
                    stb.append(rs.getString("config").replaceAll("<", "&lt;"));
                    stb.append("</config_cliente>");
                }
            }

            preparedStamnt.close();

            stb.append("</xml>");
            return stb.toString();

        }
        preparedStamnt.close();

        throw new Exception("No results: selectModulo(String nome) =" + nome);
    }

    public static String selectCampoPersonalizados(int modulo_id) throws Exception {

        PreparedStatement preparedStamnt;
        preparedStamnt = conn.prepareStatement(
                "select nome_campo, valor_campo "
                + "from campos_personalizados where modulo_id =?;");

        preparedStamnt.setInt(1, modulo_id);

        ResultSet rs = preparedStamnt.executeQuery();
        StringBuilder stb = new StringBuilder();
        stb.append("<xml version='2.0'><returnType>OK</returnType>");

        while (rs.next()) {
            //cria strutura de dados em xml
            stb.append("<campos>");
            stb.append(rs.getString("nome_campo"));
            stb.append("</campos>");
            if (rs.getString("valor_campo") != null) {
                stb.append("<data_").append(rs.getString("nome_campo")).append(">");
                stb.append(rs.getString("valor_campo").replaceAll("<", "&lt;"));
                stb.append("</data_").append(rs.getString("nome_campo")).append(">");
            }
        }
        stb.append("</xml>");
        preparedStamnt.close();
        return stb.toString();
    }

    public static void updateClientesModulo(String[] codigos, int modulo_id) throws Exception {

        StringBuilder strb = new StringBuilder();
        for (String codigo : codigos) {
            strb.append("insert into cliente_vs_modulo(cliente_id, modulo_id) values ((select cliente_id from clientes where codigo=")
                    .append("'")
                    .append(codigo)
                    .append("'")
                    .append("),")
                    .append(modulo_id)
                    .append(");");
        }

        PreparedStatement preparedStamnt;

        preparedStamnt = conn.prepareStatement(
                "delete from cliente_vs_modulo where modulo_id=?;"
                + strb.toString());

        preparedStamnt.setInt(1, modulo_id);

        preparedStamnt.executeUpdate();

        preparedStamnt.close();

    }

    public static void connect(dataBaseType type, String server, String Port, String dataBase,
            String User, String Password) throws ClassNotFoundException, SQLException {
        String URL = "";

        try {

            switch (type) {
                case JavaDB:
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    URL = URL + "jdbc:derby://";
                    break;
                case mySql:
                    Class.forName("com.mysql.jdbc.Driver");
                    URL = URL + "jdbc:mysql://";
                    break;
                case Postgres:
                    Class.forName("org.postgresql.Driver");
                    URL = URL + "jdbc:postgresql://";
                    break;
                default:
                    throw new AssertionError(type.name());

            }

            URL = URL.concat(server + ":" + Port + "/" + dataBase);

            conn = DriverManager.getConnection(URL, User, Password);

        } catch (ClassNotFoundException | SQLException ex) {
            throw ex;
        }

    }

    public static List<String> consultaClientesTodos() throws SQLException, ClassNotFoundException {

        PreparedStatement preparedStamnt = null;
        try {

            preparedStamnt = conn.prepareStatement("select codigo from "
                    + "clientes");

            ResultSet rs = preparedStamnt.executeQuery();
            if (rs.next()) {

                List<String> data = new ArrayList<>();

                data.add(rs.getString(1));

                while (rs.next()) {
                    data.add(rs.getString(1));
                }

                preparedStamnt.close();
                return data;

            } else {

                throw new SQLException("dados Inexistente");

            }
        } catch (SQLException ex) {

            throw ex;

        }
    }

    public static List<String> consultaModulosTodos() throws SQLException, ClassNotFoundException {

        PreparedStatement preparedStamnt = null;
        try {

            preparedStamnt = conn.prepareStatement("select nome from "
                    + "modulos");

            ResultSet rs = preparedStamnt.executeQuery();
            if (rs.next()) {

                List<String> data = new ArrayList<>();

                data.add(rs.getString(1));

                while (rs.next()) {
                    data.add(rs.getString(1));
                }

                preparedStamnt.close();
                return data;

            } else {

                throw new SQLException("dados Inexistente");

            }
        } catch (SQLException ex) {

            throw ex;

        }
    }

    public static void RunSqlScript_updateDatabase(dataBaseType databseType, File file, File logFile,
            String host, String port, String username, String password) throws Exception {
        Connection con = null;
        if (databseType == dataBaseType.mySql) {
            // Create MySql Connection
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(
                    "jdbc:mysql://" + host + ":" + port + "/", username, password);
        } else if (databseType == dataBaseType.Postgres) {
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection(
                    "jdbc:postgresql://" + host + ":" + port + "/clients_info", username, password);
        }

        PrintWriter pt = new PrintWriter(logFile), ptr = new PrintWriter(logFile);
        // Initialize object for ScripRunner
        ScriptRunner sr = new ScriptRunner(con, false, false);
        // Give the input file to Reader
        Reader reader = new BufferedReader(
                new FileReader(file));

        sr.setLogWriter(pt);
        sr.setErrorLogWriter(ptr);

        // Exctute script
        sr.runScript(reader);

    }

    public static void RunSqlScript(dataBaseType databseType, File file, File logFile,
            String host, String port, String username, String password) throws Exception {
        Connection con = null;
        if (databseType == dataBaseType.mySql) {
            // Create MySql Connection
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(
                    "jdbc:mysql://" + host + ":" + port + "/", username, password);
        } else if (databseType == dataBaseType.Postgres) {
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection(
                    "jdbc:postgresql://" + host + ":" + port + "/", username, password);
            PreparedStatement preparedStamnt = null;
            preparedStamnt = con.prepareStatement("CREATE DATABASE clients_info;");
            preparedStamnt.execute();
            con.close();
            con = DriverManager.getConnection(
                    "jdbc:postgresql://" + host + ":" + port + "/clients_info", username, password);

        }

        PrintWriter pt = new PrintWriter(logFile), ptr = new PrintWriter(logFile);
        // Initialize object for ScripRunner
        ScriptRunner sr = new ScriptRunner(con, false, false);
        // Give the input file to Reader
        Reader reader = new BufferedReader(
                new FileReader(file));

        sr.setLogWriter(pt);
        sr.setErrorLogWriter(ptr);

        // Exctute script
        sr.runScript(reader);

    }

    static public dataBaseType getDataBaseType(File filestream) throws Exception {
        Properties configFile;
        databaseConectivity.dataBaseType tipoBase = null;
        try {
            configFile = new Properties();
            FileInputStream inFile = new FileInputStream(filestream);

            if (filestream.exists()) {
                configFile.load(inFile);//Read from WEB-INF/classes folder

                if (!configFile.getProperty("configok").equals("true")) {
                    inFile.close();
                    throw new Exception("Config File Not Ok");
                }
                if (configFile.getProperty("databasetype") != null) {
                    if (configFile.getProperty("databasetype").contains("postgres")) {
                        tipoBase = databaseConectivity.dataBaseType.Postgres;
                    } else if (configFile.getProperty("databasetype").contains("mysql")) {
                        tipoBase = databaseConectivity.dataBaseType.mySql;
                    } else {
                        inFile.close();
                        throw new Exception("Unkown database Type " + configFile.getProperty("databasetype"));
                    }
                } else {
                    throw new Exception("Null database Type ");
                }
                inFile.close();

            } else { //if not goto cofig page
                throw new Exception("Config File Doesn\'t existes.");
            }

        } catch (Exception e) {
            throw new Exception("Unkown Error: " + e.getMessage());
        }
        return tipoBase;
    }

}
