<%--
    Document   : login
    Created on : 15/08/2011, 04:45:10 PM
    Author     : ISC Cesar Martinez poseidon24@hotmail.com
--%>


<%@page import="java.util.Calendar"%>
<%@page import="com.tsp.gespro.jdbc.UsuariosDaoImpl"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.tsp.gespro.util.DateManage"%>
<%@page import="java.util.Date"%>
<%@page import="com.tsp.gespro.bo.AccionBitacoraBO"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="intentosFallidos" scope="session" class="java.lang.String"/>
<jsp:useBean id="user" scope="session" class="com.tsp.gespro.bo.UsuarioBO"/>

<% 

    String login="";
    String pwd = "";
    String mensajeUsuario = "";

    String urlRedir ="main.jsp";

    int intentosFallidosInt = 0;
    
    try {
        intentosFallidosInt = Integer.parseInt(intentosFallidos);
    }
    catch (Exception e) {
        intentosFallidos = "0";
        intentosFallidosInt = 0;
    }


    String action = request.getParameter("action")==null?"":request.getParameter("action");

    if(action.trim().equalsIgnoreCase("loginRequired")){
        urlRedir = request.getParameter("urlSource")==null?urlRedir:request.getParameter("urlSource");
    }

 
    if (action.trim().equalsIgnoreCase("logout")) {
        if (user!=null && user.getUser()!=null){
            AccionBitacoraBO accionBitacora = new AccionBitacoraBO(user.getConn());
            accionBitacora.insertAccionLogout(user.getUser().getIdUsuarios(), "");
            
            try{
                //actualizamos la bandera del cierre de sesion para que quede una sesion libre de acceso de usuario
                user.getUser().setLogin((short)0);
                new UsuariosDaoImpl(user.getConn()).update(user.getUser().createPk(), user.getUser());
            }catch(Exception e){}
        }
        
        request.getSession().setAttribute("user", null);
        user=null;
        //mensajeUsuario="<script>apprise('<center><img src=../../images/candado.png> <br/>Sesión finalizada. <br/>Que tengas un excelente día, vuelve pronto!</center>',{'animate':true});</script>";
        mensajeUsuario = "<script> $('#login_info').css('display', 'block');</script> <center>Sesión finalizada.</center>";
    }else if (action.trim().equalsIgnoreCase("logoutInactiveSession")) {
        if (user!=null && user.getUser()!=null){
            AccionBitacoraBO accionBitacora = new AccionBitacoraBO(user.getConn());
            accionBitacora.insertAccionLogout(user.getUser().getIdUsuarios(), "Cierre de sesión automática por inactividad del usuario.");
            
            
        }
        
            try{
                //actualizamos la bandera del cierre de sesion para que quede una sesion libre de acceso de usuario
                user.getUser().setLogin((short)0);
                new UsuariosDaoImpl(user.getConn()).update(user.getUser().createPk(), user.getUser());
            }catch(Exception e){}

        request.getSession().setAttribute("user", null);
        user=null;
        
        //mensajeUsuario="<script>apprise('<center><img src=../../images/candado.png> <br/>Sesión finalizada por inactividad del usuario.</center>',{'animate':true});</script>";
        mensajeUsuario = "<script> $('#login_info').css('display', 'block');</script> <center>Sesión finalizada por inactividad del usuario.</center>";
    }
    else if (request.getParameter("username")!=null) {
        login = request.getParameter("username")==null?"":request.getParameter("username");
        pwd = request.getParameter("password")==null?"":request.getParameter("password");
 
               
        //Validamos el Login
        try{

            if (user.loginConsola(login, pwd)) {
                AccionBitacoraBO accionBitacora = new AccionBitacoraBO(user.getConn());
                accionBitacora.insertAccionLogin(user.getUser().getIdUsuarios(), "");

                request.getSession().setAttribute("user", user);
                
                //de ser que existe validamos el tiempo 
                Calendar c = Calendar.getInstance();
                c.add(Calendar.HOUR, -1);//hace una hora era
                Date date = c.getTime();
                //if(date.after(user.getFechaAccesoAnterior())){
                
                //validamos que solo exista una sola sesion activa de usuario y si existe por no salir bien validamos por tiempo
                if(user.getUser().getLogin() == (short)0 || date.after(user.getFechaAccesoAnterior())){
                    //actualizamos el valor de  login, de que entro una sesion activa de usuario
                    user.getUser().setLogin((short)1);
                    user.getUser().setFechaUltimoAcceso(new Date());                        
                    new UsuariosDaoImpl(user.getConn()).update(user.getUser().createPk(), user.getUser());
                    response.sendRedirect(urlRedir);                    
                }else{
                    mensajeUsuario = "<script> $('#login_info').css('display', 'block');</script> El usuario ya esta logeado, no es posible ingresar 2 veces con el mismo usuario";                    
                }
                
            }else{
                //mensajeUsuario = "<script>apprise('Usuario o contraseña inválidos',{'animate':true}); $('username').focus();</script>";
                mensajeUsuario = "<script> $('#login_info').css('display', 'block');</script> Usuario o contraseña inválidos";
            }            
            
            
       }catch(Exception ex){
            mensajeUsuario = "<script> $('#login_info').css('display', 'block');</script> " + ex.getMessage();
       }
        
     }
 
    
        
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="shortcut icon" href="../../images/favicon.ico">
    
    <title><jsp:include page="../../jsp/include/titleApp.jsp" /></title>
    <jsp:include page="../include/keyWordSEO.jsp" />

    <jsp:include page="../../jsp/include/skinCSS_login.jsp" />

    <jsp:include page="../../jsp/include/jsFunctions.jsp" />
    
    <link href="../../css/login/login_gespro.css" rel="stylesheet" type="text/css" media="all"/>
    <link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>

    <script type="text/javascript" charset="utf-8"> 
        $(function(){ 
            // find all the input elements with title attributes
            $('input[title!=""]').hint();
            $('#login_info').click(function(){
                        $(this).fadeOut('fast');
                });
        });
        
        function submitFormulario(){
            $('#login_info').click(function(){
                        $(this).fadeOut('fast');
                });
            $('#form_login').submit();
        }
        
    </script>
    <!---->
    <!--<script language="javascript" type="text/javascript">
        $(document).ready(function(){ $(":input:first").focus(); });
    </script>-->
    <!---->

