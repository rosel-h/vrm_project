import org.mindrot.jbcrypt.BCrypt;
import java.security.SecureRandom;

//// contains security related methods for site
public class Security {

    //generates a 30 length random string to be used as StateParam
    public static String randomString(int length) {
        String list = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        String randomString = "";
        SecureRandom secureRandom = new SecureRandom();

        for (int i = 0; i < length; i++) {
            int random = (secureRandom.nextInt(61));
            randomString += list.charAt(random);
        }

        System.out.println("random string is " + randomString);
        return randomString;
    }

    public String hashString(String string) {
        return BCrypt.hashpw(string, BCrypt.gensalt(15));
    }

    public boolean checkPassword(String password, String hash) {

        return BCrypt.checkpw(password, hash);
    }


}
