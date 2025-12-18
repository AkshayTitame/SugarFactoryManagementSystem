package com.sms;

import java.io.IOException;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SendSMS {

    private static final Logger LOGGER = Logger.getLogger(SendSMS.class.getName());
    private static final String API_KEY = "ZDJkNWQwZmNhY2E3MzI5NTRmM2MzOTg1NmM2YzRhYzQ=";
    private static final String SENDER = "TXTLCL";
    private static final String API_URL = "https://api.textlocal.in/send/";

    private final HttpClient httpClient;

    public SendSMS() {
        this.httpClient = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(10))
                .build();
    }

    /**
     * Sends SMS to the specified mobile number.
     * @param mobile Recipient mobile number
     * @param message Message to send
     * @return Response from SMS API
     */
    public String sendSms(String mobile, String message) {
        try {
            String encodedMessage = URLEncoder.encode(message, StandardCharsets.UTF_8);
            String url = API_URL +
                    "?apikey=" + URLEncoder.encode(API_KEY, StandardCharsets.UTF_8) +
                    "&numbers=" + URLEncoder.encode(mobile, StandardCharsets.UTF_8) +
                    "&sender=" + URLEncoder.encode(SENDER, StandardCharsets.UTF_8) +
                    "&message=" + encodedMessage;

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .timeout(Duration.ofSeconds(10))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            LOGGER.info("SMS sent to " + mobile + " | Status: " + response.statusCode());
            return response.body();

        } catch (IOException | InterruptedException e) {
            LOGGER.log(Level.SEVERE, "Failed to send SMS to " + mobile, e);
            Thread.currentThread().interrupt(); // restore interrupted state
            return "Error: " + e.getMessage();
        }
    }

    /**
     * Encodes message in custom hex format (if needed).
     */
    public String encodeMessage(String message) {
        StringBuilder newMessage = new StringBuilder("@U");
        for (char c : message.toCharArray()) {
            newMessage.append(String.format("%04x", (int) c));
        }
        return newMessage.toString();
    }
}
