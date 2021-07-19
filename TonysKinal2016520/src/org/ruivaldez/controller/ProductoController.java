package org.ruivaldez.controller;

import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.ResourceBundle;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javax.swing.JOptionPane;
import org.ruivaldez.bean.Producto;
import org.ruivaldez.db.Conexion;
import org.ruivaldez.system.Principal;

public class ProductoController implements Initializable {

   
    private enum operaciones {NUEVO,GUARDAR,ELIMINAR,EDITAR,ACTUALIZAR,CANCELAR,NINGUNO};
    private Principal escenarioPrincipal;
    private operaciones tipoDeOperacion = operaciones.NINGUNO;
    private ObservableList<Producto>ListaProductos;
    
    @FXML private TextField txtCodigoProducto;
    @FXML private TextField txtNombreProducto;
    @FXML private TextField txtCantidad;
    @FXML private TableView tblProductos;
    @FXML private TableColumn colCodigoProducto;
    @FXML private TableColumn colNombreProducto;
    @FXML private TableColumn colCantidad;
    @FXML private Button btnNuevo;
    @FXML private Button btnEliminar;
    @FXML private Button btnEditar;
    @FXML private Button btnReporte;
    
    @Override
    public void initialize(URL location, ResourceBundle resources) {
        cargarDatos();
    }
        public void cargarDatos(){
            tblProductos.setItems(getProductos());
            colCodigoProducto.setCellValueFactory(new PropertyValueFactory<Producto,Integer>("codigoProducto"));
            colNombreProducto.setCellValueFactory(new PropertyValueFactory<Producto,String>("nombreProducto"));
            colCantidad.setCellValueFactory(new PropertyValueFactory<Producto,Integer>("cantidad"));
   }
        public ObservableList<Producto> getProductos(){
           ArrayList<Producto> lista = new ArrayList<Producto>();
                try{
                    PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_ListarProductos}");
                    ResultSet resultado = procedimiento.executeQuery();
              while(resultado.next()){
                      lista.add(new Producto (resultado.getInt("codigoProducto"),
                                        resultado.getString("nombreProducto"),
                                        resultado.getInt("cantidad")));
              }
                }catch(Exception e){
                    e.printStackTrace();
                }
                return ListaProductos = FXCollections.observableArrayList(lista);
        } 

        public void nuevo(){
            switch(tipoDeOperacion){
                case NINGUNO:
                           activarControles();
                           limpiarControles();
                           btnNuevo.setText("Guardar");
                           btnEliminar.setDisable(false);
                           btnEliminar.setText("Cancelar");
                           btnEditar.setDisable(true);
                           btnReporte.setDisable(true);
                           tipoDeOperacion = operaciones.GUARDAR;
                    break;
                case GUARDAR:
                    guardar();
                        desactivarControles();
                        limpiarControles();
                        btnNuevo.setText("Nuevo");
                        btnEliminar.setText("Elimnar");
                        btnEliminar.setDisable(false);
                        btnEditar.setDisable(false);
                        btnReporte.setDisable(false);
                        tipoDeOperacion = operaciones.NINGUNO;
                        cargarDatos();
                    break;
            }
        }
            
    public void guardar(){
        Producto registro = new Producto();
        registro.setNombreProducto(txtNombreProducto.getText());
        registro.setCantidad(Integer.parseInt(txtCantidad.getText()));

            try{
                 PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_AgregarProducto(?,?)}");
                 procedimiento.setString(1,registro.getNombreProducto());
                 procedimiento.setInt(2,registro.getCantidad());
                 procedimiento.execute();
                 ListaProductos.add(registro);
                 cargarDatos();
            }catch(Exception e){
                e.printStackTrace();
            }
    }
    public void seleccionarElemento(){
         if(tblProductos.getSelectionModel().getSelectedItem() == null){
         }else{
        txtCodigoProducto.setText(String.valueOf(((Producto)tblProductos.getSelectionModel().getSelectedItem()).getCodigoProducto()));
        txtNombreProducto.setText(((Producto)tblProductos.getSelectionModel().getSelectedItem()).getNombreProducto());
         txtCantidad.setText(String.valueOf(((Producto)tblProductos.getSelectionModel().getSelectedItem()).getCantidad()));
         }
    }
    public Producto BuscarProductos( int codigoProducto){
        Producto resultado = null;
            try{
                PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_BuscarProducto(?)}");
                procedimiento.setInt(1,codigoProducto);
                ResultSet registro = procedimiento.executeQuery();
            while (registro.next()){
                resultado = new Producto(
                            registro.getInt("codigoProducto"),
                            registro.getString("nombreProducto"),
                            registro.getInt("cantidad"));
                
            }
            }catch(Exception e){
                e.printStackTrace();
                
            }
             return resultado;      
    }
    public void eliminar() {
        switch (tipoDeOperacion){
            case GUARDAR:
                desactivarControles();
                limpiarControles();
                btnNuevo.setText("Nuevo");
                btnNuevo.setDisable(false);
                btnEliminar.setText("Eliminar");
                btnEliminar.setDisable(false);
                btnEditar.setDisable(false);
                btnReporte.setDisable(false);
                tipoDeOperacion = operaciones.NINGUNO;
                cargarDatos();
                break;
            default:
                if(tblProductos.getSelectionModel().getSelectedItem() !=null){
                    int respuesta = JOptionPane.showConfirmDialog(null,"¿Esta seguro de eliminar el registro?","Eliminar Producto", JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE);
                    if(respuesta == JOptionPane.YES_OPTION)
                        try{
                            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_EliminarProducto(?)}");
                             procedimiento.setInt(1, ((Producto)tblProductos.getSelectionModel().getSelectedItem()).getCodigoProducto());
                             procedimiento.execute();
                             ListaProductos.remove(tblProductos.getSelectionModel().getFocusedIndex());
                             limpiarControles();
                        }catch(Exception e){
                            e.printStackTrace();
                        }
                }else{
                   JOptionPane.showMessageDialog(null, "Debe seleccionar un elemento");
                }
        }
    }
    public void editar(){
        switch(tipoDeOperacion){
            case NINGUNO:
               if(tblProductos.getSelectionModel().getSelectedItem() !=null){
                 btnEditar.setText("Actualizar");
                btnReporte.setText("Cancelar");
                btnNuevo.setDisable(true);
                btnEliminar.setDisable(true);
                activarControles();
                tipoDeOperacion = operaciones.ACTUALIZAR;
               }else{
                   JOptionPane.showMessageDialog(null,"Debe seleccionar un elemento");
               }
               break;
            case ACTUALIZAR:
                actualizar();
                    btnEditar.setText("Editar");
                    btnReporte.setText("Reporte");
                    btnNuevo.setDisable(false);
                    btnEliminar.setDisable(false);
                    tipoDeOperacion = operaciones.NINGUNO;
                    cargarDatos();
                    desactivarControles();
                break;
        }
    }
    public void actualizar(){
        try{
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_ActualizarProducto(?,?,?)}");
            Producto registro = (Producto)tblProductos.getSelectionModel().getSelectedItem();
            registro.setNombreProducto(txtNombreProducto.getText());
            registro.setCantidad(Integer.parseInt(txtCantidad.getText()));
            procedimiento.setInt(1,registro.getCodigoProducto());
            procedimiento.setString(2,registro.getNombreProducto());
            procedimiento.setInt(3,registro.getCantidad());
            procedimiento.execute();
        }catch(Exception e){
            e.printStackTrace();
        }          
    }
    
    public void generarReporte(){
        switch(tipoDeOperacion){
            case ACTUALIZAR:
                limpiarControles();
                desactivarControles();
                btnNuevo.setDisable(false);
                btnEliminar.setDisable(false);
                btnEliminar.setDisable(false);
                btnEditar.setText("Editar");
                btnReporte.setText("Reporte");
                tipoDeOperacion = operaciones.NINGUNO;
                break;
        }
    }
    public void desactivarControles(){
        txtCodigoProducto.setEditable(false);
        txtNombreProducto.setEditable(false);
        txtCantidad.setEditable(false);
    }
    public void activarControles(){
        txtCodigoProducto.setEditable(false);
        txtNombreProducto.setEditable(true);
        txtCantidad.setEditable(true);
    }
    public void limpiarControles(){
       txtCodigoProducto.setText("");
        txtNombreProducto.setText("");
        txtCantidad.setText("");
    }
     

    public Principal getEscenarioPrincipal() {
        return escenarioPrincipal;
    }

    public void setEscenarioPrincipal(Principal escenarioPrincipal) {
        this.escenarioPrincipal = escenarioPrincipal;
    }
    public void menuPrincipal(){
        escenarioPrincipal.menuPrincipal();
    }
    
}