package com.mycompany.viveyatravel.modelo.dao;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class correoClave {

    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SMTP_USERNAME = "yhullianaguerrero@gmail.com"; // Reemplaza con tu email
    private static final String SMTP_PASSWORD = "kuuk mfzv hahw xssc"; // Reemplaza con la contraseña de aplicación generada

    public static void enviarCorreoClave(String toEmail, String nombre) {

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
            Message msg = new MimeMessage(session);

            // Configurar el remitente y el destinatario
            msg.setFrom(new InternetAddress(SMTP_USERNAME));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));

            // Configurar el asunto y el contenido del mensaje
            msg.setSubject("Restablecer su contraseña");
            String enlace = "http://localhost:8080/ViveYaTravel/vista/recuperarClave?correo=" + toEmail;
            /*String emailContent = "Hola " + nombre + ",\n\n"
                    + "Alguien ha solicitado recientemente que se restablezca la contraseña.\n\n"
                    + " Haz clic en el siguiente enlace para continuar: \n"
                    + enlace + "\n\n"
                    + "Si esto fue un error, ignora este correo.";
            msg.setText(emailContent); */

            String emailContent = "<!DOCTYPE html>"
                    + "<html>"
                    + "<body style='font-family: Arial, sans-serif; line-height:1.6;'>"
                    + "<h2>Hola " + nombre + ",</h2>"
                    + "<p>Alguien ha solicitado recientemente restablecer tu contraseña.</p>"
                    + "<p>Haz clic en el siguiente botón para continuar:</p>"
                    + "<a href='" + enlace + "' "
                    + "style='display:inline-block; padding:10px 20px; margin:10px 0; "
                    + "font-size:16px; color:#fff; background-color:#28a745; text-decoration:none; "
                    + "border-radius:5px;'>"
                    + "Restablecer contraseña</a>"
                    + "<p style='margin-top:20px; font-size:12px; color:#555;'>"
                    + "Si no solicitaste este cambio, ignora este correo.</p>"
                    + "</body></html>";

// Decirle a JavaMail que es HTML
            msg.setContent(emailContent, "text/html; charset=UTF-8");

            // Enviar el mensaje
            Transport.send(msg);

            // Mensaje de registro para confirmar el envío exitoso
            System.out.println("Correo de cambio de contraseña exito");

        } catch (MessagingException e) {
            // Manejo de excepciones: imprimir la traza de la excepción
            e.printStackTrace();
        }
    }
}
