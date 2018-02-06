import com.google.gson.Gson;
import org.apache.commons.fileupload.FileItem;
import org.jooq.tools.json.JSONObject;

import javax.servlet.http.HttpServlet;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

/**
 * Created by Mengjie
 * Date : 2018/2/3
 * Time : 18:48
 **/
public class LogWriter{

    private String logType;
    private String datetime;
    private File logFile;


    public LogWriter(String logType) throws IOException {
        Date nowTime=new Date();
        SimpleDateFormat logtime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        this.logType = logType;
        this.datetime = logtime.format(nowTime);

    }

    public void init(String path){
        File rootFolder = new File(path);
        if (!rootFolder.exists()) {
            rootFolder.mkdir();
        }
        System.out.println("LogWriter enter line 40: filePath=" + path);

        String logPath = path + "/" + this.logType;
        File logFolder = new File(logPath);
        if (!logFolder.exists()) {
            logFolder.mkdir();
        }
        System.out.println("LogWriter enter line 46: logPath=" + logPath);

        SimpleDateFormat filetime=new SimpleDateFormat("yyyyMMdd");
        String filename = logPath + "/" + this.logType + "_" + filetime.format(new Date()) + ".log";
        logFile = new File(filename);
        System.out.println("LogWriter enter line 51: filename=" + filename);

    }

    public void write(String logType, Map map) throws IOException {
        map.put("datetime",this.datetime);


        Gson gsonObj = new Gson();
        // converts object to json string
        String jsonStr = gsonObj.toJson(map);
        String logStr = "[" + logType + "][" + this.datetime + "]" + jsonStr;
        System.out.println("LogWriter enter line 65: log=" + logStr);
        try (BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(logFile,true))) {
            System.out.println("LogWriter enter line 59: logfilename=" + logFile.getName());
            System.out.println("LogWriter enter line 60: logfilepath=" + logFile.getAbsolutePath());

            bufferedWriter.write(logStr);
            bufferedWriter.newLine();

        }


    }



}
