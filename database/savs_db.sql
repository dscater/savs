--
-- PostgreSQL database dump
--

\restrict lEpaeuuXma659dn2R2z7cDYQhdUBHKGH3YHTduHcxMgV9aKvRNV0fCCiluJhFos

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

-- Started on 2026-04-23 18:33:14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 226 (class 1259 OID 24629)
-- Name: categorias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorias (
    id bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    descripcion character varying(900),
    fecha_registro date NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.categorias OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24628)
-- Name: categorias_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categorias_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categorias_id_seq OWNER TO postgres;

--
-- TOC entry 5133 (class 0 OID 0)
-- Dependencies: 225
-- Name: categorias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categorias_id_seq OWNED BY public.categorias.id;


--
-- TOC entry 240 (class 1259 OID 24724)
-- Name: clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clientes (
    id bigint NOT NULL,
    nombre character varying(300) NOT NULL,
    nit_ci character varying(20),
    cel character varying(40),
    correo character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    fecha_registro date NOT NULL
);


ALTER TABLE public.clientes OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 24723)
-- Name: clientes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clientes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clientes_id_seq OWNER TO postgres;

--
-- TOC entry 5134 (class 0 OID 0)
-- Dependencies: 239
-- Name: clientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clientes_id_seq OWNED BY public.clientes.id;


--
-- TOC entry 220 (class 1259 OID 24587)
-- Name: configuracions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.configuracions (
    id bigint NOT NULL,
    nombre_sistema character varying(255) NOT NULL,
    alias character varying(255),
    razon_social character varying(255),
    logo character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.configuracions OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24586)
-- Name: configuracions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.configuracions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.configuracions_id_seq OWNER TO postgres;

--
-- TOC entry 5135 (class 0 OID 0)
-- Dependencies: 219
-- Name: configuracions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.configuracions_id_seq OWNED BY public.configuracions.id;


--
-- TOC entry 224 (class 1259 OID 24606)
-- Name: historial_accions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historial_accions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    accion character varying(155) NOT NULL,
    descripcion text NOT NULL,
    datos_original json,
    datos_nuevo json,
    modulo character varying(155) NOT NULL,
    fecha date NOT NULL,
    hora time(0) without time zone NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.historial_accions OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24605)
-- Name: historial_accions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.historial_accions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.historial_accions_id_seq OWNER TO postgres;

--
-- TOC entry 5136 (class 0 OID 0)
-- Dependencies: 223
-- Name: historial_accions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historial_accions_id_seq OWNED BY public.historial_accions.id;


--
-- TOC entry 232 (class 1259 OID 24669)
-- Name: ingreso_productos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ingreso_productos (
    id bigint NOT NULL,
    producto_id bigint NOT NULL,
    cantidad double precision NOT NULL,
    descripcion text,
    fecha_registro date,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.ingreso_productos OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 24668)
-- Name: ingreso_productos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ingreso_productos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ingreso_productos_id_seq OWNER TO postgres;

--
-- TOC entry 5137 (class 0 OID 0)
-- Dependencies: 231
-- Name: ingreso_productos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ingreso_productos_id_seq OWNED BY public.ingreso_productos.id;


--
-- TOC entry 236 (class 1259 OID 24697)
-- Name: kardex_productos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kardex_productos (
    id bigint NOT NULL,
    tipo_registro character varying(255),
    registro_id bigint,
    modulo character varying(255),
    producto_id bigint NOT NULL,
    detalle text NOT NULL,
    precio numeric(24,2),
    tipo_is character varying(255) NOT NULL,
    cantidad_ingreso double precision,
    cantidad_salida double precision,
    cantidad_saldo double precision NOT NULL,
    cu numeric(24,2) NOT NULL,
    monto_ingreso numeric(24,2),
    monto_salida numeric(24,2),
    monto_saldo numeric(24,2) NOT NULL,
    fecha date NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.kardex_productos OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 24696)
-- Name: kardex_productos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kardex_productos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.kardex_productos_id_seq OWNER TO postgres;

--
-- TOC entry 5138 (class 0 OID 0)
-- Dependencies: 235
-- Name: kardex_productos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kardex_productos_id_seq OWNED BY public.kardex_productos.id;


--
-- TOC entry 218 (class 1259 OID 24580)
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24579)
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO postgres;

--
-- TOC entry 5139 (class 0 OID 0)
-- Dependencies: 217
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- TOC entry 252 (class 1259 OID 24800)
-- Name: notificacion_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notificacion_users (
    id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    notificacion_id bigint,
    user_id bigint,
    visto integer DEFAULT 0
);


ALTER TABLE public.notificacion_users OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 24799)
-- Name: notificacion_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notificacion_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notificacion_users_id_seq OWNER TO postgres;

--
-- TOC entry 5140 (class 0 OID 0)
-- Dependencies: 251
-- Name: notificacion_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notificacion_users_id_seq OWNED BY public.notificacion_users.id;


--
-- TOC entry 250 (class 1259 OID 24791)
-- Name: notificacions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notificacions (
    id bigint NOT NULL,
    modulo character varying(255) NOT NULL,
    registro_id bigint NOT NULL,
    descripcion text NOT NULL,
    fecha date NOT NULL,
    hora time(0) without time zone NOT NULL,
    tipo character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.notificacions OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 24790)
-- Name: notificacions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notificacions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notificacions_id_seq OWNER TO postgres;

--
-- TOC entry 5141 (class 0 OID 0)
-- Dependencies: 249
-- Name: notificacions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notificacions_id_seq OWNED BY public.notificacions.id;


--
-- TOC entry 256 (class 1259 OID 24905)
-- Name: parametrizacions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.parametrizacions (
    id bigint NOT NULL,
    servidor_correo json NOT NULL,
    datos_banco json NOT NULL,
    tiempo_pub integer NOT NULL,
    terminos_condiciones text NOT NULL,
    verificar_comprobante text NOT NULL,
    comp_rechazado text NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.parametrizacions OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 24904)
-- Name: parametrizacions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.parametrizacions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.parametrizacions_id_seq OWNER TO postgres;

--
-- TOC entry 5142 (class 0 OID 0)
-- Dependencies: 255
-- Name: parametrizacions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.parametrizacions_id_seq OWNED BY public.parametrizacions.id;


--
-- TOC entry 248 (class 1259 OID 24779)
-- Name: participante_pujas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.participante_pujas (
    id bigint NOT NULL,
    participante_id bigint NOT NULL,
    monto numeric(24,2) NOT NULL,
    fecha date NOT NULL,
    hora time(0) without time zone NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    user_id bigint NOT NULL,
    subasta_id bigint NOT NULL
);


ALTER TABLE public.participante_pujas OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 24778)
-- Name: participante_pujas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.participante_pujas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.participante_pujas_id_seq OWNER TO postgres;

--
-- TOC entry 5143 (class 0 OID 0)
-- Dependencies: 247
-- Name: participante_pujas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.participante_pujas_id_seq OWNED BY public.participante_pujas.id;


--
-- TOC entry 246 (class 1259 OID 24762)
-- Name: participantes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.participantes (
    id bigint NOT NULL,
    subasta_id bigint NOT NULL,
    user_id bigint NOT NULL,
    fecha date NOT NULL,
    hora time(0) without time zone NOT NULL,
    monto_puja numeric(24,2) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    estado integer NOT NULL,
    garantia integer NOT NULL,
    comprobante character varying(255),
    estado_comprobante integer DEFAULT 0 NOT NULL,
    fecha_comprobante date,
    hora_comprobante time without time zone,
    devolucion integer DEFAULT 0,
    descripcion_devolucion text,
    fecha_devolucion date,
    hora_devolucion time without time zone
);


ALTER TABLE public.participantes OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 24761)
-- Name: participantes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.participantes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.participantes_id_seq OWNER TO postgres;

--
-- TOC entry 5144 (class 0 OID 0)
-- Dependencies: 245
-- Name: participantes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.participantes_id_seq OWNED BY public.participantes.id;


--
-- TOC entry 230 (class 1259 OID 24657)
-- Name: producto_imagens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.producto_imagens (
    id bigint NOT NULL,
    producto_id bigint NOT NULL,
    imagen character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.producto_imagens OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 24656)
-- Name: producto_imagens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.producto_imagens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.producto_imagens_id_seq OWNER TO postgres;

--
-- TOC entry 5145 (class 0 OID 0)
-- Dependencies: 229
-- Name: producto_imagens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.producto_imagens_id_seq OWNED BY public.producto_imagens.id;


--
-- TOC entry 228 (class 1259 OID 24640)
-- Name: productos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productos (
    id bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    descripcion text,
    precio numeric(24,2) NOT NULL,
    stock double precision DEFAULT '0'::double precision NOT NULL,
    categoria_id bigint NOT NULL,
    fecha_registro date NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    codigo character varying(255) NOT NULL,
    tsg integer DEFAULT 0
);


ALTER TABLE public.productos OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 24639)
-- Name: productos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productos_id_seq OWNER TO postgres;

--
-- TOC entry 5146 (class 0 OID 0)
-- Dependencies: 227
-- Name: productos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productos_id_seq OWNED BY public.productos.id;


--
-- TOC entry 258 (class 1259 OID 24929)
-- Name: recuperar_passwords; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recuperar_passwords (
    id bigint NOT NULL,
    cod character varying(255) NOT NULL,
    user_id bigint NOT NULL,
    status integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.recuperar_passwords OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 24928)
-- Name: recuperar_passwords_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recuperar_passwords_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recuperar_passwords_id_seq OWNER TO postgres;

--
-- TOC entry 5147 (class 0 OID 0)
-- Dependencies: 257
-- Name: recuperar_passwords_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recuperar_passwords_id_seq OWNED BY public.recuperar_passwords.id;


--
-- TOC entry 234 (class 1259 OID 24683)
-- Name: salida_productos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.salida_productos (
    id bigint NOT NULL,
    producto_id bigint NOT NULL,
    cantidad double precision NOT NULL,
    descripcion text,
    fecha_registro date,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.salida_productos OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 24682)
-- Name: salida_productos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.salida_productos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.salida_productos_id_seq OWNER TO postgres;

--
-- TOC entry 5148 (class 0 OID 0)
-- Dependencies: 233
-- Name: salida_productos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.salida_productos_id_seq OWNED BY public.salida_productos.id;


--
-- TOC entry 238 (class 1259 OID 24712)
-- Name: subastas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subastas (
    id bigint NOT NULL,
    producto_id bigint NOT NULL,
    estado_producto character varying(255) NOT NULL,
    monto_inicial numeric(24,2) NOT NULL,
    fecha_fin date NOT NULL,
    hora_fin time(0) without time zone NOT NULL,
    publico integer NOT NULL,
    estado_subasta integer DEFAULT 1 NOT NULL,
    fecha_registro date NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    garantia numeric(24,2) DEFAULT 0 NOT NULL,
    descripcion text
);


ALTER TABLE public.subastas OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 24711)
-- Name: subastas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subastas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subastas_id_seq OWNER TO postgres;

--
-- TOC entry 5149 (class 0 OID 0)
-- Dependencies: 237
-- Name: subastas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subastas_id_seq OWNED BY public.subastas.id;


--
-- TOC entry 254 (class 1259 OID 24891)
-- Name: user_datos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_datos (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    foto_ci_anverso character varying(255),
    foto_ci_reverso character varying(255),
    banco character varying(255) NOT NULL,
    nro_cuenta character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    ci character varying(155) NOT NULL,
    ci_exp character varying(155) NOT NULL,
    complemento character varying(155),
    dpto_residencia character varying(255) NOT NULL,
    email character varying(255) NOT NULL
);


ALTER TABLE public.user_datos OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 24890)
-- Name: user_datos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_datos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_datos_id_seq OWNER TO postgres;

--
-- TOC entry 5150 (class 0 OID 0)
-- Dependencies: 253
-- Name: user_datos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_datos_id_seq OWNED BY public.user_datos.id;


--
-- TOC entry 222 (class 1259 OID 24596)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    usuario character varying(255) NOT NULL,
    nombre character varying(255) NOT NULL,
    paterno character varying(255) NOT NULL,
    materno character varying(255),
    correo character varying(255),
    fono character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    acceso integer NOT NULL,
    tipo character varying(255) NOT NULL,
    foto character varying(255),
    fecha_registro date NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    ci character varying(255),
    ci_exp character varying(255)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24595)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5151 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 244 (class 1259 OID 24745)
-- Name: venta_detalles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venta_detalles (
    id bigint NOT NULL,
    venta_id bigint NOT NULL,
    producto_id bigint NOT NULL,
    precio numeric(24,2) NOT NULL,
    cantidad double precision NOT NULL,
    subtotal numeric(24,2) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.venta_detalles OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 24744)
-- Name: venta_detalles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.venta_detalles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.venta_detalles_id_seq OWNER TO postgres;

--
-- TOC entry 5152 (class 0 OID 0)
-- Dependencies: 243
-- Name: venta_detalles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.venta_detalles_id_seq OWNED BY public.venta_detalles.id;


--
-- TOC entry 242 (class 1259 OID 24733)
-- Name: ventas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ventas (
    id bigint NOT NULL,
    cliente_id bigint NOT NULL,
    total numeric(24,2) NOT NULL,
    fecha date NOT NULL,
    hora time(0) without time zone NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    status integer DEFAULT 1 NOT NULL,
    nit_ci character varying(255),
    user_id bigint NOT NULL
);


ALTER TABLE public.ventas OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 24732)
-- Name: ventas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ventas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ventas_id_seq OWNER TO postgres;

--
-- TOC entry 5153 (class 0 OID 0)
-- Dependencies: 241
-- Name: ventas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ventas_id_seq OWNED BY public.ventas.id;


--
-- TOC entry 4847 (class 2604 OID 24632)
-- Name: categorias id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias ALTER COLUMN id SET DEFAULT nextval('public.categorias_id_seq'::regclass);


--
-- TOC entry 4859 (class 2604 OID 24727)
-- Name: clientes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes ALTER COLUMN id SET DEFAULT nextval('public.clientes_id_seq'::regclass);


--
-- TOC entry 4843 (class 2604 OID 24590)
-- Name: configuracions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configuracions ALTER COLUMN id SET DEFAULT nextval('public.configuracions_id_seq'::regclass);


--
-- TOC entry 4846 (class 2604 OID 24609)
-- Name: historial_accions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_accions ALTER COLUMN id SET DEFAULT nextval('public.historial_accions_id_seq'::regclass);


--
-- TOC entry 4852 (class 2604 OID 24672)
-- Name: ingreso_productos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingreso_productos ALTER COLUMN id SET DEFAULT nextval('public.ingreso_productos_id_seq'::regclass);


--
-- TOC entry 4854 (class 2604 OID 24700)
-- Name: kardex_productos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kardex_productos ALTER COLUMN id SET DEFAULT nextval('public.kardex_productos_id_seq'::regclass);


--
-- TOC entry 4842 (class 2604 OID 24583)
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- TOC entry 4868 (class 2604 OID 24803)
-- Name: notificacion_users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificacion_users ALTER COLUMN id SET DEFAULT nextval('public.notificacion_users_id_seq'::regclass);


--
-- TOC entry 4867 (class 2604 OID 24794)
-- Name: notificacions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificacions ALTER COLUMN id SET DEFAULT nextval('public.notificacions_id_seq'::regclass);


--
-- TOC entry 4871 (class 2604 OID 24908)
-- Name: parametrizacions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parametrizacions ALTER COLUMN id SET DEFAULT nextval('public.parametrizacions_id_seq'::regclass);


--
-- TOC entry 4866 (class 2604 OID 24782)
-- Name: participante_pujas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participante_pujas ALTER COLUMN id SET DEFAULT nextval('public.participante_pujas_id_seq'::regclass);


--
-- TOC entry 4863 (class 2604 OID 24765)
-- Name: participantes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participantes ALTER COLUMN id SET DEFAULT nextval('public.participantes_id_seq'::regclass);


--
-- TOC entry 4851 (class 2604 OID 24660)
-- Name: producto_imagens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto_imagens ALTER COLUMN id SET DEFAULT nextval('public.producto_imagens_id_seq'::regclass);


--
-- TOC entry 4848 (class 2604 OID 24643)
-- Name: productos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos ALTER COLUMN id SET DEFAULT nextval('public.productos_id_seq'::regclass);


--
-- TOC entry 4872 (class 2604 OID 24932)
-- Name: recuperar_passwords id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recuperar_passwords ALTER COLUMN id SET DEFAULT nextval('public.recuperar_passwords_id_seq'::regclass);


--
-- TOC entry 4853 (class 2604 OID 24686)
-- Name: salida_productos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salida_productos ALTER COLUMN id SET DEFAULT nextval('public.salida_productos_id_seq'::regclass);


--
-- TOC entry 4856 (class 2604 OID 24715)
-- Name: subastas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subastas ALTER COLUMN id SET DEFAULT nextval('public.subastas_id_seq'::regclass);


--
-- TOC entry 4870 (class 2604 OID 24894)
-- Name: user_datos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_datos ALTER COLUMN id SET DEFAULT nextval('public.user_datos_id_seq'::regclass);


--
-- TOC entry 4844 (class 2604 OID 24599)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4862 (class 2604 OID 24748)
-- Name: venta_detalles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_detalles ALTER COLUMN id SET DEFAULT nextval('public.venta_detalles_id_seq'::regclass);


--
-- TOC entry 4860 (class 2604 OID 24736)
-- Name: ventas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas ALTER COLUMN id SET DEFAULT nextval('public.ventas_id_seq'::regclass);


--
-- TOC entry 5095 (class 0 OID 24629)
-- Dependencies: 226
-- Data for Name: categorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorias (id, nombre, descripcion, fecha_registro, created_at, updated_at) FROM stdin;
1	FAROS		2026-04-08	2026-04-08 10:54:38	2026-04-18 16:55:20
3	PARACHOQUES		2026-04-08	2026-04-08 10:54:47	2026-04-18 16:55:34
2	RETROVISORES		2026-04-08	2026-04-08 10:54:42	2026-04-18 16:56:37
4	PARACHOQUES TRASEROS		2026-04-18	2026-04-18 19:24:20	2026-04-18 19:24:20
\.


--
-- TOC entry 5109 (class 0 OID 24724)
-- Dependencies: 240
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clientes (id, nombre, nit_ci, cel, correo, created_at, updated_at, fecha_registro) FROM stdin;
1	JUAN PEREZ	123456	67676767	juan@gmail.com	2026-04-08 16:56:30	2026-04-08 16:56:30	2026-04-08
2	CONDORI ALEX		\N	\N	2026-04-08 16:56:42	2026-04-08 16:56:42	2026-04-08
3	SANDOVAL	543453453	78787878	\N	2026-04-17 16:20:23	2026-04-17 16:20:23	2026-04-17
4	CHIRI	345345345	\N	\N	2026-04-17 16:20:31	2026-04-17 16:20:31	2026-04-17
5	CONDORI		\N	\N	2026-04-17 16:20:50	2026-04-17 16:20:50	2026-04-17
6	RODRIGUEZ	3442343	\N	\N	2026-04-18 19:22:20	2026-04-18 19:22:28	2026-04-18
\.


--
-- TOC entry 5089 (class 0 OID 24587)
-- Dependencies: 220
-- Data for Name: configuracions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.configuracions (id, nombre_sistema, alias, razon_social, logo, created_at, updated_at) FROM stdin;
1	SAVS	SAVS	SAVS S.A.	logo.jpeg	2026-04-07 16:04:07	2026-04-07 16:04:07
\.


