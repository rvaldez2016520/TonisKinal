package org.ruivaldez.system;

import java.io.InputStream;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.fxml.JavaFXBuilderFactory;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;
import org.ruivaldez.controller.DatosPersonalesController;
import org.ruivaldez.controller.EmpleadoController;
import org.ruivaldez.controller.EmpresaController;
import org.ruivaldez.controller.MenuPrincipalController;
import org.ruivaldez.controller.PlatoController;
import org.ruivaldez.controller.PresupuestosController;
import org.ruivaldez.controller.ProductoController;
import org.ruivaldez.controller.ProductoHasPlatoController;
import org.ruivaldez.controller.ServicioController;
import org.ruivaldez.controller.ServicioHasEmpleadoController;
import org.ruivaldez.controller.ServicioHasPlatoController;
import org.ruivaldez.controller.TipoEmpleadoController;
import org.ruivaldez.controller.TipoPlatoController;

public class Principal extends Application {
    private final String PAQUETE_VISTA = "/org/ruivaldez/view/";
    private Stage escenarioPrincipal;
    private Scene escena;
    
    
    @Override
        public void start(Stage escenarioPrincipal) throws Exception {
        this.escenarioPrincipal = escenarioPrincipal;
        this.escenarioPrincipal.setTitle("Toni's Kinal App");
        escenarioPrincipal.getIcons().add(new Image("/org/ruivaldez/image/IconoTienda.png"));
        //Parent root = FXMLLoader.load(getClass().getResource("/org/ruivaldez/view/MenuPrincipalView.fxml"));
        //Scene escena = new Scene(root);
        //escenarioPrincipal.setScene(escena);
        menuPrincipal();
        escenarioPrincipal.show();
    }
    
        public void menuPrincipal(){
        
        try {
            MenuPrincipalController menuPrincipal = (MenuPrincipalController)cambiarEscena("MenuPrincipalView.fxml",1015,586);
            menuPrincipal.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
   
        public void ventanaProgramador(){  
        try {
            DatosPersonalesController datosPersonales = (DatosPersonalesController)cambiarEscena("DatosPersonalesView.fxml",1015,586);
            datosPersonales.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
        public void ventanaEmpresas(){
        try{
            EmpresaController empresasController = (EmpresaController)cambiarEscena("EmpresaView.fxml",1015,698);    
            empresasController.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace(); 
        }
    }
         public void ventanaPresupuestos(){
        try{
            PresupuestosController presupuestosController = (PresupuestosController)cambiarEscena("PresupuestosView.fxml",1015,698);    
            presupuestosController.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace(); 
        }
    }
        public void ventanaTipoEmpleado(){
        try{
            TipoEmpleadoController tipoEmpleadoController = (TipoEmpleadoController)cambiarEscena("TipoEmpleadoView.fxml",1015,698);    
            tipoEmpleadoController.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace(); 
        }
    }
        public void ventanaEmpleado(){
        try{
            EmpleadoController empleadoController = (EmpleadoController)cambiarEscena("EmpleadoView.fxml",1176,698);    
            empleadoController.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace(); 
        }
    }
        public void ventanaServicio(){
            try{
                ServicioController servicioController = (ServicioController)cambiarEscena("ServicioView.fxml",1153,838);
                servicioController.setEscenarioPrincipal(this);  
            }catch(Exception e){
                e.printStackTrace();
            }
        }
        public void ventanaProducto(){
            try{
                ProductoController productoController = (ProductoController)cambiarEscena("ProductoView.fxml",924,698);
                productoController.setEscenarioPrincipal(this);  
            }catch(Exception e){
                e.printStackTrace();
            }
        }
        public void ventanaTipoPlato(){
            try{
                TipoPlatoController tipoPlatoController = (TipoPlatoController)cambiarEscena("TipoPlatoView.fxml",1015,698);
                tipoPlatoController.setEscenarioPrincipal(this);  
            }catch(Exception e){
                e.printStackTrace();
            }
        }
        public void ventanaPlato(){
            try{
                PlatoController platoController = (PlatoController)cambiarEscena("PlatoView.fxml",1176,698);
                platoController.setEscenarioPrincipal(this);  
            }catch(Exception e){
                e.printStackTrace();
            }
        }
        public void ventanaServicioHasEmpleado(){
            try{
                ServicioHasEmpleadoController servicioHasEmpleadoController = (ServicioHasEmpleadoController)cambiarEscena("ServicioEmpleadoView.fxml",1153,726);
                servicioHasEmpleadoController.setEscenarioPrincipal(this);  
            }catch(Exception e){
                e.printStackTrace();
            }
        }
        public void ventanaServicioHasPlato(){
            try{
                ServicioHasPlatoController servicioHasPlatoController = (ServicioHasPlatoController)cambiarEscena("ServicioPlatoView.fxml",726,606);
                servicioHasPlatoController.setEscenarioPrincipal(this);  
            }catch(Exception e){
                e.printStackTrace();
            }
        }
        public void ventanaProductoHasPlato(){
            try{
                ProductoHasPlatoController productoHasPlatoController = (ProductoHasPlatoController)cambiarEscena("ProductoPlatoView.fxml",726,606);
                productoHasPlatoController.setEscenarioPrincipal(this);
            }catch(Exception e){
                e.printStackTrace();
            }
        }

    public static void main(String[] args) {
        launch(args);
    }
    
    public Initializable cambiarEscena (String fxml,int ancho,int alto) throws Exception{
        Initializable resultado = null;
        FXMLLoader cargadorFXML = new FXMLLoader();
        InputStream archivo = Principal.class.getResourceAsStream(PAQUETE_VISTA+fxml);
        cargadorFXML.setBuilderFactory(new JavaFXBuilderFactory());
        cargadorFXML.setLocation(Principal.class.getResource(PAQUETE_VISTA+fxml));
        escena = new Scene((AnchorPane)cargadorFXML.load(archivo),ancho,alto);
        escenarioPrincipal.setScene(escena);
        escenarioPrincipal.sizeToScene();
        resultado = (Initializable)cargadorFXML.getController();
        
        return resultado;  
    }

    
}
