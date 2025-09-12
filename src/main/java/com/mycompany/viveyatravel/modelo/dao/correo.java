package com.mycompany.viveyatravel.modelo.dao;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class correo {
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SMTP_USERNAME = "yhullianaguerrero@gmail.com"; // Reemplaza con tu email
    private static final String SMTP_PASSWORD = "kuuk mfzv hahw xssc"; // Reemplaza con la contraseña de aplicación generada

    public static void enviarCorreoBienvenida(String toEmail, String nombre) {
    Properties props = new Properties();
    props.put("mail.smtp.host", SMTP_HOST);
    props.put("mail.smtp.port", SMTP_PORT);
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true");
    
    // Activar registros de depuración
    props.put("mail.debug", "true");

    Session session = Session.getInstance(props, new Authenticator() {
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(SMTP_USERNAME, SMTP_PASSWORD);
        }
    });

    try {
        // Crear un objeto MimeMessage
        Message message = new MimeMessage(session);
        
        // Configurar el remitente y el destinatario
        message.setFrom(new InternetAddress(SMTP_USERNAME));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        
        // Configurar el asunto y el contenido del mensaje
        message.setSubject("¡Bienvenido a la agencia de viaje Vive Ya Travel!");
        String emailContent = "Hola " + nombre + ",\n\n" +
                "Gracias por registrarte en ViveYaTravel. Estamos encantados de tenerte con nosotros.\n\n" +
                "Saludos cordiales,\n" +
                "El equipo de ViveYaTravel";
        message.setText(emailContent);

        // Enviar el mensaje
        Transport.send(message);
        
        // Mensaje de registro para confirmar el envío exitoso
        System.out.println("Correo de bienvenida enviado exitosamente");

    } catch (MessagingException e) {
        // Manejo de excepciones: imprimir la traza de la excepción
        e.printStackTrace();
    }
}

    
    
    
}