--
-- TOC entry 5093 (class 0 OID 24606)
-- Dependencies: 224
-- Data for Name: historial_accions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historial_accions (id, user_id, accion, descripcion, datos_original, datos_nuevo, modulo, fecha, hora, created_at, updated_at) FROM stdin;
1	1	CREACIÓN	EL USUARIO admin REGISTRO UN USUARIO	{"usuario":"JPERES","nombre":"JUAN","paterno":"PERES","materno":"MAMANI","correo":"juan@gmail.com","fono":"67676767","acceso":"1","tipo":"ADMINISTRADOR","fecha_registro":"2026-04-08","updated_at":"2026-04-08T13:54:15.000000Z","created_at":"2026-04-08T13:54:15.000000Z","id":2,"foto":"21775656455.jpg"}	\N	USUARIOS	2026-04-08	09:54:15	2026-04-08 09:54:15	2026-04-08 09:54:15
2	1	CREACIÓN	EL USUARIO admin REGISTRO UN USUARIO	{"usuario":"GCARVAJAL","nombre":"GERMAN","paterno":"CARVAJAL","materno":"","correo":null,"fono":"67676767","acceso":"1","tipo":"AUXILIAR","fecha_registro":"2026-04-08","updated_at":"2026-04-08T13:54:55.000000Z","created_at":"2026-04-08T13:54:55.000000Z","id":3}	\N	USUARIOS	2026-04-08	09:54:55	2026-04-08 09:54:55	2026-04-08 09:54:55
3	1	CREACIÓN	EL USUARIO admin REGISTRO UNA CATEGORIA	{"nombre":"CATEGOR\\u00cdA 1","descripcion":"DESCRIPCION","fecha_registro":"2026-04-08","updated_at":"2026-04-08T14:50:14.000000Z","created_at":"2026-04-08T14:50:14.000000Z","id":2}	\N	CATEGORIAS	2026-04-08	10:50:14	2026-04-08 10:50:14	2026-04-08 10:50:14
4	1	CREACIÓN	EL USUARIO admin REGISTRO UNA CATEGORIA	{"nombre":"CATEGORIA 2","descripcion":"","fecha_registro":"2026-04-08","updated_at":"2026-04-08T14:50:21.000000Z","created_at":"2026-04-08T14:50:21.000000Z","id":3}	\N	CATEGORIAS	2026-04-08	10:50:21	2026-04-08 10:50:21	2026-04-08 10:50:21
5	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UNA CATEGORIA	{"id":2,"nombre":"CATEGOR\\u00cdA 1","descripcion":"DESCRIPCION","fecha_registro":"2026-04-08","created_at":"2026-04-08T14:50:14.000000Z","updated_at":"2026-04-08T14:50:14.000000Z"}	{"id":2,"nombre":"CATEGOR\\u00cdA 1ASD","descripcion":"DESCRIPCIONASD","fecha_registro":"2026-04-08","created_at":"2026-04-08T14:50:14.000000Z","updated_at":"2026-04-08T14:50:25.000000Z"}	CATEGORIAS	2026-04-08	10:50:26	2026-04-08 10:50:26	2026-04-08 10:50:26
6	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UNA CATEGORIA	{"id":2,"nombre":"CATEGOR\\u00cdA 1ASD","descripcion":"DESCRIPCIONASD","fecha_registro":"2026-04-08","created_at":"2026-04-08T14:50:14.000000Z","updated_at":"2026-04-08T14:50:25.000000Z"}	{"id":2,"nombre":"CATEGOR\\u00cdA 1","descripcion":"DESCRIPCION","fecha_registro":"2026-04-08","created_at":"2026-04-08T14:50:14.000000Z","updated_at":"2026-04-08T14:50:32.000000Z"}	CATEGORIAS	2026-04-08	10:50:32	2026-04-08 10:50:32	2026-04-08 10:50:32
7	1	CREACIÓN	EL USUARIO admin REGISTRO UNA CATEGORIA	{"nombre":"CATEGORIA 1","descripcion":"DESC 1","fecha_registro":"2026-04-08","updated_at":"2026-04-08T14:54:38.000000Z","created_at":"2026-04-08T14:54:38.000000Z","id":1}	\N	CATEGORIAS	2026-04-08	10:54:38	2026-04-08 10:54:38	2026-04-08 10:54:38
8	1	CREACIÓN	EL USUARIO admin REGISTRO UNA CATEGORIA	{"nombre":"CATEGORIA 2","descripcion":"","fecha_registro":"2026-04-08","updated_at":"2026-04-08T14:54:42.000000Z","created_at":"2026-04-08T14:54:42.000000Z","id":2}	\N	CATEGORIAS	2026-04-08	10:54:42	2026-04-08 10:54:42	2026-04-08 10:54:42
9	1	CREACIÓN	EL USUARIO admin REGISTRO UNA CATEGORIA	{"nombre":"CATEGORIA 3","descripcion":"","fecha_registro":"2026-04-08","updated_at":"2026-04-08T14:54:47.000000Z","created_at":"2026-04-08T14:54:47.000000Z","id":3}	\N	CATEGORIAS	2026-04-08	10:54:47	2026-04-08 10:54:47	2026-04-08 10:54:47
10	1	CREACIÓN	EL USUARIO admin REGISTRO UN PRODUCTO	{"nombre":"PRODUCTO 1","descripcion":"<H2>DESCRIPCI\\u00d3N DEL PRODUCTO<\\/H2><P><SPAN STYLE=\\"COLOR: RGB(0, 0, 0);\\">IT IS A LONG ESTABLISHED FACT THAT A READER WILL BE DISTRACTED BY THE READABLE CONTENT OF A PAGE WHEN LOOKING AT ITS LAYOUT. THE POINT OF USING LOREM IPSUM IS THAT IT HAS A MORE-OR-LESS NORMAL DISTRIBUTION OF LETTERS, AS OPPOSED TO USING 'CONTENT HERE, CONTENT HERE', MAKING IT LOOK LIKE READABLE ENGLISH. MANY DESKTOP PUBLISHING PACKAGES AND WEB PAGE EDITORS NOW USE LOREM IPSUM AS THEIR DEFAULT MODEL TEXT, AND A SEARCH FOR 'LOREM IPSUM' WILL UNCOVER MANY WEB SITES STILL IN THEIR INFANCY. VARIOUS VERSIONS HAVE EVOLVED OVER THE YEARS, SOMETIMES BY ACCIDENT, SOMETIMES ON PURPOSE (INJECTED HUMOUR AND THE LIKE).<\\/SPAN><\\/P>","precio":"120","categoria_id":"1","fecha_registro":"2026-04-08","updated_at":"2026-04-08T15:39:00.000000Z","created_at":"2026-04-08T15:39:00.000000Z","id":1}	\N	PRODUCTOS	2026-04-08	11:39:00	2026-04-08 11:39:00	2026-04-08 11:39:00
11	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UN PRODUCTO	{"id":1,"nombre":"PRODUCTO 1","descripcion":"<H2>DESCRIPCI\\u00d3N DEL PRODUCTO<\\/H2><P><SPAN STYLE=\\"COLOR: RGB(0, 0, 0);\\">IT IS A LONG ESTABLISHED FACT THAT A READER WILL BE DISTRACTED BY THE READABLE CONTENT OF A PAGE WHEN LOOKING AT ITS LAYOUT. THE POINT OF USING LOREM IPSUM IS THAT IT HAS A MORE-OR-LESS NORMAL DISTRIBUTION OF LETTERS, AS OPPOSED TO USING 'CONTENT HERE, CONTENT HERE', MAKING IT LOOK LIKE READABLE ENGLISH. MANY DESKTOP PUBLISHING PACKAGES AND WEB PAGE EDITORS NOW USE LOREM IPSUM AS THEIR DEFAULT MODEL TEXT, AND A SEARCH FOR 'LOREM IPSUM' WILL UNCOVER MANY WEB SITES STILL IN THEIR INFANCY. VARIOUS VERSIONS HAVE EVOLVED OVER THE YEARS, SOMETIMES BY ACCIDENT, SOMETIMES ON PURPOSE (INJECTED HUMOUR AND THE LIKE).<\\/SPAN><\\/P>","precio":"120.00","stock":"0","categoria_id":1,"fecha_registro":"2026-04-08","created_at":"2026-04-08T15:39:00.000000Z","updated_at":"2026-04-08T15:39:00.000000Z"}	{"id":1,"nombre":"PRODUCTO 1","descripcion":"<h2>DESCRIPCI\\u00d3N DEL PRODUCTO<\\/h2><p>IT IS A LONG ESTABLISHED FACT THAT A READER WILL BE DISTRACTED BY THE READABLE CONTENT OF A PAGE WHEN LOOKING AT ITS LAYOUT. THE POINT OF USING LOREM IPSUM IS THAT IT HAS A MORE-OR-LESS NORMAL DISTRIBUTION OF LETTERS, AS OPPOSED TO USING 'CONTENT HERE, CONTENT HERE', MAKING IT LOOK LIKE READABLE ENGLISH. MANY DESKTOP PUBLISHING PACKAGES AND WEB PAGE EDITORS NOW USE LOREM IPSUM AS THEIR DEFAULT MODEL TEXT, AND A SEARCH FOR 'LOREM IPSUM' WILL UNCOVER MANY WEB SITES STILL IN THEIR INFANCY. VARIOUS VERSIONS HAVE EVOLVED OVER THE YEARS, SOMETIMES BY ACCIDENT, SOMETIMES ON PURPOSE (INJECTED HUMOUR AND THE LIKE).<\\/p>","precio":"120.00","stock":"0","categoria_id":"1","fecha_registro":"2026-04-08","created_at":"2026-04-08T15:39:00.000000Z","updated_at":"2026-04-08T15:53:43.000000Z"}	PRODUCTOS	2026-04-08	11:53:43	2026-04-08 11:53:43	2026-04-08 11:53:43
22	1	CREACIÓN	EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTOS	{"producto_id":"1","cantidad":"90","descripcion":"INICIO STOCK","fecha_registro":"2026-04-08","updated_at":"2026-04-08T23:26:14.000000Z","created_at":"2026-04-08T23:26:14.000000Z","id":1}	\N	INGRESO DE PRODUCTOS	2026-04-08	19:26:14	2026-04-08 19:26:14	2026-04-08 19:26:14
23	1	CREACIÓN	EL USUARIO admin REGISTRO UNA SALIDA DE PRODUCTOS	{"producto_id":"1","cantidad":"1","descripcion":"POR DEFECTOS","fecha_registro":"2026-04-08","updated_at":"2026-04-08T23:28:52.000000Z","created_at":"2026-04-08T23:28:52.000000Z","id":1}	\N	SALIDA DE PRODUCTOS	2026-04-08	19:28:52	2026-04-08 19:28:52	2026-04-08 19:28:52
24	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UNA SALIDA DE PRODUCTOS	{"id":1,"producto_id":1,"cantidad":"1","descripcion":"POR DEFECTOS","fecha_registro":"2026-04-08","created_at":"2026-04-08T23:28:52.000000Z","updated_at":"2026-04-08T23:28:52.000000Z"}	{"id":1,"producto_id":"1","cantidad":"2","descripcion":"POR DEFECTOS","fecha_registro":"2026-04-08","created_at":"2026-04-08T23:28:52.000000Z","updated_at":"2026-04-08T23:31:54.000000Z"}	SALIDA DE PRODUCTOS	2026-04-08	19:31:54	2026-04-08 19:31:54	2026-04-08 19:31:54
54	1	CREACIÓN	EL USUARIO admin REGISTRO UNA SUBASTA	{"producto_id":"3","estado_producto":"SEMINUEVO","monto_inicial":"300","garantia":"150","fecha_fin":"2026-04-17","hora_fin":"11:00","publico":"1","fecha_registro":"2026-04-16","updated_at":"2026-04-16T14:33:50.000000Z","created_at":"2026-04-16T14:33:50.000000Z","id":5}	\N	SUBASTAS	2026-04-16	10:33:50	2026-04-16 10:33:50	2026-04-16 10:33:50
12	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UN PRODUCTO	{"id":1,"nombre":"PRODUCTO 1","descripcion":"<h2>DESCRIPCI\\u00d3N DEL PRODUCTO<\\/h2><p>IT IS A LONG ESTABLISHED FACT THAT A READER WILL BE DISTRACTED BY THE READABLE CONTENT OF A PAGE WHEN LOOKING AT ITS LAYOUT. THE POINT OF USING LOREM IPSUM IS THAT IT HAS A MORE-OR-LESS NORMAL DISTRIBUTION OF LETTERS, AS OPPOSED TO USING 'CONTENT HERE, CONTENT HERE', MAKING IT LOOK LIKE READABLE ENGLISH. MANY DESKTOP PUBLISHING PACKAGES AND WEB PAGE EDITORS NOW USE LOREM IPSUM AS THEIR DEFAULT MODEL TEXT, AND A SEARCH FOR 'LOREM IPSUM' WILL UNCOVER MANY WEB SITES STILL IN THEIR INFANCY. VARIOUS VERSIONS HAVE EVOLVED OVER THE YEARS, SOMETIMES BY ACCIDENT, SOMETIMES ON PURPOSE (INJECTED HUMOUR AND THE LIKE).<\\/p>","precio":"120.00","stock":"0","categoria_id":1,"fecha_registro":"2026-04-08","created_at":"2026-04-08T15:39:00.000000Z","updated_at":"2026-04-08T15:53:43.000000Z"}	{"id":1,"nombre":"PRODUCTO 1","descripcion":"<h2>DESCRIPCI\\u00d3N DEL PRODUCTO<\\/h2><p><span style=\\"color: rgb(0, 0, 0);\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><\\/p>","precio":"120.00","stock":"0","categoria_id":"1","fecha_registro":"2026-04-08","created_at":"2026-04-08T15:39:00.000000Z","updated_at":"2026-04-08T16:02:39.000000Z"}	PRODUCTOS	2026-04-08	12:02:39	2026-04-08 12:02:39	2026-04-08 12:02:39
13	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UN PRODUCTO	{"id":1,"nombre":"PRODUCTO 1","descripcion":"<h2>DESCRIPCI\\u00d3N DEL PRODUCTO<\\/h2><p><span style=\\"color: rgb(0, 0, 0);\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><\\/p>","precio":"120.00","stock":"0","categoria_id":1,"fecha_registro":"2026-04-08","created_at":"2026-04-08T15:39:00.000000Z","updated_at":"2026-04-08T16:02:39.000000Z"}	{"id":1,"nombre":"PRODUCTO 1","descripcion":"<h2><strong><u>DESCRIPCI\\u00d3N DEL PRODUCTO<\\/u><\\/strong><\\/h2><p><span style=\\"color: rgb(0, 0, 0);\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><\\/p>","precio":"120.00","stock":"0","categoria_id":"1","fecha_registro":"2026-04-08","created_at":"2026-04-08T15:39:00.000000Z","updated_at":"2026-04-08T16:02:49.000000Z"}	PRODUCTOS	2026-04-08	12:02:49	2026-04-08 12:02:49	2026-04-08 12:02:49
14	1	CREACIÓN	EL USUARIO admin REGISTRO UN CLIENTE	{"nombre":"JUAN PEREZ","nit_ci":"123456","cel":"676767676","correo":"juan@gmail.com","fecha_registro":"2026-04-08","updated_at":"2026-04-08T20:53:38.000000Z","created_at":"2026-04-08T20:53:38.000000Z","id":1}	\N	CLIENTES	2026-04-08	16:53:39	2026-04-08 16:53:39	2026-04-08 16:53:39
15	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UN CLIENTE	{"id":1,"nombre":"JUAN PEREZ","nit_ci":"123456","cel":"676767676","correo":"juan@gmail.com","created_at":"2026-04-08T20:53:38.000000Z","updated_at":"2026-04-08T20:53:38.000000Z","fecha_registro":"2026-04-08"}	{"id":1,"nombre":"JUAN PEREZS","nit_ci":"123456","cel":"676767676","correo":"juan@gmail.com","created_at":"2026-04-08T20:53:38.000000Z","updated_at":"2026-04-08T20:53:44.000000Z","fecha_registro":"2026-04-08"}	CLIENTES	2026-04-08	16:53:44	2026-04-08 16:53:44	2026-04-08 16:53:44
16	1	CREACIÓN	EL USUARIO admin REGISTRO UN CLIENTE	{"nombre":"JUAN PEREZ","nit_ci":"123456","cel":"65767675","correo":"juan@gmail.com","fecha_registro":"2026-04-08","updated_at":"2026-04-08T20:55:03.000000Z","created_at":"2026-04-08T20:55:03.000000Z","id":1}	\N	CLIENTES	2026-04-08	16:55:03	2026-04-08 16:55:03	2026-04-08 16:55:03
17	1	CREACIÓN	EL USUARIO admin REGISTRO UN CLIENTE	{"nombre":"CONDORI ALEX","nit_ci":"","cel":null,"correo":null,"fecha_registro":"2026-04-08","updated_at":"2026-04-08T20:55:56.000000Z","created_at":"2026-04-08T20:55:56.000000Z","id":4}	\N	CLIENTES	2026-04-08	16:55:56	2026-04-08 16:55:56	2026-04-08 16:55:56
18	1	CREACIÓN	EL USUARIO admin REGISTRO UN CLIENTE	{"nombre":"JUAN PEREZ","nit_ci":"123456","cel":"67676767","correo":"juan@gmail.com","fecha_registro":"2026-04-08","updated_at":"2026-04-08T20:56:30.000000Z","created_at":"2026-04-08T20:56:30.000000Z","id":1}	\N	CLIENTES	2026-04-08	16:56:30	2026-04-08 16:56:30	2026-04-08 16:56:30
19	1	CREACIÓN	EL USUARIO admin REGISTRO UN CLIENTE	{"nombre":"CONDORI ALEX","nit_ci":"","cel":null,"correo":null,"fecha_registro":"2026-04-08","updated_at":"2026-04-08T20:56:42.000000Z","created_at":"2026-04-08T20:56:42.000000Z","id":2}	\N	CLIENTES	2026-04-08	16:56:42	2026-04-08 16:56:42	2026-04-08 16:56:42
20	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UN PRODUCTO	{"id":1,"nombre":"PRODUCTO 1","descripcion":"<h2><strong><u>DESCRIPCI\\u00d3N DEL PRODUCTO<\\/u><\\/strong><\\/h2><p><span style=\\"color: rgb(0, 0, 0);\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><\\/p>","precio":"120.00","stock":"0","categoria_id":1,"fecha_registro":"2026-04-08","created_at":"2026-04-08T15:39:00.000000Z","updated_at":"2026-04-08T16:02:49.000000Z","codigo":null,"producto_imagens":[{"id":19,"producto_id":1,"imagen":"191775664131.jpg","created_at":"2026-04-08T16:02:11.000000Z","updated_at":"2026-04-08T16:02:11.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/191775664131.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/191775664131.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/191775664131.jpg","file":"191775664131.jpg","name":"191775664131.jpg","ext":""},{"id":20,"producto_id":1,"imagen":"1201775664131.jpeg","created_at":"2026-04-08T16:02:11.000000Z","updated_at":"2026-04-08T16:02:11.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/1201775664131.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/1201775664131.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/1201775664131.jpeg","file":"1201775664131.jpeg","name":"1201775664131.jpeg","ext":""},{"id":21,"producto_id":1,"imagen":"2211775664131.jpeg","created_at":"2026-04-08T16:02:11.000000Z","updated_at":"2026-04-08T16:02:11.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/2211775664131.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/2211775664131.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/2211775664131.jpeg","file":"2211775664131.jpeg","name":"2211775664131.jpeg","ext":""}]}	{"id":1,"nombre":"PRODUCTO 1","descripcion":"<h2><strong><u>DESCRIPCI\\u00d3N DEL PRODUCTO<\\/u><\\/strong><\\/h2><p><span style=\\"color: rgb(0, 0, 0);\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><\\/p>","precio":"120.00","stock":"0","categoria_id":"1","fecha_registro":"2026-04-08","created_at":"2026-04-08T15:39:00.000000Z","updated_at":"2026-04-08T21:24:34.000000Z","codigo":"P001","producto_imagens":[{"id":19,"producto_id":1,"imagen":"191775664131.jpg","created_at":"2026-04-08T16:02:11.000000Z","updated_at":"2026-04-08T16:02:11.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/191775664131.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/191775664131.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/191775664131.jpg","file":"191775664131.jpg","name":"191775664131.jpg","ext":""},{"id":20,"producto_id":1,"imagen":"1201775664131.jpeg","created_at":"2026-04-08T16:02:11.000000Z","updated_at":"2026-04-08T16:02:11.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/1201775664131.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/1201775664131.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/1201775664131.jpeg","file":"1201775664131.jpeg","name":"1201775664131.jpeg","ext":""},{"id":21,"producto_id":1,"imagen":"2211775664131.jpeg","created_at":"2026-04-08T16:02:11.000000Z","updated_at":"2026-04-08T16:02:11.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/2211775664131.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/2211775664131.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/2211775664131.jpeg","file":"2211775664131.jpeg","name":"2211775664131.jpeg","ext":""}]}	PRODUCTOS	2026-04-08	17:24:34	2026-04-08 17:24:34	2026-04-08 17:24:34
21	1	CREACIÓN	EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTOS	{"producto_id":"1","cantidad":"10","descripcion":"INICIO STOCK","fecha_registro":"2026-04-08","updated_at":"2026-04-08T23:24:33.000000Z","created_at":"2026-04-08T23:24:33.000000Z","id":4}	\N	INGRESO DE PRODUCTOS	2026-04-08	19:24:33	2026-04-08 19:24:33	2026-04-08 19:24:33
25	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UN INGRESO DE PRODUCTOS	{"id":1,"producto_id":1,"cantidad":"90","descripcion":"INICIO STOCK","fecha_registro":"2026-04-08","created_at":"2026-04-08T23:26:14.000000Z","updated_at":"2026-04-08T23:26:14.000000Z"}	{"id":1,"producto_id":"1","cantidad":"60","descripcion":"INICIO STOCK","fecha_registro":"2026-04-08","created_at":"2026-04-08T23:26:14.000000Z","updated_at":"2026-04-08T23:33:04.000000Z"}	INGRESO DE PRODUCTOS	2026-04-08	19:33:04	2026-04-08 19:33:04	2026-04-08 19:33:04
26	1	CREACIÓN	EL USUARIO admin REGISTRO UN PRODUCTO	{"codigo":"P002","nombre":"PRODUCTO 2","descripcion":"<p>Descripcion del producto 2<\\/p>","precio":"67","categoria_id":"1","fecha_registro":"2026-04-08","updated_at":"2026-04-08T23:33:31.000000Z","created_at":"2026-04-08T23:33:31.000000Z","id":2,"producto_imagens":[{"id":23,"producto_id":2,"imagen":"231775691211.jpg","created_at":"2026-04-08T23:33:31.000000Z","updated_at":"2026-04-08T23:33:31.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/231775691211.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/231775691211.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/231775691211.jpg","file":"231775691211.jpg","name":"231775691211.jpg","ext":""},{"id":24,"producto_id":2,"imagen":"1241775691211.jpg","created_at":"2026-04-08T23:33:31.000000Z","updated_at":"2026-04-08T23:33:31.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/1241775691211.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/1241775691211.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/1241775691211.jpg","file":"1241775691211.jpg","name":"1241775691211.jpg","ext":""},{"id":25,"producto_id":2,"imagen":"2251775691211.jpg","created_at":"2026-04-08T23:33:31.000000Z","updated_at":"2026-04-08T23:33:31.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/2251775691211.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/2251775691211.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/2251775691211.jpg","file":"2251775691211.jpg","name":"2251775691211.jpg","ext":""}]}	\N	PRODUCTOS	2026-04-08	19:33:31	2026-04-08 19:33:31	2026-04-08 19:33:31
27	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UN INGRESO DE PRODUCTOS	{"id":1,"producto_id":1,"cantidad":"60","descripcion":"INICIO STOCK","fecha_registro":"2026-04-08","created_at":"2026-04-08T23:26:14.000000Z","updated_at":"2026-04-08T23:33:04.000000Z"}	{"id":1,"producto_id":"2","cantidad":"60","descripcion":"INICIO STOCK","fecha_registro":"2026-04-08","created_at":"2026-04-08T23:26:14.000000Z","updated_at":"2026-04-08T23:33:40.000000Z"}	INGRESO DE PRODUCTOS	2026-04-08	19:33:40	2026-04-08 19:33:40	2026-04-08 19:33:40
28	1	CREACIÓN	EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTOS	{"producto_id":"1","cantidad":"100","descripcion":"INICIO STOCK","fecha_registro":"2026-04-08","updated_at":"2026-04-08T23:34:55.000000Z","created_at":"2026-04-08T23:34:55.000000Z","id":1}	\N	INGRESO DE PRODUCTOS	2026-04-08	19:34:55	2026-04-08 19:34:55	2026-04-08 19:34:55
29	1	CREACIÓN	EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTOS	{"producto_id":"2","cantidad":"100","descripcion":"INICIO STOCK","fecha_registro":"2026-04-08","updated_at":"2026-04-08T23:35:03.000000Z","created_at":"2026-04-08T23:35:03.000000Z","id":2}	\N	INGRESO DE PRODUCTOS	2026-04-08	19:35:03	2026-04-08 19:35:03	2026-04-08 19:35:03
30	1	CREACIÓN	EL USUARIO admin REGISTRO UNA VENTA	{"cliente_id":"1","total":"427","fecha":"2026-04-09","hora":"09:18:22","updated_at":"2026-04-09T13:18:22.000000Z","created_at":"2026-04-09T13:18:22.000000Z","id":1,"venta_detalles":[{"id":1,"venta_id":1,"producto_id":1,"precio":"120.00","cantidad":"3","subtotal":"360.00","created_at":"2026-04-09T13:18:23.000000Z","updated_at":"2026-04-09T13:18:23.000000Z"},{"id":2,"venta_id":1,"producto_id":2,"precio":"67.00","cantidad":"1","subtotal":"67.00","created_at":"2026-04-09T13:18:23.000000Z","updated_at":"2026-04-09T13:18:23.000000Z"}]}	\N	VENTAS	2026-04-09	09:18:23	2026-04-09 09:18:23	2026-04-09 09:18:23
31	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UNA VENTA	{"id":1,"cliente_id":1,"total":"427.00","fecha":"2026-04-09","hora":"09:18:22","created_at":"2026-04-09T13:18:22.000000Z","updated_at":"2026-04-09T13:18:22.000000Z","status":1,"nit_ci":null,"venta_detalles":[{"id":1,"venta_id":1,"producto_id":1,"precio":"120.00","cantidad":"3","subtotal":"360.00","created_at":"2026-04-09T13:18:23.000000Z","updated_at":"2026-04-09T13:18:23.000000Z"},{"id":2,"venta_id":1,"producto_id":2,"precio":"67.00","cantidad":"1","subtotal":"67.00","created_at":"2026-04-09T13:18:23.000000Z","updated_at":"2026-04-09T13:18:23.000000Z"}]}	{"id":1,"cliente_id":"1","total":"667","fecha":"2026-04-09","hora":"09:18:22","created_at":"2026-04-09T13:18:22.000000Z","updated_at":"2026-04-09T13:36:06.000000Z","status":1,"nit_ci":null,"venta_detalles":[{"id":1,"venta_id":1,"producto_id":1,"precio":"120.00","cantidad":"3","subtotal":"360.00","created_at":"2026-04-09T13:18:23.000000Z","updated_at":"2026-04-09T13:18:23.000000Z"},{"id":2,"venta_id":1,"producto_id":2,"precio":"67.00","cantidad":"1","subtotal":"67.00","created_at":"2026-04-09T13:18:23.000000Z","updated_at":"2026-04-09T13:18:23.000000Z"}]}	VENTAS	2026-04-09	09:36:06	2026-04-09 09:36:06	2026-04-09 09:36:06
32	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UNA VENTA	{"id":1,"cliente_id":1,"total":"667.00","fecha":"2026-04-09","hora":"09:18:22","created_at":"2026-04-09T13:18:22.000000Z","updated_at":"2026-04-09T13:36:06.000000Z","status":1,"nit_ci":null,"venta_detalles":[{"id":1,"venta_id":1,"producto_id":1,"precio":"120.00","cantidad":"3","subtotal":"360.00","created_at":"2026-04-09T13:18:23.000000Z","updated_at":"2026-04-09T13:18:23.000000Z"},{"id":2,"venta_id":1,"producto_id":2,"precio":"67.00","cantidad":"1","subtotal":"67.00","created_at":"2026-04-09T13:18:23.000000Z","updated_at":"2026-04-09T13:18:23.000000Z"}]}	{"id":1,"cliente_id":"1","total":"427","fecha":"2026-04-09","hora":"09:18:22","created_at":"2026-04-09T13:18:22.000000Z","updated_at":"2026-04-09T13:43:57.000000Z","status":1,"nit_ci":"123456","venta_detalles":[{"id":1,"venta_id":1,"producto_id":1,"precio":"120.00","cantidad":"3","subtotal":"360.00","created_at":"2026-04-09T13:18:23.000000Z","updated_at":"2026-04-09T13:18:23.000000Z"},{"id":2,"venta_id":1,"producto_id":2,"precio":"67.00","cantidad":"1","subtotal":"67.00","created_at":"2026-04-09T13:18:23.000000Z","updated_at":"2026-04-09T13:18:23.000000Z"}]}	VENTAS	2026-04-09	09:43:57	2026-04-09 09:43:57	2026-04-09 09:43:57
33	1	ELIMINACIÓN	EL USUARIO admin ELIMINÓ UNA VENTA	{"id":1,"cliente_id":1,"total":"427.00","fecha":"2026-04-09","hora":"09:18:22","created_at":"2026-04-09T13:18:22.000000Z","updated_at":"2026-04-09T13:43:57.000000Z","status":1,"nit_ci":"123456","venta_detalles":[{"id":1,"venta_id":1,"producto_id":1,"precio":"120.00","cantidad":"3","subtotal":"360.00","created_at":"2026-04-09T13:18:23.000000Z","updated_at":"2026-04-09T13:18:23.000000Z"},{"id":2,"venta_id":1,"producto_id":2,"precio":"67.00","cantidad":"1","subtotal":"67.00","created_at":"2026-04-09T13:18:23.000000Z","updated_at":"2026-04-09T13:18:23.000000Z"}]}	{"id":1,"cliente_id":1,"total":"427.00","fecha":"2026-04-09","hora":"09:18:22","created_at":"2026-04-09T13:18:22.000000Z","updated_at":"2026-04-09T13:46:05.000000Z","status":0,"nit_ci":"123456","venta_detalles":[{"id":1,"venta_id":1,"producto_id":1,"precio":"120.00","cantidad":"3","subtotal":"360.00","created_at":"2026-04-09T13:18:23.000000Z","updated_at":"2026-04-09T13:18:23.000000Z"},{"id":2,"venta_id":1,"producto_id":2,"precio":"67.00","cantidad":"1","subtotal":"67.00","created_at":"2026-04-09T13:18:23.000000Z","updated_at":"2026-04-09T13:18:23.000000Z"}]}	VENTAS	2026-04-09	09:46:06	2026-04-09 09:46:06	2026-04-09 09:46:06
34	1	CREACIÓN	EL USUARIO admin REGISTRO UNA VENTA	{"cliente_id":"1","nit_ci":"123456","total":"254","fecha":"2026-04-09","hora":"09:49:03","updated_at":"2026-04-09T13:49:03.000000Z","created_at":"2026-04-09T13:49:03.000000Z","id":2,"venta_detalles":[{"id":3,"venta_id":2,"producto_id":1,"precio":"120.00","cantidad":"1","subtotal":"120.00","created_at":"2026-04-09T13:49:03.000000Z","updated_at":"2026-04-09T13:49:03.000000Z"},{"id":4,"venta_id":2,"producto_id":2,"precio":"67.00","cantidad":"2","subtotal":"134.00","created_at":"2026-04-09T13:49:03.000000Z","updated_at":"2026-04-09T13:49:03.000000Z"}]}	\N	VENTAS	2026-04-09	09:49:03	2026-04-09 09:49:03	2026-04-09 09:49:03
35	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UNA VENTA	{"id":2,"cliente_id":1,"total":"254.00","fecha":"2026-04-09","hora":"09:49:03","created_at":"2026-04-09T13:49:03.000000Z","updated_at":"2026-04-09T13:49:03.000000Z","status":1,"nit_ci":"123456","venta_detalles":[{"id":3,"venta_id":2,"producto_id":1,"precio":"120.00","cantidad":"1","subtotal":"120.00","created_at":"2026-04-09T13:49:03.000000Z","updated_at":"2026-04-09T13:49:03.000000Z"},{"id":4,"venta_id":2,"producto_id":2,"precio":"67.00","cantidad":"4","subtotal":"268.00","created_at":"2026-04-09T13:49:03.000000Z","updated_at":"2026-04-09T13:49:13.000000Z"}]}	{"id":2,"cliente_id":"1","total":"388","fecha":"2026-04-09","hora":"09:49:03","created_at":"2026-04-09T13:49:03.000000Z","updated_at":"2026-04-09T13:49:13.000000Z","status":1,"nit_ci":"123456","venta_detalles":[{"id":3,"venta_id":2,"producto_id":1,"precio":"120.00","cantidad":"1","subtotal":"120.00","created_at":"2026-04-09T13:49:03.000000Z","updated_at":"2026-04-09T13:49:03.000000Z"},{"id":4,"venta_id":2,"producto_id":2,"precio":"67.00","cantidad":"4","subtotal":"268.00","created_at":"2026-04-09T13:49:03.000000Z","updated_at":"2026-04-09T13:49:13.000000Z"}]}	VENTAS	2026-04-09	09:49:13	2026-04-09 09:49:13	2026-04-09 09:49:13
36	1	ELIMINACIÓN	EL USUARIO admin ELIMINÓ UNA VENTA	{"id":2,"cliente_id":1,"total":"388.00","fecha":"2026-04-09","hora":"09:49:03","created_at":"2026-04-09T13:49:03.000000Z","updated_at":"2026-04-09T13:49:13.000000Z","status":1,"nit_ci":"123456","venta_detalles":[{"id":3,"venta_id":2,"producto_id":1,"precio":"120.00","cantidad":"1","subtotal":"120.00","created_at":"2026-04-09T13:49:03.000000Z","updated_at":"2026-04-09T13:49:03.000000Z"},{"id":4,"venta_id":2,"producto_id":2,"precio":"67.00","cantidad":"4","subtotal":"268.00","created_at":"2026-04-09T13:49:03.000000Z","updated_at":"2026-04-09T13:49:13.000000Z"}]}	{"id":2,"cliente_id":1,"total":"388.00","fecha":"2026-04-09","hora":"09:49:03","created_at":"2026-04-09T13:49:03.000000Z","updated_at":"2026-04-09T13:49:18.000000Z","status":0,"nit_ci":"123456","venta_detalles":[{"id":3,"venta_id":2,"producto_id":1,"precio":"120.00","cantidad":"1","subtotal":"120.00","created_at":"2026-04-09T13:49:03.000000Z","updated_at":"2026-04-09T13:49:03.000000Z"},{"id":4,"venta_id":2,"producto_id":2,"precio":"67.00","cantidad":"4","subtotal":"268.00","created_at":"2026-04-09T13:49:03.000000Z","updated_at":"2026-04-09T13:49:13.000000Z"}]}	VENTAS	2026-04-09	09:49:18	2026-04-09 09:49:18	2026-04-09 09:49:18
37	1	CREACIÓN	EL USUARIO admin REGISTRO UNA VENTA	{"cliente_id":"2","nit_ci":null,"total":"187","fecha":"2026-04-09","hora":"09:49:31","updated_at":"2026-04-09T13:49:31.000000Z","created_at":"2026-04-09T13:49:31.000000Z","id":3,"venta_detalles":[{"id":5,"venta_id":3,"producto_id":1,"precio":"120.00","cantidad":"1","subtotal":"120.00","created_at":"2026-04-09T13:49:31.000000Z","updated_at":"2026-04-09T13:49:31.000000Z"},{"id":6,"venta_id":3,"producto_id":2,"precio":"67.00","cantidad":"1","subtotal":"67.00","created_at":"2026-04-09T13:49:31.000000Z","updated_at":"2026-04-09T13:49:31.000000Z"}]}	\N	VENTAS	2026-04-09	09:49:31	2026-04-09 09:49:31	2026-04-09 09:49:31
38	1	MODIFICACIÓN	EL USUARIO admin REVIRTIÓ LA ANULACIÓN DE UNA VENTA	{"id":1,"cliente_id":1,"total":"427.00","fecha":"2026-04-09","hora":"09:18:22","created_at":"2026-04-09T13:18:22.000000Z","updated_at":"2026-04-09T13:46:05.000000Z","status":0,"nit_ci":"123456","venta_detalles":[{"id":1,"venta_id":1,"producto_id":1,"precio":"120.00","cantidad":"3","subtotal":"360.00","created_at":"2026-04-09T13:18:23.000000Z","updated_at":"2026-04-09T13:18:23.000000Z"},{"id":2,"venta_id":1,"producto_id":2,"precio":"67.00","cantidad":"1","subtotal":"67.00","created_at":"2026-04-09T13:18:23.000000Z","updated_at":"2026-04-09T13:18:23.000000Z"}]}	{"id":1,"cliente_id":1,"total":"427.00","fecha":"2026-04-09","hora":"09:18:22","created_at":"2026-04-09T13:18:22.000000Z","updated_at":"2026-04-09T19:42:39.000000Z","status":1,"nit_ci":"123456","venta_detalles":[{"id":1,"venta_id":1,"producto_id":1,"precio":"120.00","cantidad":"3","subtotal":"360.00","created_at":"2026-04-09T13:18:23.000000Z","updated_at":"2026-04-09T13:18:23.000000Z"},{"id":2,"venta_id":1,"producto_id":2,"precio":"67.00","cantidad":"1","subtotal":"67.00","created_at":"2026-04-09T13:18:23.000000Z","updated_at":"2026-04-09T13:18:23.000000Z"}]}	VENTAS	2026-04-09	15:42:39	2026-04-09 15:42:39	2026-04-09 15:42:39
39	1	MODIFICACIÓN	EL USUARIO admin REVIRTIÓ LA ANULACIÓN DE UNA VENTA	{"id":2,"cliente_id":1,"total":"388.00","fecha":"2026-04-09","hora":"09:49:03","created_at":"2026-04-09T13:49:03.000000Z","updated_at":"2026-04-09T13:49:18.000000Z","status":0,"nit_ci":"123456","venta_detalles":[{"id":3,"venta_id":2,"producto_id":1,"precio":"120.00","cantidad":"1","subtotal":"120.00","created_at":"2026-04-09T13:49:03.000000Z","updated_at":"2026-04-09T13:49:03.000000Z"},{"id":4,"venta_id":2,"producto_id":2,"precio":"67.00","cantidad":"4","subtotal":"268.00","created_at":"2026-04-09T13:49:03.000000Z","updated_at":"2026-04-09T13:49:13.000000Z"}]}	{"id":2,"cliente_id":1,"total":"388.00","fecha":"2026-04-09","hora":"09:49:03","created_at":"2026-04-09T13:49:03.000000Z","updated_at":"2026-04-09T19:43:05.000000Z","status":1,"nit_ci":"123456","venta_detalles":[{"id":3,"venta_id":2,"producto_id":1,"precio":"120.00","cantidad":"1","subtotal":"120.00","created_at":"2026-04-09T13:49:03.000000Z","updated_at":"2026-04-09T13:49:03.000000Z"},{"id":4,"venta_id":2,"producto_id":2,"precio":"67.00","cantidad":"4","subtotal":"268.00","created_at":"2026-04-09T13:49:03.000000Z","updated_at":"2026-04-09T13:49:13.000000Z"}]}	VENTAS	2026-04-09	15:43:05	2026-04-09 15:43:05	2026-04-09 15:43:05
40	1	ELIMINACIÓN	EL USUARIO admin ELIMINÓ UNA VENTA	{"id":1,"cliente_id":1,"total":"427.00","fecha":"2026-04-09","hora":"09:18:22","created_at":"2026-04-09T13:18:22.000000Z","updated_at":"2026-04-09T19:42:39.000000Z","status":1,"nit_ci":"123456","user_id":1,"venta_detalles":[{"id":1,"venta_id":1,"producto_id":1,"precio":"120.00","cantidad":"3","subtotal":"360.00","created_at":"2026-04-09T13:18:23.000000Z","updated_at":"2026-04-09T13:18:23.000000Z"},{"id":2,"venta_id":1,"producto_id":2,"precio":"67.00","cantidad":"1","subtotal":"67.00","created_at":"2026-04-09T13:18:23.000000Z","updated_at":"2026-04-09T13:18:23.000000Z"}]}	{"id":1,"cliente_id":1,"total":"427.00","fecha":"2026-04-09","hora":"09:18:22","created_at":"2026-04-09T13:18:22.000000Z","updated_at":"2026-04-09T20:16:27.000000Z","status":0,"nit_ci":"123456","user_id":1,"venta_detalles":[{"id":1,"venta_id":1,"producto_id":1,"precio":"120.00","cantidad":"3","subtotal":"360.00","created_at":"2026-04-09T13:18:23.000000Z","updated_at":"2026-04-09T13:18:23.000000Z"},{"id":2,"venta_id":1,"producto_id":2,"precio":"67.00","cantidad":"1","subtotal":"67.00","created_at":"2026-04-09T13:18:23.000000Z","updated_at":"2026-04-09T13:18:23.000000Z"}]}	VENTAS	2026-04-09	16:16:27	2026-04-09 16:16:27	2026-04-09 16:16:27
41	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UN USUARIO	{"id":2,"usuario":"JPERES","nombre":"JUAN","paterno":"PERES","materno":"MAMANI","correo":"juan@gmail.com","fono":"67676767","acceso":1,"tipo":"ADMINISTRADOR","foto":"21775656455.jpg","fecha_registro":"2026-04-08","status":1,"created_at":"2026-04-08T13:54:15.000000Z","updated_at":"2026-04-08T13:54:15.000000Z","ci":null,"ci_exp":null}	{"id":2,"usuario":"JPERES1","nombre":"JUAN","paterno":"PERES","materno":"MAMANI","correo":"juan@gmail.com","fono":"67676767","acceso":"1","tipo":"ADMINISTRADOR","foto":"21775656455.jpg","fecha_registro":"2026-04-08","status":1,"created_at":"2026-04-08T13:54:15.000000Z","updated_at":"2026-04-09T20:39:14.000000Z","ci":"123456","ci_exp":"LP"}	USUARIOS	2026-04-09	16:39:15	2026-04-09 16:39:15	2026-04-09 16:39:15
42	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UN USUARIO	{"id":3,"usuario":"GCARVAJAL","nombre":"GERMAN","paterno":"CARVAJAL","materno":"","correo":null,"fono":"67676767","acceso":1,"tipo":"AUXILIAR","foto":null,"fecha_registro":"2026-04-08","status":1,"created_at":"2026-04-08T13:54:55.000000Z","updated_at":"2026-04-08T13:54:55.000000Z","ci":null,"ci_exp":null}	{"id":3,"usuario":"GCARVAJAL","nombre":"GERMAN","paterno":"CARVAJAL","materno":"","correo":null,"fono":"67676767","acceso":"1","tipo":"AUXILIAR","foto":null,"fecha_registro":"2026-04-08","status":1,"created_at":"2026-04-08T13:54:55.000000Z","updated_at":"2026-04-09T20:42:06.000000Z","ci":"5454544","ci_exp":"LP"}	USUARIOS	2026-04-09	16:42:06	2026-04-09 16:42:06	2026-04-09 16:42:06
43	1	CREACIÓN	EL USUARIO admin REGISTRO UN PRODUCTO	{"codigo":"P003","nombre":"PRODUCTO 3","descripcion":"<h2>What is Lorem Ipsum?<\\/h2><p><strong>Lorem Ipsum<\\/strong>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/p>","precio":"433","categoria_id":"2","fecha_registro":"2026-04-10","updated_at":"2026-04-10T13:40:31.000000Z","created_at":"2026-04-10T13:40:31.000000Z","id":3,"producto_imagens":[{"id":26,"producto_id":3,"imagen":"261775828431.jpeg","created_at":"2026-04-10T13:40:31.000000Z","updated_at":"2026-04-10T13:40:31.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/261775828431.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/261775828431.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/261775828431.jpeg","file":"261775828431.jpeg","name":"261775828431.jpeg","ext":""},{"id":27,"producto_id":3,"imagen":"1271775828431.jpeg","created_at":"2026-04-10T13:40:31.000000Z","updated_at":"2026-04-10T13:40:31.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/1271775828431.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/1271775828431.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/1271775828431.jpeg","file":"1271775828431.jpeg","name":"1271775828431.jpeg","ext":""},{"id":28,"producto_id":3,"imagen":"2281775828431.webp","created_at":"2026-04-10T13:40:31.000000Z","updated_at":"2026-04-10T13:40:31.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/2281775828431.webp","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/2281775828431.webp","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/2281775828431.webp","file":"2281775828431.webp","name":"2281775828431.webp","ext":""}]}	\N	PRODUCTOS	2026-04-10	09:40:31	2026-04-10 09:40:31	2026-04-10 09:40:31
44	1	CREACIÓN	EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTOS	{"producto_id":"3","cantidad":"20","descripcion":"","fecha_registro":"2026-04-10","updated_at":"2026-04-10T13:40:43.000000Z","created_at":"2026-04-10T13:40:43.000000Z","id":3}	\N	INGRESO DE PRODUCTOS	2026-04-10	09:40:43	2026-04-10 09:40:43	2026-04-10 09:40:43
45	1	CREACIÓN	EL USUARIO admin REGISTRO UNA SUBASTA	{"producto_id":"2","estado_producto":"SEMINUEVO","monto_inicial":"1000","fecha_fin":"2026-04-15","hora_fin":"12:00","publico":"0","fecha_registro":"2026-04-10","updated_at":"2026-04-10T13:59:41.000000Z","created_at":"2026-04-10T13:59:41.000000Z","id":1}	\N	SUBASTAS	2026-04-10	09:59:41	2026-04-10 09:59:41	2026-04-10 09:59:41
46	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UNA SUBASTA	{"id":1,"producto_id":2,"estado_producto":"SEMINUEVO","monto_inicial":"1000.00","fecha_fin":"2026-04-15","hora_fin":"12:00:00","publico":0,"estado_subasta":1,"fecha_registro":"2026-04-10","created_at":"2026-04-10T13:59:41.000000Z","updated_at":"2026-04-10T13:59:41.000000Z"}	{"id":1,"producto_id":"2","estado_producto":"SEMINUEVO","monto_inicial":"1000.00","fecha_fin":"2026-04-16","hora_fin":"12:00:00","publico":"1","estado_subasta":1,"fecha_registro":"2026-04-10","created_at":"2026-04-10T13:59:41.000000Z","updated_at":"2026-04-10T14:14:21.000000Z"}	SUBASTAS	2026-04-10	10:14:21	2026-04-10 10:14:21	2026-04-10 10:14:21
47	1	CREACIÓN	EL USUARIO admin REGISTRO UNA SUBASTA	{"producto_id":"1","estado_producto":"USADO","monto_inicial":"1000","fecha_fin":"2026-04-16","hora_fin":"12:00","publico":"1","fecha_registro":"2026-04-10","updated_at":"2026-04-10T14:15:12.000000Z","created_at":"2026-04-10T14:15:12.000000Z","id":2}	\N	SUBASTAS	2026-04-10	10:15:12	2026-04-10 10:15:12	2026-04-10 10:15:12
48	1	CREACIÓN	EL USUARIO admin REGISTRO UNA SUBASTA	{"producto_id":"2","estado_producto":"NUEVO","monto_inicial":"2300","fecha_fin":"2026-04-16","hora_fin":"12:00","publico":"0","fecha_registro":"2026-04-10","updated_at":"2026-04-10T14:15:32.000000Z","created_at":"2026-04-10T14:15:32.000000Z","id":3}	\N	SUBASTAS	2026-04-10	10:15:32	2026-04-10 10:15:32	2026-04-10 10:15:32
49	1	CREACIÓN	EL USUARIO admin REGISTRO UNA VENTA	{"cliente_id":"1","nit_ci":"123456","total":"120","fecha":"2026-04-10","hora":"21:04:48","user_id":1,"updated_at":"2026-04-11T01:04:48.000000Z","created_at":"2026-04-11T01:04:48.000000Z","id":4,"venta_detalles":[{"id":7,"venta_id":4,"producto_id":1,"precio":"120.00","cantidad":"1","subtotal":"120.00","created_at":"2026-04-11T01:04:48.000000Z","updated_at":"2026-04-11T01:04:48.000000Z"}]}	\N	VENTAS	2026-04-10	21:04:48	2026-04-10 21:04:48	2026-04-10 21:04:48
50	1	CREACIÓN	EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTOS	{"producto_id":"3","cantidad":"1","descripcion":"","fecha_registro":"2026-04-10","updated_at":"2026-04-11T01:05:51.000000Z","created_at":"2026-04-11T01:05:51.000000Z","id":4}	\N	INGRESO DE PRODUCTOS	2026-04-10	21:05:51	2026-04-10 21:05:51	2026-04-10 21:05:51
51	1	CREACIÓN	EL USUARIO admin REGISTRO UNA SUBASTA	{"producto_id":"1","estado_producto":"NUEVO","monto_inicial":"200","fecha_fin":"2026-04-15","hora_fin":"12:00","publico":"1","fecha_registro":"2026-04-10","updated_at":"2026-04-11T01:07:25.000000Z","created_at":"2026-04-11T01:07:25.000000Z","id":4}	\N	SUBASTAS	2026-04-10	21:07:25	2026-04-10 21:07:25	2026-04-10 21:07:25
52	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UNA SUBASTA	{"id":4,"producto_id":1,"estado_producto":"NUEVO","monto_inicial":"200.00","fecha_fin":"2026-04-15","hora_fin":"12:00:00","publico":1,"estado_subasta":1,"fecha_registro":"2026-04-10","created_at":"2026-04-11T01:07:25.000000Z","updated_at":"2026-04-11T01:07:25.000000Z","garantia":"0.00"}	{"id":4,"producto_id":"1","estado_producto":"NUEVO","monto_inicial":"200.00","fecha_fin":"2026-04-15","hora_fin":"12:00:00","publico":"1","estado_subasta":1,"fecha_registro":"2026-04-10","created_at":"2026-04-11T01:07:25.000000Z","updated_at":"2026-04-16T13:04:19.000000Z","garantia":"100"}	SUBASTAS	2026-04-16	09:04:19	2026-04-16 09:04:19	2026-04-16 09:04:19
53	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UN PRODUCTO	{"id":1,"nombre":"PRODUCTO 1","descripcion":"<h2><strong><u>DESCRIPCI\\u00d3N DEL PRODUCTO<\\/u><\\/strong><\\/h2><p><span style=\\"color: rgb(0, 0, 0);\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><\\/p>","precio":"120.00","stock":"93","categoria_id":1,"fecha_registro":"2026-04-08","created_at":"2026-04-08T15:39:00.000000Z","updated_at":"2026-04-11T01:07:25.000000Z","codigo":"P001","producto_imagens":[{"id":19,"producto_id":1,"imagen":"191775664131.jpg","created_at":"2026-04-08T16:02:11.000000Z","updated_at":"2026-04-08T16:02:11.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/191775664131.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/191775664131.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/191775664131.jpg","file":"191775664131.jpg","name":"191775664131.jpg","ext":""},{"id":20,"producto_id":1,"imagen":"1201775664131.jpeg","created_at":"2026-04-08T16:02:11.000000Z","updated_at":"2026-04-08T16:02:11.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/1201775664131.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/1201775664131.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/1201775664131.jpeg","file":"1201775664131.jpeg","name":"1201775664131.jpeg","ext":""},{"id":21,"producto_id":1,"imagen":"2211775664131.jpeg","created_at":"2026-04-08T16:02:11.000000Z","updated_at":"2026-04-08T16:02:11.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/2211775664131.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/2211775664131.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/2211775664131.jpeg","file":"2211775664131.jpeg","name":"2211775664131.jpeg","ext":""}]}	{"id":1,"nombre":"PRODUCTO 1","descripcion":"<h3><strong><u>DESCRIPCI\\u00d3N DEL PRODUCTO<\\/u><\\/strong><\\/h3><p><span style=\\"color: rgb(0, 0, 0);\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><\\/p>","precio":"120.00","stock":"93","categoria_id":"1","fecha_registro":"2026-04-08","created_at":"2026-04-08T15:39:00.000000Z","updated_at":"2026-04-16T14:31:12.000000Z","codigo":"P001","producto_imagens":[{"id":19,"producto_id":1,"imagen":"191775664131.jpg","created_at":"2026-04-08T16:02:11.000000Z","updated_at":"2026-04-08T16:02:11.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/191775664131.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/191775664131.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/191775664131.jpg","file":"191775664131.jpg","name":"191775664131.jpg","ext":""},{"id":20,"producto_id":1,"imagen":"1201775664131.jpeg","created_at":"2026-04-08T16:02:11.000000Z","updated_at":"2026-04-08T16:02:11.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/1201775664131.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/1201775664131.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/1201775664131.jpeg","file":"1201775664131.jpeg","name":"1201775664131.jpeg","ext":""},{"id":21,"producto_id":1,"imagen":"2211775664131.jpeg","created_at":"2026-04-08T16:02:11.000000Z","updated_at":"2026-04-08T16:02:11.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/2211775664131.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/2211775664131.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/2211775664131.jpeg","file":"2211775664131.jpeg","name":"2211775664131.jpeg","ext":""}]}	PRODUCTOS	2026-04-16	10:31:12	2026-04-16 10:31:12	2026-04-16 10:31:12
55	1	CREACIÓN	EL USUARIO admin REGISTRO UN CLIENTE	{"nombre":"SANDOVAL","nit_ci":"543453453","cel":"78787878","correo":null,"fecha_registro":"2026-04-17","updated_at":"2026-04-17T20:20:23.000000Z","created_at":"2026-04-17T20:20:23.000000Z","id":3}	\N	CLIENTES	2026-04-17	16:20:23	2026-04-17 16:20:23	2026-04-17 16:20:23
56	1	CREACIÓN	EL USUARIO admin REGISTRO UN CLIENTE	{"nombre":"CHIRI","nit_ci":"345345345","cel":null,"correo":null,"fecha_registro":"2026-04-17","updated_at":"2026-04-17T20:20:31.000000Z","created_at":"2026-04-17T20:20:31.000000Z","id":4}	\N	CLIENTES	2026-04-17	16:20:31	2026-04-17 16:20:31	2026-04-17 16:20:31
57	1	CREACIÓN	EL USUARIO admin REGISTRO UN CLIENTE	{"nombre":"CONDORI","nit_ci":"","cel":null,"correo":null,"fecha_registro":"2026-04-17","updated_at":"2026-04-17T20:20:50.000000Z","created_at":"2026-04-17T20:20:50.000000Z","id":5}	\N	CLIENTES	2026-04-17	16:20:50	2026-04-17 16:20:50	2026-04-17 16:20:50
58	1	CREACIÓN	EL USUARIO admin REGISTRO UNA SUBASTA	{"producto_id":"2","estado_producto":"NUEVO","monto_inicial":"700","garantia":"200","fecha_fin":"2026-04-19","hora_fin":"12:00","publico":"1","fecha_registro":"2026-04-17","updated_at":"2026-04-17T20:26:17.000000Z","created_at":"2026-04-17T20:26:17.000000Z","id":6}	\N	SUBASTAS	2026-04-17	16:26:17	2026-04-17 16:26:17	2026-04-17 16:26:17
59	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UNA SUBASTA	{"id":6,"producto_id":2,"estado_producto":"NUEVO","monto_inicial":"700.00","fecha_fin":"2026-04-19","hora_fin":"12:00:00","publico":1,"estado_subasta":1,"fecha_registro":"2026-04-17","created_at":"2026-04-17T20:26:17.000000Z","updated_at":"2026-04-17T20:26:17.000000Z","garantia":"200.00","descripcion":null}	{"id":6,"producto_id":"2","estado_producto":"NUEVO","monto_inicial":"700.00","fecha_fin":"2026-04-19","hora_fin":"12:00:00","publico":"1","estado_subasta":1,"fecha_registro":"2026-04-17","created_at":"2026-04-17T20:26:17.000000Z","updated_at":"2026-04-17T20:27:05.000000Z","garantia":"200.00","descripcion":"<h3><strong>Descripci\\u00f3n de subasta<\\/strong><\\/h3><p><strong style=\\"color: rgb(0, 0, 0);\\">Lorem Ipsum<\\/strong><span style=\\"color: rgb(0, 0, 0);\\">&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type<\\/span><\\/p>"}	SUBASTAS	2026-04-17	16:27:05	2026-04-17 16:27:05	2026-04-17 16:27:05
60	1	CREACIÓN	EL USUARIO admin REGISTRO UNA SALIDA DE PRODUCTOS	{"producto_id":"3","cantidad":"1","descripcion":"DEFECTUOSO","fecha_registro":"2026-04-18","updated_at":"2026-04-18T19:39:50.000000Z","created_at":"2026-04-18T19:39:50.000000Z","id":1}	\N	SALIDA DE PRODUCTOS	2026-04-18	15:39:50	2026-04-18 15:39:50	2026-04-18 15:39:50
61	1	CREACIÓN	EL USUARIO admin REGISTRO UNA SALIDA DE PRODUCTOS	{"producto_id":"2","cantidad":"1","descripcion":"ERROR DE CONTEO","fecha_registro":"2026-04-18","updated_at":"2026-04-18T19:40:44.000000Z","created_at":"2026-04-18T19:40:44.000000Z","id":2}	\N	SALIDA DE PRODUCTOS	2026-04-18	15:40:44	2026-04-18 15:40:44	2026-04-18 15:40:44
62	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UNA CATEGORIA	{"id":1,"nombre":"CATEGORIA 1","descripcion":"DESC 1","fecha_registro":"2026-04-08","created_at":"2026-04-08T14:54:38.000000Z","updated_at":"2026-04-08T14:54:38.000000Z"}	{"id":1,"nombre":"FAROS","descripcion":"","fecha_registro":"2026-04-08","created_at":"2026-04-08T14:54:38.000000Z","updated_at":"2026-04-18T20:55:20.000000Z"}	CATEGORIAS	2026-04-18	16:55:20	2026-04-18 16:55:20	2026-04-18 16:55:20
63	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UNA CATEGORIA	{"id":2,"nombre":"CATEGORIA 2","descripcion":"","fecha_registro":"2026-04-08","created_at":"2026-04-08T14:54:42.000000Z","updated_at":"2026-04-08T14:54:42.000000Z"}	{"id":2,"nombre":"ALERONES","descripcion":"","fecha_registro":"2026-04-08","created_at":"2026-04-08T14:54:42.000000Z","updated_at":"2026-04-18T20:55:28.000000Z"}	CATEGORIAS	2026-04-18	16:55:28	2026-04-18 16:55:28	2026-04-18 16:55:28
64	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UNA CATEGORIA	{"id":3,"nombre":"CATEGORIA 3","descripcion":"","fecha_registro":"2026-04-08","created_at":"2026-04-08T14:54:47.000000Z","updated_at":"2026-04-08T14:54:47.000000Z"}	{"id":3,"nombre":"PARACHOQUES","descripcion":"","fecha_registro":"2026-04-08","created_at":"2026-04-08T14:54:47.000000Z","updated_at":"2026-04-18T20:55:34.000000Z"}	CATEGORIAS	2026-04-18	16:55:34	2026-04-18 16:55:34	2026-04-18 16:55:34
65	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UNA CATEGORIA	{"id":2,"nombre":"ALERONES","descripcion":"","fecha_registro":"2026-04-08","created_at":"2026-04-08T14:54:42.000000Z","updated_at":"2026-04-18T20:55:28.000000Z"}	{"id":2,"nombre":"RETROVISORES","descripcion":"","fecha_registro":"2026-04-08","created_at":"2026-04-08T14:54:42.000000Z","updated_at":"2026-04-18T20:56:37.000000Z"}	CATEGORIAS	2026-04-18	16:56:37	2026-04-18 16:56:37	2026-04-18 16:56:37
66	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UN PRODUCTO	{"id":3,"nombre":"PRODUCTO 3","descripcion":"<h2>What is Lorem Ipsum?<\\/h2><p><strong>Lorem Ipsum<\\/strong>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/p>","precio":"433.00","stock":"19","categoria_id":2,"fecha_registro":"2026-04-10","created_at":"2026-04-10T13:40:31.000000Z","updated_at":"2026-04-18T19:39:50.000000Z","codigo":"P003","producto_imagens":[{"id":29,"producto_id":3,"imagen":"291776545880.jpeg","created_at":"2026-04-18T20:58:00.000000Z","updated_at":"2026-04-18T20:58:00.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/291776545880.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/291776545880.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/291776545880.jpeg","file":"291776545880.jpeg","name":"291776545880.jpeg","ext":""}]}	{"id":3,"nombre":"RETROVISORES","descripcion":"<h2>What is Lorem Ipsum?<\\/h2><p><strong>Lorem Ipsum<\\/strong>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/p>","precio":"433.00","stock":"19","categoria_id":"2","fecha_registro":"2026-04-10","created_at":"2026-04-10T13:40:31.000000Z","updated_at":"2026-04-18T20:58:00.000000Z","codigo":"P003","producto_imagens":[{"id":29,"producto_id":3,"imagen":"291776545880.jpeg","created_at":"2026-04-18T20:58:00.000000Z","updated_at":"2026-04-18T20:58:00.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/291776545880.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/291776545880.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/291776545880.jpeg","file":"291776545880.jpeg","name":"291776545880.jpeg","ext":""}]}	PRODUCTOS	2026-04-18	16:58:00	2026-04-18 16:58:00	2026-04-18 16:58:00
67	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UN PRODUCTO	{"id":1,"nombre":"PRODUCTO 1","descripcion":"<h3><strong><u>DESCRIPCI\\u00d3N DEL PRODUCTO<\\/u><\\/strong><\\/h3><p><span style=\\"color: rgb(0, 0, 0);\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><\\/p>","precio":"120.00","stock":"93","categoria_id":1,"fecha_registro":"2026-04-08","created_at":"2026-04-08T15:39:00.000000Z","updated_at":"2026-04-16T14:31:12.000000Z","codigo":"P001","producto_imagens":[{"id":40,"producto_id":1,"imagen":"401776546090.jpeg","created_at":"2026-04-18T21:01:30.000000Z","updated_at":"2026-04-18T21:01:30.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/401776546090.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/401776546090.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/401776546090.jpeg","file":"401776546090.jpeg","name":"401776546090.jpeg","ext":""}]}	{"id":1,"nombre":"AURIS IZQUIERDO","descripcion":"<h3><strong><u>DESCRIPCI\\u00d3N DEL PRODUCTO<\\/u><\\/strong><\\/h3><p><span style=\\"color: rgb(0, 0, 0);\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><\\/p>","precio":"120.00","stock":"93","categoria_id":"1","fecha_registro":"2026-04-08","created_at":"2026-04-08T15:39:00.000000Z","updated_at":"2026-04-18T21:01:30.000000Z","codigo":"P001","producto_imagens":[{"id":40,"producto_id":1,"imagen":"401776546090.jpeg","created_at":"2026-04-18T21:01:30.000000Z","updated_at":"2026-04-18T21:01:30.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/401776546090.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/401776546090.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/401776546090.jpeg","file":"401776546090.jpeg","name":"401776546090.jpeg","ext":""}]}	PRODUCTOS	2026-04-18	17:01:30	2026-04-18 17:01:30	2026-04-18 17:01:30
68	1	CREACIÓN	EL USUARIO admin REGISTRO UN PRODUCTO	{"codigo":"P004","nombre":"PARACHOQUES BLANCO","descripcion":"<p>DEscripcion deparachoques blanco<\\/p>","precio":"250","categoria_id":"3","fecha_registro":"2026-04-18","updated_at":"2026-04-18T21:10:40.000000Z","created_at":"2026-04-18T21:10:40.000000Z","id":4,"producto_imagens":[{"id":56,"producto_id":4,"imagen":"561776546640.jpeg","created_at":"2026-04-18T21:10:40.000000Z","updated_at":"2026-04-18T21:10:40.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/561776546640.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/561776546640.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/561776546640.jpeg","file":"561776546640.jpeg","name":"561776546640.jpeg","ext":""}]}	\N	PRODUCTOS	2026-04-18	17:10:40	2026-04-18 17:10:40	2026-04-18 17:10:40
69	1	CREACIÓN	EL USUARIO admin REGISTRO UN PRODUCTO	{"codigo":"P005","nombre":"FAROS DERECHO","descripcion":"<p>descripcion faros derecho<\\/p>","precio":"190","categoria_id":"1","fecha_registro":"2026-04-18","updated_at":"2026-04-18T21:12:49.000000Z","created_at":"2026-04-18T21:12:49.000000Z","id":5,"producto_imagens":[{"id":58,"producto_id":5,"imagen":"581776546769.jpeg","created_at":"2026-04-18T21:12:49.000000Z","updated_at":"2026-04-18T21:12:49.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/581776546769.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/581776546769.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/581776546769.jpeg","file":"581776546769.jpeg","name":"581776546769.jpeg","ext":""},{"id":59,"producto_id":5,"imagen":"1591776546769.jpeg","created_at":"2026-04-18T21:12:49.000000Z","updated_at":"2026-04-18T21:12:49.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/1591776546769.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/1591776546769.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/1591776546769.jpeg","file":"1591776546769.jpeg","name":"1591776546769.jpeg","ext":""}]}	\N	PRODUCTOS	2026-04-18	17:12:49	2026-04-18 17:12:49	2026-04-18 17:12:49
70	1	CREACIÓN	EL USUARIO admin REGISTRO UNA VENTA	{"cliente_id":"1","nit_ci":"123456","total":"433","fecha":"2026-04-18","hora":"17:23:52","user_id":1,"updated_at":"2026-04-18T21:23:52.000000Z","created_at":"2026-04-18T21:23:52.000000Z","id":10,"venta_detalles":[{"id":9,"venta_id":10,"producto_id":3,"precio":"433.00","cantidad":"1","subtotal":"433.00","created_at":"2026-04-18T21:23:52.000000Z","updated_at":"2026-04-18T21:23:52.000000Z"}]}	\N	VENTAS	2026-04-18	17:23:52	2026-04-18 17:23:52	2026-04-18 17:23:52
71	1	CREACIÓN	EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTOS	{"producto_id":"5","cantidad":"1","descripcion":"","fecha_registro":"2026-04-18","updated_at":"2026-04-18T21:24:01.000000Z","created_at":"2026-04-18T21:24:01.000000Z","id":5}	\N	INGRESO DE PRODUCTOS	2026-04-18	17:24:01	2026-04-18 17:24:01	2026-04-18 17:24:01
72	1	CREACIÓN	EL USUARIO admin REGISTRO UNA VENTA	{"cliente_id":"1","nit_ci":"123456","total":"190","fecha":"2026-04-18","hora":"17:28:28","user_id":1,"updated_at":"2026-04-18T21:28:28.000000Z","created_at":"2026-04-18T21:28:28.000000Z","id":14,"venta_detalles":[{"id":10,"venta_id":14,"producto_id":5,"precio":"190.00","cantidad":"1","subtotal":"190.00","created_at":"2026-04-18T21:28:28.000000Z","updated_at":"2026-04-18T21:28:28.000000Z"}]}	\N	VENTAS	2026-04-18	17:28:28	2026-04-18 17:28:28	2026-04-18 17:28:28
73	1	CREACIÓN	EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTOS	{"producto_id":"4","cantidad":"1","descripcion":"","fecha_registro":"2026-04-18","updated_at":"2026-04-18T21:32:28.000000Z","created_at":"2026-04-18T21:32:28.000000Z","id":6}	\N	INGRESO DE PRODUCTOS	2026-04-18	17:32:28	2026-04-18 17:32:28	2026-04-18 17:32:28
74	1	CREACIÓN	EL USUARIO admin REGISTRO UNA VENTA	{"cliente_id":"2","nit_ci":null,"total":"250","fecha":"2026-04-18","hora":"17:32:41","user_id":1,"updated_at":"2026-04-18T21:32:41.000000Z","created_at":"2026-04-18T21:32:41.000000Z","id":15,"venta_detalles":[{"id":11,"venta_id":15,"producto_id":4,"precio":"250.00","cantidad":"1","subtotal":"250.00","created_at":"2026-04-18T21:32:41.000000Z","updated_at":"2026-04-18T21:32:41.000000Z"}]}	\N	VENTAS	2026-04-18	17:32:41	2026-04-18 17:32:41	2026-04-18 17:32:41
75	1	CREACIÓN	EL USUARIO admin REGISTRO UNA VENTA	{"cliente_id":"1","nit_ci":"123456","total":"120","fecha":"2026-04-18","hora":"19:21:55","user_id":1,"updated_at":"2026-04-18T23:21:55.000000Z","created_at":"2026-04-18T23:21:55.000000Z","id":16,"venta_detalles":[{"id":12,"venta_id":16,"producto_id":1,"precio":"120.00","cantidad":"1","subtotal":"120.00","created_at":"2026-04-18T23:21:55.000000Z","updated_at":"2026-04-18T23:21:55.000000Z"}]}	\N	VENTAS	2026-04-18	19:21:55	2026-04-18 19:21:55	2026-04-18 19:21:55
76	1	CREACIÓN	EL USUARIO admin REGISTRO UNA VENTA	{"cliente_id":"2","nit_ci":null,"total":"134","fecha":"2026-04-18","hora":"19:22:04","user_id":1,"updated_at":"2026-04-18T23:22:04.000000Z","created_at":"2026-04-18T23:22:04.000000Z","id":17,"venta_detalles":[{"id":13,"venta_id":17,"producto_id":2,"precio":"67.00","cantidad":"2","subtotal":"134.00","created_at":"2026-04-18T23:22:04.000000Z","updated_at":"2026-04-18T23:22:04.000000Z"}]}	\N	VENTAS	2026-04-18	19:22:04	2026-04-18 19:22:04	2026-04-18 19:22:04
77	1	CREACIÓN	EL USUARIO admin REGISTRO UN CLIENTE	{"nombre":"SOLIZ","nit_ci":"3442343","cel":null,"correo":null,"fecha_registro":"2026-04-18","updated_at":"2026-04-18T23:22:20.000000Z","created_at":"2026-04-18T23:22:20.000000Z","id":6}	\N	CLIENTES	2026-04-18	19:22:20	2026-04-18 19:22:20	2026-04-18 19:22:20
78	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UN CLIENTE	{"id":6,"nombre":"SOLIZ","nit_ci":"3442343","cel":null,"correo":null,"created_at":"2026-04-18T23:22:20.000000Z","updated_at":"2026-04-18T23:22:20.000000Z","fecha_registro":"2026-04-18"}	{"id":6,"nombre":"RODRIGUEZ","nit_ci":"3442343","cel":null,"correo":null,"created_at":"2026-04-18T23:22:20.000000Z","updated_at":"2026-04-18T23:22:28.000000Z","fecha_registro":"2026-04-18"}	CLIENTES	2026-04-18	19:22:28	2026-04-18 19:22:28	2026-04-18 19:22:28
79	1	CREACIÓN	EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTOS	{"producto_id":"5","cantidad":"20","descripcion":"","fecha_registro":"2026-04-18","updated_at":"2026-04-18T23:22:36.000000Z","created_at":"2026-04-18T23:22:36.000000Z","id":7}	\N	INGRESO DE PRODUCTOS	2026-04-18	19:22:36	2026-04-18 19:22:36	2026-04-18 19:22:36
80	1	CREACIÓN	EL USUARIO admin REGISTRO UNA CATEGORIA	{"nombre":"PARACHOQUES TRASEROS","descripcion":"","fecha_registro":"2026-04-18","updated_at":"2026-04-18T23:24:20.000000Z","created_at":"2026-04-18T23:24:20.000000Z","id":4}	\N	CATEGORIAS	2026-04-18	19:24:20	2026-04-18 19:24:20	2026-04-18 19:24:20
81	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UNA SUBASTA	{"id":6,"producto_id":2,"estado_producto":"NUEVO","monto_inicial":"700.00","fecha_fin":"2026-04-19","hora_fin":"12:00:00","publico":1,"estado_subasta":1,"fecha_registro":"2026-04-17","created_at":"2026-04-17T20:26:17.000000Z","updated_at":"2026-04-17T20:27:05.000000Z","garantia":"200.00","descripcion":"<h3><strong>Descripci\\u00f3n de subasta<\\/strong><\\/h3><p><strong style=\\"color: rgb(0, 0, 0);\\">Lorem Ipsum<\\/strong><span style=\\"color: rgb(0, 0, 0);\\">&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type<\\/span><\\/p>"}	{"id":6,"producto_id":"2","estado_producto":"NUEVO","monto_inicial":"700.00","fecha_fin":"2026-04-19","hora_fin":"12:00:00","publico":"1","estado_subasta":1,"fecha_registro":"2026-04-17","created_at":"2026-04-17T20:26:17.000000Z","updated_at":"2026-04-18T23:24:39.000000Z","garantia":"200.00","descripcion":"<h3><strong>Descripci\\u00f3n de subasta<\\/strong><\\/h3><p><strong style=\\"color: rgb(0, 0, 0);\\">Lorem Ipsum<\\/strong><span style=\\"color: rgb(0, 0, 0);\\">&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type.<\\/span><\\/p><p><span style=\\"color: rgb(0, 0, 0);\\">Descripcion de la subasta<\\/span><\\/p>"}	SUBASTAS	2026-04-18	19:24:39	2026-04-18 19:24:39	2026-04-18 19:24:39
82	1	CREACIÓN	EL USUARIO admin REGISTRO UNA SUBASTA	{"producto_id":"3","estado_producto":"NUEVO","monto_inicial":"200","garantia":"100","fecha_fin":"2026-04-20","hora_fin":"12:00","publico":"0","descripcion":"<p>Descripcion<\\/p>","fecha_registro":"2026-04-18","updated_at":"2026-04-19T01:12:19.000000Z","created_at":"2026-04-19T01:12:19.000000Z","id":7}	\N	SUBASTAS	2026-04-18	21:12:19	2026-04-18 21:12:19	2026-04-18 21:12:19
83	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UNA SUBASTA	{"id":7,"producto_id":3,"estado_producto":"NUEVO","monto_inicial":"200.00","fecha_fin":"2026-04-20","hora_fin":"12:00:00","publico":0,"estado_subasta":1,"fecha_registro":"2026-04-18","created_at":"2026-04-19T01:12:19.000000Z","updated_at":"2026-04-19T01:12:19.000000Z","garantia":"100.00","descripcion":"<p>Descripcion<\\/p>"}	{"id":7,"producto_id":"3","estado_producto":"NUEVO","monto_inicial":"200.00","fecha_fin":"2026-04-20","hora_fin":"12:00:00","publico":"1","estado_subasta":1,"fecha_registro":"2026-04-18","created_at":"2026-04-19T01:12:19.000000Z","updated_at":"2026-04-19T01:12:31.000000Z","garantia":"100.00","descripcion":"<p>Descripcion<\\/p>"}	SUBASTAS	2026-04-18	21:12:31	2026-04-18 21:12:31	2026-04-18 21:12:31
84	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UNA SUBASTA	{"id":7,"producto_id":3,"estado_producto":"NUEVO","monto_inicial":"200.00","fecha_fin":"2026-04-20","hora_fin":"12:00:00","publico":1,"estado_subasta":1,"fecha_registro":"2026-04-18","created_at":"2026-04-19T01:12:19.000000Z","updated_at":"2026-04-19T01:12:31.000000Z","garantia":"100.00","descripcion":"<p>Descripcion<\\/p>"}	{"id":7,"producto_id":"3","estado_producto":"NUEVO","monto_inicial":"300","fecha_fin":"2026-04-20","hora_fin":"12:00:00","publico":"1","estado_subasta":1,"fecha_registro":"2026-04-18","created_at":"2026-04-19T01:12:19.000000Z","updated_at":"2026-04-19T01:12:52.000000Z","garantia":"120","descripcion":"<p>Descripcion<\\/p>"}	SUBASTAS	2026-04-18	21:12:52	2026-04-18 21:12:52	2026-04-18 21:12:52
85	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UN PRODUCTO	{"id":1,"nombre":"AURIS IZQUIERDO","descripcion":"<h3><strong><u>DESCRIPCI\\u00d3N DEL PRODUCTO<\\/u><\\/strong><\\/h3><p><span style=\\"color: rgb(0, 0, 0);\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><\\/p>","precio":"120.00","stock":"92","categoria_id":1,"fecha_registro":"2026-04-08","created_at":"2026-04-08T15:39:00.000000Z","updated_at":"2026-04-18T23:21:55.000000Z","codigo":"P001","tsg":0,"producto_imagens":[{"id":40,"producto_id":1,"imagen":"401776546090.jpeg","created_at":"2026-04-18T21:01:30.000000Z","updated_at":"2026-04-18T21:01:30.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/401776546090.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/401776546090.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/401776546090.jpeg","file":"401776546090.jpeg","name":"401776546090.jpeg","ext":""}]}	{"id":1,"nombre":"AURIS IZQUIERDO","descripcion":"<h3><strong><u>DESCRIPCI\\u00d3N DEL PRODUCTO<\\/u><\\/strong><\\/h3><p><span style=\\"color: rgb(0, 0, 0);\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><\\/p>","precio":"120.00","stock":"92","categoria_id":"1","fecha_registro":"2026-04-08","created_at":"2026-04-08T15:39:00.000000Z","updated_at":"2026-04-22T20:32:12.000000Z","codigo":"P001","tsg":"1","producto_imagens":[{"id":40,"producto_id":1,"imagen":"401776546090.jpeg","created_at":"2026-04-18T21:01:30.000000Z","updated_at":"2026-04-18T21:01:30.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/401776546090.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/401776546090.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/401776546090.jpeg","file":"401776546090.jpeg","name":"401776546090.jpeg","ext":""}]}	PRODUCTOS	2026-04-22	16:32:12	2026-04-22 16:32:12	2026-04-22 16:32:12
86	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UN PRODUCTO	{"id":1,"nombre":"AURIS IZQUIERDO","descripcion":"<h3><strong><u>DESCRIPCI\\u00d3N DEL PRODUCTO<\\/u><\\/strong><\\/h3><p><span style=\\"color: rgb(0, 0, 0);\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><\\/p>","precio":"120.00","stock":"92","categoria_id":1,"fecha_registro":"2026-04-08","created_at":"2026-04-08T15:39:00.000000Z","updated_at":"2026-04-22T20:32:12.000000Z","codigo":"P001","tsg":1,"producto_imagens":[{"id":83,"producto_id":1,"imagen":"831776890534.jpg","created_at":"2026-04-22T20:42:14.000000Z","updated_at":"2026-04-22T20:42:14.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/831776890534.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/831776890534.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/831776890534.jpg","file":"831776890534.jpg","name":"831776890534.jpg","ext":""},{"id":84,"producto_id":1,"imagen":"1841776890534.jpg","created_at":"2026-04-22T20:42:14.000000Z","updated_at":"2026-04-22T20:42:14.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/1841776890534.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/1841776890534.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/1841776890534.jpg","file":"1841776890534.jpg","name":"1841776890534.jpg","ext":""}]}	{"id":1,"nombre":"AURIS IZQUIERDO","descripcion":"<h3><strong><u>DESCRIPCI\\u00d3N DEL PRODUCTO<\\/u><\\/strong><\\/h3><p><span style=\\"color: rgb(0, 0, 0);\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><\\/p>","precio":"120.00","stock":"92","categoria_id":"1","fecha_registro":"2026-04-08","created_at":"2026-04-08T15:39:00.000000Z","updated_at":"2026-04-22T20:42:14.000000Z","codigo":"P001","tsg":"0","producto_imagens":[{"id":83,"producto_id":1,"imagen":"831776890534.jpg","created_at":"2026-04-22T20:42:14.000000Z","updated_at":"2026-04-22T20:42:14.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/831776890534.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/831776890534.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/831776890534.jpg","file":"831776890534.jpg","name":"831776890534.jpg","ext":""},{"id":84,"producto_id":1,"imagen":"1841776890534.jpg","created_at":"2026-04-22T20:42:14.000000Z","updated_at":"2026-04-22T20:42:14.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/1841776890534.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/1841776890534.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/1841776890534.jpg","file":"1841776890534.jpg","name":"1841776890534.jpg","ext":""}]}	PRODUCTOS	2026-04-22	16:42:14	2026-04-22 16:42:14	2026-04-22 16:42:14
87	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UN PRODUCTO	{"id":1,"nombre":"AURIS IZQUIERDO","descripcion":"<h3><strong><u>DESCRIPCI\\u00d3N DEL PRODUCTO<\\/u><\\/strong><\\/h3><p><span style=\\"color: rgb(0, 0, 0);\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><\\/p>","precio":"120.00","stock":"92","categoria_id":1,"fecha_registro":"2026-04-08","created_at":"2026-04-08T15:39:00.000000Z","updated_at":"2026-04-22T20:42:14.000000Z","codigo":"P001","tsg":0,"producto_imagens":[{"id":101,"producto_id":1,"imagen":"181011776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/181011776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/181011776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/181011776890606.jpg","file":"181011776890606.jpg","name":"181011776890606.jpg","ext":""},{"id":102,"producto_id":1,"imagen":"191021776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/191021776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/191021776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/191021776890606.jpg","file":"191021776890606.jpg","name":"191021776890606.jpg","ext":""},{"id":103,"producto_id":1,"imagen":"201031776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/201031776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/201031776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/201031776890606.jpg","file":"201031776890606.jpg","name":"201031776890606.jpg","ext":""},{"id":104,"producto_id":1,"imagen":"211041776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/211041776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/211041776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/211041776890606.jpg","file":"211041776890606.jpg","name":"211041776890606.jpg","ext":""},{"id":105,"producto_id":1,"imagen":"221051776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/221051776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/221051776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/221051776890606.jpg","file":"221051776890606.jpg","name":"221051776890606.jpg","ext":""},{"id":106,"producto_id":1,"imagen":"231061776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/231061776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/231061776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/231061776890606.jpg","file":"231061776890606.jpg","name":"231061776890606.jpg","ext":""},{"id":107,"producto_id":1,"imagen":"241071776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/241071776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/241071776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/241071776890606.jpg","file":"241071776890606.jpg","name":"241071776890606.jpg","ext":""},{"id":108,"producto_id":1,"imagen":"251081776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/251081776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/251081776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/251081776890606.jpg","file":"251081776890606.jpg","name":"251081776890606.jpg","ext":""},{"id":109,"producto_id":1,"imagen":"261091776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/261091776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/261091776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/261091776890606.jpg","file":"261091776890606.jpg","name":"261091776890606.jpg","ext":""},{"id":110,"producto_id":1,"imagen":"271101776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/271101776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/271101776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/271101776890606.jpg","file":"271101776890606.jpg","name":"271101776890606.jpg","ext":""},{"id":111,"producto_id":1,"imagen":"281111776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/281111776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/281111776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/281111776890606.jpg","file":"281111776890606.jpg","name":"281111776890606.jpg","ext":""},{"id":112,"producto_id":1,"imagen":"291121776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/291121776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/291121776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/291121776890606.jpg","file":"291121776890606.jpg","name":"291121776890606.jpg","ext":""},{"id":113,"producto_id":1,"imagen":"301131776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/301131776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/301131776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/301131776890606.jpg","file":"301131776890606.jpg","name":"301131776890606.jpg","ext":""},{"id":114,"producto_id":1,"imagen":"311141776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/311141776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/311141776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/311141776890606.jpg","file":"311141776890606.jpg","name":"311141776890606.jpg","ext":""},{"id":83,"producto_id":1,"imagen":"831776890534.jpg","created_at":"2026-04-22T20:42:14.000000Z","updated_at":"2026-04-22T20:42:14.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/831776890534.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/831776890534.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/831776890534.jpg","file":"831776890534.jpg","name":"831776890534.jpg","ext":""},{"id":84,"producto_id":1,"imagen":"1841776890534.jpg","created_at":"2026-04-22T20:42:14.000000Z","updated_at":"2026-04-22T20:42:14.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/1841776890534.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/1841776890534.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/1841776890534.jpg","file":"1841776890534.jpg","name":"1841776890534.jpg","ext":""},{"id":85,"producto_id":1,"imagen":"2851776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/2851776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/2851776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/2851776890606.jpg","file":"2851776890606.jpg","name":"2851776890606.jpg","ext":""},{"id":86,"producto_id":1,"imagen":"3861776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/3861776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/3861776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/3861776890606.jpg","file":"3861776890606.jpg","name":"3861776890606.jpg","ext":""},{"id":87,"producto_id":1,"imagen":"4871776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/4871776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/4871776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/4871776890606.jpg","file":"4871776890606.jpg","name":"4871776890606.jpg","ext":""},{"id":88,"producto_id":1,"imagen":"5881776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/5881776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/5881776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/5881776890606.jpg","file":"5881776890606.jpg","name":"5881776890606.jpg","ext":""},{"id":89,"producto_id":1,"imagen":"6891776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/6891776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/6891776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/6891776890606.jpg","file":"6891776890606.jpg","name":"6891776890606.jpg","ext":""},{"id":90,"producto_id":1,"imagen":"7901776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/7901776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/7901776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/7901776890606.jpg","file":"7901776890606.jpg","name":"7901776890606.jpg","ext":""},{"id":91,"producto_id":1,"imagen":"8911776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/8911776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/8911776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/8911776890606.jpg","file":"8911776890606.jpg","name":"8911776890606.jpg","ext":""},{"id":92,"producto_id":1,"imagen":"9921776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/9921776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/9921776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/9921776890606.jpg","file":"9921776890606.jpg","name":"9921776890606.jpg","ext":""},{"id":93,"producto_id":1,"imagen":"10931776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/10931776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/10931776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/10931776890606.jpg","file":"10931776890606.jpg","name":"10931776890606.jpg","ext":""},{"id":94,"producto_id":1,"imagen":"11941776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/11941776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/11941776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/11941776890606.jpg","file":"11941776890606.jpg","name":"11941776890606.jpg","ext":""},{"id":95,"producto_id":1,"imagen":"12951776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/12951776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/12951776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/12951776890606.jpg","file":"12951776890606.jpg","name":"12951776890606.jpg","ext":""},{"id":96,"producto_id":1,"imagen":"13961776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/13961776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/13961776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/13961776890606.jpg","file":"13961776890606.jpg","name":"13961776890606.jpg","ext":""},{"id":97,"producto_id":1,"imagen":"14971776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/14971776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/14971776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/14971776890606.jpg","file":"14971776890606.jpg","name":"14971776890606.jpg","ext":""},{"id":98,"producto_id":1,"imagen":"15981776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/15981776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/15981776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/15981776890606.jpg","file":"15981776890606.jpg","name":"15981776890606.jpg","ext":""},{"id":99,"producto_id":1,"imagen":"16991776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/16991776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/16991776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/16991776890606.jpg","file":"16991776890606.jpg","name":"16991776890606.jpg","ext":""},{"id":100,"producto_id":1,"imagen":"171001776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/171001776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/171001776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/171001776890606.jpg","file":"171001776890606.jpg","name":"171001776890606.jpg","ext":""},{"id":115,"producto_id":1,"imagen":"321151776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/321151776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/321151776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/321151776890606.jpg","file":"321151776890606.jpg","name":"321151776890606.jpg","ext":""},{"id":116,"producto_id":1,"imagen":"331161776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/331161776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/331161776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/331161776890606.jpg","file":"331161776890606.jpg","name":"331161776890606.jpg","ext":""},{"id":117,"producto_id":1,"imagen":"341171776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/341171776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/341171776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/341171776890606.jpg","file":"341171776890606.jpg","name":"341171776890606.jpg","ext":""},{"id":118,"producto_id":1,"imagen":"351181776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/351181776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/351181776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/351181776890606.jpg","file":"351181776890606.jpg","name":"351181776890606.jpg","ext":""},{"id":119,"producto_id":1,"imagen":"361191776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/361191776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/361191776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/361191776890606.jpg","file":"361191776890606.jpg","name":"361191776890606.jpg","ext":""},{"id":120,"producto_id":1,"imagen":"371201776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/371201776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/371201776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/371201776890606.jpg","file":"371201776890606.jpg","name":"371201776890606.jpg","ext":""},{"id":121,"producto_id":1,"imagen":"381211776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/381211776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/381211776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/381211776890606.jpg","file":"381211776890606.jpg","name":"381211776890606.jpg","ext":""},{"id":122,"producto_id":1,"imagen":"391221776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/391221776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/391221776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/391221776890606.jpg","file":"391221776890606.jpg","name":"391221776890606.jpg","ext":""},{"id":123,"producto_id":1,"imagen":"401231776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/401231776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/401231776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/401231776890606.jpg","file":"401231776890606.jpg","name":"401231776890606.jpg","ext":""},{"id":124,"producto_id":1,"imagen":"411241776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/411241776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/411241776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/411241776890606.jpg","file":"411241776890606.jpg","name":"411241776890606.jpg","ext":""},{"id":125,"producto_id":1,"imagen":"421251776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/421251776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/421251776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/421251776890606.jpg","file":"421251776890606.jpg","name":"421251776890606.jpg","ext":""},{"id":126,"producto_id":1,"imagen":"431261776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/431261776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/431261776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/431261776890606.jpg","file":"431261776890606.jpg","name":"431261776890606.jpg","ext":""},{"id":127,"producto_id":1,"imagen":"441271776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/441271776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/441271776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/441271776890606.jpg","file":"441271776890606.jpg","name":"441271776890606.jpg","ext":""},{"id":128,"producto_id":1,"imagen":"451281776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/451281776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/451281776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/451281776890606.jpg","file":"451281776890606.jpg","name":"451281776890606.jpg","ext":""},{"id":129,"producto_id":1,"imagen":"461291776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/461291776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/461291776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/461291776890606.jpg","file":"461291776890606.jpg","name":"461291776890606.jpg","ext":""},{"id":130,"producto_id":1,"imagen":"471301776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/471301776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/471301776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/471301776890606.jpg","file":"471301776890606.jpg","name":"471301776890606.jpg","ext":""},{"id":131,"producto_id":1,"imagen":"481311776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/481311776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/481311776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/481311776890606.jpg","file":"481311776890606.jpg","name":"481311776890606.jpg","ext":""},{"id":132,"producto_id":1,"imagen":"491321776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/491321776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/491321776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/491321776890606.jpg","file":"491321776890606.jpg","name":"491321776890606.jpg","ext":""},{"id":133,"producto_id":1,"imagen":"501331776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/501331776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/501331776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/501331776890606.jpg","file":"501331776890606.jpg","name":"501331776890606.jpg","ext":""},{"id":134,"producto_id":1,"imagen":"511341776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/511341776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/511341776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/511341776890606.jpg","file":"511341776890606.jpg","name":"511341776890606.jpg","ext":""},{"id":135,"producto_id":1,"imagen":"521351776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/521351776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/521351776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/521351776890606.jpg","file":"521351776890606.jpg","name":"521351776890606.jpg","ext":""},{"id":136,"producto_id":1,"imagen":"531361776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/531361776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/531361776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/531361776890606.jpg","file":"531361776890606.jpg","name":"531361776890606.jpg","ext":""},{"id":137,"producto_id":1,"imagen":"541371776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/541371776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/541371776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/541371776890606.jpg","file":"541371776890606.jpg","name":"541371776890606.jpg","ext":""},{"id":138,"producto_id":1,"imagen":"551381776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/551381776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/551381776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/551381776890606.jpg","file":"551381776890606.jpg","name":"551381776890606.jpg","ext":""},{"id":139,"producto_id":1,"imagen":"561391776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/561391776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/561391776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/561391776890606.jpg","file":"561391776890606.jpg","name":"561391776890606.jpg","ext":""},{"id":140,"producto_id":1,"imagen":"571401776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/571401776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/571401776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/571401776890606.jpg","file":"571401776890606.jpg","name":"571401776890606.jpg","ext":""},{"id":141,"producto_id":1,"imagen":"581411776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/581411776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/581411776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/581411776890606.jpg","file":"581411776890606.jpg","name":"581411776890606.jpg","ext":""},{"id":142,"producto_id":1,"imagen":"591421776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/591421776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/591421776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/591421776890606.jpg","file":"591421776890606.jpg","name":"591421776890606.jpg","ext":""},{"id":143,"producto_id":1,"imagen":"601431776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/601431776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/601431776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/601431776890606.jpg","file":"601431776890606.jpg","name":"601431776890606.jpg","ext":""},{"id":144,"producto_id":1,"imagen":"611441776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/611441776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/611441776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/611441776890606.jpg","file":"611441776890606.jpg","name":"611441776890606.jpg","ext":""},{"id":145,"producto_id":1,"imagen":"621451776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/621451776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/621451776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/621451776890606.jpg","file":"621451776890606.jpg","name":"621451776890606.jpg","ext":""},{"id":146,"producto_id":1,"imagen":"631461776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/631461776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/631461776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/631461776890606.jpg","file":"631461776890606.jpg","name":"631461776890606.jpg","ext":""},{"id":147,"producto_id":1,"imagen":"641471776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/641471776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/641471776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/641471776890606.jpg","file":"641471776890606.jpg","name":"641471776890606.jpg","ext":""},{"id":148,"producto_id":1,"imagen":"651481776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/651481776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/651481776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/651481776890606.jpg","file":"651481776890606.jpg","name":"651481776890606.jpg","ext":""},{"id":149,"producto_id":1,"imagen":"661491776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/661491776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/661491776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/661491776890606.jpg","file":"661491776890606.jpg","name":"661491776890606.jpg","ext":""},{"id":150,"producto_id":1,"imagen":"671501776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/671501776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/671501776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/671501776890606.jpg","file":"671501776890606.jpg","name":"671501776890606.jpg","ext":""},{"id":151,"producto_id":1,"imagen":"681511776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/681511776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/681511776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/681511776890606.jpg","file":"681511776890606.jpg","name":"681511776890606.jpg","ext":""},{"id":152,"producto_id":1,"imagen":"691521776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/691521776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/691521776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/691521776890606.jpg","file":"691521776890606.jpg","name":"691521776890606.jpg","ext":""},{"id":153,"producto_id":1,"imagen":"701531776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/701531776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/701531776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/701531776890606.jpg","file":"701531776890606.jpg","name":"701531776890606.jpg","ext":""},{"id":154,"producto_id":1,"imagen":"711541776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/711541776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/711541776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/711541776890606.jpg","file":"711541776890606.jpg","name":"711541776890606.jpg","ext":""},{"id":155,"producto_id":1,"imagen":"721551776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/721551776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/721551776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/721551776890606.jpg","file":"721551776890606.jpg","name":"721551776890606.jpg","ext":""},{"id":156,"producto_id":1,"imagen":"731561776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/731561776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/731561776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/731561776890606.jpg","file":"731561776890606.jpg","name":"731561776890606.jpg","ext":""},{"id":157,"producto_id":1,"imagen":"741571776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/741571776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/741571776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/741571776890606.jpg","file":"741571776890606.jpg","name":"741571776890606.jpg","ext":""},{"id":158,"producto_id":1,"imagen":"751581776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/751581776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/751581776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/751581776890606.jpg","file":"751581776890606.jpg","name":"751581776890606.jpg","ext":""},{"id":159,"producto_id":1,"imagen":"761591776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/761591776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/761591776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/761591776890606.jpg","file":"761591776890606.jpg","name":"761591776890606.jpg","ext":""},{"id":160,"producto_id":1,"imagen":"771601776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/771601776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/771601776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/771601776890606.jpg","file":"771601776890606.jpg","name":"771601776890606.jpg","ext":""}]}	{"id":1,"nombre":"AURIS IZQUIERDO","descripcion":"<h3><strong><u>DESCRIPCI\\u00d3N DEL PRODUCTO<\\/u><\\/strong><\\/h3><p><span style=\\"color: rgb(0, 0, 0);\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><\\/p>","precio":"120.00","stock":"92","categoria_id":"1","fecha_registro":"2026-04-08","created_at":"2026-04-08T15:39:00.000000Z","updated_at":"2026-04-22T20:43:43.000000Z","codigo":"P001","tsg":"1","producto_imagens":[{"id":101,"producto_id":1,"imagen":"181011776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/181011776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/181011776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/181011776890606.jpg","file":"181011776890606.jpg","name":"181011776890606.jpg","ext":""},{"id":102,"producto_id":1,"imagen":"191021776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/191021776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/191021776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/191021776890606.jpg","file":"191021776890606.jpg","name":"191021776890606.jpg","ext":""},{"id":103,"producto_id":1,"imagen":"201031776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/201031776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/201031776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/201031776890606.jpg","file":"201031776890606.jpg","name":"201031776890606.jpg","ext":""},{"id":104,"producto_id":1,"imagen":"211041776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/211041776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/211041776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/211041776890606.jpg","file":"211041776890606.jpg","name":"211041776890606.jpg","ext":""},{"id":105,"producto_id":1,"imagen":"221051776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/221051776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/221051776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/221051776890606.jpg","file":"221051776890606.jpg","name":"221051776890606.jpg","ext":""},{"id":106,"producto_id":1,"imagen":"231061776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/231061776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/231061776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/231061776890606.jpg","file":"231061776890606.jpg","name":"231061776890606.jpg","ext":""},{"id":107,"producto_id":1,"imagen":"241071776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/241071776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/241071776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/241071776890606.jpg","file":"241071776890606.jpg","name":"241071776890606.jpg","ext":""},{"id":108,"producto_id":1,"imagen":"251081776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/251081776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/251081776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/251081776890606.jpg","file":"251081776890606.jpg","name":"251081776890606.jpg","ext":""},{"id":109,"producto_id":1,"imagen":"261091776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/261091776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/261091776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/261091776890606.jpg","file":"261091776890606.jpg","name":"261091776890606.jpg","ext":""},{"id":110,"producto_id":1,"imagen":"271101776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/271101776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/271101776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/271101776890606.jpg","file":"271101776890606.jpg","name":"271101776890606.jpg","ext":""},{"id":111,"producto_id":1,"imagen":"281111776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/281111776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/281111776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/281111776890606.jpg","file":"281111776890606.jpg","name":"281111776890606.jpg","ext":""},{"id":112,"producto_id":1,"imagen":"291121776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/291121776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/291121776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/291121776890606.jpg","file":"291121776890606.jpg","name":"291121776890606.jpg","ext":""},{"id":113,"producto_id":1,"imagen":"301131776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/301131776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/301131776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/301131776890606.jpg","file":"301131776890606.jpg","name":"301131776890606.jpg","ext":""},{"id":114,"producto_id":1,"imagen":"311141776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/311141776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/311141776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/311141776890606.jpg","file":"311141776890606.jpg","name":"311141776890606.jpg","ext":""},{"id":83,"producto_id":1,"imagen":"831776890534.jpg","created_at":"2026-04-22T20:42:14.000000Z","updated_at":"2026-04-22T20:42:14.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/831776890534.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/831776890534.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/831776890534.jpg","file":"831776890534.jpg","name":"831776890534.jpg","ext":""},{"id":84,"producto_id":1,"imagen":"1841776890534.jpg","created_at":"2026-04-22T20:42:14.000000Z","updated_at":"2026-04-22T20:42:14.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/1841776890534.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/1841776890534.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/1841776890534.jpg","file":"1841776890534.jpg","name":"1841776890534.jpg","ext":""},{"id":85,"producto_id":1,"imagen":"2851776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/2851776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/2851776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/2851776890606.jpg","file":"2851776890606.jpg","name":"2851776890606.jpg","ext":""},{"id":86,"producto_id":1,"imagen":"3861776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/3861776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/3861776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/3861776890606.jpg","file":"3861776890606.jpg","name":"3861776890606.jpg","ext":""},{"id":87,"producto_id":1,"imagen":"4871776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/4871776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/4871776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/4871776890606.jpg","file":"4871776890606.jpg","name":"4871776890606.jpg","ext":""},{"id":88,"producto_id":1,"imagen":"5881776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/5881776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/5881776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/5881776890606.jpg","file":"5881776890606.jpg","name":"5881776890606.jpg","ext":""},{"id":89,"producto_id":1,"imagen":"6891776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/6891776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/6891776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/6891776890606.jpg","file":"6891776890606.jpg","name":"6891776890606.jpg","ext":""},{"id":90,"producto_id":1,"imagen":"7901776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/7901776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/7901776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/7901776890606.jpg","file":"7901776890606.jpg","name":"7901776890606.jpg","ext":""},{"id":91,"producto_id":1,"imagen":"8911776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/8911776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/8911776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/8911776890606.jpg","file":"8911776890606.jpg","name":"8911776890606.jpg","ext":""},{"id":92,"producto_id":1,"imagen":"9921776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/9921776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/9921776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/9921776890606.jpg","file":"9921776890606.jpg","name":"9921776890606.jpg","ext":""},{"id":93,"producto_id":1,"imagen":"10931776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/10931776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/10931776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/10931776890606.jpg","file":"10931776890606.jpg","name":"10931776890606.jpg","ext":""},{"id":94,"producto_id":1,"imagen":"11941776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/11941776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/11941776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/11941776890606.jpg","file":"11941776890606.jpg","name":"11941776890606.jpg","ext":""},{"id":95,"producto_id":1,"imagen":"12951776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/12951776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/12951776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/12951776890606.jpg","file":"12951776890606.jpg","name":"12951776890606.jpg","ext":""},{"id":96,"producto_id":1,"imagen":"13961776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/13961776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/13961776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/13961776890606.jpg","file":"13961776890606.jpg","name":"13961776890606.jpg","ext":""},{"id":97,"producto_id":1,"imagen":"14971776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/14971776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/14971776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/14971776890606.jpg","file":"14971776890606.jpg","name":"14971776890606.jpg","ext":""},{"id":98,"producto_id":1,"imagen":"15981776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/15981776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/15981776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/15981776890606.jpg","file":"15981776890606.jpg","name":"15981776890606.jpg","ext":""},{"id":99,"producto_id":1,"imagen":"16991776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/16991776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/16991776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/16991776890606.jpg","file":"16991776890606.jpg","name":"16991776890606.jpg","ext":""},{"id":100,"producto_id":1,"imagen":"171001776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/171001776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/171001776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/171001776890606.jpg","file":"171001776890606.jpg","name":"171001776890606.jpg","ext":""},{"id":115,"producto_id":1,"imagen":"321151776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/321151776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/321151776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/321151776890606.jpg","file":"321151776890606.jpg","name":"321151776890606.jpg","ext":""},{"id":116,"producto_id":1,"imagen":"331161776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/331161776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/331161776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/331161776890606.jpg","file":"331161776890606.jpg","name":"331161776890606.jpg","ext":""},{"id":117,"producto_id":1,"imagen":"341171776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/341171776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/341171776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/341171776890606.jpg","file":"341171776890606.jpg","name":"341171776890606.jpg","ext":""},{"id":118,"producto_id":1,"imagen":"351181776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/351181776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/351181776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/351181776890606.jpg","file":"351181776890606.jpg","name":"351181776890606.jpg","ext":""},{"id":119,"producto_id":1,"imagen":"361191776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/361191776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/361191776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/361191776890606.jpg","file":"361191776890606.jpg","name":"361191776890606.jpg","ext":""},{"id":120,"producto_id":1,"imagen":"371201776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/371201776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/371201776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/371201776890606.jpg","file":"371201776890606.jpg","name":"371201776890606.jpg","ext":""},{"id":121,"producto_id":1,"imagen":"381211776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/381211776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/381211776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/381211776890606.jpg","file":"381211776890606.jpg","name":"381211776890606.jpg","ext":""},{"id":122,"producto_id":1,"imagen":"391221776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/391221776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/391221776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/391221776890606.jpg","file":"391221776890606.jpg","name":"391221776890606.jpg","ext":""},{"id":123,"producto_id":1,"imagen":"401231776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/401231776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/401231776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/401231776890606.jpg","file":"401231776890606.jpg","name":"401231776890606.jpg","ext":""},{"id":124,"producto_id":1,"imagen":"411241776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/411241776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/411241776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/411241776890606.jpg","file":"411241776890606.jpg","name":"411241776890606.jpg","ext":""},{"id":125,"producto_id":1,"imagen":"421251776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/421251776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/421251776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/421251776890606.jpg","file":"421251776890606.jpg","name":"421251776890606.jpg","ext":""},{"id":126,"producto_id":1,"imagen":"431261776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/431261776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/431261776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/431261776890606.jpg","file":"431261776890606.jpg","name":"431261776890606.jpg","ext":""},{"id":127,"producto_id":1,"imagen":"441271776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/441271776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/441271776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/441271776890606.jpg","file":"441271776890606.jpg","name":"441271776890606.jpg","ext":""},{"id":128,"producto_id":1,"imagen":"451281776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/451281776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/451281776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/451281776890606.jpg","file":"451281776890606.jpg","name":"451281776890606.jpg","ext":""},{"id":129,"producto_id":1,"imagen":"461291776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/461291776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/461291776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/461291776890606.jpg","file":"461291776890606.jpg","name":"461291776890606.jpg","ext":""},{"id":130,"producto_id":1,"imagen":"471301776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/471301776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/471301776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/471301776890606.jpg","file":"471301776890606.jpg","name":"471301776890606.jpg","ext":""},{"id":131,"producto_id":1,"imagen":"481311776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/481311776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/481311776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/481311776890606.jpg","file":"481311776890606.jpg","name":"481311776890606.jpg","ext":""},{"id":132,"producto_id":1,"imagen":"491321776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/491321776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/491321776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/491321776890606.jpg","file":"491321776890606.jpg","name":"491321776890606.jpg","ext":""},{"id":133,"producto_id":1,"imagen":"501331776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/501331776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/501331776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/501331776890606.jpg","file":"501331776890606.jpg","name":"501331776890606.jpg","ext":""},{"id":134,"producto_id":1,"imagen":"511341776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/511341776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/511341776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/511341776890606.jpg","file":"511341776890606.jpg","name":"511341776890606.jpg","ext":""},{"id":135,"producto_id":1,"imagen":"521351776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/521351776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/521351776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/521351776890606.jpg","file":"521351776890606.jpg","name":"521351776890606.jpg","ext":""},{"id":136,"producto_id":1,"imagen":"531361776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/531361776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/531361776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/531361776890606.jpg","file":"531361776890606.jpg","name":"531361776890606.jpg","ext":""},{"id":137,"producto_id":1,"imagen":"541371776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/541371776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/541371776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/541371776890606.jpg","file":"541371776890606.jpg","name":"541371776890606.jpg","ext":""},{"id":138,"producto_id":1,"imagen":"551381776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/551381776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/551381776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/551381776890606.jpg","file":"551381776890606.jpg","name":"551381776890606.jpg","ext":""},{"id":139,"producto_id":1,"imagen":"561391776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/561391776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/561391776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/561391776890606.jpg","file":"561391776890606.jpg","name":"561391776890606.jpg","ext":""},{"id":140,"producto_id":1,"imagen":"571401776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/571401776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/571401776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/571401776890606.jpg","file":"571401776890606.jpg","name":"571401776890606.jpg","ext":""},{"id":141,"producto_id":1,"imagen":"581411776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/581411776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/581411776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/581411776890606.jpg","file":"581411776890606.jpg","name":"581411776890606.jpg","ext":""},{"id":142,"producto_id":1,"imagen":"591421776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/591421776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/591421776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/591421776890606.jpg","file":"591421776890606.jpg","name":"591421776890606.jpg","ext":""},{"id":143,"producto_id":1,"imagen":"601431776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/601431776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/601431776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/601431776890606.jpg","file":"601431776890606.jpg","name":"601431776890606.jpg","ext":""},{"id":144,"producto_id":1,"imagen":"611441776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/611441776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/611441776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/611441776890606.jpg","file":"611441776890606.jpg","name":"611441776890606.jpg","ext":""},{"id":145,"producto_id":1,"imagen":"621451776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/621451776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/621451776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/621451776890606.jpg","file":"621451776890606.jpg","name":"621451776890606.jpg","ext":""},{"id":146,"producto_id":1,"imagen":"631461776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/631461776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/631461776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/631461776890606.jpg","file":"631461776890606.jpg","name":"631461776890606.jpg","ext":""},{"id":147,"producto_id":1,"imagen":"641471776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/641471776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/641471776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/641471776890606.jpg","file":"641471776890606.jpg","name":"641471776890606.jpg","ext":""},{"id":148,"producto_id":1,"imagen":"651481776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/651481776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/651481776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/651481776890606.jpg","file":"651481776890606.jpg","name":"651481776890606.jpg","ext":""},{"id":149,"producto_id":1,"imagen":"661491776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/661491776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/661491776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/661491776890606.jpg","file":"661491776890606.jpg","name":"661491776890606.jpg","ext":""},{"id":150,"producto_id":1,"imagen":"671501776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/671501776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/671501776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/671501776890606.jpg","file":"671501776890606.jpg","name":"671501776890606.jpg","ext":""},{"id":151,"producto_id":1,"imagen":"681511776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/681511776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/681511776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/681511776890606.jpg","file":"681511776890606.jpg","name":"681511776890606.jpg","ext":""},{"id":152,"producto_id":1,"imagen":"691521776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/691521776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/691521776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/691521776890606.jpg","file":"691521776890606.jpg","name":"691521776890606.jpg","ext":""},{"id":153,"producto_id":1,"imagen":"701531776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/701531776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/701531776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/701531776890606.jpg","file":"701531776890606.jpg","name":"701531776890606.jpg","ext":""},{"id":154,"producto_id":1,"imagen":"711541776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/711541776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/711541776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/711541776890606.jpg","file":"711541776890606.jpg","name":"711541776890606.jpg","ext":""},{"id":155,"producto_id":1,"imagen":"721551776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/721551776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/721551776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/721551776890606.jpg","file":"721551776890606.jpg","name":"721551776890606.jpg","ext":""},{"id":156,"producto_id":1,"imagen":"731561776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/731561776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/731561776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/731561776890606.jpg","file":"731561776890606.jpg","name":"731561776890606.jpg","ext":""},{"id":157,"producto_id":1,"imagen":"741571776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/741571776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/741571776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/741571776890606.jpg","file":"741571776890606.jpg","name":"741571776890606.jpg","ext":""},{"id":158,"producto_id":1,"imagen":"751581776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/751581776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/751581776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/751581776890606.jpg","file":"751581776890606.jpg","name":"751581776890606.jpg","ext":""},{"id":159,"producto_id":1,"imagen":"761591776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/761591776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/761591776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/761591776890606.jpg","file":"761591776890606.jpg","name":"761591776890606.jpg","ext":""},{"id":160,"producto_id":1,"imagen":"771601776890606.jpg","created_at":"2026-04-22T20:43:26.000000Z","updated_at":"2026-04-22T20:43:26.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/771601776890606.jpg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/771601776890606.jpg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/771601776890606.jpg","file":"771601776890606.jpg","name":"771601776890606.jpg","ext":""}]}	PRODUCTOS	2026-04-22	16:43:43	2026-04-22 16:43:43	2026-04-22 16:43:43
88	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UN PRODUCTO	{"id":2,"nombre":"PRODUCTO 2","descripcion":"<p>Descripcion del producto 2<\\/p>","precio":"67.00","stock":"90","categoria_id":1,"fecha_registro":"2026-04-08","created_at":"2026-04-08T23:33:31.000000Z","updated_at":"2026-04-18T23:22:04.000000Z","codigo":"P002","tsg":0,"producto_imagens":[{"id":53,"producto_id":2,"imagen":"531776546244.jpeg","created_at":"2026-04-18T21:04:04.000000Z","updated_at":"2026-04-18T21:04:04.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/531776546244.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/531776546244.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/531776546244.jpeg","file":"531776546244.jpeg","name":"531776546244.jpeg","ext":""},{"id":54,"producto_id":2,"imagen":"1541776546244.jpeg","created_at":"2026-04-18T21:04:04.000000Z","updated_at":"2026-04-18T21:04:04.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/1541776546244.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/1541776546244.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/1541776546244.jpeg","file":"1541776546244.jpeg","name":"1541776546244.jpeg","ext":""}]}	{"id":2,"nombre":"PRODUCTO 2","descripcion":"<p>Descripcion del producto 2<\\/p>","precio":"67.00","stock":"90","categoria_id":"1","fecha_registro":"2026-04-08","created_at":"2026-04-08T23:33:31.000000Z","updated_at":"2026-04-22T20:45:23.000000Z","codigo":"P002","tsg":"1","producto_imagens":[{"id":53,"producto_id":2,"imagen":"531776546244.jpeg","created_at":"2026-04-18T21:04:04.000000Z","updated_at":"2026-04-18T21:04:04.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/531776546244.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/531776546244.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/531776546244.jpeg","file":"531776546244.jpeg","name":"531776546244.jpeg","ext":""},{"id":54,"producto_id":2,"imagen":"1541776546244.jpeg","created_at":"2026-04-18T21:04:04.000000Z","updated_at":"2026-04-18T21:04:04.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/1541776546244.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/1541776546244.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/1541776546244.jpeg","file":"1541776546244.jpeg","name":"1541776546244.jpeg","ext":""}]}	PRODUCTOS	2026-04-22	16:45:23	2026-04-22 16:45:23	2026-04-22 16:45:23
89	1	MODIFICACIÓN	EL USUARIO admin ACTUALIZÓ UN PRODUCTO	{"id":2,"nombre":"PRODUCTO 2","descripcion":"<p>Descripcion del producto 2<\\/p>","precio":"67.00","stock":"90","categoria_id":1,"fecha_registro":"2026-04-08","created_at":"2026-04-08T23:33:31.000000Z","updated_at":"2026-04-22T20:45:23.000000Z","codigo":"P002","tsg":1,"producto_imagens":[{"id":53,"producto_id":2,"imagen":"531776546244.jpeg","created_at":"2026-04-18T21:04:04.000000Z","updated_at":"2026-04-18T21:04:04.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/531776546244.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/531776546244.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/531776546244.jpeg","file":"531776546244.jpeg","name":"531776546244.jpeg","ext":""},{"id":54,"producto_id":2,"imagen":"1541776546244.jpeg","created_at":"2026-04-18T21:04:04.000000Z","updated_at":"2026-04-18T21:04:04.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/1541776546244.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/1541776546244.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/1541776546244.jpeg","file":"1541776546244.jpeg","name":"1541776546244.jpeg","ext":""}]}	{"id":2,"nombre":"PRODUCTO 2","descripcion":"<p>Descripcion del producto 2<\\/p>","precio":"67.00","stock":"90","categoria_id":"1","fecha_registro":"2026-04-08","created_at":"2026-04-08T23:33:31.000000Z","updated_at":"2026-04-22T20:45:52.000000Z","codigo":"P002","tsg":"0","producto_imagens":[{"id":53,"producto_id":2,"imagen":"531776546244.jpeg","created_at":"2026-04-18T21:04:04.000000Z","updated_at":"2026-04-18T21:04:04.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/531776546244.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/531776546244.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/531776546244.jpeg","file":"531776546244.jpeg","name":"531776546244.jpeg","ext":""},{"id":54,"producto_id":2,"imagen":"1541776546244.jpeg","created_at":"2026-04-18T21:04:04.000000Z","updated_at":"2026-04-18T21:04:04.000000Z","url_imagen":"http:\\/\\/savs.test\\/imgs\\/productos\\/1541776546244.jpeg","url_archivo":"http:\\/\\/savs.test\\/imgs\\/productos\\/1541776546244.jpeg","url_file":"http:\\/\\/savs.test\\/imgs\\/productos\\/1541776546244.jpeg","file":"1541776546244.jpeg","name":"1541776546244.jpeg","ext":""}]}	PRODUCTOS	2026-04-22	16:45:52	2026-04-22 16:45:52	2026-04-22 16:45:52
90	1	CREACIÓN	EL USUARIO admin REGISTRO UNA SUBASTA	{"producto_id":"1","estado_producto":"NUEVO","monto_inicial":"500","garantia":"230","fecha_fin":"2026-04-23","hora_fin":"12:00","publico":"1","descripcion":"<p>Descripcion subasta producto 360\\u00b0<\\/p>","fecha_registro":"2026-04-22","updated_at":"2026-04-22T22:57:35.000000Z","created_at":"2026-04-22T22:57:35.000000Z","id":8}	\N	SUBASTAS	2026-04-22	18:57:36	2026-04-22 18:57:36	2026-04-22 18:57:36
91	1	CREACIÓN	EL USUARIO admin REGISTRO UNA SUBASTA	{"producto_id":"1","estado_producto":"NUEVO","monto_inicial":"300","garantia":"200","fecha_fin":"2026-04-24","hora_fin":"12:00","publico":"1","descripcion":"<p>desc subasta producto 1<\\/p>","fecha_registro":"2026-04-23","updated_at":"2026-04-23T21:20:59.000000Z","created_at":"2026-04-23T21:20:59.000000Z","id":9}	\N	SUBASTAS	2026-04-23	17:20:59	2026-04-23 17:20:59	2026-04-23 17:20:59
\.


--
-- TOC entry 5101 (class 0 OID 24669)
-- Dependencies: 232
-- Data for Name: ingreso_productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ingreso_productos (id, producto_id, cantidad, descripcion, fecha_registro, created_at, updated_at) FROM stdin;
1	1	100	INICIO STOCK	2026-04-08	2026-04-08 19:34:55	2026-04-08 19:34:55
2	2	100	INICIO STOCK	2026-04-08	2026-04-08 19:35:03	2026-04-08 19:35:03
3	3	20		2026-04-10	2026-04-10 09:40:43	2026-04-10 09:40:43
4	3	1		2026-04-10	2026-04-10 21:05:51	2026-04-10 21:05:51
5	5	1		2026-04-18	2026-04-18 17:24:01	2026-04-18 17:24:01
6	4	1		2026-04-18	2026-04-18 17:32:28	2026-04-18 17:32:28
7	5	20		2026-04-18	2026-04-18 19:22:36	2026-04-18 19:22:36
\.


--
-- TOC entry 5105 (class 0 OID 24697)
-- Dependencies: 236
-- Data for Name: kardex_productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kardex_productos (id, tipo_registro, registro_id, modulo, producto_id, detalle, precio, tipo_is, cantidad_ingreso, cantidad_salida, cantidad_saldo, cu, monto_ingreso, monto_salida, monto_saldo, fecha, status, created_at, updated_at) FROM stdin;
1	INGRESO DE PRODUCTO	1	IngresoProducto	1	VALOR INICIAL	120.00	INGRESO	100	\N	100	120.00	12000.00	\N	12000.00	2026-04-08	1	2026-04-08 19:34:55	2026-04-08 19:34:55
2	INGRESO DE PRODUCTO	2	IngresoProducto	2	VALOR INICIAL	67.00	INGRESO	100	\N	100	67.00	6700.00	\N	6700.00	2026-04-08	1	2026-04-08 19:35:03	2026-04-08 19:35:03
3	VENTAS	1	VentaDetalle	1	VENTA DE PRODUCTO	120.00	EGRESO	\N	3	97	120.00	\N	360.00	11640.00	2026-04-09	1	2026-04-09 09:18:23	2026-04-09 09:18:23
4	VENTAS	2	VentaDetalle	2	VENTA DE PRODUCTO	67.00	EGRESO	\N	1	99	67.00	\N	67.00	6633.00	2026-04-09	1	2026-04-09 09:18:23	2026-04-09 09:18:23
5	VENTAS	1	VentaDetalle	1	INGRESO POR MODIFICACIÓN DE CANTIDAD DE VENTA	120.00	INGRESO	3	\N	100	120.00	360.00	\N	12000.00	2026-04-09	1	2026-04-09 09:36:06	2026-04-09 09:36:06
6	VENTAS	1	VentaDetalle	1	EGRESO POR MODIFICACIÓN DE VENTA	120.00	EGRESO	\N	5	95	120.00	\N	600.00	11400.00	2026-04-09	1	2026-04-09 09:36:06	2026-04-09 09:36:06
7	VENTAS	1	VentaDetalle	1	INGRESO POR ANULACIÓN DE VENTA	120.00	INGRESO	3	\N	98	120.00	360.00	\N	11760.00	2026-04-09	1	2026-04-09 09:46:05	2026-04-09 09:46:05
8	VENTAS	2	VentaDetalle	2	INGRESO POR ANULACIÓN DE VENTA	67.00	INGRESO	1	\N	100	67.00	67.00	\N	6700.00	2026-04-09	1	2026-04-09 09:46:05	2026-04-09 09:46:05
9	VENTAS	3	VentaDetalle	1	VENTA DE PRODUCTO	120.00	EGRESO	\N	1	97	120.00	\N	120.00	11640.00	2026-04-09	1	2026-04-09 09:49:03	2026-04-09 09:49:03
10	VENTAS	4	VentaDetalle	2	VENTA DE PRODUCTO	67.00	EGRESO	\N	2	98	67.00	\N	134.00	6566.00	2026-04-09	1	2026-04-09 09:49:03	2026-04-09 09:49:03
11	VENTAS	4	VentaDetalle	2	INGRESO POR MODIFICACIÓN DE CANTIDAD DE VENTA	67.00	INGRESO	2	\N	100	67.00	134.00	\N	6700.00	2026-04-09	1	2026-04-09 09:49:13	2026-04-09 09:49:13
12	VENTAS	4	VentaDetalle	2	EGRESO POR MODIFICACIÓN DE VENTA	67.00	EGRESO	\N	4	96	67.00	\N	268.00	6432.00	2026-04-09	1	2026-04-09 09:49:13	2026-04-09 09:49:13
13	VENTAS	3	VentaDetalle	1	INGRESO POR ANULACIÓN DE VENTA	120.00	INGRESO	1	\N	98	120.00	120.00	\N	11760.00	2026-04-09	1	2026-04-09 09:49:18	2026-04-09 09:49:18
14	VENTAS	4	VentaDetalle	2	INGRESO POR ANULACIÓN DE VENTA	67.00	INGRESO	4	\N	100	67.00	268.00	\N	6700.00	2026-04-09	1	2026-04-09 09:49:18	2026-04-09 09:49:18
15	VENTAS	5	VentaDetalle	1	VENTA DE PRODUCTO	120.00	EGRESO	\N	1	97	120.00	\N	120.00	11640.00	2026-04-09	1	2026-04-09 09:49:31	2026-04-09 09:49:31
16	VENTAS	6	VentaDetalle	2	VENTA DE PRODUCTO	67.00	EGRESO	\N	1	99	67.00	\N	67.00	6633.00	2026-04-09	1	2026-04-09 09:49:31	2026-04-09 09:49:31
17	VENTAS	1	VentaDetalle	1	EGRESO POR VENTA	120.00	EGRESO	\N	3	94	120.00	\N	360.00	11280.00	2026-04-09	1	2026-04-09 15:42:39	2026-04-09 15:42:39
18	VENTAS	2	VentaDetalle	2	EGRESO POR VENTA	67.00	EGRESO	\N	1	98	67.00	\N	67.00	6566.00	2026-04-09	1	2026-04-09 15:42:39	2026-04-09 15:42:39
19	VENTAS	3	VentaDetalle	1	EGRESO POR VENTA	120.00	EGRESO	\N	1	93	120.00	\N	120.00	11160.00	2026-04-09	1	2026-04-09 15:43:05	2026-04-09 15:43:05
20	VENTAS	4	VentaDetalle	2	EGRESO POR VENTA	67.00	EGRESO	\N	4	94	67.00	\N	268.00	6298.00	2026-04-09	1	2026-04-09 15:43:05	2026-04-09 15:43:05
21	VENTAS	1	VentaDetalle	1	INGRESO POR ANULACIÓN DE VENTA	120.00	INGRESO	3	\N	96	120.00	360.00	\N	11520.00	2026-04-09	1	2026-04-09 16:16:27	2026-04-09 16:16:27
22	VENTAS	2	VentaDetalle	2	INGRESO POR ANULACIÓN DE VENTA	67.00	INGRESO	1	\N	95	67.00	67.00	\N	6365.00	2026-04-09	1	2026-04-09 16:16:27	2026-04-09 16:16:27
23	INGRESO DE PRODUCTO	3	IngresoProducto	3	VALOR INICIAL	433.00	INGRESO	20	\N	20	433.00	8660.00	\N	8660.00	2026-04-10	1	2026-04-10 09:40:43	2026-04-10 09:40:43
24	SUBASTA	1	Subasta	2	EGRESO DE PRODUCTO PARA SUBASTA	67.00	EGRESO	\N	1	94	67.00	\N	67.00	6298.00	2026-04-10	1	2026-04-10 09:59:41	2026-04-10 09:59:41
25	SUBASTA	1	Subasta	2	INGRESO POR ELIMINACIÓN DE SUBASTA	67.00	INGRESO	1	\N	95	67.00	67.00	\N	6365.00	2026-04-10	1	2026-04-10 10:14:52	2026-04-10 10:14:52
26	SUBASTA	2	Subasta	1	EGRESO DE PRODUCTO PARA SUBASTA	120.00	EGRESO	\N	1	95	120.00	\N	120.00	11400.00	2026-04-10	1	2026-04-10 10:15:12	2026-04-10 10:15:12
27	SUBASTA	3	Subasta	2	EGRESO DE PRODUCTO PARA SUBASTA	67.00	EGRESO	\N	1	94	67.00	\N	67.00	6298.00	2026-04-10	1	2026-04-10 10:15:32	2026-04-10 10:15:32
28	VENTAS	7	VentaDetalle	1	VENTA DE PRODUCTO	120.00	EGRESO	\N	1	94	120.00	\N	120.00	11280.00	2026-04-10	1	2026-04-10 21:04:48	2026-04-10 21:04:48
29	INGRESO DE PRODUCTO	4	IngresoProducto	3	INGRESO DE PRODUCTO	433.00	INGRESO	1	\N	21	433.00	433.00	\N	9093.00	2026-04-10	1	2026-04-10 21:05:51	2026-04-10 21:05:51
30	SUBASTA	4	Subasta	1	EGRESO DE PRODUCTO PARA SUBASTA	120.00	EGRESO	\N	1	93	120.00	\N	120.00	11160.00	2026-04-10	1	2026-04-10 21:07:25	2026-04-10 21:07:25
31	SUBASTA	5	Subasta	3	EGRESO DE PRODUCTO PARA SUBASTA	433.00	EGRESO	\N	1	20	433.00	\N	433.00	8660.00	2026-04-16	1	2026-04-16 10:33:50	2026-04-16 10:33:50
32	SUBASTA	6	Subasta	2	EGRESO DE PRODUCTO PARA SUBASTA	67.00	EGRESO	\N	1	93	67.00	\N	67.00	6231.00	2026-04-17	1	2026-04-17 16:26:17	2026-04-17 16:26:17
33	SALIDA DE PRODUCTO	1	SalidaProducto	3	DEFECTUOSO	433.00	EGRESO	\N	1	19	433.00	\N	433.00	8227.00	2026-04-18	1	2026-04-18 15:39:50	2026-04-18 15:39:50
34	SALIDA DE PRODUCTO	2	SalidaProducto	2	ERROR DE CONTEO	67.00	EGRESO	\N	1	92	67.00	\N	67.00	6164.00	2026-04-18	1	2026-04-18 15:40:44	2026-04-18 15:40:44
35	VENTAS	9	VentaDetalle	3	VENTA DE PRODUCTO	433.00	EGRESO	\N	1	18	433.00	\N	433.00	7794.00	2026-04-18	1	2026-04-18 17:23:52	2026-04-18 17:23:52
36	INGRESO DE PRODUCTO	5	IngresoProducto	5	VALOR INICIAL	190.00	INGRESO	1	\N	1	190.00	190.00	\N	190.00	2026-04-18	1	2026-04-18 17:24:01	2026-04-18 17:24:01
37	VENTAS	10	VentaDetalle	5	VENTA DE PRODUCTO	190.00	EGRESO	\N	1	0	190.00	\N	190.00	0.00	2026-04-18	1	2026-04-18 17:28:28	2026-04-18 17:28:28
38	INGRESO DE PRODUCTO	6	IngresoProducto	4	VALOR INICIAL	250.00	INGRESO	1	\N	1	250.00	250.00	\N	250.00	2026-04-18	1	2026-04-18 17:32:28	2026-04-18 17:32:28
39	VENTAS	11	VentaDetalle	4	VENTA DE PRODUCTO	250.00	EGRESO	\N	1	0	250.00	\N	250.00	0.00	2026-04-18	1	2026-04-18 17:32:41	2026-04-18 17:32:41
40	VENTAS	12	VentaDetalle	1	VENTA DE PRODUCTO	120.00	EGRESO	\N	1	92	120.00	\N	120.00	11040.00	2026-04-18	1	2026-04-18 19:21:55	2026-04-18 19:21:55
41	VENTAS	13	VentaDetalle	2	VENTA DE PRODUCTO	67.00	EGRESO	\N	2	90	67.00	\N	134.00	6030.00	2026-04-18	1	2026-04-18 19:22:04	2026-04-18 19:22:04
42	INGRESO DE PRODUCTO	7	IngresoProducto	5	INGRESO DE PRODUCTO	190.00	INGRESO	20	\N	20	190.00	3800.00	\N	3800.00	2026-04-18	1	2026-04-18 19:22:36	2026-04-18 19:22:36
43	SUBASTA	7	Subasta	3	EGRESO DE PRODUCTO PARA SUBASTA	433.00	EGRESO	\N	1	17	433.00	\N	433.00	7361.00	2026-04-18	1	2026-04-18 21:12:19	2026-04-18 21:12:19
44	SUBASTA	8	Subasta	1	EGRESO DE PRODUCTO PARA SUBASTA	120.00	EGRESO	\N	1	91	120.00	\N	120.00	10920.00	2026-04-22	1	2026-04-22 18:57:35	2026-04-22 18:57:35
45	SUBASTA	9	Subasta	1	EGRESO DE PRODUCTO PARA SUBASTA	120.00	EGRESO	\N	1	90	120.00	\N	120.00	10800.00	2026-04-23	1	2026-04-23 17:20:59	2026-04-23 17:20:59
\.


--
-- TOC entry 5087 (class 0 OID 24580)
-- Dependencies: 218
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	2024_01_31_165641_create_configuracions_table	1
2	2024_11_02_153317_create_users_table	1
3	2024_11_02_153318_create_historial_accions_table	1
4	2026_04_02_153417_create_qrs_table	1
5	2026_04_02_153421_create_categorias_table	1
6	2026_04_02_153548_create_productos_table	1
7	2026_04_02_153610_create_producto_imagens_table	1
8	2026_04_02_153621_create_ingreso_productos_table	1
9	2026_04_02_153625_create_salida_productos_table	1
10	2026_04_02_153637_create_kardex_productos_table	1
11	2026_04_02_153647_create_subastas_table	1
12	2026_04_02_153650_create_clientes_table	1
13	2026_04_02_153651_create_ventas_table	1
14	2026_04_02_153653_create_venta_detalles_table	1
15	2026_04_02_153747_create_participantes_table	1
16	2026_04_02_153750_create_participante_pujas_table	1
17	2026_04_02_153843_create_notificacions_table	1
18	2026_04_02_153845_create_notificacion_users_table	1
19	2026_04_16_160347_create_user_datos_table	2
20	2026_04_16_171316_create_parametrizacions_table	3
21	2026_04_18_142119_create_recuperar_passwords_table	4
\.


--
-- TOC entry 5121 (class 0 OID 24800)
-- Dependencies: 252
-- Data for Name: notificacion_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notificacion_users (id, created_at, updated_at, notificacion_id, user_id, visto) FROM stdin;
3	2026-04-16 18:40:49	2026-04-16 18:40:49	5	2	0
5	2026-04-17 09:14:26	2026-04-17 09:14:26	6	3	0
6	2026-04-17 09:14:26	2026-04-17 09:14:26	6	2	0
10	2026-04-17 11:07:03	2026-04-18 15:07:17	8	1	1
12	2026-04-17 11:07:03	2026-04-18 15:07:26	8	2	1
9	2026-04-17 09:26:12	2026-04-18 15:07:28	7	2	1
2	2026-04-16 18:40:49	2026-04-18 15:07:30	5	3	1
11	2026-04-17 11:07:03	2026-04-18 15:07:36	8	3	1
7	2026-04-17 09:26:12	2026-04-18 15:08:05	7	1	1
8	2026-04-17 09:26:12	2026-04-18 15:08:08	7	3	1
4	2026-04-17 09:14:26	2026-04-18 15:17:48	6	1	1
1	2026-04-16 18:40:49	2026-04-18 15:18:44	5	1	1
14	2026-04-18 17:32:41	2026-04-18 17:32:41	9	3	0
15	2026-04-18 17:32:41	2026-04-18 17:32:41	9	2	0
13	2026-04-18 17:32:41	2026-04-18 17:37:54	9	1	1
17	2026-04-18 19:21:55	2026-04-18 19:21:55	10	3	0
18	2026-04-18 19:21:55	2026-04-18 19:21:55	10	2	0
20	2026-04-18 19:22:04	2026-04-18 19:22:04	11	3	0
21	2026-04-18 19:22:04	2026-04-18 19:22:04	11	2	0
16	2026-04-18 19:21:55	2026-04-18 20:52:37	10	1	1
19	2026-04-18 19:22:04	2026-04-18 20:52:46	11	1	1
23	2026-04-18 21:06:41	2026-04-18 21:06:41	12	3	0
24	2026-04-18 21:06:41	2026-04-18 21:06:41	12	2	0
22	2026-04-18 21:06:41	2026-04-18 21:06:50	12	1	1
26	2026-04-18 21:12:19	2026-04-18 21:12:19	13	3	0
27	2026-04-18 21:12:19	2026-04-18 21:12:19	13	2	0
25	2026-04-18 21:12:19	2026-04-22 16:29:17	13	1	1
29	2026-04-22 18:57:35	2026-04-22 18:57:35	14	3	0
30	2026-04-22 18:57:35	2026-04-22 18:57:35	14	2	0
28	2026-04-22 18:57:35	2026-04-22 18:57:43	14	1	1
31	2026-04-23 17:24:38	2026-04-23 17:24:38	15	1	0
32	2026-04-23 17:24:38	2026-04-23 17:24:38	15	3	0
33	2026-04-23 17:24:38	2026-04-23 17:24:38	15	2	0
34	2026-04-23 17:26:24	2026-04-23 17:26:24	16	1	0
35	2026-04-23 17:26:24	2026-04-23 17:26:24	16	3	0
36	2026-04-23 17:26:24	2026-04-23 17:26:24	16	2	0
\.


--
-- TOC entry 5119 (class 0 OID 24791)
-- Dependencies: 250
-- Data for Name: notificacions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notificacions (id, modulo, registro_id, descripcion, fecha, hora, tipo, created_at, updated_at) FROM stdin;
5	Participante	10	JUAN PERES MAMANI REGISTRO SU COMPROBANTE	2026-04-16	18:40:00	COMPROBANTE	2026-04-16 18:40:49	2026-04-16 18:40:49
6	Participante	11	MARIA MAMANI MAMANI REGISTRO SU COMPROBANTE	2026-04-17	09:14:00	COMPROBANTE	2026-04-17 09:14:26	2026-04-17 09:14:26
7	Participante	12	MARCELO GONZALES BERSAVE REGISTRO SU COMPROBANTE	2026-04-17	09:26:00	COMPROBANTE	2026-04-17 09:26:12	2026-04-17 09:26:12
8	Participante	13	FRANZ MARTINEZ REGISTRO SU COMPROBANTE	2026-04-17	11:07:00	COMPROBANTE	2026-04-17 11:07:03	2026-04-17 11:07:03
9	Producto	4	PARACHOQUES BLANCO SE QUEDO SIN STOCK	2026-04-18	17:32:00	STOCK	2026-04-18 17:32:41	2026-04-18 17:32:41
10	Producto	1	AURIS IZQUIERDO SE QUEDO SIN STOCK	2026-04-18	19:21:00	STOCK	2026-04-18 19:21:55	2026-04-18 19:21:55
11	Producto	2	PRODUCTO 2 SE QUEDO SIN STOCK	2026-04-18	19:22:00	STOCK	2026-04-18 19:22:04	2026-04-18 19:22:04
12	Participante	14	MARCOS AVILA REGISTRO SU COMPROBANTE	2026-04-18	21:06:00	COMPROBANTE	2026-04-18 21:06:41	2026-04-18 21:06:41
13	Producto	3	RETROVISORES SE QUEDO SIN STOCK	2026-04-18	21:12:00	STOCK	2026-04-18 21:12:19	2026-04-18 21:12:19
14	Producto	1	AURIS IZQUIERDO SE QUEDO SIN STOCK	2026-04-22	18:57:00	STOCK	2026-04-22 18:57:35	2026-04-22 18:57:35
15	Participante	15	MARIA MAMANI MAMANI REGISTRO SU COMPROBANTE	2026-04-23	17:24:00	COMPROBANTE	2026-04-23 17:24:38	2026-04-23 17:24:38
16	Participante	16	ALFONSO MARTINEZ REGISTRO SU COMPROBANTE	2026-04-23	17:26:00	COMPROBANTE	2026-04-23 17:26:24	2026-04-23 17:26:24
\.


--
-- TOC entry 5125 (class 0 OID 24905)
-- Dependencies: 256
-- Data for Name: parametrizacions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.parametrizacions (id, servidor_correo, datos_banco, tiempo_pub, terminos_condiciones, verificar_comprobante, comp_rechazado, created_at, updated_at) FROM stdin;
1	{"host":"smtp.gmail.com","puerto":"465","encriptado":"ssl","correo":"kingceroci.as@gmail.com","nombre":"SAVS S.A.","password":"rmkwqggnhptnxmuy","driver":"smtp"}	{"titular":"eduardo ramirez","banco":"banco union","nro_cuenta":"10000011","qr":"1776438403.png"}	2	1. Aceptación de los Términos\r\nAl registrarse y/o pujar en la subasta, el participante ("Postor") acepta cumplir con estos Términos y Condiciones. Si no está de acuerdo, no debe participar. \r\n\r\n2. Registro y Elegibilidad\r\nRegistro: Todo participante debe crear una cuenta en [Nombre de la plataforma/empresa].\r\nCapacidad Legal: El participante debe ser mayor de edad (+18) y tener capacidad legal para contratar.\r\nVeracidad: El postor garantiza que toda la información facilitada es real y actual. \r\n\r\n3. La Subasta (Proceso de Puja)\r\nLotes: Los bienes se subastarán por lotes numerados, indicados en el catálogo.\r\nPuja Inicial: Se define un precio base para cada lote. Las ofertas deben superar este precio o la última oferta.\r\nOfertas Vinculantes: Toda puja realizada es definitiva y no puede ser retirada. El mejor postor al cierre se adjudica el lote.\r\nCierre de Subasta: Los lotes se adjudicarán automáticamente al mejor postor tras finalizar el tiempo de cuenta regresiva. \r\n\r\n4. Depósito de Garantía (Si aplica)\r\nPara participar, se puede requerir un depósito de garantía de [$XXX].\r\nEste monto será devuelto si el participante no gana ningún lote, o aplicado al pago si gana. \r\n\r\n5. Adjudicación y Pago\r\nNotificación: El ganador será notificado por correo electrónico o a través de la plataforma.\r\nPlazo de Pago: El pago total debe realizarse dentro de los [X] días hábiles siguientes a la adjudicación.\r\nIncumplimiento: El impago dentro del plazo conllevará la pérdida de la garantía y posibles sanciones (suspensión de usuario). \r\n\r\n6. Retiro de los Lotes\r\nLa entrega se realizará una vez confirmado el pago.\r\nEl comprador es responsable de la recogida del bien en [Dirección/Sede] en los horarios establecidos. \r\n\r\n7. Estado de los Bienes (As-Is)\r\nLos productos se venden en el estado físico y jurídico en que se encuentran ("as is").\r\nLas fotos y descripciones son ilustrativas. Se recomienda la inspección previa por parte del postor. \r\n\r\n8. Responsabilidades y Limitaciones\r\n[Nombre de la Empresa] no se hace responsable de fallos técnicos en la plataforma online que impidan la puja.\r\nNos reservamos el derecho de admisión y de retirar cualquier lote antes de la subasta. \r\n\r\n9. Legislación Aplicable\r\nCualquier controversia se someterá a los tribunales de [Tu Ciudad/País].	Estamos verificando tu comprobante y te enviaremos un correo de confirmación para que pueda realizar tus ofertas/pujas. Cualquiera información comunicarse al <strong>7777777777</strong>	TU COMPROBANTE FUE RECHAZADO, ENVÍANOS UN COMPROBANTE LEGIBLE. CUALQUIER CONSULTA O DUDA COMUNÍCATE AL SIGUIENTE CORREO ELECTRÓNICO INSTITUCIONAL: correo@gmail.com Y EN CASO DE NO RECIBIR UNA REPUESTA PRONTA COMUNÍCATE AL SIGUIENTE NÚMERO 777777777	2026-04-16 18:02:26	2026-04-17 11:06:43
\.


--
-- TOC entry 5117 (class 0 OID 24779)
-- Dependencies: 248
-- Data for Name: participante_pujas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.participante_pujas (id, participante_id, monto, fecha, hora, created_at, updated_at, user_id, subasta_id) FROM stdin;
4	12	300.00	2026-04-17	10:35:33	2026-04-17 10:35:33	2026-04-17 10:35:33	7	5
5	12	301.00	2026-04-17	10:40:41	2026-04-17 10:40:41	2026-04-17 10:40:41	7	5
6	12	303.00	2026-04-17	10:41:54	2026-04-17 10:41:54	2026-04-17 10:41:54	7	5
7	12	306.00	2026-04-17	10:42:54	2026-04-17 10:42:54	2026-04-17 10:42:54	7	5
8	12	308.00	2026-04-17	10:43:55	2026-04-17 10:43:55	2026-04-17 10:43:55	7	5
9	12	340.00	2026-04-17	10:46:21	2026-04-17 10:46:21	2026-04-17 10:46:21	7	5
10	12	380.00	2026-04-17	10:46:57	2026-04-17 10:46:57	2026-04-17 10:46:57	7	5
11	12	381.00	2026-04-17	10:48:42	2026-04-17 10:48:42	2026-04-17 10:48:42	7	5
12	12	382.00	2026-04-17	10:52:02	2026-04-17 10:52:02	2026-04-17 10:52:02	7	5
13	13	383.00	2026-04-17	11:07:46	2026-04-17 11:07:46	2026-04-17 11:07:46	8	5
14	11	384.00	2026-04-17	11:10:57	2026-04-17 11:10:57	2026-04-17 11:10:57	6	5
15	11	385.00	2026-04-17	11:11:29	2026-04-17 11:11:29	2026-04-17 11:11:29	6	5
16	11	386.00	2026-04-17	11:11:39	2026-04-17 11:11:39	2026-04-17 11:11:39	6	5
17	14	700.00	2026-04-18	21:10:52	2026-04-18 21:10:52	2026-04-18 21:10:52	9	6
18	14	701.00	2026-04-18	21:11:08	2026-04-18 21:11:08	2026-04-18 21:11:08	9	6
19	16	300.00	2026-04-23	17:26:41	2026-04-23 17:26:41	2026-04-23 17:26:41	10	9
20	15	301.00	2026-04-23	17:26:57	2026-04-23 17:26:57	2026-04-23 17:26:57	6	9
21	15	302.00	2026-04-23	17:27:19	2026-04-23 17:27:19	2026-04-23 17:27:19	6	9
22	16	303.00	2026-04-23	17:27:31	2026-04-23 17:27:31	2026-04-23 17:27:31	10	9
23	15	304.00	2026-04-23	17:28:36	2026-04-23 17:28:36	2026-04-23 17:28:36	6	9
24	16	305.00	2026-04-23	17:30:12	2026-04-23 17:30:12	2026-04-23 17:30:12	10	9
25	15	306.00	2026-04-23	17:30:47	2026-04-23 17:30:47	2026-04-23 17:30:47	6	9
26	15	307.00	2026-04-23	17:36:18	2026-04-23 17:36:18	2026-04-23 17:36:18	6	9
27	16	308.00	2026-04-23	17:37:27	2026-04-23 17:37:27	2026-04-23 17:37:27	10	9
\.


--
-- TOC entry 5115 (class 0 OID 24762)
-- Dependencies: 246
-- Data for Name: participantes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.participantes (id, subasta_id, user_id, fecha, hora, monto_puja, created_at, updated_at, estado, garantia, comprobante, estado_comprobante, fecha_comprobante, hora_comprobante, devolucion, descripcion_devolucion, fecha_devolucion, hora_devolucion) FROM stdin;
10	5	5	2026-04-16	18:40:49	0.00	2026-04-16 18:40:49	2026-04-16 18:40:49	0	1	51776379249.pdf	0	2026-04-16	18:40:49	0	\N	\N	\N
12	5	7	2026-04-17	09:26:12	382.00	2026-04-17 09:26:12	2026-04-17 10:52:02	0	1	71776432372.pdf	1	2026-04-17	09:26:12	0	\N	\N	\N
11	5	6	2026-04-17	09:14:26	386.00	2026-04-17 09:14:26	2026-04-17 15:08:25	2	1	61776431666.png	1	2026-04-17	09:14:26	0	\N	\N	\N
13	5	8	2026-04-17	11:07:03	383.00	2026-04-17 11:07:03	2026-04-17 16:12:10	0	1	81776438423.pdf	1	2026-04-17	11:07:03	1	\N	2026-04-17	16:11:00
14	6	9	2026-04-18	21:06:41	701.00	2026-04-18 21:06:41	2026-04-22 16:13:53	2	1	91776560801.png	1	2026-04-18	21:06:41	0	\N	\N	\N
15	9	6	2026-04-23	17:24:38	307.00	2026-04-23 17:24:38	2026-04-23 17:36:18	0	1	61776979478.pdf	1	2026-04-23	17:24:38	0	\N	\N	\N
16	9	10	2026-04-23	17:26:24	308.00	2026-04-23 17:26:24	2026-04-23 17:37:27	1	1	101776979584.png	1	2026-04-23	17:26:24	0	\N	\N	\N
\.


--
-- TOC entry 5099 (class 0 OID 24657)
-- Dependencies: 230
-- Data for Name: producto_imagens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.producto_imagens (id, producto_id, imagen, created_at, updated_at) FROM stdin;
53	2	531776546244.jpeg	2026-04-18 17:04:04	2026-04-18 17:04:04
54	2	1541776546244.jpeg	2026-04-18 17:04:04	2026-04-18 17:04:04
55	3	1551776546257.jpeg	2026-04-18 17:04:17	2026-04-18 17:04:17
56	4	561776546640.jpeg	2026-04-18 17:10:40	2026-04-18 17:10:40
57	4	1571776546740.jpeg	2026-04-18 17:12:20	2026-04-18 17:12:20
29	3	291776545880.jpeg	2026-04-18 16:58:00	2026-04-18 16:58:00
60	5	601776546780.jpeg	2026-04-18 17:13:00	2026-04-18 17:13:00
61	5	1611776546780.jpeg	2026-04-18 17:13:00	2026-04-18 17:13:00
161	1	1611776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
162	1	11621776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
163	1	21631776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
164	1	31641776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
165	1	41651776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
166	1	51661776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
167	1	61671776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
168	1	71681776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
169	1	81691776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
170	1	91701776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
171	1	101711776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
172	1	111721776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
173	1	121731776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
174	1	131741776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
175	1	141751776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
176	1	151761776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
177	1	161771776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
178	1	171781776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
179	1	181791776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
180	1	191801776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
181	1	201811776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
182	1	211821776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
183	1	221831776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
184	1	231841776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
185	1	241851776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
186	1	251861776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
187	1	261871776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
188	1	271881776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
189	1	281891776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
190	1	291901776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
191	1	301911776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
192	1	311921776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
193	1	321931776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
194	1	331941776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
195	1	341951776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
196	1	351961776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
197	1	361971776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
198	1	371981776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
199	1	381991776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
200	1	392001776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
201	1	402011776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
202	1	412021776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
203	1	422031776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
204	1	432041776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
205	1	442051776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
206	1	452061776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
207	1	462071776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
208	1	472081776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:14
209	1	482091776890774.jpg	2026-04-22 16:46:14	2026-04-22 16:46:15
210	1	492101776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
211	1	502111776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
212	1	512121776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
213	1	522131776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
214	1	532141776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
215	1	542151776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
216	1	552161776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
217	1	562171776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
218	1	572181776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
219	1	582191776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
220	1	592201776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
221	1	602211776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
222	1	612221776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
223	1	622231776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
224	1	632241776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
225	1	642251776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
226	1	652261776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
227	1	662271776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
228	1	672281776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
229	1	682291776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
230	1	692301776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
231	1	702311776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
232	1	712321776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
233	1	722331776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
234	1	732341776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
235	1	742351776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
236	1	752361776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
237	1	762371776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
238	1	772381776890775.jpg	2026-04-22 16:46:15	2026-04-22 16:46:15
\.


--
-- TOC entry 5097 (class 0 OID 24640)
-- Dependencies: 228
-- Data for Name: productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productos (id, nombre, descripcion, precio, stock, categoria_id, fecha_registro, created_at, updated_at, codigo, tsg) FROM stdin;
4	PARACHOQUES BLANCO	<p>DEscripcion deparachoques blanco</p>	250.00	0	3	2026-04-18	2026-04-18 17:10:40	2026-04-18 17:32:41	P004	0
2	PRODUCTO 2	<p>Descripcion del producto 2</p>	67.00	90	1	2026-04-08	2026-04-08 19:33:31	2026-04-22 16:45:52	P002	0
5	FAROS DERECHO	<p>descripcion faros derecho</p>	190.00	20	1	2026-04-18	2026-04-18 17:12:49	2026-04-18 19:22:36	P005	0
3	RETROVISORES	<h2>What is Lorem Ipsum?</h2><p><strong>Lorem Ipsum</strong>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>	433.00	17	2	2026-04-10	2026-04-10 09:40:31	2026-04-18 21:12:19	P003	0
1	AURIS IZQUIERDO	<h3><strong><u>DESCRIPCIÓN DEL PRODUCTO</u></strong></h3><p><span style="color: rgb(0, 0, 0);">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</span></p>	120.00	90	1	2026-04-08	2026-04-08 11:39:00	2026-04-23 17:20:59	P001	1
\.


--
-- TOC entry 5127 (class 0 OID 24929)
-- Dependencies: 258
-- Data for Name: recuperar_passwords; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recuperar_passwords (id, cod, user_id, status, created_at, updated_at) FROM stdin;
1	CE2Iug	7	0	2026-04-18 14:24:56	2026-04-18 14:29:52
\.


--
-- TOC entry 5103 (class 0 OID 24683)
-- Dependencies: 234
-- Data for Name: salida_productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.salida_productos (id, producto_id, cantidad, descripcion, fecha_registro, created_at, updated_at) FROM stdin;
1	3	1	DEFECTUOSO	2026-04-18	2026-04-18 15:39:50	2026-04-18 15:39:50
2	2	1	ERROR DE CONTEO	2026-04-18	2026-04-18 15:40:44	2026-04-18 15:40:44
\.


--
-- TOC entry 5107 (class 0 OID 24712)
-- Dependencies: 238
-- Data for Name: subastas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subastas (id, producto_id, estado_producto, monto_inicial, fecha_fin, hora_fin, publico, estado_subasta, fecha_registro, created_at, updated_at, garantia, descripcion) FROM stdin;
4	1	NUEVO	200.00	2026-04-15	12:00:00	0	3	2026-04-10	2026-04-10 21:07:25	2026-04-22 16:28:52	100.00	\N
2	1	USADO	1000.00	2026-04-16	12:00:00	0	3	2026-04-10	2026-04-10 10:15:12	2026-04-22 16:28:52	0.00	\N
3	2	NUEVO	2300.00	2026-04-16	12:00:00	0	3	2026-04-10	2026-04-10 10:15:32	2026-04-22 16:28:52	0.00	\N
5	3	SEMINUEVO	300.00	2026-04-17	15:00:00	0	3	2026-04-16	2026-04-16 10:33:50	2026-04-22 16:28:52	150.00	\N
7	3	NUEVO	300.00	2026-04-20	12:00:00	0	3	2026-04-18	2026-04-18 21:12:19	2026-04-22 16:28:52	120.00	<p>Descripcion</p>
6	2	NUEVO	700.00	2026-04-19	12:00:00	0	3	2026-04-17	2026-04-17 16:26:17	2026-04-22 16:28:52	200.00	<h3><strong>Descripción de subasta</strong></h3><p><strong style="color: rgb(0, 0, 0);">Lorem Ipsum</strong><span style="color: rgb(0, 0, 0);">&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type.</span></p><p><span style="color: rgb(0, 0, 0);">Descripcion de la subasta</span></p>
8	1	NUEVO	500.00	2026-04-23	12:00:00	1	0	2026-04-22	2026-04-22 18:57:35	2026-04-23 17:14:23	230.00	<p>Descripcion subasta producto 360°</p>
9	1	NUEVO	300.00	2026-04-24	12:00:00	1	1	2026-04-23	2026-04-23 17:20:59	2026-04-23 17:20:59	200.00	<p>desc subasta producto 1</p>
\.


--
-- TOC entry 5123 (class 0 OID 24891)
-- Dependencies: 254
-- Data for Name: user_datos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_datos (id, user_id, foto_ci_anverso, foto_ci_reverso, banco, nro_cuenta, created_at, updated_at, ci, ci_exp, complemento, dpto_residencia, email) FROM stdin;
2	5	151776373428.jpeg	251776373428.jpeg	BANCO NACIONAL DE BOLIVIA S.A.	100000234234	2026-04-16 17:03:48	2026-04-16 17:03:48	1234567	LP		LA PAZ	juan@gmail.com
3	6	161776431394.jpeg	261776431394.png	BANCO NACIONAL DE BOLIVIA S.A.	100005555555555	2026-04-17 09:09:54	2026-04-17 09:09:54	2342344	LP		LA PAZ	maria@gmail.com
5	8	181776437667.jpg	281776437667.jpeg	BANCO MERCANTIL SANTA CRUZ S.A.	10000000001	2026-04-17 10:54:27	2026-04-17 10:54:27	5675675	LP		LA PAZ	franz@gmail.com
4	7	171776432351.jpeg	271776432351.png	BANCO ECONÓMICO S.A.	112323232323	2026-04-17 09:25:51	2026-04-18 12:45:59	5454655	LP		LA PAZ	marcelo@gmail.com
6	9	191776560753.jpeg	291776560753.jpeg	BANCO DE CRÉDITO DE BOLIVIA S.A.	112323232323	2026-04-18 21:05:53	2026-04-18 21:05:53	34534534	LP		LA PAZ	marcos@gmail.com
7	10	1101776979565.jpeg	2101776979565.png	BANCO DE CRÉDITO DE BOLIVIA S.A.	112323232323	2026-04-23 17:26:05	2026-04-23 17:26:05	435345345	LP		COCHABAMBA	alfonso@gmail.com
\.


--
-- TOC entry 5091 (class 0 OID 24596)
-- Dependencies: 222
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, usuario, nombre, paterno, materno, correo, fono, password, acceso, tipo, foto, fecha_registro, status, created_at, updated_at, ci, ci_exp) FROM stdin;
1	admin	admin	admin	\N	admin@admin.com		$2y$12$jrlcVfmykFHgcsTVPdyyiuFveypQPhYDxR.XPKtupQSRo5aOc8JVO	1	ADMINISTRADOR	\N	2026-04-07	1	2026-04-07 16:08:34	2026-04-07 16:08:34	\N	\N
3	GCARVAJAL	GERMAN	CARVAJAL		\N	67676767	$2y$12$nMvJvy/iJOvTGZaodz3cS.LyUT43ix18US/s.k5BRGWzrnPHIRvHG	1	AUXILIAR	\N	2026-04-08	1	2026-04-08 09:54:55	2026-04-09 16:42:06	5454544	LP
2	JPERES	JUAN	PERES	MAMANI	juan@gmail.com	67676767	$2y$12$cAUyhnIvv2KBIRDmmIGqmeIZhQGXZlLSJAX6LcPxJbn2YWRh6yaqi	1	ADMINISTRADOR	21775656455.jpg	2026-04-08	1	2026-04-08 09:54:15	2026-04-09 16:42:42	123456	LP
5	juan@gmail.com	JUAN	PERES	MAMANI	juan@gmail.com	78787878	$2y$12$lkCiCb6ApPSAcHj9cj/4M.Nom9a6tDFIehfgYWscfEnBkkVkYCy72	1	PARTICIPANTE	\N	2026-04-16	1	2026-04-16 17:03:48	2026-04-16 17:03:48	1234567	LP
6	maria@gmail.com	MARIA	MAMANI	MAMANI	maria@gmail.com	78787878	$2y$12$go2e/Mn5yMZaUCG.3nHGDe8PbK/.rFvNZFmEiXbOWDO1ThP/yxJdK	1	PARTICIPANTE	\N	2026-04-17	1	2026-04-17 09:09:54	2026-04-17 09:09:54	2342344	LP
8	franz@gmail.com	FRANZ	MARTINEZ		franz@gmail.com	78787878	$2y$12$BQWM6Dbic8ZkuFuhghgAve0aU2KoceUX2xfNnPJ8eZXN5QKU5NioS	1	PARTICIPANTE	\N	2026-04-17	1	2026-04-17 10:54:27	2026-04-17 10:54:27	5675675	LP
7	marcelo@gmail.com	MARCELO	GONZALES	BERSAVE	marcelo@gmail.com	67676767	$2y$12$91NbCaoZrffBqRrkceM2Ee891n6y19BGVKCtrYMHoCD4i4rRSA2ce	1	PARTICIPANTE	1776530942_7.jpg	2026-04-17	1	2026-04-17 09:25:51	2026-04-18 14:29:52	5454655	LP
9	marcos@gmail.com	MARCOS	AVILA		marcos@gmail.com	676767676	$2y$12$4FAAkeBHNwDXlkG/Lt5rwODO1B7ZgOEkJByo9iHHNxCe/6L5jhpGa	1	PARTICIPANTE	\N	2026-04-18	1	2026-04-18 21:05:53	2026-04-18 21:05:53	34534534	LP
10	alfonso@gmail.com	ALFONSO	MARTINEZ		alfonso@gmail.com	78787878	$2y$12$YuCIgAgJSR7qhkrmek6/Ru8Luokdf/VXcw1GWDuRzogez9SHaAgDG	1	PARTICIPANTE	\N	2026-04-23	1	2026-04-23 17:26:05	2026-04-23 17:26:05	435345345	LP
\.


