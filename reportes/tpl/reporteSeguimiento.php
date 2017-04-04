<font size="8">
    <table width="100%" cellpadding="5px" rules="cols" border="1">
        <tbody>
        <tr>
            <td style="text-align: center"><b>Tabla de ponderación</b></td>
        </tr>
        <tr>
            <td width="75%"><b>Actividad</b></td>
            <td width="25%"><b>% avance </b></td>

        </tr>
        <?php
        $sumaAvance = 0;


        foreach ($this->datos_detalle as $objDato_detalle) {
            if ($objDato_detalle['nivel'] == 1) {
                $sumaAvance += $objDato_detalle['total_avance'];
            }
        }
        foreach ($this->datos_detalle as $objDato_detalle) { ?>
            <tr>
                <td>
                    <?php if ($objDato_detalle['nivel'] == 1) { ?>
                        <h4><?php echo $objDato_detalle['actividad']; ?> </h4>
                    <?php } else { ?>
                        <?php echo $objDato_detalle['actividad']; ?>
                    <?php } ?>

                </td>
                <td>
                    <?php if ($objDato_detalle['nivel'] == 1) { ?>
                        <h4><?php echo $objDato_detalle['total_avance']; ?></h4>
                    <?php } else { ?>
                        <?php echo $objDato_detalle['total_avance']; ?>
                    <?php } ?>
                </td>
            </tr>
            <?php
            //  $sumPonderacion += round(($objDato_detalle['plazo'] * $objDato_detalle['monto_suma'])/$sumMultiplicacion,4);

        } ?>
        <tr>
            <td>
                Totales:
            </td>
            <td><b>
                    <?php echo $sumaAvance ?>
                </b>
            </td>

        </tr>

        </tbody>
    </table>
</font>