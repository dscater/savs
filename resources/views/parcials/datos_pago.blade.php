<div class="row">
    <div class="col-12">
        <p><strong>TITULAR:</strong> {{ $parametrizacion->datos_banco['titular'] }}</p>
        <p><strong>BANCO:</strong> {{ $parametrizacion->datos_banco['banco'] }}</p>
        <p><strong>NRO. CUENTA: </strong> {{ $parametrizacion->datos_banco['nro_cuenta'] }}</p>
        <p><strong>QR:</strong> <img src="{{ asset('imgs/' . $parametrizacion->datos_banco['qr']) }}" alt=""
                style="max-width: 100%;max-height:300px">
        </p>
    </div>
</div>
