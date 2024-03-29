
import DAO_setup.*;
import org.jooq.tools.json.JSONObject;

import org.jsoup.Jsoup;
import org.jsoup.safety.Whitelist;


import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * Created by rher490 on 2/02/2018.
 * The servlet deals with retrieving each individual article.
 * It also handles manipulating data related to articles....
 * - adding and deleting articles,
 * - adding and deleting comments
 * note: editing articles is handled in the EditArticle.java file
 */
public class IndividualArticleServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("IndividualArticleServlet Do get ");
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        System.out.println("> do post");
        HttpSession session = req.getSession(false);
        String content = req.getParameter("content");

        String csrfSessionToken = (String) session.getAttribute("csrfSessionToken");
        String csrfToken = req.getParameter("csrfToken");
        //set up
        ServletContext servletContext = getServletContext();
        String sessionFilePath = servletContext.getRealPath("WEB-INF/Sessions");
        String sessionID = session.getId();
        String fileName = sessionFilePath + "\\" + sessionID + ".json";
        JSONObject userJson;
        File sessionFile = new File(fileName);
        String user = String.valueOf(session.getAttribute("personLoggedIn"));
        String op = req.getParameter("operation");
        System.out.println("in do post again");
        String checkIfTheresArticle = req.getParameter("articleID");
        System.out.println("IndividualArticleServlet - article  " + checkIfTheresArticle + " operation " + op);
        if (checkIfTheresArticle == null && op == null) {
            System.out.println("IAS: this is being redirected to allarticles");
            //redirects user
            req.getRequestDispatcher("Articles").forward(req, resp);
        } else {
            try (BlogDAO dao = new BlogDAO(new MYSQLDatabase(getServletContext().getRealPath("WEB-INF/mysql.properties")))) {
                System.out.println("IndividualArticleServlet Connection success");

                if (sessionFile.exists()) {
                    System.out.println("IndividualArticleServlet - session exists");
                    userJson = User.readJSONFile(fileName);
                    System.out.println(JSONObject.toJSONString(userJson));
                    user = String.valueOf(userJson.get("username"));
                } else {
                    System.out.println("IndividualArticleServlet - session doesnt exist");
                }

                String icon = dao.getIcon(user);
                System.out.println(icon + " " + user);
                if (user != null) {
                    req.setAttribute("personLoggedIn", user);
                }

                //add articles
                if ("add".equals(op)) {
                    if (!passTokenCheck(csrfToken, csrfSessionToken)) {
                        resp.sendError(666);
                        return;
                    }

                    String title = req.getParameter("title");
                    user = String.valueOf(session.getAttribute("personLoggedIn"));
                    //check if date is to be published today or not
                    String submittedDate = req.getParameter("futureDate");
                    System.out.println("IndividualArticleServlet: date " + submittedDate);
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                    java.sql.Date sqlDate;

                    if (submittedDate.length() < 10) {
                        //in case user did not add any date
                        sqlDate = java.sql.Date.valueOf(LocalDate.now());
                    } else {
                        LocalDate submittedDateReformatted = LocalDate.parse(submittedDate, formatter);
                        sqlDate = java.sql.Date.valueOf(submittedDateReformatted);
                    }

                    dao.addArticle(title, content, user, sqlDate);
                    System.out.println("IndividualArticleServlet: new article made");
                    System.out.println("transfer to new article");

                    //print log to file
                    Map<String, String> map = new HashMap<>();
                    map.put("user", user);
                    map.put("title", title);
                    map.put("content", content);
                    map.put("submittedDate", String.valueOf(sqlDate));
                    map.put("operation", op);

                    String ipAddress = req.getRemoteAddr();
                    map.put("ip", ipAddress);

                    String logType = "AddArticle";
                    LogWriter logWriter = new LogWriter(logType);
                    logWriter.init(getServletContext().getRealPath("log"));
                    logWriter.write(logType, map);
                    //end of logging code

                    req.getRequestDispatcher("myArticles").forward(req, resp);
                    //delete article
                } else if ("delete".equals(op)) {
                    if (!passTokenCheck(csrfToken, csrfSessionToken)) {
                        resp.sendError(666);
                        return;
                    }

                    System.out.println("IndividualArticleServlet: Delete option");
                    System.out.println(req.getParameter("articleID"));
                    int id = Integer.parseInt(req.getParameter("articleID"));
                    dao.deleteArticle(id);

                    //print log to file
                    Map<String, String> map = new HashMap<>();
                    map.put("user", user);
                    map.put("articleID", String.valueOf(id));

                    map.put("operation", op);

                    String ipAddress = req.getRemoteAddr();
                    map.put("ip", ipAddress);

                    String logType = "DeleteArticle";
                    LogWriter logWriter = new LogWriter(logType);
                    logWriter.init(getServletContext().getRealPath("log"));
                    logWriter.write(logType, map);
                    //end of logging code


                    //deleting articles goes to my articles as well
                    req.getRequestDispatcher("myArticles").forward(req, resp);
                } else {
                    //deals with article manipulation
                    System.out.println("IndividualArticleServlet: Else Statement");
                    //add a comment to article
                    if ("commentOnArticle".equals(op)) {
                        if (!passTokenCheck(csrfToken, csrfSessionToken)) {
                            resp.sendError(666);
                            return;
                        }

                        //retrieve data from jsp
                        String userWhoCommented = req.getParameter("userWhoCommented");
                        String comment = Jsoup.clean(req.getParameter("newComment"), Whitelist.relaxed());
                        int articleID = Integer.parseInt(req.getParameter("articleID"));
                        //get today's date
                        java.sql.Date sqlDate = java.sql.Date.valueOf(LocalDate.now());
                        dao.addCommentToArticle(articleID, userWhoCommented, sqlDate, comment);
                        //print log to file
                        Map<String, String> map = new HashMap<>();
                        map.put("articleID", String.valueOf(articleID));
                        map.put("userWhoCommented", userWhoCommented);
                        map.put("comment", comment);
                        map.put("operation", op);
                        String ipAddress = req.getRemoteAddr();
                        map.put("ip", ipAddress);
                        String logType = "CommentOnArticle";
                        LogWriter logWriter = new LogWriter(logType);
                        logWriter.init(getServletContext().getRealPath("log"));
                        logWriter.write(logType, map);
                        //end of logging code

                    } else if ("deleteCommentOnArticle".equals(op)) {
                        if (!passTokenCheck(csrfToken, csrfSessionToken)) {
                            resp.sendError(666);
                            return;
                        }
                        System.out.println("IndividualArticleServlet: delete button pressed");
                        String commentIDToBeDeleted = req.getParameter("commentID");
                        System.out.println();
                        System.out.println("IAS: id - " + commentIDToBeDeleted);
                        dao.deleteCommentOnArticle(Integer.parseInt(commentIDToBeDeleted));

                        //print log to file
                        Map<String, String> map = new HashMap<>();
                        map.put("commentIDToBeDeleted", commentIDToBeDeleted);
                        map.put("operation", op);

                        String ipAddress = req.getRemoteAddr();
                        map.put("ip", ipAddress);

                        String logType = "DeleteCommentOnArticle";
                        LogWriter logWriter = new LogWriter(logType);
                        logWriter.init(getServletContext().getRealPath("log"));
                        logWriter.write(logType, map);
                        //end of logging code

                    } else if ("replyToAComment".equals(op)) {
                        if (!passTokenCheck(csrfToken, csrfSessionToken)) {
                            resp.sendError(666);
                            return;
                        }
                        System.out.println("IndividualArticleServlet replying to comment button pressed");
                        java.sql.Date sqlDate = java.sql.Date.valueOf(LocalDate.now());
                        String userWhoCommented = req.getParameter("userWhoCommented");
                        String comment = Jsoup.clean(req.getParameter("newComment"), Whitelist.relaxed());
                        int articleID = Integer.parseInt(req.getParameter("articleID"));
                        int parentComment = Integer.parseInt(req.getParameter("fatherComment"));
                        dao.addCommentToAnotherComment(articleID, userWhoCommented, sqlDate, comment, parentComment);

                        //print log to file
                        Map<String, String> map = new HashMap<>();
                        map.put("articleID", String.valueOf(articleID));
                        map.put("parentCommentID", String.valueOf(parentComment));
                        map.put("userWhoCommented", userWhoCommented);
                        map.put("comment", comment);
                        map.put("operation", op);

                        String ipAddress = req.getRemoteAddr();
                        map.put("ip", ipAddress);

                        String logType = "ReplyToAComment";
                        LogWriter logWriter = new LogWriter(logType);
                        logWriter.init(getServletContext().getRealPath("log"));
                        logWriter.write(logType, map);
                        //end of logging code
                    }
                    int articleID = Integer.parseInt(req.getParameter("articleID"));
                    Article articleToLoad = dao.getOneArticle(articleID);
                    System.out.println("IndividualArticleServlet - articletitle: " + articleToLoad.getTitle());
                    List<CommentOnArticles> list = dao.getAllCommentOfArticle(articleID);
                    System.out.println("IndividualArticleServlet - commentList: " + list.size());
                    //sort the comments into children and parents
                    List<CommentOnArticles> commentsWithChildren = CommentOnArticles.addChildrenToParentComments(list);
                    System.out.println("IndividualArticleServlet - commentListCompressed: " + commentsWithChildren.size());
                    req.setAttribute("articleToLoad", articleToLoad);
                    req.setAttribute("commentList", commentsWithChildren);
                    req.getRequestDispatcher("oneArticle.jsp").forward(req, resp);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
    }

    private boolean passTokenCheck(String token, String sessionToken) {
        if (!sessionToken.equals(token)) {
            System.out.println("csrfTokens not verified");
            return false;
        }

        System.out.println("token verification passed!");
        return true;
    }
}
