<font size="8">
    <table width="100%" cellpadding="5px" rules="cols" border="1">
        <tbody>
        <tr>
            <td colspan="2" style="text-align: center"><b>Tabla de ponderación</b></td>
        </tr>
        <tr>
            <td width="70%"><b>ACTIVIDAD</b></td>
            <td width="30%">
                <b>AVANCE(%)</b>
            </td>
        </tr>
        <?php


        if (!empty($this->datos_detalle)) {

            $total = 0;
            foreach ($this->datos_detalle as $objDato_detalle) { ?>
                <tr <?php echo($objDato_detalle['nivel'] == 1 ? 'STYLE="background-color:darkgrey"' : '') ?> >
                    <td>
                        <?php echo($objDato_detalle['nivel'] == 1 ? ('<b>' . $objDato_detalle['actividad'] . '</b>') : $objDato_detalle['actividad']); ?>
                    </td>
                    <td>
                        <?php if ($objDato_detalle['nivel'] == 1) {
                            $total += $objDato_detalle['total_avance'];
                            echo '<b>' . $objDato_detalle['total_avance'] . '%</b>';
                        } else {
                            echo $objDato_detalle['avance'].'%';
                        } ?>
                    </td>

                </tr>

                <?php
                //$sumPonderacion += round(($objDato_detalle['plazo'] * $objDato_detalle['monto_suma'])/$sumMultiplicacion,4);

            } ?>
            <tr>
                <td>TOTAL:</td>
                <td><?php echo $total.'%' ?></td>
            </tr>
        <?php } ?>


        </tbody>
    </table>
</font>