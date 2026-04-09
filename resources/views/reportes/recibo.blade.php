<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Recibo</title>
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

        body {
            color: #072a68;
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
            font-size: 9pt;
        }

        table tbody tr td {
            font-size: 8pt;
        }


        .encabezado {
            width: 100%;
        }

        .logo img {
            position: absolute;
            height: 70px;
            top: -20px;
            left: 0px;
        }

        h2.titulo {
            width: 450px;
            margin: auto;
            margin-top: 0PX;
            text-align: center;
            font-size: 14pt;
            color: #072a68;
        }

        .texto {
            width: 250px;
            text-align: center;
            margin: auto;
            font-weight: bold;
            font-size: 1.1em;
            color: #072a68;
        }

        .fecha {
            width: 250px;
            text-align: center;
            margin: auto;
            font-weight: normal;
            font-size: 0.85em;
        }

        table {
            width: 100%;
        }

        table thead {
            background: #f8f8f8;
        }

        tr {
            page-break-inside: avoid !important;
        }

        .centreado {
            padding-left: 0px;
            text-align: center;
        }


        .gray {
            background: #f8f8f8;
        }

        .bold {}

        .bg-principal {
            background: #072a68;
            color: white;
        }

        .derecha {
            text-align: right;
        }

        .izquierda {
            text-align: left;
        }


        .bold {
            color: #072a68;
            font-weight: bold;
        }

        .text-md {
            font-size: 10pt;
        }

        .border-t {
            border-top: solid 1px #072a68;
        }

        .nro_venta {
            position: absolute;
            right: 0px;
            top: 0px;
            border: solid 1px #072a68;
            border-radius: 8px;
            padding: 5px;
        }

        .anulado {
            margin-top: 0;
            margin-bottom: 0;
            color: red;
            font-weight: bold;
            width: 100%;
            display: block;
            text-align: center;
            font-size: 12pt;
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
        <h4 class="texto">RECIBO DE VENTA</h4>
        @if ($venta->status == 0)
            <h4 class="anulado">ANULADO</h4>
        @endif
        <div class="nro_venta">
            <span class="bold">Nro.:</span>
            <span>{{ $nro_venta }}</span>
        </div>
    </div>
    <table class="info_venta">
        <tbody>
            <tr>
                <td class="bold" width="20%">Nombre/Razón Social:</td>
                <td width="40%">{{ $venta->cliente->nombre }}</td>
                <td class="bold" width="10%">NIT/C.I.:</td>
                <td>{{ $venta->nit_ci }}</td>
            </tr>
            <tr>
                <td class="bold">Fecha y Hora:</td>
                <td>{{ $venta->fecha_t }} {{ $venta->hora }}</td>
                <td class="bold">Usuario:</td>
                <td>{{ $venta->user->usuario }}</td>
            </tr>
        </tbody>
    </table>
    <table class="table table-bordered">
        <thead>
            <tr class="bg-principal">
                <th class="izquierda" width="9%">CÓDIGO</th>
                <th class="izquierda" width="30%">DESCRIPCIÓN</th>
                <th>CANTIDAD</th>
                <th>C/U BS.</th>
                <th>SUBTOTAL BS.</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($venta->venta_detalles as $item)
                <tr>
                    <td>
                        {{ $item->producto->codigo }}
                    </td>
                    <td>
                        {{ $item->producto->nombre }}
                    </td>
                    <td class="centreado">{{ $item->cantidad }}</td>
                    <td class="derecha">{{ $item->precio }}</td>
                    <td class="derecha">{{ $item->subtotal }}</td>
                </tr>
            @endforeach
            <tr class="border-t">
                <td class="derecha bold text-md" colspan="4">
                    TOTAL BS.
                </td>
                <td class="derecha bold text-md">
                    {{ $venta->total }}
                </td>
            </tr>
        </tbody>
    </table>
</body>

</html>
