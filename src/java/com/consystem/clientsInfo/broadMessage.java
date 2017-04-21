/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.consystem.clientsInfo;

/**
 *
 * @author david_000
 */
public class broadMessage {

    public static String messageString;
    public static messageType messageType;
    public static boolean isMessage = false;

    public static void createMessage(String message, messageType type) {
        messageString = message;
        isMessage = true;
        messageType = type;
    }

    public static String postMessage() {
        isMessage = false;
       
        return "<div id=\"defaultmessage\" class=\"alert " + getMessageClassType() + "\" role=\"alert\">"
                + messageString
                + "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">"
                + "<span aria-hidden=\"true\">&times;</span>"
                + "</button></div>" + (messageType == messageType.successMessage ? "<script>autoDismissAlert();</script>" : "");
    }
    
    public static String postMessage(boolean autoDismiss) {
        isMessage = false;
       
        return "<div id=\"defaultmessage\" class=\"alert " + getMessageClassType() + "\" role=\"alert\">"
                + messageString
                + "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">"
                + "<span aria-hidden=\"true\">&times;</span>"
                + "</button></div>" + (autoDismiss ? "<script>autoDismissAlert();</script>" : "");
    }

    private static String getMessageClassType() {
        switch (messageType) {
            case errorMessage:
                return "alert-danger";
            case successMessage:
                return "alert-success";
            case noMessage:
                return "";
            default:
                throw new AssertionError(messageType.name());

        }
    }
}
