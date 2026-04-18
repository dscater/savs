<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Participantes</title>
    <style type="text/css">
        * {
            font-family: sans-serif;
        }

        @page {
            margin-top: 1.5cm;
            margin-bottom: 1cm;
            margin-left: 1cm;
            margin-right: 1cm;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
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
            height: 100px;
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
            width: 400px;
            text-align: center;
            margin: auto;
            font-weight: bold;
            font-size: 1.1em;
        }

        .fecha {
            width: 400px;
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
            width: 400px;
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

        .cumplimiento {
            position: absolute;
            width: 150px;
            right: 0px;
            top: 86px;
        }

        .b_top {
            border-top: solid 1px black;
        }

        .gray {
            background: rgb(202, 202, 202);
        }

        .bg-principal {
            background: #153f59;
            color: white;
        }

        .page_break {
            page-break-after: always;
        }

        .img_celda img {
            width: 45px;
        }

        .lista {
            padding-left: 8px;
        }

        .bold {
            font-weight: bold;
        }

        .text-md {
            font-size: 1.2em;
        }

        .bg-ganador {
            background-color: #e7ffe7;
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
            <img src="{{ $configuracion->first()->logo_b64 }}">
        </div>
        <h2 class="titulo">
            {{ $configuracion->first()->razon_social }}
        </h2>
        <h4 class="texto">LISTA DE PARTICIPANTES OFERTANTES POR SUBASTA</h4>
        <h4 class="fecha">Expedido: {{ date('d-m-Y') }}</h4>
        <div style="margin-bottom: 15px;"></div>
    </div>

    @php
        $contador = 0;
    @endphp

    @foreach ($subastas as $subasta)
        @php
            $participantes = [];
            if ($fecha_ini && $fecha_fin) {
                // Illuminate\Support\Facades\Log::debug($fecha_ini);
                // Illuminate\Support\Facades\Log::debug($fecha_fin);
                $participantes = App\Models\Participante::where('subasta_id', $subasta->id)
                    ->where(function ($query) use ($fecha_ini, $fecha_fin) {
                        $query
                            ->whereBetween('fecha', [$fecha_ini, $fecha_fin])
                            ->orWhereBetween('created_at', [
                                Carbon\Carbon::parse($fecha_ini)->startOfDay(),
                                Carbon\Carbon::parse($fecha_fin)->endOfDay(),
                            ]);
                    })
                    // ->where('puja', '>', 0)
                    // ->where('estado_comprobante', 1)
                    ->get();
            } elseif ($subasta) {
                $participantes = App\Models\Participante::where('subasta_id', $subasta->id)
                    // ->where('puja', '>', 0)
                    // ->where('estado_comprobante', 1)
                    ->get();
            }

            $contador++;

        @endphp
        <table style="margin-bottom: 5px;">
            <tbody>
                <tr>
                    <td width="14%" class="bold derecha text-md">NRO. DE SUBASTA:</td>
                    <td class="text-md">{{ $subasta->id }} </td>
                </tr>
                <tr>
                    <td width="14%" class="bold derecha text-md">PRODUCTO SUBASTADO:</td>
                    <td class="text-md">{{ $subasta->producto->nombre }} </td>
                </tr>
                <tr>
                    <td width="14%" class="bold derecha text-md">DESCRIPCIÓN:</td>
                    <td class="text-md">{!! $subasta->descripcion !!} </td>
                </tr>
            </tbody>
        </table>
        <table border="1">
            <thead class="bg-principal">
                <tr>
                    <th width="3%">N°</th>
                    <th>NOMBRE DEL PARTICIPANTE</th>
                    <th>CARNET DE IDENTIDAD</th>
                    <th width="4%">COMPLEMENTO</th>
                    <th>CORREO ELECTRÓNICO</th>
                    <th>NRO. DE CELULAR</th>
                    <th>USUARIO DEL PARTICIPANTE</th>
                    <th>FECHA DE LA OFERTA</th>
                    <th>HORA DE LA OFERTA</th>
                    <th>OFERTA <br />MONTO <br />{{ $subasta->moneda_txt }}</th>
                    <th>MONTO DE GARANTÍA <br />{{ $subasta->moneda_txt }}<br />-<br />ESTADO DEVOLUCIÓN</th>
                    <th>COMPROBANTE</th>
                    <th>COMPROBANTE DE PAGO DE GARANTÍA <br />(DOCUMENTO PARA DESCARGAR)</th>
                    <th>CARNET DE IDENTIDAD <br />(DOCUMENTO PARA DESCARGAR)</th>
                    <th>ESTADO</th>
                </tr>
            </thead>
            <tbody>
                @php
                    $cont = 1;
                @endphp
                @forelse ($participantes as $participante)
                    <tr
                        class="{{ $subasta->estado_txt == 'FINALIZADO' && $participante->estado == 2 ? 'bg-ganador' : '' }}">
                        <td class="centreado">{{ $cont++ }}</td>
                        <td>{{ $participante->user->full_name }}</td>
                        <td class="">{{ $participante->user->full_ci }}</td>
                        <td class="">{{ $participante->user->complemento }}</td>
                        <td class="">{{ $participante->user->user_dato->email }}</td>
                        <td class="">{{ $participante->user->fono }}</td>
                        <td class="">{{ $participante->user->usuario }}</td>
                        <td class="">
                            @if (count($participante->participante_pujas) > 0)
                                @foreach ($participante->participante_pujas as $key_ho => $historial_oferta)
                                    <span class="{{ $key_ho == 0 ? 'bold text-md' : '' }}">-
                                        {{ $historial_oferta->fecha_t }}
                                    </span><br>
                                @endforeach
                            @else
                                {{ $participante->fecha_t }}
                            @endif
                        </td>
                        <td class="">
                            @if (count($participante->participante_pujas) > 0)
                                @foreach ($participante->participante_pujas as $key_ho => $historial_oferta)
                                    <span class="{{ $key_ho == 0 ? 'bold text-md' : '' }}">-
                                        {{ $historial_oferta->hora }}
                                    </span><br>
                                @endforeach
                            @else
                                {{ $participante->hora }}
                            @endif
                        </td>
                        <td class="centreado">
                            @if (count($participante->participante_pujas) > 0)
                                @foreach ($participante->participante_pujas as $key_ho => $historial_oferta)
                                    <span class="{{ $key_ho == 0 ? 'bold text-md' : '' }}">-
                                        {{ number_format($historial_oferta->puja, 2, '.', ',') }}</span><br>
                                @endforeach
                            @else
                                {{ number_format($participante->puja, 2, '.', ',') }}
                            @endif
                        </td>
                        <td class="centreado">
                            {{ number_format($subasta->monto_garantia, 2, '.', ',') }}
                            @if ($participante->estado != 2 && $participante->estado_comprobante == 1)
                                <br />
                                DEVOLUCIÓN
                                <br />
                                {{ $participante->devolucion_txt }}
                            @endif
                        </td>
                        <td>
                            {{ $participante->estado_comprobante_t }}
                        </td>
                        <td class="">{{ $participante->url_comprobante }}</td>
                        <td class="">{{ $participante->user->user_dato->url_ci_anverso }} <br>
                            {{ $participante->user->user_dato->url_ci_reverso }}</td>
                        <td>
                            @if ($participante->estado == 2)
                                GANADOR
                            @else
                                PARTICIPANDO
                            @endif
                        </td>
                    </tr>

                @empty
                    <tr>
                        <td colspan="15">
                            SIN PARTICIPANTES
                        </td>
                    </tr>
                @endforelse
            </tbody>
        </table>
        @if ($contador < count($subastas))
            <div class="page_break"></div>
        @endif
    @endforeach
</body>

</html>