--
-- TOC entry 5113 (class 0 OID 24745)
-- Dependencies: 244
-- Data for Name: venta_detalles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.venta_detalles (id, venta_id, producto_id, precio, cantidad, subtotal, created_at, updated_at) FROM stdin;
1	1	1	120.00	3	360.00	2026-04-09 09:18:23	2026-04-09 09:18:23
2	1	2	67.00	1	67.00	2026-04-09 09:18:23	2026-04-09 09:18:23
3	2	1	120.00	1	120.00	2026-04-09 09:49:03	2026-04-09 09:49:03
4	2	2	67.00	4	268.00	2026-04-09 09:49:03	2026-04-09 09:49:13
5	3	1	120.00	1	120.00	2026-04-09 09:49:31	2026-04-09 09:49:31
6	3	2	67.00	1	67.00	2026-04-09 09:49:31	2026-04-09 09:49:31
7	4	1	120.00	1	120.00	2026-04-10 21:04:48	2026-04-10 21:04:48
9	10	3	433.00	1	433.00	2026-04-18 17:23:52	2026-04-18 17:23:52
10	14	5	190.00	1	190.00	2026-04-18 17:28:28	2026-04-18 17:28:28
11	15	4	250.00	1	250.00	2026-04-18 17:32:41	2026-04-18 17:32:41
12	16	1	120.00	1	120.00	2026-04-18 19:21:55	2026-04-18 19:21:55
13	17	2	67.00	2	134.00	2026-04-18 19:22:04	2026-04-18 19:22:04
\.


