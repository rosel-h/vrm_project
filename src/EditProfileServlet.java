import DAO_setup.BlogDAO;
import DAO_setup.MYSQLDatabase;
import DAO_setup.User;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.jooq.tools.json.JSONObject;

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
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

/**
 * Created by Mengjie
 * Date : 2018/1/26
 * Time : 11:04
 **/
public class EditProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession(true);
        System.out.println("EditProfileServlet enter line 39: session id = " + session.getId());
        String operation = (String) session.getAttribute("operation");
        if (operation == null) {
            operation = "view";
        }
        System.out.println("EditProfileServlet enter line 43: operation = " + operation);

        MYSQLDatabase mysqlDatabase = (MYSQLDatabase) session.getAttribute("database");
        if (mysqlDatabase == null) {
            try {
                mysqlDatabase = new MYSQLDatabase(getServletContext().getRealPath("mysql.properties"));
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        ServletContext servletContext = getServletContext();
        String sessionFilePath = servletContext.getRealPath("/Sessions");
        String sessionID = session.getId();
        String seesionFileName = sessionFilePath + "\\" + sessionID + ".json";
        JSONObject userJson;

        File sessionFile = new File(seesionFileName);
        if (sessionFile.exists()) {
            userJson = User.readJSONFile(seesionFileName);
            System.out.println(JSONObject.toJSONString(userJson));
            String username = String.valueOf(userJson.get("username"));
            if (ServletFileUpload.isMultipartContent(req)) {
                try  {
                    BlogDAO dao = new BlogDAO(mysqlDatabase);
                    System.out.println("EditProfileServlet enter line 69:");
                    User user = dao.getOneUser(username);

                    System.out.println("EditProfileServlet enter line 71: username = " + username);
                    //if user uploads profile image, set maxMemSize and maxFileSize allowed
                    final int maxMemSize = 10 * 1024 * 1024;
                    final int maxFileSize = 50 * 1024 * 1024;

                    //get the path of directory which stores all avatar images
                    String filePath = servletContext.getRealPath("/avatars");
                    System.out.println("EditProfileServlet enter line 76: filePath = " + filePath);
                    DiskFileItemFactory factory = new DiskFileItemFactory();
                    factory.setSizeThreshold(maxMemSize);
                    factory.setRepository(new File("c:\\temp"));
                    ServletFileUpload upload = new ServletFileUpload(factory);
                    upload.setSizeMax(maxFileSize);

                    File file = null;
                    String uploadFileName = "";
                    boolean hasUpload = false;
                    FileItem doUpload = null;
                    String fname = "";
                    String lname = "";
                    String dob = "1970-01-01";//if user's dob field is empty, use 1970-01-01 as default
                    String country = "";
                    String description = "";
                    String avatar = "";

                    try {
                        System.out.println("EditProfileServlet enter line 95:");
                        List fileItems = upload.parseRequest(req);
                        Iterator i = fileItems.iterator();
                        //loop through all the file items in signup form
                        while (i.hasNext()) {
                            FileItem fileItem = (FileItem) i.next();

                            //logic for uploading an image
                            if (!fileItem.isFormField()) {
                                String fieldName = fileItem.getFieldName();
                                String fileName = fileItem.getName();
                                System.out.println("EditProfileServlet enter line 106: fileName = " + fieldName);
                                String contentType = fileItem.getContentType();
                                boolean isInMemory = fileItem.isInMemory();
                                long sizeInBytes = fileItem.getSize();

                                //uploading image field is empty
                                if (fileName == null | fileName == "") {
                                    break;
                                }

                                // Write the file
                                System.out.println("EditProfileServlet enter line 105: " + filePath);

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
                                System.out.println("EditProfileServlet enter line 169: fieldName: " + fieldName + "," + fileItem.getString());
                                if (fieldName.equals("username")) {
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
                            }
                        }


                        if (uploadFileName.equals("")) {
                            if (avatar.equals("")) {
                                if (user.getAvatar_icon().equals("")) {
                                    avatar = "avatar_01.png";
                                }else {
                                    avatar = user.getAvatar_icon();
                                }

                            }
                        } else {
                            avatar = username + "_" + uploadFileName;
                            file = new File(filePath + "\\" + avatar);
                            System.out.println("EditProfileServlet enter line 197: " + avatar);
                            System.out.println("EditProfileServlet enter line 197: " + file.getAbsolutePath());
                            doUpload.write(file);

                            BufferedImage img = null;
                            try {
                                System.out.println("EditProfileServlet enter line 203");
                                img = ImageIO.read(file);
                                String thumbFileName = avatar.replace(avatar.substring(avatar.lastIndexOf(".")), "_thumbnail.png");
                                avatar = thumbFileName;
                                System.out.println("EditProfileServlet enter line 204: " + thumbFileName);
                                File thumbFile = new File(filePath + "\\" + thumbFileName);
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


                        Connection conn = mysqlDatabase.getConnection();
                        try (PreparedStatement stmt = conn.prepareStatement("UPDATE vrm_users " +
                                "SET fname = ?, lname = ?, dob = ?, country = ?, description = ?, avatar_icon = ? WHERE username = ?;")) {
                            stmt.setString(1, fname);
                            stmt.setString(2, lname);
                            stmt.setString(3, dob);
                            stmt.setString(4, country);
                            stmt.setString(5, description);
                            stmt.setString(6, avatar);
                            stmt.setString(7, username);

                            stmt.executeUpdate();

                            req.setAttribute("successMessage", "Save profile successfully");
                            user.setAvatar_icon(avatar);
                            req.setAttribute("user", user);
                            session.setAttribute("operation", "edit");
                            req.getRequestDispatcher("profilesavesuccess.jsp").forward(req, resp);

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
                } catch (Exception e) {
                    e.printStackTrace();
                }

            } else {
                try (BlogDAO dao = new BlogDAO(mysqlDatabase)) {
                    User user = dao.getOneUser(username);
//                    String password = user.getPassword();
//                    String fname = user.getFname();
//                    String lname = user.getLname();
//                    String dob = user.getDateOfBirth();
//                    String country = user.getCountry();
//                    String description = user.getDescription();

                    req.setAttribute("user", user);
                    session.setAttribute("operation", "view");
                    req.getRequestDispatcher("myprofile.jsp").forward(req, resp);

                } catch (SQLException e) {
                    e.printStackTrace();
                } catch (Exception e) {
                    e.printStackTrace();
                }


            }

        } else {
            System.out.println("EditProfileServlet enter line 247: session doesnt exist");
        }


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
