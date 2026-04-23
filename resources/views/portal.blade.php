<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title inertia>{{ config('app.name', 'Laravel') }}</title>
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.bunny.net">
    <link href="https://fonts.bunny.net/css?family=figtree:400,500,600&display=swap" rel="stylesheet" />

    <style>
        @font-face {
            font-family: "Inter var";
            font-weight: 100 900;
            font-display: swap;
            font-style: normal;
            font-named-instance: "Regular";
            src: url("/webfonts/Inter-roman.var.woff2") format("woff2");
        }

        @font-face {
            font-family: "Inter var";
            font-weight: 100 900;
            font-display: swap;
            font-style: italic;
            font-named-instance: "Italic";
            src: url("/webfonts/Inter-italic.var.woff2") format("woff2");
        }

        @font-face {
            font-family: "Outfit";
            font-weight: 100 900;
            font-display: swap;
            font-style: normal;
            src: url("/webfonts/Outfit/Outfit-VariableFont_wght.ttf") format("truetype");
        }
    </style>

    <script>
        const url_assets = "{{ asset('') }}";
    </script>
    {{-- CSS --}}
    @routes
    @vite(['resources/js/portal.js', "resources/js/Pages/{$page['component']}.vue"])
    @inertiaHead
</head>

<body class="app-blank layout-fixed layout-navbar-fixed portal">
    @inertia
</body>

</html>