--
-- TOC entry 5111 (class 0 OID 24733)
-- Dependencies: 242
-- Data for Name: ventas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ventas (id, cliente_id, total, fecha, hora, created_at, updated_at, status, nit_ci, user_id) FROM stdin;
3	2	187.00	2026-04-09	09:49:31	2026-04-09 09:49:31	2026-04-09 09:49:31	1	\N	1
2	1	388.00	2026-04-09	09:49:03	2026-04-09 09:49:03	2026-04-09 15:43:05	1	123456	1
1	1	427.00	2026-04-09	09:18:22	2026-04-09 09:18:22	2026-04-09 16:16:27	0	123456	1
4	1	120.00	2026-04-10	21:04:48	2026-04-10 21:04:48	2026-04-10 21:04:48	1	123456	1
10	1	433.00	2026-04-18	17:23:52	2026-04-18 17:23:52	2026-04-18 17:23:52	1	123456	1
14	1	190.00	2026-04-18	17:28:28	2026-04-18 17:28:28	2026-04-18 17:28:28	1	123456	1
15	2	250.00	2026-04-18	17:32:41	2026-04-18 17:32:41	2026-04-18 17:32:41	1	\N	1
16	1	120.00	2026-04-18	19:21:55	2026-04-18 19:21:55	2026-04-18 19:21:55	1	123456	1
17	2	134.00	2026-04-18	19:22:04	2026-04-18 19:22:04	2026-04-18 19:22:04	1	\N	1
\.


