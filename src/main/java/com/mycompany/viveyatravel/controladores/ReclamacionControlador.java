package com.mycompany.viveyatravel.controladores;

import com.mycompany.viveyatravel.modelo.dto.Reclamacion;
import com.mycompany.viveyatravel.modelo.dao.ReclamacionDAO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ReclamacionController", urlPatterns = {"/reclamaciones"})
public class ReclamacionControlador extends HttpServlet {

    private ReclamacionDAO dao;

    @Override
    public void init() throws ServletException {
        dao = new ReclamacionDAO(); // tu clase DAO que maneja BD

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String vista = request.getParameter("vista");

        if ("admin".equals(vista)) {
            //List<Reclamacion> lista = dao.obtenerTodos();
            ReclamacionDAO rdao = new ReclamacionDAO();
            List<Reclamacion> lista = new ArrayList();
            lista = rdao.obtenerTodos();
            request.setAttribute("lista", lista);
            request.getRequestDispatcher("vista/ADMIReclamaciones.jsp").forward(request, response);
        } else {
            // usuario normal (libro de reclamaciones)
            String exito = request.getParameter("exito");
            if ("true".equals(exito)) {
                request.setAttribute("mensaje", "Reclamo registrado correctamente");
            }
            request.getRequestDispatcher("vista/libroReclamaciones.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Se recibió POST en /reclamaciones");

        // Acción: registrar un nuevo reclamo en el Libro de Reclamaciones
        String nombre = request.getParameter("nombre");
        String dni = request.getParameter("dni");
        String direccion = request.getParameter("direccion");
        String distrito = request.getParameter("distrito");
        String telefono = request.getParameter("telefono");
        String email = request.getParameter("email");
        String tipoBien = request.getParameter("tipo_bien");
        String descripcionBien = request.getParameter("descripcion_bien");
        String tipoReclamo = request.getParameter("tipo_reclamo");
        String detalleReclamo = request.getParameter("detalle_reclamo");

        Reclamacion r = new Reclamacion();
        r.setNombre(nombre);
        r.setDni(dni);
        r.setDireccion(direccion);
        r.setDistrito(distrito);
        r.setTelefono(telefono);
        r.setEmail(email);
        r.setTipoBien(tipoBien);
        r.setDescripcionBien(descripcionBien);
        r.setTipoReclamo(tipoReclamo);
        r.setDetalleReclamo(detalleReclamo);

        dao.insertar(r);

        // Mensaje de confirmación
        //request.setAttribute("mensaje", "Reclamo registrado correctamente");
        // Volvemos a cargar la vista con el mensaje
        //List<Reclamacion> lista = dao.obtenerTodos();
        //request.setAttribute("lista", lista);
        //request.getRequestDispatcher("vista/libroReclamaciones.jsp").forward(request, response);
        // ✅ Redirigir al servlet con parámetro de éxito (evita recargar mal el JSP)
        response.sendRedirect(request.getContextPath() + "/reclamaciones?exito=true");

    }
}
