import org.mindrot.jbcrypt.BCrypt;

import java.security.SecureRandom;
import java.io.*;

// Mr Meads is a static class with security related methods and logging to be used by servlets :D

public class MrMeads {

    //generates a n length random string to be used as CSRF token or State_Param
    public static String randomString(int length) {
        String list = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        String randomString = "";
        SecureRandom secureRandom = new SecureRandom();

        for (int i = 0; i < length; i++) {
            int random = (secureRandom.nextInt(61));
            randomString += list.charAt(random);
        }

        return randomString;
    }

    public static String hashString(String string) {
        return BCrypt.hashpw(string, BCrypt.gensalt(15));
    }

    public static boolean checkPassword(String password, String hash) {
        return BCrypt.checkpw(password, hash);
    }


}
