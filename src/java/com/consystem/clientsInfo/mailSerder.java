/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.consystem.clientsInfo;

import java.util.Properties;
import javax.mail.PasswordAuthentication;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/*
 * @author david
 */
public class mailSerder implements Runnable {

    protected String to, subject, body;

    public static void sendEmail(String to, String subject, String body) throws RuntimeException {

        mailSerder mail = new mailSerder();
        mail.to = to;
        mail.subject = subject;
        mail.body = body;

        Thread enviaThread = new Thread(mail);
        enviaThread.start();

    }

    @Override
    public void run() {

        final String username = "dicazaemail@gmail.com";
        final String password = "dicaza#1987";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session;
        session = Session.getInstance(props, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("dicazaemail@gmail.com"));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(body);

            Transport.send(message);

        } catch (MessagingException ex) {
            throw new RuntimeException(ex);
        }
    }

    public static void testEmail(String host, String port, boolean tsl,
            String senderMail, String password, String to, String subject, String body) throws RuntimeException {

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", Boolean.toString(tsl));
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);

        Session session;
        session = Session.getInstance(props, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderMail, password);
            }
        });

        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderMail));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(body);

            Transport.send(message);

        } catch (MessagingException ex) {
            throw new RuntimeException(ex);
        }

    }

}
