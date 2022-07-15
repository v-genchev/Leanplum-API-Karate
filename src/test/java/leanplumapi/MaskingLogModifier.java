package leanplumapi;

import com.intuit.karate.http.HttpLogModifier;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class MaskingLogModifier implements HttpLogModifier {
    @Override
    public boolean enableForUri(String s) {
        return true;
    }

    @Override
    public String uri(String uri) {
        String pattern = ".*?((?:clientKey|appId)=(.*?)(&|$))";
        return escape(uri, pattern);
    }

    @Override
    public String header(String header, String value) {
        if (header.toLowerCase().contains("xss-protection")) {
            return "***";
        }
        return value;
    }

    @Override
    public String request(String uri, String request) {

        String pattern = (".*?(\"(?:clientKey|appId)\":(.*?)(?:,|$))");
        return escape(request, pattern);
    }

    @Override
    public String response(String uri, String response) {
        return response;
    }

    private String escape(String stringToEscape, String pattern){
        Pattern escapePattern = Pattern.compile(pattern);
        Matcher matcher = escapePattern.matcher(stringToEscape);
        while(matcher.find()){
            String valueToEscape = matcher.group(2);
            stringToEscape = stringToEscape.replace(valueToEscape, "***");
        }
        return stringToEscape;
    }
}
