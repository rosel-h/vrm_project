import DAO_setup.MYSQLDatabase;
import DAO_setup.UserDAO;
import com.mysql.fabric.xmlrpc.base.Array;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.JSONException;
import org.json.simple.JSONObject;
import org.json.JSONTokener;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.*;
import java.util.*;
import java.util.List;

/**
 * Created by mshe666 on 23/01/2018.
 */
public class SignUpServlet extends HttpServlet {
    //this is for local host
    private static final String SECRET_KEY = "6Lcm70MUAAAAAACdrHaIDupGxaTx42JOwTZubiVn";
    //this is for sporadic
//    private static final String SECRET_KEY = "6LfS8UMUAAAAAKGHuY1p1voSxu1vPvWSeu4KcvKN";
    private static final String SECRET_PARAM = "secret";
    private static final String RESPONSE_PARAM = "response";
    private static final String G_RECAPTCHA_RESPONSE = "g-recaptcha-response";
    private static final String SITE_VERIFY_URL = "https://www.google.com/recaptcha/api/siteverify";


    public void createUser(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException, ServletException, JSONException {
        System.out.println("SignUpServlet enter sign up servlet");

        String gRecaptchaResponse = req.getParameter("g-recaptcha-response");
        System.out.println("g-recaptcha-response=" + gRecaptchaResponse);
        boolean verify = VerifyRecaptcha.verify(gRecaptchaResponse);

        System.out.println("SignUpServlet enter line 57: verify=" + verify);

        if (!verify) {
            req.setAttribute("recaptchaError", "You are a ROBOT!");
            req.getRequestDispatcher("signup.jsp").forward(req, resp);
        } else {
            try {
                Class.forName("com.mysql.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
            // Establishing connection to the database

            System.out.println("SignUpServlet Connection attempt...");
            try (UserDAO userDAO = new UserDAO(new MYSQLDatabase(getServletContext().getRealPath("WEB-INF/mysql.properties")))) {
                System.out.println("SignUpServlet Connection Successful");

                Map<String, String[]> paraMaps = req.getParameterMap();
                for (String key : paraMaps.keySet()) {
                    System.out.println("paramaps key=" + key + ",value=" + paraMaps.get(key));
                }

                String username = (paraMaps.get("username")[0].equals("")) ? "" : paraMaps.get("username")[0];
                String password = (paraMaps.get("password")[0].equals("")) ? "" : paraMaps.get("password")[0];
                String cPassword = (paraMaps.get("cPassword")[0].equals("")) ? "" : paraMaps.get("cPassword")[0];
                String fname = (paraMaps.get("fname")[0].equals("")) ? "" : paraMaps.get("fname")[0];
                String lname = (paraMaps.get("lname")[0].equals("")) ? "" : paraMaps.get("lname")[0];
                String dob = (paraMaps.get("dob")[0].equals("")) ? "1970-01-01" : paraMaps.get("dob")[0];//if user's dob field is empty, use 1970-01-01 as default
                String country = (paraMaps.get("country")[0].equals("")) ? "" : paraMaps.get("country")[0];
                String description = (paraMaps.get("description")[0].equals("")) ? "" : paraMaps.get("description")[0];
                String avatar = (paraMaps.get("avatar") == null) ? "avatar_01.png" : paraMaps.get("avatar")[0];
                String email = "";
                System.out.println(Arrays.toString(paraMaps.get("dob")));

                System.out.println("values are:" + username + "," + password + "," + cPassword + "," + fname + "," + lname + "," + dob + "," + country + "," + description + "," + avatar);

//            //setting for upload a photo***************************************************
//            final int maxMemSize = 10 * 1024 * 1024;
//            final int maxFileSize = 50 * 1024 * 1024;
//
//            ServletContext servletContext = getServletContext();
//            String filePath = servletContext.getRealPath("/avatars");
//
//            DiskFileItemFactory factory = new DiskFileItemFactory();
//            factory.setSizeThreshold(maxMemSize);
//            factory.setRepository(new File("c:\\temp"));
//            ServletFileUpload upload = new ServletFileUpload(factory);
//            upload.setSizeMax(maxFileSize);
//            //end of setting for upload a photo***************************************************
//
//            //declare and initiate all for fields
//            File file = null;
//            String username = "";
//            String password = "";
//            String cPassword = "";
//            String fname = "";
//            String lname = "";
//            String dob = "1970-01-01";//if user's dob field is empty, use 1970-01-01 as default
//            String country = "";
//            String description = "";
//            String avatar = "";
//            String email = "";
//            String uploadFileName = "";
//            boolean hasUpload = false;
//            FileItem doUpload = null;
//            String gresponse = "";
//
//            try {
//                List fileItems = upload.parseRequest(req);
//                Iterator i = fileItems.iterator();
//                //loop through all the file items in signup form
//                while (i.hasNext()) {
//                    FileItem fileItem = (FileItem) i.next();
//                    System.out.println("fileitem: " + fileItem);
//
//                    //logic for uploading an image
//                    if (!fileItem.isFormField()) {
//                        String fieldName = fileItem.getFieldName();
//                        String fileName = fileItem.getName();
//                        String contentType = fileItem.getContentType();
//                        boolean isInMemory = fileItem.isInMemory();
//                        long sizeInBytes = fileItem.getSize();
//
//                        //uploading image field is empty
//                        if (fileName == null | fileName == "") {
//                            break;
//                        }
//
//                        // Write the file
//                        System.out.println("SignUpServlet enter line 112: " + filePath);
//
//                        if (fileName.lastIndexOf("\\") >= 0) {
//                            fileName = fileName.substring(fileName.lastIndexOf("\\"));
//                        } else {
//                            fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
//                        }
//
//                        uploadFileName = fileName;
//                        doUpload = fileItem;
//                        hasUpload = true;
//
//                    } else {
//                        //logic for normal form fields
//                        String fieldName = fileItem.getFieldName();
//                        System.out.println("SignUpServlet enter line 127: fieldName: " + fieldName + "," + fileItem.getString());
//                        if (fieldName.equals("username")) {
//                            username = fileItem.getString();
//                        } else if (fieldName.equals("password")) {
//                            password = fileItem.getString();
//                        } else if (fieldName.equals("cPassword")) {
//                            cPassword = fileItem.getString();
//                        } else if (fieldName.equals("fname")) {
//                            fname = fileItem.getString();
//                        } else if (fieldName.equals("lname")) {
//                            lname = fileItem.getString();
//                        } else if (fieldName.equals("dob")) {
//                            dob = (fileItem.getString().equals("")) ? dob : fileItem.getString();
//                        } else if (fieldName.equals("country")) {
//                            country = fileItem.getString();
//                        } else if (fieldName.equals("description")) {
//                            description = fileItem.getString();
//                        } else if (fieldName.equals("avatar")) {
//                            avatar = fileItem.getString();
//                        } else if (fieldName.equals("g-recaptcha-response")) {
//                            gresponse = fileItem.getString();
////                            System.out.println("this is g-recaptcha-response:" + gresponse);
//                        }
//                    }
//                }
//
                System.out.println("SignUpServlet enter line 147: " + username + "," + password + "," + cPassword + "," + fname + "," + lname + "," + dob + "," + country + "," + description + "," + avatar);

                if (userDAO.getUserByUsername("username") != null) {
                    System.out.println("SignUpServlet enter line 149: username exists");
                    req.setAttribute("usernameError", "username already exists");
                    req.getRequestDispatcher("signup.jsp").forward(req, resp);
                }

                boolean hasUppercase = false;
                boolean hasLowercase = false;
                boolean hasInteger = false;
                boolean hasFour = false;
                for (int j = 0; j < password.length(); j++) {
                    if (password.charAt(j) >= 'A' && password.charAt(j) <= 'Z') {
                        hasUppercase = true;
                    }
                    if (password.charAt(j) >= 'a' && password.charAt(j) <= 'z') {
                        hasLowercase = true;
                    }
                    if (password.charAt(j) >= '0' && password.charAt(j) <= '9') {
                        hasInteger = true;
                    }
                    if (password.length() >= 4) {
                        hasFour = true;
                    }
                }
                System.out.println("SignUpServlet enter line 173: " + hasUppercase + "," + hasLowercase + "," + hasInteger + "," + hasFour);

                System.out.println("SignUpServlet enter line 175: " + password + "," + cPassword);
                if (!cPassword.equals(password)) {
                    req.setAttribute("passwordError", "two passwords are different");
                    req.getRequestDispatcher("signup.jsp").forward(req, resp);
                } else if (!hasUppercase || !hasLowercase || !hasInteger || !hasFour) {
                    req.setAttribute("passwordError", "Your password should contain at least 1 UPPERCASE character, 1 lowercase character, 1 digit number, and minimum length is 4!");
                    req.getRequestDispatcher("signup.jsp").forward(req, resp);
                }
//
//                if (avatar.equals("")) {
//                    if (uploadFileName.equals("")) {
//                        avatar = "avatar_01.png";
//                    } else {
//                        avatar = username + "_" + uploadFileName;
//                        file = new File(filePath + "\\" + avatar);
//                        System.out.println("SignUpServlet enter line 189: " + avatar);
//                        System.out.println("SignUpServlet enter line 190: " + file.getAbsolutePath());
//                        doUpload.write(file);
//
//                        BufferedImage img = null;
//                        try {
//                            System.out.println("SignUpServlet enter line 195");
//                            img = ImageIO.read(file);
//                            String thumbFileName = avatar.replace(avatar.substring(avatar.lastIndexOf(".")), "_thumbnail.png");
//                            avatar = thumbFileName;
//                            System.out.println("SignUpServlet enter line 199: " + thumbFileName);
//                            File thumbFile = new File(filePath + "\\" + thumbFileName);
//                            System.out.println("SignUpServlet enter line 201: " + thumbFile.getAbsolutePath());
//
//                            if (img.getHeight() < 20 && img.getWidth() < 20) {
//                                ImageIO.write(img, "png", thumbFile);
//                            } else {
//                                double zoom = Math.max(1.0 * img.getHeight() / 400, 1.0 * img.getWidth() / 400);
//                                int type = img.getType() == 0 ? BufferedImage.TYPE_INT_ARGB : img.getType();
//                                BufferedImage resizedImage = new BufferedImage((int) (img.getWidth() / zoom), (int) (img.getHeight() / zoom), type);
//                                Graphics2D g = resizedImage.createGraphics();
//                                g.drawImage(img, 0, 0, (int) (img.getWidth() / zoom), (int) (img.getHeight() / zoom), null);
//                                g.dispose();
//                                g.setComposite(AlphaComposite.Src);
//                                g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
//                                g.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
//                                g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
//                                ImageIO.write(resizedImage, "png", thumbFile);
//
//                            }
//
//                        } catch (IOException e) {
//                            e.getStackTrace();
//                        }
//                    }
//                }
//
//
                boolean signupSuccess = userDAO.addUser(username, password, fname, lname, dob, country, description, avatar, "active", "");
                //print log to file
                Map<String, String> map = new HashMap<>();
                map.put("username",username);
                map.put("fname",fname);
                map.put("lname",lname);
                map.put("dob",dob);
                map.put("country",country);
                map.put("description",description);
                map.put("avatar",avatar);
                map.put("status","active");
                map.put("email",email);

                String logType = "SignUp";
                LogWriter logWriter = new LogWriter(logType);
                logWriter.init(getServletContext().getRealPath("/log"));
                logWriter.write(logType,map);
                //end of logging code


                System.out.println("SignUpServlet enter line 231: success = " + signupSuccess);


//                Map<String, String[]> maps = req.getParameterMap();
//                for (String key : maps.keySet()) {
//                    System.out.println("enter line 248: key=" + key + ",value=" + maps.get(key));
//                }
//
//                JSONObject jsonObject = performRecaptchaSiteVerify(gresponse);
//                boolean success = (boolean) jsonObject.get("success");
//                req.setAttribute("success", success);
//                System.out.println("recaptcha Success = " + success);
//
                req.setAttribute("successMessage", "Sign up successfully!");
                req.setAttribute("directMessage", "You will be directed to login page");
                req.setAttribute("directErrorMessage", "true");
                req.getRequestDispatcher("signupsuccess.jsp").forward(req, resp);
//
//
//
//
//            } catch (FileUploadException e) {
//                e.printStackTrace();
//            }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }


    }


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            createUser(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    private JSONObject performRecaptchaSiteVerify(String recaptchaResponseToken) throws IOException, JSONException {
        URL url = new URL(SITE_VERIFY_URL);
        StringBuilder postData = new StringBuilder();
        addParam(postData, SECRET_PARAM, SECRET_KEY);
        addParam(postData, RESPONSE_PARAM, recaptchaResponseToken);

        return postAndParseJSON(url, postData.toString());
    }

    private StringBuilder addParam(StringBuilder postData, String param, String value) throws UnsupportedEncodingException {
        if (postData.length() != 0) {
            postData.append("&");
        }
        System.out.println("addParam enter line 295: param=" + param + ", value=" + value);
        return postData.append(
                String.format("%s=%s",
                        URLEncoder.encode(param, StandardCharsets.UTF_8.displayName()),
                        URLEncoder.encode(value, StandardCharsets.UTF_8.displayName())));
    }

    private JSONObject postAndParseJSON(URL url, String postData) throws IOException, JSONException {
        HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
        urlConnection.setDoOutput(true);
        urlConnection.setRequestMethod("POST");
        urlConnection.setRequestProperty(
                "Content-Type", "application/x-www-form-urlencoded");
        urlConnection.setRequestProperty(
                "charset", StandardCharsets.UTF_8.displayName());
        urlConnection.setRequestProperty(
                "Content-Length", Integer.toString(postData.length()));
        urlConnection.setUseCaches(false);
        urlConnection.getOutputStream()
                .write(postData.getBytes(StandardCharsets.UTF_8));
        JSONTokener jsonTokener = new JSONTokener(urlConnection.getInputStream());
        return new JSONObject((Map) jsonTokener);
    }

}