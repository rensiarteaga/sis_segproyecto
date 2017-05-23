<font size="8">
    <table width="100%" cellpadding="5px" rules="cols" border="1">
        <tbody>
        <tr>
            <td colspan="2" style="text-align: center"><b>Tabla de ponderación</b></td>
        </tr>
        <tr>
            <td width="70%"><b>actividad</b></td>
            <td width="15%">
                <b>Avance(%)</b>
            </td>
            <td width="15%">
                <b>Total Avance(%)</b>
            </td>
        </tr>
        <?php


        if (!empty($this->datos_detalle)) {


            foreach ($this->datos_detalle as $objDato_detalle) { ?>
                <tr >
                    <td>
                        <?php echo ($objDato_detalle['nivel']==1?('<b>'.$objDato_detalle['actividad'].'</b>'):$objDato_detalle['actividad']); ?>
                    </td>
                    <td>
                        <?php echo $objDato_detalle['avance']; ?>
                    </td>
                    <td>

                        <?php echo $objDato_detalle['total_avance']; ?>

                    </td>
                </tr>
                <?php
                //$sumPonderacion += round(($objDato_detalle['plazo'] * $objDato_detalle['monto_suma'])/$sumMultiplicacion,4);

            }
        } ?>


        </tbody>
    </table>
</font>