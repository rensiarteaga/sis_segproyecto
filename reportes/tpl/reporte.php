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
        $sumPonderacionPorcentaje = 0;

        foreach ($this->datos_detalle as $objDato_detalle) { ?>
            <tr>
                <td>
                    <?php echo $objDato_detalle['actividad']; ?>
                </td>
                <td>
                    <?php echo $objDato_detalle['presupuesto']; ?>
                </td>
                <td>

                    <?php echo $objDato_detalle['duracion']; ?>

                </td>
                <td>

                    <?php echo $objDato_detalle['multiplicacion']; ?>

                </td>

                <td>
                    <?php echo $objDato_detalle['valor_ponderado']; ?>
                </td>
                <td>
                    <?php echo $objDato_detalle['valor_ponderado_porcentaje']; ?>%
                </td>
            </tr>
            <?php
            $sumPonderacion += $objDato_detalle['valor_ponderado'];
            $sumPonderacionPorcentaje += $objDato_detalle['valor_ponderado_porcentaje'];
            $sumMultiplicacion += $objDato_detalle['multiplicacion'];
            $sumPresupuesto += $objDato_detalle['presupuesto'];

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
            <td><?php echo $sumPonderacion ?></td>
            <td><?php echo $sumPonderacionPorcentaje ?>%</td>
        </tr>
        </tbody>
    </table>
</font>