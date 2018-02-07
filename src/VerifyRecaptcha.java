import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.URL;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonReader;
import javax.net.ssl.HttpsURLConnection;
/**
 * Created by Mengjie
 * Date : 2018/1/31
 * Time : 16:07
 **/


public class VerifyRecaptcha {

    public static final String url = "https://www.google.com/recaptcha/api/siteverify";

//    //this is for local host
//    public static final String secret = "6Lcm70MUAAAAAACdrHaIDupGxaTx42JOwTZubiVn";

    //this is for sporadic
    public static final String secret = "6LfS8UMUAAAAAKGHuY1p1voSxu1vPvWSeu4KcvKN";

    private final static String USER_AGENT = "Mozilla/5.0";

    static boolean verify(String gRecaptchaResponse) throws IOException {

        if (gRecaptchaResponse == null || "".equals(gRecaptchaResponse)) {
            return false;
        }

        try{
            URL obj = new URL(url);
            HttpsURLConnection connection = (HttpsURLConnection) obj.openConnection();

            // add request header
            connection.setRequestMethod("POST");
            connection.setRequestProperty("User-Agent", USER_AGENT);
            connection.setRequestProperty("Accept-Language", "en-US,en;q=0.5");

            String postParams = "secret=" + secret + "&response=" + gRecaptchaResponse;

            // Send post request
            connection.setDoOutput(true);
            DataOutputStream outputStream = new DataOutputStream(connection.getOutputStream());
            outputStream.writeBytes(postParams);
            outputStream.flush();
            outputStream.close();

            int responseCode = connection.getResponseCode();
            System.out.println("VerifyRecaptcha enter line 49 Sending 'POST' request to URL : " + url);
            System.out.println("VerifyRecaptcha enter line 50 Post parameters : " + postParams);
            System.out.println("VerifyRecaptcha enter line 51 Response Code : " + responseCode);

            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();

            while ((inputLine = bufferedReader.readLine()) != null) {
                response.append(inputLine);
            }

            bufferedReader.close();

            // print result
            System.out.println("VerifyRecaptcha enter line 64" + response.toString());

            // parse JSON response and return 'success' value
            JsonReader jsonReader = Json.createReader(new StringReader(response.toString()));
            JsonObject jsonObject = jsonReader.readObject();
            jsonReader.close();

            return jsonObject.getBoolean("success");
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
    }
}