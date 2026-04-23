<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>StockProductos</title>
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

        .red,
        .red td {
            background: rgb(255, 215, 215);
        }

        .warning,
        .warning td {
            background: rgb(255, 249, 218);
        }

        .bg-principal {
            background: #153f59;
            color: white;
        }

        .img_celda img {
            width: 45px;
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
        <h4 class="texto">STOCK DE PRODUCTOS</h4>
        <h4 class="fecha">Expedido: {{ date('d/m/Y') }}</h4>
    </div>
    <table border="1">
        <thead class="bg-principal">
            <tr>
                <th width="3%">N°</th>
                <th>CÓDIGO</th>
                <th>NOMBRE</th>
                <th>CATEGORÍA</th>
                <th>STOCK</th>
            </tr>
        </thead>
        <tbody>
            @php
                $cont = 1;
            @endphp
            @foreach ($productos as $item)
                @php
                    $class = '';
                    if ($item->stock < 3) {
                        $class = 'warning';
                    }
                    if ($item->stock < 1) {
                        $class = 'red';
                    }
                @endphp
                <tr class="{{ $class }}">
                    <td class="centreado">{{ $cont++ }}</td>
                    <td>{{ $item->codigo }}</td>
                    <td>{{ $item->nombre }}</td>
                    <td>{{ $item->categoria->nombre }}</td>
                    <td>{{ $item->stock }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>
</body>

</html>
