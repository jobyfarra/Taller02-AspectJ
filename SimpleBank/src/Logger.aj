import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Calendar;

public aspect Logger {
    File file = new File("src/log.txt");
    Calendar cal = Calendar.getInstance();
    
    
    pointcut transaction():execution(void *money*(..));
    pointcut user():execution(void *createUser*(..));
    
 
    after() : transaction(){
        String t=thisJoinPoint.getSignature().getName();
        if (t.equals("moneyMakeTransaction")) {
        	writeFile("Deposito realizado el: "+cal.getTime()+"\n");
        	System.out.println("");
        	System.out.println("Transaccion realizada (Deposito) el: "+cal.getTime()+"\n");
        }
        else{
        	writeFile("Retiro realizado el: "+cal.getTime()+"\n");
        	System.out.println("");
        	System.out.println("Transaccion realizada (Retiro) el: "+cal.getTime()+"\n");
        }
    }
    after() : user(){
        writeFile("Usuario creado el :  "+cal.getTime()+"\n");
        System.out.println("");
        System.out.println("Usuario creado el : "+cal.getTime()+"\n");
    }

    public void writeFile(String mensaje){
        try {
            String content = mensaje;
            
            if (!file.exists()) {
                file.createNewFile();
            }

            FileWriter fw = new FileWriter(file.getAbsoluteFile(),true);
            BufferedWriter bw = new BufferedWriter(fw);
            bw.write(content);
            bw.close();

            //System.out.println("Grabado corecto!");

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
}
