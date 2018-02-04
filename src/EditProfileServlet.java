import DAO_setup.MYSQLDatabase;
import DAO_setup.User;
import DAO_setup.UserDAO;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * Created by Mengjie
 * Date : 2018/1/26
 * Time : 11:04
 **/
public class EditProfileServlet extends HttpServlet {
    private File file = null;
    private String uploadFileName = "";
    private boolean hasUpload = false;
    private FileItem doUpload = null;
    private String fname = "";
    private String lname = "";
    private String dob = "1900-01-01";//if user's dob field is empty, use 1970-01-01 as default
    private String country = "";
    private String description = "";
    private String avatar = "";
    private String csrfSessionToken = "";
    private String csrfToken = "";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("EditProfileServlet enter edit profile servlet");
        HttpSession session = req.getSession(false);
        csrfSessionToken = (String) session.getAttribute("csrfSessionToken");
        System.out.println("EditProfileServlet enter line 39: session id = " + session.getId());

        if (session == null) {
            req.getRequestDispatcher("login.jsp").forward(req, resp);

        } else {
            String username = (String) session.getAttribute("personLoggedIn");
            try (UserDAO userDAO = new UserDAO(new MYSQLDatabase(getServletContext().getRealPath("WEB-INF/mysql.properties")))) {
                System.out.println("EditProfileServlet Connection Successful");
                System.out.println("EditProfileServlet enter line 51: username=" + username);

                if (ServletFileUpload.isMultipartContent(req)) {
                    //if enter servlet from edit form(which means save new profile)
                    //load new profile info from form
                    loadNewProfile(req, resp, username, userDAO);

                    //get user object from database
                    User user = userDAO.getUserByUsername(username);

                    //print log to file
                    Map<String, String> map = new HashMap<>();
                    map.put("username", username);
                    map.put("fname_before", user.getFname());
                    map.put("lname_before", user.getLname());
                    map.put("dob_before", user.getDateOfBirth());
                    map.put("country_before", user.getCountry());
                    map.put("description_before", user.getDescription());
                    map.put("avatar_before", user.getAvatar_icon());

                    String ipAddress = req.getRemoteAddr();
                    map.put("ip", ipAddress);
                    //end of logging code

                    //set attributes of user object
                    user.setFname(fname);
                    user.setLname(lname);
                    user.setDateOfBirth(dob);
                    user.setCountry(country);
                    user.setDescription(description);
                    user.setAvatar_icon(avatar);

                    //update user info in database
                    boolean updateSuccess = userDAO.updateUser(user);

                    //if update success, redirect to welcome.jsp
                    if (updateSuccess) {
                        System.out.println("EditProfileServlet enter line 200: updateSuccess=" + updateSuccess);
                        //print log to file
                        map.put("fname", fname);
                        map.put("lname", lname);
                        map.put("dob", dob);
                        map.put("country", country);
                        map.put("description", description);
                        map.put("avatar", avatar);
                        String logType = "EditProfile";
                        LogWriter logWriter = new LogWriter(logType);
                        logWriter.init(getServletContext().getRealPath("log"));
                        logWriter.write(logType, map);
                        //end of logging code
                        req.setAttribute("successMessage", "Save profile successfully");
                        req.setAttribute("user", user);
                        session.setAttribute("user", user);
                        req.getRequestDispatcher("welcome.jsp").forward(req, resp);
                    }

                } else {
                    //if enter servlet from welcome page
                    //load profile of user from database
                    User user = userDAO.getUserByUsername(username);
                    System.out.println("EditProfileServlet enter line 213:" + user.toString());
                    System.out.println("EditProfileServlet ener line 207: not multipartcontent");
                    req.setAttribute("user", user);
                    req.getRequestDispatcher("myprofile.jsp").forward(req, resp);
                }

            } catch (SQLException e) {
                e.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }

    private void loadNewProfile(HttpServletRequest req, HttpServletResponse resp, String username, UserDAO userDAO) throws Exception {

        User user = userDAO.getUserByUsername(username);
        System.out.println("EditProfileServlet enter line 53: multipartcontent");
        //if user uploads profile image, set maxMemSize and maxFileSize allowed
        final int maxMemSize = 10 * 1024 * 1024;
        final int maxFileSize = 50 * 1024 * 1024;

        //get the path of directory which stores all avatar images
        ServletContext servletContext = getServletContext();
        String filePath = servletContext.getRealPath("avatars");
        File avatarFile = new File(filePath);
        if (!avatarFile.exists()) {
            avatarFile.mkdir();
        }
        System.out.println("EditProfileServlet loadNewProfile enter line 116: filePath = " + filePath);
        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setSizeThreshold(maxMemSize);
        File tempFile = new File(filePath + "/temp");
        if (!tempFile.exists()) {
            tempFile.mkdir();
        }
        factory.setRepository(tempFile);

        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setSizeMax(maxFileSize);

        //read new
        try {
            List fileItems = upload.parseRequest(req);
            Iterator i = fileItems.iterator();
            //loop through all the file items in signup form
            while (i.hasNext()) {
                FileItem fileItem = (FileItem) i.next();
                //logic for uploading an image
                if (fileItem.isFormField()) {
                    String fieldName = fileItem.getFieldName();
                    System.out.println("EditProfileServlet loadNewProfile enter line 159: fieldName: " + fieldName + "," + fileItem.getString());
                    if (fieldName.equals("csrfToken")) {
                        csrfToken = fileItem.getString();
                        if (!csrfSessionToken.equals(csrfToken)) {
                            System.out.println("csrfToken failed");
                            return;
                        }
                    } else if (fieldName.equals("username")) {
                        username = fileItem.getString();
                    } else if (fieldName.equals("fname")) {
                        fname = fileItem.getString();
                        user.setFname(fname);
                    } else if (fieldName.equals("lname")) {
                        lname = fileItem.getString();
                        user.setLname(lname);
                    } else if (fieldName.equals("dob")) {
                        dob = (fileItem.getString().equals("")) ? "1970-01-01" : fileItem.getString();
                        user.setDateOfBirth(dob);
                    } else if (fieldName.equals("country")) {
                        country = fileItem.getString();
                        user.setCountry(country);
                    } else if (fieldName.equals("description")) {
                        description = fileItem.getString();
                        user.setDescription(description);
                    } else if (fieldName.equals("avatar")) {
                        avatar = fileItem.getString();
                    }

                } else {

                    String fieldName = fileItem.getFieldName();
                    String fileName = fileItem.getName();
                    System.out.println("EditProfileServlet loadNewProfile enter line 135: fileName = " + fieldName);
                    String contentType = fileItem.getContentType();
                    boolean isInMemory = fileItem.isInMemory();
                    long sizeInBytes = fileItem.getSize();

                    //uploading image field is empty
                    if (fileName == null | fileName == "") {
                        break;
                    }

                    // Write the file
                    System.out.println("EditProfileServlet loadNewProfile enter line 144: " + filePath);

//                    if (fileName.lastIndexOf("\\") >= 0) {
//                        fileName = fileName.substring(fileName.lastIndexOf("\\"));
//                    } else {
//                        fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
//                    }

                    uploadFileName = fileName;
                    doUpload = fileItem;
                    hasUpload = true;
                }
            }

            if (uploadFileName.equals("")) {
                if (avatar.equals("")) {
                    if (user.getAvatar_icon().equals("")) {
                        avatar = "avatar_01.png";
                    } else {
                        avatar = user.getAvatar_icon();
                    }
                }
            } else {
//                avatar = username + "_" + uploadFileName;
                avatar = username + "_" + uploadFileName;
                file = new File(filePath + "/" + avatar);
                System.out.println("EditProfileServlet loadNewProfile enter line 194: " + avatar);
                System.out.println("EditProfileServlet loadNewProfile enter line 195: " + file.getAbsolutePath());
                doUpload.write(file);

                BufferedImage img = null;
                try {
                    System.out.println("EditProfileServlet loadNewProfile enter line 200");
                    img = ImageIO.read(file);
                    String thumbFileName = avatar.replace(avatar.substring(avatar.lastIndexOf(".")), "_thumbnail.png");
                    avatar = thumbFileName;
                    System.out.println("EditProfileServlet loadNewProfileenter line 204: " + thumbFileName);
                    File thumbFile = new File(filePath + "/" + thumbFileName);
                    System.out.println("EditProfileServlet enter line 205: " + thumbFile.getAbsolutePath());

                    if (img.getHeight() < 20 && img.getWidth() < 20) {
                        ImageIO.write(img, "png", thumbFile);
                    } else {
                        double zoom = Math.max(1.0 * img.getHeight() / 400, 1.0 * img.getWidth() / 400);
                        int type = img.getType() == 0 ? BufferedImage.TYPE_INT_ARGB : img.getType();
                        BufferedImage resizedImage = new BufferedImage((int) (img.getWidth() / zoom), (int) (img.getHeight() / zoom), type);
                        Graphics2D g = resizedImage.createGraphics();
                        g.drawImage(img, 0, 0, (int) (img.getWidth() / zoom), (int) (img.getHeight() / zoom), null);
                        g.dispose();
                        g.setComposite(AlphaComposite.Src);
                        g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
                        g.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
                        g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
                        ImageIO.write(resizedImage, "png", thumbFile);

                    }

                } catch (IOException e) {
                    e.getStackTrace();
                }
            }

        } catch (FileUploadException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