--
-- TOC entry 5154 (class 0 OID 0)
-- Dependencies: 225
-- Name: categorias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categorias_id_seq', 4, true);


--
-- TOC entry 5155 (class 0 OID 0)
-- Dependencies: 239
-- Name: clientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clientes_id_seq', 6, true);


--
-- TOC entry 5156 (class 0 OID 0)
-- Dependencies: 219
-- Name: configuracions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.configuracions_id_seq', 1, true);


--
-- TOC entry 5157 (class 0 OID 0)
-- Dependencies: 223
-- Name: historial_accions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historial_accions_id_seq', 91, true);


--
-- TOC entry 5158 (class 0 OID 0)
-- Dependencies: 231
-- Name: ingreso_productos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ingreso_productos_id_seq', 7, true);


--
-- TOC entry 5159 (class 0 OID 0)
-- Dependencies: 235
-- Name: kardex_productos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kardex_productos_id_seq', 45, true);


--
-- TOC entry 5160 (class 0 OID 0)
-- Dependencies: 217
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 21, true);


--
-- TOC entry 5161 (class 0 OID 0)
-- Dependencies: 251
-- Name: notificacion_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notificacion_users_id_seq', 36, true);


--
-- TOC entry 5162 (class 0 OID 0)
-- Dependencies: 249
-- Name: notificacions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notificacions_id_seq', 16, true);


