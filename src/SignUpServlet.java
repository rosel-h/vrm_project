import DAO_setup.MYSQLDatabase;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.jooq.DSLContext;
import org.jooq.SQLDialect;
import org.jooq.impl.DSL;
import org.jooq.util.mysql.mysql.Mysql;
import org.json.JSONException;
import org.json.simple.JSONObject;
import org.json.JSONTokener;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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

    private static final String SITE_SECRET = "6LdzZkIUAAAAAEqAh4IqpMguulLqX0O1CzG7twq7";
    private static final String SECRET_PARAM = "secret";
    private static final String RESPONSE_PARAM = "response";
    private static final String G_RECAPTCHA_RESPONSE = "g-recaptcha-response";
    private static final String SITE_VERIFY_URL = "https://www.google.com/recaptcha/api/siteverify";


    public void createUser(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException, ServletException, JSONException {

        System.out.println("SignUpServlet enter sign up servlet");
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        // Establishing connection to the database

        System.out.println("SignUpServlet Connection attempt...");
        //plan A:
        Properties dbProps = new Properties();
        ServletContext s = getServletContext();
        String filepath = s.getRealPath("mysql.properties");
        try (FileInputStream fis = new FileInputStream(filepath)) {
            dbProps.load(fis);
        } catch (IOException e) {
            e.printStackTrace();
        }

        MYSQLDatabase mysqlDatabase = new MYSQLDatabase(getServletContext().getRealPath("mysql.properties"));

        //plan B:
/*        HttpSession session = req.getSession(true);
        System.out.println("SignUpServlet enter line 44:" + session.getId());
        MYSQLDatabase mysqlDatabase = (MYSQLDatabase) session.getAttribute("database");
        if (mysqlDatabase == null) {
            try {
                mysqlDatabase = new MYSQLDatabase(getServletContext().getRealPath("mysql.properties"));
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }*/

        // connect to the database
        try(Connection conn = mysqlDatabase.getConnection()) {
//            Connection conn = mysqlDatabase.getConnection();
            System.out.println("SignUpServlet Connection Successful");

            //if user uploads profile image, set maxMemSize and maxFileSize allowed
            final int maxMemSize = 10 * 1024 * 1024;
            final int maxFileSize = 50 * 1024 * 1024;

            //get the path of directory which stores all avatar images
            ServletContext servletContext = getServletContext();
            String filePath = servletContext.getRealPath("/avatars");

            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(maxMemSize);
            factory.setRepository(new File("c:\\temp"));
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setSizeMax(maxFileSize);

            //declare and initiate all for fields
            File file = null;
            String username = "";
            String password = "";
            String cPassword = "";
            String fname = "";
            String lname = "";
            String dob = "1970-01-01";//if user's dob field is empty, use 1970-01-01 as default
            String country = "";
            String description = "";
            String avatar = "";
            String email = "";
            String uploadFileName = "";
            boolean hasUpload = false;
            FileItem doUpload = null;

            try {
                List fileItems = upload.parseRequest(req);
                Iterator i = fileItems.iterator();
                //loop through all the file items in signup form
                while (i.hasNext()) {
                    FileItem fileItem = (FileItem) i.next();

                    //logic for uploading an image
                    if (!fileItem.isFormField()) {
                        String fieldName = fileItem.getFieldName();
                        String fileName = fileItem.getName();
                        System.out.println("fileName " + fileName);
                        String contentType = fileItem.getContentType();
                        boolean isInMemory = fileItem.isInMemory();
                        long sizeInBytes = fileItem.getSize();

                        //uploading image field is empty
                        if (fileName == null | fileName == "") {
                            break;
                        }

                        // Write the file
                        System.out.println("SignUpServlet enter line 133: " + filePath);

                        if (fileName.lastIndexOf("\\") >= 0) {
                            fileName = fileName.substring(fileName.lastIndexOf("\\"));
                        } else {
                            fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
                        }

                        uploadFileName = fileName;
                        doUpload = fileItem;
                        hasUpload = true;

                    } else {

                        String fieldName = fileItem.getFieldName();
                        System.out.println("SignUpServlet enter line 169: fieldName: " + fieldName + "," + fileItem.getString());
                        if (fieldName.equals("username")) {
                            username = fileItem.getString();
                        } else if (fieldName.equals("password")) {
                            password = fileItem.getString();
                        } else if (fieldName.equals("cPassword")) {
                            cPassword = fileItem.getString();
                        } else if (fieldName.equals("fname")) {
                            fname = fileItem.getString();
                        } else if (fieldName.equals("lname")) {
                            lname = fileItem.getString();
                        } else if (fieldName.equals("dob")) {
                            dob = (fileItem.getString().equals("")) ? dob : fileItem.getString();
                        } else if (fieldName.equals("country")) {
                            country = fileItem.getString();
                        } else if (fieldName.equals("description")) {
                            description = fileItem.getString();
                        } else if (fieldName.equals("avatar")) {
                            avatar = fileItem.getString();
                        }
                    }
                }

                try (PreparedStatement stmt = conn.prepareStatement("SELECT * FROM vrm_users WHERE username = ?;")) {
                    stmt.setString(1, username);
                    try (ResultSet r = stmt.executeQuery()) {
                        while (r.next()) {
                            req.setAttribute("usernameError", "username already exists");
                            req.getRequestDispatcher("signup.jsp").forward(req, resp);
                            break;
                        }
                    }
                }

                if (!cPassword.equals(password)) {
                    req.setAttribute("passwordError", "two passwords are different");
                    req.getRequestDispatcher("signup.jsp").forward(req, resp);
                }

                if (avatar.equals("")) {
                    if (uploadFileName.equals("")) {
                        avatar = "avatar_01.png";
                    }else {
                        avatar = username + "_" + uploadFileName;
                        file = new File(filePath + "\\" + avatar);
                        System.out.println("SignUpServlet enter line 197: " + avatar);
                        System.out.println("SignUpServlet enter line 197: " + file.getAbsolutePath());
                        doUpload.write(file);

                        BufferedImage img = null;
                        try {
                            System.out.println("SignUpServlet enter line 203");
                            img = ImageIO.read(file);
                            String thumbFileName = avatar.replace(avatar.substring(avatar.lastIndexOf(".")), "_thumbnail.png");
                            avatar = thumbFileName;
                            System.out.println("SignUpServlet enter line 204: " + thumbFileName);
                            File thumbFile = new File(filePath + "\\" + thumbFileName);
                            System.out.println("SignUpServlet enter line 205: " + thumbFile.getAbsolutePath());

                            if (img.getHeight() < 20 && img.getWidth() < 20) {
                                ImageIO.write(img,"png",thumbFile);
                            }else {
                                double zoom = Math.max(1.0 * img.getHeight() / 400, 1.0 * img.getWidth() / 400);
                                int type = img.getType() == 0 ? BufferedImage.TYPE_INT_ARGB : img.getType();
                                BufferedImage resizedImage = new BufferedImage((int)(img.getWidth() / zoom), (int)(img.getHeight() / zoom), type);
                                Graphics2D g = resizedImage.createGraphics();
                                g.drawImage(img,0,0,(int) (img.getWidth() / zoom), (int) (img.getHeight() / zoom), null);
                                g.dispose();
                                g.setComposite(AlphaComposite.Src);
                                g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
                                g.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
                                g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
                                ImageIO.write(resizedImage, "png", thumbFile);

                            }

                        }catch (IOException e) {
                            e.getStackTrace();
                        }
                    }
                }

                System.out.println("SignUpServlet enter line 190: " + username + "," + password + "," + cPassword + "," + fname + "," + lname + "," + dob + "," + country + "," + description + "," + avatar);

                try (PreparedStatement stmt = conn.prepareStatement("INSERT INTO vrm_users VALUE (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);")) {
                    stmt.setString(1, username);
                    stmt.setString(2, password);
                    stmt.setString(3, fname);
                    stmt.setString(4, lname);
                    stmt.setString(5, dob);
                    stmt.setString(6, country);
                    stmt.setString(7, description);
                    stmt.setString(8, avatar);
                    stmt.setString(9, "active");
                    stmt.setString(10, email);

                    stmt.executeUpdate();

                    req.setAttribute("successMessage", "Sign up successfully!");
                    req.setAttribute("directMessage", "You will be directed to login page");
                    req.setAttribute("directErrorMessage", "true");
                    req.getRequestDispatcher("signupsuccess.jsp").forward(req, resp);

                    JSONObject jsonObject = performRecaptchaSiteVerify(req.getParameter(G_RECAPTCHA_RESPONSE));
                    boolean success = (boolean) jsonObject.get("success");
                    req.setAttribute("success", success);
                    System.out.println("Success = " + success);

                } catch (ServletException e) {
                    e.printStackTrace();
                }

            } catch (FileUploadException e) {
                e.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }

        } catch (SQLException e) {
            e.printStackTrace();
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

    private String checkNull(Object object) {
        String returnStr = "";
        if (object == null) {
            return returnStr;
        } else {
            return object.toString();
        }
    }

    private JSONObject performRecaptchaSiteVerify(String recaptchaResponseToken) throws IOException, JSONException {
        URL url = new URL(SITE_VERIFY_URL);
        StringBuilder postData = new StringBuilder();
        addParam(postData, SECRET_PARAM, SITE_SECRET);
        addParam(postData, RESPONSE_PARAM, recaptchaResponseToken);

        return postAndParseJSON(url, postData.toString());
    }

    private StringBuilder addParam(StringBuilder postData, String param, String value) throws UnsupportedEncodingException {
        if (postData.length() != 0) {
            postData.append("&");
        }
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
