<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use App\Models\Publicacion;
use App\Models\User;
use App\Services\HistorialAccionService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use Inertia\Response;

class AuthenticatedSessionController extends Controller
{
    private $modulo = "LOGIN";

    public function __construct(private HistorialAccionService $historial_accion_service) {}

    /**
     * Display the login view.
     */
    public function create(): Response|RedirectResponse
    {
        if (Auth::check()) {
            return redirect()->route('inicio');
        }

        return Inertia::render('Auth/Login', [
            'canResetPassword' => Route::has('password.request'),
            'status' => session('status'),
        ]);
    }

    /**
     * Handle an incoming authentication request.
     */
    public function store(LoginRequest $request)
    {
        $request->authenticate();
        $request->session()->regenerate();

        // registrar accion
        $this->historial_accion_service->registrarAccion($this->modulo, "INICIO DE SESIÓN", Auth::user()->usuario . " INICIO SESIÓN", User::find(Auth::user()->id), null);

        if ($request->ajax()) {
            $user = User::findOrFail(Auth::user()->id);
            return response()->JSON(["user" => Auth::user()]);
        }

        if (Auth::user()->tipo === 'PARTICIPANTE') {
            return redirect()->intended(route('portal.index'));
        }

        return redirect()->intended(route('inicio'));
    }

    /**
     * Destroy an authenticated session.
     */
    public function destroy(Request $request): RedirectResponse|JsonResponse
    {
        // registrar accion
        $this->historial_accion_service->registrarAccion($this->modulo, "FIN DE SESIÓN", Auth::user()->usuario . " CERRÓ SESIÓN", User::find(Auth::user()->id), null,);

        Auth::guard('web')->logout();

        $request->session()->invalidate();

        $request->session()->regenerateToken();

        if ($request->ajax()) {
            return response()->JSON(true);
        }
        return redirect()->intended(route('login'));
    }
}