--
-- TOC entry 5163 (class 0 OID 0)
-- Dependencies: 255
-- Name: parametrizacions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.parametrizacions_id_seq', 1, true);


--
-- TOC entry 5164 (class 0 OID 0)
-- Dependencies: 247
-- Name: participante_pujas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.participante_pujas_id_seq', 27, true);


--
-- TOC entry 5165 (class 0 OID 0)
-- Dependencies: 245
-- Name: participantes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.participantes_id_seq', 16, true);


--
-- TOC entry 5166 (class 0 OID 0)
-- Dependencies: 229
-- Name: producto_imagens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.producto_imagens_id_seq', 238, true);


--
-- TOC entry 5167 (class 0 OID 0)
-- Dependencies: 227
-- Name: productos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productos_id_seq', 5, true);


--
-- TOC entry 5168 (class 0 OID 0)
-- Dependencies: 257
-- Name: recuperar_passwords_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recuperar_passwords_id_seq', 1, true);


--
-- TOC entry 5169 (class 0 OID 0)
-- Dependencies: 233
-- Name: salida_productos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.salida_productos_id_seq', 2, true);


--
-- TOC entry 5170 (class 0 OID 0)
-- Dependencies: 237
-- Name: subastas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subastas_id_seq', 9, true);


--
-- TOC entry 5171 (class 0 OID 0)
-- Dependencies: 253
-- Name: user_datos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_datos_id_seq', 7, true);