</head>
<body class="login">
    <!--<div id="adholder">
         <div id="adinner">
           <div class="adright"></div>
        </div>
    </div>-->
  <div id="envolvente1" >
  <div>
    <!-- Inicio de ventana de login -->

<div align="center" id="login_wrapper">
            <div id="login_info" class="alert_warning noshadow" 
                 style="width:350px;margin:0;padding:auto; display: none;">
                <p><%=mensajeUsuario%></p>
            </div>
            <br class="clear"/>
            <div id="login_top_window">
                <div class="loginLinePretoriano">&nbsp;</div>
            </div>

            <!-- Inicio de contenido -->
            <div id="login_body_window">
                    <div class="inner">
                      <div id="logo_gespro_02" style="text-align:center; display:none">
                      <img src="images/login/gespro_logo.png"  alt="" width="30%" height="30%" /> 
          			  </div>
                            <form action="login.jsp?<%out.print((request.getQueryString()!=null)&&(!action.trim().equalsIgnoreCase("logout") && !action.trim().equalsIgnoreCase("logoutInactiveSession"))?request.getQueryString():"action=login");%>" method="post" id="form_login" name="form_login">
                                    <p>
                                        <input type="text" id="username" name="username" style="width:285px" title="Usuario"/>
                                    </p>
                                    <p>
                                        <input type="password" id="password" name="password" style="width:270px" title="******"/>
                                   
                                        <!--<input type="submit" id="submit" name="submit" value="Entrar" class="Login" style="margin-right:15px"/>-->
                                        <div id="login_submit_text">
                                            <a href="#" onclick="submitFormulario();" class="forgot_pass">Entrar</a>
                                        </div>
                                    </p>
                                     </p>
                                    &nbsp;&nbsp;&nbsp;<a href="../inicio/restorePassword.jsp" class="forgot_pass">Olvide mi Contraseña</a>
                                    <p>
                            </form>
                    </div>
            </div>
            <!-- FIN de contenido -->
            <div id="login_footer_window">
                <div class="loginLinePretoriano">&nbsp;</div>
            </div>
            <div id="login_right_bg">
                &nbsp;
            </div>
    </div>
     <!-- FIN de ventana de login --> 
    
    <!--coliseo-->
    <div style="display:inline-block; width:45%" id="gespro_01">
                <img src="../../images/login/gespro_logo.png" width="70%" height="70%" />
                </div>

    <!--coliseo-->
            </div>
            </div>
</body>
</html>