<font size="8">
    <table width="100%" cellpadding="5px" rules="cols" border="1">
        <tbody>
        <tr>
            <td colspan="2" style="text-align: center"><b>Tabla de ponderación</b></td>
        </tr>
        <tr>
            <td width="35%"><b>Hitos</b></td>
            <td width="15%"><b>Presupuesto</b></td>
            <td width="15%"><b>Duracion</b></td>
            <td width="15%"><b>Multiplicación</b></td>
            <td width="10%">
                <b>Valor Ponderado:</b>
            </td>
            <td width="10%">
                <b>Valor ponderado (%)</b>
            </td>
        </tr>
        <?php
        $sumPresupuesto = 0;
        $sumMultiplicacion = 0;
        $sumPonderacion = 0;

        foreach ($this->datos_detalle as $objDato_detalle){
            $sumPresupuesto += $objDato_detalle['monto_suma'];
            $sumMultiplicacion += ($objDato_detalle['plazo'] * $objDato_detalle['monto_suma']);
        }
        foreach ($this->datos_detalle as $objDato_detalle) { ?>
            <tr>
                <td>
                    <?php echo $objDato_detalle['actividad']; ?>
                </td>
                <td>
                    <?php echo $objDato_detalle['monto_suma']; ?>
                </td>
                <td>

                    <?php echo $objDato_detalle['plazo']; ?>

                </td>
                <td>

                    <?php echo $objDato_detalle['plazo'] * $objDato_detalle['monto_suma']; ?>

                </td>

                <td>
                    <?php
                    echo round(($objDato_detalle['plazo'] * $objDato_detalle['monto_suma'])/$sumMultiplicacion,4); ?>
                </td>
                <td>
                    <?php echo round((($objDato_detalle['plazo'] * $objDato_detalle['monto_suma'])/$sumMultiplicacion)*100,2)?>%
                </td>
            </tr>
        <?php
            $sumPonderacion += round(($objDato_detalle['plazo'] * $objDato_detalle['monto_suma'])/$sumMultiplicacion,4);

        } ?>
        <tr>
            <td>
                Totales:
            </td>
            <td><b>
                    <?php echo $sumPresupuesto ?>
                </b>
            </td>
            <td>

            </td>
            <td><b>
                    <?php echo $sumMultiplicacion ?>
                </b>
            </td>
            <td><?php echo $sumPonderacion?></td>
            <td><?php echo ($sumPonderacion*100)?>%</td>
        </tr>

        </tbody>
    </table>
</font>