--
-- TOC entry 5172 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 10, true);


--
-- TOC entry 5173 (class 0 OID 0)
-- Dependencies: 243
-- Name: venta_detalles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.venta_detalles_id_seq', 13, true);


--
-- TOC entry 5174 (class 0 OID 0)
-- Dependencies: 241
-- Name: ventas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ventas_id_seq', 17, true);


--
-- TOC entry 4882 (class 2606 OID 24638)
-- Name: categorias categorias_nombre_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_nombre_unique UNIQUE (nombre);


--
-- TOC entry 4884 (class 2606 OID 24636)
-- Name: categorias categorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (id);


--
-- TOC entry 4902 (class 2606 OID 24731)
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id);


--
-- TOC entry 4876 (class 2606 OID 24594)
-- Name: configuracions configuracions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configuracions
    ADD CONSTRAINT configuracions_pkey PRIMARY KEY (id);


--
-- TOC entry 4880 (class 2606 OID 24613)
-- Name: historial_accions historial_accions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_accions
    ADD CONSTRAINT historial_accions_pkey PRIMARY KEY (id);


--
-- TOC entry 4894 (class 2606 OID 24676)
-- Name: ingreso_productos ingreso_productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingreso_productos
    ADD CONSTRAINT ingreso_productos_pkey PRIMARY KEY (id);


