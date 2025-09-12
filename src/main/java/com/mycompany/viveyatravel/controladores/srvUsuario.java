package com.mycompany.viveyatravel.controladores;

import com.mycompany.viveyatravel.modelo.dao.usuarioDAO;
import com.mycompany.viveyatravel.modelo.dto.usuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class srvUsuario extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String accion = request.getParameter("accion"); //Se obtiene el valor del parametro accion
        try {
            if(accion != null){
                switch (accion){ //Evalua el valor de la accion
                    case "verificar": 
                        verificar(request, response); //Llama al metodo verificar
                        break;
                    case "cerrar":
                        cerrarSesion(request, response); //Llama al metodo cerrar
                        break;
                    default:
                        response.sendRedirect("/vista/iniciarSesion"); //Por defecto, si no es ni verificar ni cerrar
                }
            } else {
                response.sendRedirect("/vista/iniciarSesion"); 
            }
        } catch (Exception e) { //Manejo de exepciones
            try {
                this.getServletConfig().getServletContext().getRequestDispatcher("/vista/mensaje.jsp").forward(request, response);
                
            } catch (Exception ex) {
                System.out.println("Error" + ex.getMessage());
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void verificar(HttpServletRequest request, HttpServletResponse response) throws Exception{
        HttpSession sesion;
        usuarioDAO dao;
        usuario usuario;
        usuario = this.obtenerUsuario(request);  //llama al metodo obtener usuario
        dao = new usuarioDAO();
        usuario = dao.identificar(usuario); //Verificar las credenciales con el metodo identificar que esta en la clase usuarioDAO
        if(usuario != null && usuario.getCargo().getNombreCargo().equals("administrador")){ //Si el cargo es administrador
            sesion = request.getSession(); //Crea una sesion
            sesion.setAttribute("admin", usuario);
            request.setAttribute("mensaje", "Bienvenido");
            this.getServletConfig().getServletContext().getRequestDispatcher("/vista/ADMIndex.jsp").forward(request, response);  //Redirecciona la vista del administrador
        } else if(usuario != null && usuario.getCargo().getNombreCargo().equals("cliente")){ //Si el cargo es cliente
            sesion = request.getSession();
            sesion.setAttribute("cliente", usuario);
            this.getServletConfig().getServletContext().getRequestDispatcher("/vista/index.jsp").forward(request, response); //Redirecciona a la vista de cliente
        } else{
            request.setAttribute("msjeCredenciales", "Credenciales incorrectas");  //Si las credenciales son incorrectas
            request.getRequestDispatcher("./vista/iniciarSesion.jsp").forward(request, response); //Redirecciona a la pagina de inicio
        }
        
    }

    private void cerrarSesion(HttpServletRequest request, HttpServletResponse response) throws Exception{
        HttpSession sesion = request.getSession();
        sesion.setAttribute("usuario", null); //Cierra la sesion y redirecciona a la vista Iniciar sesion
        sesion.invalidate();
        response.sendRedirect("./vista/iniciarSesion.jsp");
    }

    private usuario obtenerUsuario(HttpServletRequest request) {
        usuario u = new usuario(); //Crea el objeto usuario
        //Establece su correo electronico y la clave
        u.setCorreoElectronico(request.getParameter("correo"));   //nombre que tiene en el input de la vista iniciarSesion
        u.setClave(request.getParameter("clave"));
        return u;
    }
}