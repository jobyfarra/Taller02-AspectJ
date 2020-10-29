import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Calendar;

public aspect Logger {
    File file = new File("src/log.txt");
    Calendar cal = Calendar.getInstance();
    
    
    pointcut transaction():execution(void *moneyMakeTransaction*(..));
    pointcut money():execution(void *moneyWithdrawal*(..));
    pointcut user():execution(void *createUser*(..));
    
 
    after() : transaction(){
        writeFile("Transaccion realizada el: "+cal.getTime()+"\n");
        System.out.println("");
        System.out.println("Transaccion realizada el: "+cal.getTime()+"\n");
    }
    after() : money(){
        writeFile("Dinero retirado el :  "+cal.getTime()+"\n");
        System.out.println("");
        System.out.println("Dinero retirado el : "+cal.getTime()+"\n");
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