--
-- TOC entry 4898 (class 2606 OID 24705)
-- Name: kardex_productos kardex_productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kardex_productos
    ADD CONSTRAINT kardex_productos_pkey PRIMARY KEY (id);


--
-- TOC entry 4874 (class 2606 OID 24585)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4914 (class 2606 OID 24805)
-- Name: notificacion_users notificacion_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificacion_users
    ADD CONSTRAINT notificacion_users_pkey PRIMARY KEY (id);


--
-- TOC entry 4912 (class 2606 OID 24798)
-- Name: notificacions notificacions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificacions
    ADD CONSTRAINT notificacions_pkey PRIMARY KEY (id);


--
-- TOC entry 4918 (class 2606 OID 24912)
-- Name: parametrizacions parametrizacions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parametrizacions
    ADD CONSTRAINT parametrizacions_pkey PRIMARY KEY (id);


--
-- TOC entry 4910 (class 2606 OID 24784)
-- Name: participante_pujas participante_pujas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participante_pujas
    ADD CONSTRAINT participante_pujas_pkey PRIMARY KEY (id);


--
-- TOC entry 4908 (class 2606 OID 24767)
-- Name: participantes participantes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participantes
    ADD CONSTRAINT participantes_pkey PRIMARY KEY (id);


--
-- TOC entry 4892 (class 2606 OID 24662)
-- Name: producto_imagens producto_imagens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto_imagens
    ADD CONSTRAINT producto_imagens_pkey PRIMARY KEY (id);


--
-- TOC entry 4886 (class 2606 OID 24840)
-- Name: productos productos_codigo_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_codigo_unique UNIQUE (codigo);


--
-- TOC entry 4888 (class 2606 OID 24655)
-- Name: productos productos_nombre_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_nombre_unique UNIQUE (nombre);


--
-- TOC entry 4890 (class 2606 OID 24648)
-- Name: productos productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id);


--
-- TOC entry 4920 (class 2606 OID 24934)
-- Name: recuperar_passwords recuperar_passwords_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recuperar_passwords
    ADD CONSTRAINT recuperar_passwords_pkey PRIMARY KEY (id);


--
-- TOC entry 4896 (class 2606 OID 24690)
-- Name: salida_productos salida_productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salida_productos
    ADD CONSTRAINT salida_productos_pkey PRIMARY KEY (id);


--
-- TOC entry 4900 (class 2606 OID 24717)
-- Name: subastas subastas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subastas
    ADD CONSTRAINT subastas_pkey PRIMARY KEY (id);


--
-- TOC entry 4916 (class 2606 OID 24898)
-- Name: user_datos user_datos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_datos
    ADD CONSTRAINT user_datos_pkey PRIMARY KEY (id);


--
-- TOC entry 4878 (class 2606 OID 24604)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4906 (class 2606 OID 24750)
-- Name: venta_detalles venta_detalles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_detalles
    ADD CONSTRAINT venta_detalles_pkey PRIMARY KEY (id);


--
-- TOC entry 4904 (class 2606 OID 24738)
-- Name: ventas ventas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_pkey PRIMARY KEY (id);


--
-- TOC entry 4921 (class 2606 OID 24614)
-- Name: historial_accions historial_accions_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_accions
    ADD CONSTRAINT historial_accions_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4924 (class 2606 OID 24677)
-- Name: ingreso_productos ingreso_productos_producto_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingreso_productos
    ADD CONSTRAINT ingreso_productos_producto_id_foreign FOREIGN KEY (producto_id) REFERENCES public.productos(id);


--
-- TOC entry 4926 (class 2606 OID 24706)
-- Name: kardex_productos kardex_productos_producto_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kardex_productos
    ADD CONSTRAINT kardex_productos_producto_id_foreign FOREIGN KEY (producto_id) REFERENCES public.productos(id);


--
-- TOC entry 4937 (class 2606 OID 24915)
-- Name: notificacion_users notificacion_user_notificacion_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificacion_users
    ADD CONSTRAINT notificacion_user_notificacion_id FOREIGN KEY (notificacion_id) REFERENCES public.notificacions(id);


--
-- TOC entry 4938 (class 2606 OID 24920)
-- Name: notificacion_users notificacion_user_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificacion_users
    ADD CONSTRAINT notificacion_user_user_id FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4934 (class 2606 OID 24785)
-- Name: participante_pujas participante_pujas_participante_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participante_pujas
    ADD CONSTRAINT participante_pujas_participante_id_foreign FOREIGN KEY (participante_id) REFERENCES public.participantes(id);


--
-- TOC entry 4935 (class 2606 OID 24871)
-- Name: participante_pujas participante_pujas_subasta_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participante_pujas
    ADD CONSTRAINT participante_pujas_subasta_id_foreign FOREIGN KEY (subasta_id) REFERENCES public.subastas(id);


--
-- TOC entry 4936 (class 2606 OID 24866)
-- Name: participante_pujas participante_pujas_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participante_pujas
    ADD CONSTRAINT participante_pujas_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4932 (class 2606 OID 24768)
-- Name: participantes participantes_subasta_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participantes
    ADD CONSTRAINT participantes_subasta_id_foreign FOREIGN KEY (subasta_id) REFERENCES public.subastas(id);


--
-- TOC entry 4933 (class 2606 OID 24773)
-- Name: participantes participantes_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participantes
    ADD CONSTRAINT participantes_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4923 (class 2606 OID 24663)
-- Name: producto_imagens producto_imagens_producto_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto_imagens
    ADD CONSTRAINT producto_imagens_producto_id_foreign FOREIGN KEY (producto_id) REFERENCES public.productos(id);


--
-- TOC entry 4922 (class 2606 OID 24649)
-- Name: productos productos_categoria_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_categoria_id_foreign FOREIGN KEY (categoria_id) REFERENCES public.categorias(id);


--
-- TOC entry 4940 (class 2606 OID 24935)
-- Name: recuperar_passwords recuperar_passwords_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recuperar_passwords
    ADD CONSTRAINT recuperar_passwords_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4925 (class 2606 OID 24691)
-- Name: salida_productos salida_productos_producto_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salida_productos
    ADD CONSTRAINT salida_productos_producto_id_foreign FOREIGN KEY (producto_id) REFERENCES public.productos(id);


--
-- TOC entry 4927 (class 2606 OID 24718)
-- Name: subastas subastas_producto_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subastas
    ADD CONSTRAINT subastas_producto_id_foreign FOREIGN KEY (producto_id) REFERENCES public.productos(id);


--
-- TOC entry 4939 (class 2606 OID 24899)
-- Name: user_datos user_datos_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_datos
    ADD CONSTRAINT user_datos_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4930 (class 2606 OID 24756)
-- Name: venta_detalles venta_detalles_producto_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_detalles
    ADD CONSTRAINT venta_detalles_producto_id_foreign FOREIGN KEY (producto_id) REFERENCES public.productos(id);


--
-- TOC entry 4931 (class 2606 OID 24751)
-- Name: venta_detalles venta_detalles_venta_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_detalles
    ADD CONSTRAINT venta_detalles_venta_id_foreign FOREIGN KEY (venta_id) REFERENCES public.ventas(id);


--
-- TOC entry 4928 (class 2606 OID 24739)
-- Name: ventas ventas_cliente_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_cliente_id_foreign FOREIGN KEY (cliente_id) REFERENCES public.clientes(id);


--
-- TOC entry 4929 (class 2606 OID 24859)
-- Name: ventas ventas_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


-- Completed on 2026-04-23 18:33:15

--
-- PostgreSQL database dump complete
--

\unrestrict lEpaeuuXma659dn2R2z7cDYQhdUBHKGH3YHTduHcxMgV9aKvRNV0fCCiluJhFos

