<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>SubastasPorParticipante</title>
    <style type="text/css">
        * {
            font-family: sans-serif;
        }

        @page {
            margin-top: 1cm;
            margin-bottom: 1cm;
            margin-left: 1.5cm;
            margin-right: 1cm;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
            margin-top: 20px;
            page-break-before: avoid;
        }

        table thead tr th,
        tbody tr td {
            padding: 3px;
            word-wrap: break-word;
        }

        table thead tr th {
            font-size: 8pt;
        }

        table tbody tr td {
            font-size: 7pt;
        }


        .encabezado {
            width: 100%;
        }

        .logo img {
            position: absolute;
            height: 90px;
            top: -20px;
            left: 0px;
        }

        h2.titulo {
            width: 450px;
            margin: auto;
            margin-top: 0PX;
            text-align: center;
            font-size: 14pt;
        }

        .texto {
            width: 250px;
            text-align: center;
            margin: auto;
            font-weight: bold;
            font-size: 1.1em;
        }

        .fecha {
            width: 250px;
            text-align: center;
            margin: auto;
            font-weight: normal;
            font-size: 0.85em;
        }

        .total {
            text-align: right;
            padding-right: 15px;
            font-weight: bold;
        }

        table {
            width: 100%;
        }

        table thead {
            background: rgb(236, 236, 236)
        }

        tr {
            page-break-inside: avoid !important;
        }

        .centreado {
            padding-left: 0px;
            text-align: center;
        }

        .datos {
            margin-left: 15px;
            border-top: solid 1px;
            border-collapse: collapse;
            width: 250px;
        }

        .txt {
            font-weight: bold;
            text-align: right;
            padding-right: 5px;
        }

        .txt_center {
            font-weight: bold;
            text-align: center;
        }

        .b_top {
            border-top: solid 1px black;
        }



        .bg-ganador {
            background-color: #e7ffe7;
        }

        .bg-principal {
            background: #153f59;
            color: white;
        }

        .img_celda img {
            width: 45px;
        }

        .nueva_pagina {
            page-break-after: always;
        }

        .bold {
            font-weight: bold;
        }

        .derecha {
            text-align: right;
        }

        .text-md {
            font-size: 9pt;
        }
    </style>
</head>

<body>
    @inject('configuracion', 'App\Models\Configuracion')
    <div class="encabezado">
        <div class="logo">
            <img src="{{ public_path('imgs/' . $configuracion->first()->logo) }}">
        </div>
        <h2 class="titulo">
            {{ $configuracion->first()->razon_social }}
        </h2>
        <h4 class="texto">HISTORIAL DE SUBASTAS POR PARTICIPANTE</h4>
        <h4 class="fecha">Expedido: {{ date('d/m/Y') }}</h4>
    </div>
    @php
        $contador = 0;
    @endphp

    @foreach ($users as $user)
        <table>
            <tbody>
                <tr>
                    <td class="bold derecha">Apellidos:</td>
                    <td>{{ $user->paterno }} {{ $user->materno }}</td>
                    <td class="bold derecha">Celular:</td>
                    <td>{{ $user->fono }}</td>
                </tr>
                <tr>
                    <td class="bold derecha">Nombre(s):</td>
                    <td>{{ $user->nombre }}</td>
                    <td class="bold derecha">Dpto. de Residencia:</td>
                    <td>{{ $user->user_dato->dpto_residencia }}</td>
                </tr>
                <tr>
                    <td class="bold derecha">C.I.:</td>
                    <td>{{ $user->user_dato->full_ci }}</td>
                    <td class="bold derecha">Correo:</td>
                    <td>{{ $user->user_dato->email }}</td>
                </tr>
            </tbody>
        </table>
        <table border="1">
            <thead class="bg-principal">
                <tr>
                    <th width="6%">N°</th>
                    <th>CÓD. SUBASTA - PRODUCTO</th>
                    <th>ESTADO</th>
                    <th>OFERTA INICIAL BS.</th>
                    <th>MONTO DE GARANTÍA BS. - ESTADO DEVOLUCIÓN</th>
                    <th>FECHA DE FINALIZACIÓN</th>
                    <th>HORA DE FINALIZACIÓN</th>
                    <th>ESTADO</th>
                    <th>DESCRIPCIÓN</th>
                </tr>
            </thead>
            <tbody>
                @php
                    $participantes = App\Models\Participante::where('user_id', $user->id);
                    if ($fecha_ini && $fecha_fin) {
                        $participantes->whereBetween('fecha', [$fecha_ini, $fecha_fin]);
                    }
                    $participantes = $participantes->get();
                    $cont = 1;
                @endphp
                @foreach ($participantes as $participante)
                    <tr
                        class="{{ $participante->subasta->estado_txt == 'FINALIZADO' && $participante->estado == 2 ? 'bg-ganador' : '' }}">
                        <td>{{ $cont++ }}</td>
                        <td class="">{{ $participante->subasta->id }} -
                            {{ $participante->subasta->producto->nombre }}</td>
                        <td class="">{{ $participante->subasta->estado_producto }}</td>
                        <td class="">{{ $participante->subasta->monto_inicial }}</td>
                        <td class="">
                            {{ number_format($participante->subasta->monto_garantia, 2, '.', ',') }}
                            @if ($participante->estado != 2 && $participante->estado_comprobante == 1)
                                <br />
                                DEVOLUCIÓN
                                <br />
                                {{ $participante->devolucion_txt }}
                            @endif
                        </td>
                        <td class="">{{ $participante->subasta->fecha_fin_t }}</td>
                        <td class="">{{ $participante->subasta->hora_fin }}</td>
                        <td class="">{{ $participante->subasta->estado_txt }}</td>
                        <td class="">{!! $participante->subasta->descripcion !!}</td>
                    </tr>
                @endforeach
            </tbody>
        </table>

        @php
            $contador++;
        @endphp
        @if ($contador < count($users))
            <div class="nueva_pagina"></div>
        @endif
    @endforeach
</body>

</html>
