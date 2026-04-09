--
-- PostgreSQL database dump
--

\restrict 3nc7iwpjPvFreRiFxUceDGYBJqTH0GlmsBZgh5ofUJlHBmWSpwMgHkIqB10iZ5z

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

-- Started on 2026-04-09 13:18:10

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
-- TOC entry 228 (class 1259 OID 24629)
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
-- TOC entry 227 (class 1259 OID 24628)
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
-- TOC entry 5100 (class 0 OID 0)
-- Dependencies: 227
-- Name: categorias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categorias_id_seq OWNED BY public.categorias.id;


--
-- TOC entry 242 (class 1259 OID 24724)
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
-- TOC entry 241 (class 1259 OID 24723)
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
-- TOC entry 5101 (class 0 OID 0)
-- Dependencies: 241
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
-- TOC entry 5102 (class 0 OID 0)
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
-- TOC entry 5103 (class 0 OID 0)
-- Dependencies: 223
-- Name: historial_accions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historial_accions_id_seq OWNED BY public.historial_accions.id;


--
-- TOC entry 234 (class 1259 OID 24669)
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
-- TOC entry 233 (class 1259 OID 24668)
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
-- TOC entry 5104 (class 0 OID 0)
-- Dependencies: 233
-- Name: ingreso_productos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ingreso_productos_id_seq OWNED BY public.ingreso_productos.id;


--
-- TOC entry 238 (class 1259 OID 24697)
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
-- TOC entry 237 (class 1259 OID 24696)
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
-- TOC entry 5105 (class 0 OID 0)
-- Dependencies: 237
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
-- TOC entry 5106 (class 0 OID 0)
-- Dependencies: 217
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- TOC entry 254 (class 1259 OID 24800)
-- Name: notificacion_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notificacion_users (
    id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.notificacion_users OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 24799)
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
-- TOC entry 5107 (class 0 OID 0)
-- Dependencies: 253
-- Name: notificacion_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notificacion_users_id_seq OWNED BY public.notificacion_users.id;


--
-- TOC entry 252 (class 1259 OID 24791)
-- Name: notificacions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notificacions (
    id bigint NOT NULL,
    modelo character varying(255) NOT NULL,
    modelo_id bigint NOT NULL,
    descripcion text NOT NULL,
    fecha date NOT NULL,
    hora time(0) without time zone NOT NULL,
    tipo character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.notificacions OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 24790)
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
-- TOC entry 5108 (class 0 OID 0)
-- Dependencies: 251
-- Name: notificacions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notificacions_id_seq OWNED BY public.notificacions.id;


--
-- TOC entry 250 (class 1259 OID 24779)
-- Name: participante_pujas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.participante_pujas (
    id bigint NOT NULL,
    participante_id bigint NOT NULL,
    monto numeric(24,2) NOT NULL,
    fecha date NOT NULL,
    hora time(0) without time zone NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.participante_pujas OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 24778)
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
-- TOC entry 5109 (class 0 OID 0)
-- Dependencies: 249
-- Name: participante_pujas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.participante_pujas_id_seq OWNED BY public.participante_pujas.id;


--
-- TOC entry 248 (class 1259 OID 24762)
-- Name: participantes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.participantes (
    id bigint NOT NULL,
    subasta_id bigint NOT NULL,
    user_id bigint NOT NULL,
    estado character varying(255) NOT NULL,
    fecha date NOT NULL,
    hora time(0) without time zone NOT NULL,
    monto_puja numeric(24,2) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.participantes OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 24761)
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
-- TOC entry 5110 (class 0 OID 0)
-- Dependencies: 247
-- Name: participantes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.participantes_id_seq OWNED BY public.participantes.id;


--
-- TOC entry 232 (class 1259 OID 24657)
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
-- TOC entry 231 (class 1259 OID 24656)
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
-- TOC entry 5111 (class 0 OID 0)
-- Dependencies: 231
-- Name: producto_imagens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.producto_imagens_id_seq OWNED BY public.producto_imagens.id;


--
-- TOC entry 230 (class 1259 OID 24640)
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
    codigo character varying(255) NOT NULL
);


ALTER TABLE public.productos OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 24639)
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
-- TOC entry 5112 (class 0 OID 0)
-- Dependencies: 229
-- Name: productos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productos_id_seq OWNED BY public.productos.id;


--
-- TOC entry 226 (class 1259 OID 24620)
-- Name: qrs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrs (
    id bigint NOT NULL,
    imagen character varying(255) NOT NULL,
    remitente character varying(255) NOT NULL,
    fecha_vencimiento date NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.qrs OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24619)
-- Name: qrs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.qrs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.qrs_id_seq OWNER TO postgres;

--
-- TOC entry 5113 (class 0 OID 0)
-- Dependencies: 225
-- Name: qrs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.qrs_id_seq OWNED BY public.qrs.id;


--
-- TOC entry 236 (class 1259 OID 24683)
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
-- TOC entry 235 (class 1259 OID 24682)
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
-- TOC entry 5114 (class 0 OID 0)
-- Dependencies: 235
-- Name: salida_productos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.salida_productos_id_seq OWNED BY public.salida_productos.id;


--
-- TOC entry 240 (class 1259 OID 24712)
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
    estado_subasta integer NOT NULL,
    fecha_registro date NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.subastas OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 24711)
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
-- TOC entry 5115 (class 0 OID 0)
-- Dependencies: 239
-- Name: subastas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subastas_id_seq OWNED BY public.subastas.id;


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
-- TOC entry 5116 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 246 (class 1259 OID 24745)
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
-- TOC entry 245 (class 1259 OID 24744)
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
-- TOC entry 5117 (class 0 OID 0)
-- Dependencies: 245
-- Name: venta_detalles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.venta_detalles_id_seq OWNED BY public.venta_detalles.id;


--
-- TOC entry 244 (class 1259 OID 24733)
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
    nit_ci character varying(255)
);


ALTER TABLE public.ventas OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 24732)
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
-- TOC entry 5118 (class 0 OID 0)
-- Dependencies: 243
-- Name: ventas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ventas_id_seq OWNED BY public.ventas.id;


--
-- TOC entry 4838 (class 2604 OID 24632)
-- Name: categorias id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias ALTER COLUMN id SET DEFAULT nextval('public.categorias_id_seq'::regclass);


--
-- TOC entry 4847 (class 2604 OID 24727)
-- Name: clientes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes ALTER COLUMN id SET DEFAULT nextval('public.clientes_id_seq'::regclass);


--
-- TOC entry 4833 (class 2604 OID 24590)
-- Name: configuracions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configuracions ALTER COLUMN id SET DEFAULT nextval('public.configuracions_id_seq'::regclass);


--
-- TOC entry 4836 (class 2604 OID 24609)
-- Name: historial_accions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_accions ALTER COLUMN id SET DEFAULT nextval('public.historial_accions_id_seq'::regclass);


--
-- TOC entry 4842 (class 2604 OID 24672)
-- Name: ingreso_productos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingreso_productos ALTER COLUMN id SET DEFAULT nextval('public.ingreso_productos_id_seq'::regclass);


--
-- TOC entry 4844 (class 2604 OID 24700)
-- Name: kardex_productos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kardex_productos ALTER COLUMN id SET DEFAULT nextval('public.kardex_productos_id_seq'::regclass);


--
-- TOC entry 4832 (class 2604 OID 24583)
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- TOC entry 4854 (class 2604 OID 24803)
-- Name: notificacion_users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificacion_users ALTER COLUMN id SET DEFAULT nextval('public.notificacion_users_id_seq'::regclass);


--
-- TOC entry 4853 (class 2604 OID 24794)
-- Name: notificacions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificacions ALTER COLUMN id SET DEFAULT nextval('public.notificacions_id_seq'::regclass);


--
-- TOC entry 4852 (class 2604 OID 24782)
-- Name: participante_pujas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participante_pujas ALTER COLUMN id SET DEFAULT nextval('public.participante_pujas_id_seq'::regclass);


--
-- TOC entry 4851 (class 2604 OID 24765)
-- Name: participantes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participantes ALTER COLUMN id SET DEFAULT nextval('public.participantes_id_seq'::regclass);


--
-- TOC entry 4841 (class 2604 OID 24660)
-- Name: producto_imagens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto_imagens ALTER COLUMN id SET DEFAULT nextval('public.producto_imagens_id_seq'::regclass);


--
-- TOC entry 4839 (class 2604 OID 24643)
-- Name: productos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos ALTER COLUMN id SET DEFAULT nextval('public.productos_id_seq'::regclass);


--
-- TOC entry 4837 (class 2604 OID 24623)
-- Name: qrs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrs ALTER COLUMN id SET DEFAULT nextval('public.qrs_id_seq'::regclass);


--
-- TOC entry 4843 (class 2604 OID 24686)
-- Name: salida_productos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salida_productos ALTER COLUMN id SET DEFAULT nextval('public.salida_productos_id_seq'::regclass);


--
-- TOC entry 4846 (class 2604 OID 24715)
-- Name: subastas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subastas ALTER COLUMN id SET DEFAULT nextval('public.subastas_id_seq'::regclass);


--
-- TOC entry 4834 (class 2604 OID 24599)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4850 (class 2604 OID 24748)
-- Name: venta_detalles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_detalles ALTER COLUMN id SET DEFAULT nextval('public.venta_detalles_id_seq'::regclass);


--
-- TOC entry 4848 (class 2604 OID 24736)
-- Name: ventas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas ALTER COLUMN id SET DEFAULT nextval('public.ventas_id_seq'::regclass);


--
-- TOC entry 5068 (class 0 OID 24629)
-- Dependencies: 228
-- Data for Name: categorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorias (id, nombre, descripcion, fecha_registro, created_at, updated_at) FROM stdin;
1	CATEGORIA 1	DESC 1	2026-04-08	2026-04-08 10:54:38	2026-04-08 10:54:38
2	CATEGORIA 2		2026-04-08	2026-04-08 10:54:42	2026-04-08 10:54:42
3	CATEGORIA 3		2026-04-08	2026-04-08 10:54:47	2026-04-08 10:54:47
\.


--
-- TOC entry 5082 (class 0 OID 24724)
-- Dependencies: 242
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clientes (id, nombre, nit_ci, cel, correo, created_at, updated_at, fecha_registro) FROM stdin;
1	JUAN PEREZ	123456	67676767	juan@gmail.com	2026-04-08 16:56:30	2026-04-08 16:56:30	2026-04-08
2	CONDORI ALEX		\N	\N	2026-04-08 16:56:42	2026-04-08 16:56:42	2026-04-08
\.


--
-- TOC entry 5060 (class 0 OID 24587)
-- Dependencies: 220
-- Data for Name: configuracions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.configuracions (id, nombre_sistema, alias, razon_social, logo, created_at, updated_at) FROM stdin;
1	SAVS	SAVS	SAVS S.A.	logo.jpeg	2026-04-07 16:04:07	2026-04-07 16:04:07
\.


--
-- TOC entry 5064 (class 0 OID 24606)
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
\.


--
-- TOC entry 5074 (class 0 OID 24669)
-- Dependencies: 234
-- Data for Name: ingreso_productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ingreso_productos (id, producto_id, cantidad, descripcion, fecha_registro, created_at, updated_at) FROM stdin;
1	1	100	INICIO STOCK	2026-04-08	2026-04-08 19:34:55	2026-04-08 19:34:55
2	2	100	INICIO STOCK	2026-04-08	2026-04-08 19:35:03	2026-04-08 19:35:03
\.


--
-- TOC entry 5078 (class 0 OID 24697)
-- Dependencies: 238
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
\.


--
-- TOC entry 5058 (class 0 OID 24580)
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
\.


--
-- TOC entry 5094 (class 0 OID 24800)
-- Dependencies: 254
-- Data for Name: notificacion_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notificacion_users (id, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5092 (class 0 OID 24791)
-- Dependencies: 252
-- Data for Name: notificacions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notificacions (id, modelo, modelo_id, descripcion, fecha, hora, tipo, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5090 (class 0 OID 24779)
-- Dependencies: 250
-- Data for Name: participante_pujas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.participante_pujas (id, participante_id, monto, fecha, hora, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5088 (class 0 OID 24762)
-- Dependencies: 248
-- Data for Name: participantes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.participantes (id, subasta_id, user_id, estado, fecha, hora, monto_puja, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5072 (class 0 OID 24657)
-- Dependencies: 232
-- Data for Name: producto_imagens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.producto_imagens (id, producto_id, imagen, created_at, updated_at) FROM stdin;
19	1	191775664131.jpg	2026-04-08 12:02:11	2026-04-08 12:02:11
20	1	1201775664131.jpeg	2026-04-08 12:02:11	2026-04-08 12:02:11
21	1	2211775664131.jpeg	2026-04-08 12:02:11	2026-04-08 12:02:11
23	2	231775691211.jpg	2026-04-08 19:33:31	2026-04-08 19:33:31
24	2	1241775691211.jpg	2026-04-08 19:33:31	2026-04-08 19:33:31
25	2	2251775691211.jpg	2026-04-08 19:33:31	2026-04-08 19:33:31
\.


--
-- TOC entry 5070 (class 0 OID 24640)
-- Dependencies: 230
-- Data for Name: productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productos (id, nombre, descripcion, precio, stock, categoria_id, fecha_registro, created_at, updated_at, codigo) FROM stdin;
1	PRODUCTO 1	<h2><strong><u>DESCRIPCIÓN DEL PRODUCTO</u></strong></h2><p><span style="color: rgb(0, 0, 0);">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</span></p>	120.00	97	1	2026-04-08	2026-04-08 11:39:00	2026-04-09 09:49:31	P001
2	PRODUCTO 2	<p>Descripcion del producto 2</p>	67.00	99	1	2026-04-08	2026-04-08 19:33:31	2026-04-09 09:49:31	P002
\.


--
-- TOC entry 5066 (class 0 OID 24620)
-- Dependencies: 226
-- Data for Name: qrs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.qrs (id, imagen, remitente, fecha_vencimiento, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5076 (class 0 OID 24683)
-- Dependencies: 236
-- Data for Name: salida_productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.salida_productos (id, producto_id, cantidad, descripcion, fecha_registro, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5080 (class 0 OID 24712)
-- Dependencies: 240
-- Data for Name: subastas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subastas (id, producto_id, estado_producto, monto_inicial, fecha_fin, hora_fin, publico, estado_subasta, fecha_registro, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5062 (class 0 OID 24596)
-- Dependencies: 222
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, usuario, nombre, paterno, materno, correo, fono, password, acceso, tipo, foto, fecha_registro, status, created_at, updated_at, ci, ci_exp) FROM stdin;
1	admin	admin	admin	\N	admin@admin.com		$2y$12$jrlcVfmykFHgcsTVPdyyiuFveypQPhYDxR.XPKtupQSRo5aOc8JVO	1	ADMINISTRADOR	\N	2026-04-07	1	2026-04-07 16:08:34	2026-04-07 16:08:34	\N	\N
2	JPERES	JUAN	PERES	MAMANI	juan@gmail.com	67676767	$2y$12$aBNjGfUpAcIywtg8ZyvcmejU/ex/rwh7YBo4SJ3pPpCUZsrbRcXvC	1	ADMINISTRADOR	21775656455.jpg	2026-04-08	1	2026-04-08 09:54:15	2026-04-08 09:54:15	\N	\N
3	GCARVAJAL	GERMAN	CARVAJAL		\N	67676767	$2y$12$nMvJvy/iJOvTGZaodz3cS.LyUT43ix18US/s.k5BRGWzrnPHIRvHG	1	AUXILIAR	\N	2026-04-08	1	2026-04-08 09:54:55	2026-04-08 09:54:55	\N	\N
\.


--
-- TOC entry 5086 (class 0 OID 24745)
-- Dependencies: 246
-- Data for Name: venta_detalles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.venta_detalles (id, venta_id, producto_id, precio, cantidad, subtotal, created_at, updated_at) FROM stdin;
1	1	1	120.00	3	360.00	2026-04-09 09:18:23	2026-04-09 09:18:23
2	1	2	67.00	1	67.00	2026-04-09 09:18:23	2026-04-09 09:18:23
3	2	1	120.00	1	120.00	2026-04-09 09:49:03	2026-04-09 09:49:03
4	2	2	67.00	4	268.00	2026-04-09 09:49:03	2026-04-09 09:49:13
5	3	1	120.00	1	120.00	2026-04-09 09:49:31	2026-04-09 09:49:31
6	3	2	67.00	1	67.00	2026-04-09 09:49:31	2026-04-09 09:49:31
\.


--
-- TOC entry 5084 (class 0 OID 24733)
-- Dependencies: 244
-- Data for Name: ventas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ventas (id, cliente_id, total, fecha, hora, created_at, updated_at, status, nit_ci) FROM stdin;
1	1	427.00	2026-04-09	09:18:22	2026-04-09 09:18:22	2026-04-09 09:46:05	0	123456
2	1	388.00	2026-04-09	09:49:03	2026-04-09 09:49:03	2026-04-09 09:49:18	0	123456
3	2	187.00	2026-04-09	09:49:31	2026-04-09 09:49:31	2026-04-09 09:49:31	1	\N
\.


--
-- TOC entry 5119 (class 0 OID 0)
-- Dependencies: 227
-- Name: categorias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categorias_id_seq', 3, true);


--
-- TOC entry 5120 (class 0 OID 0)
-- Dependencies: 241
-- Name: clientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clientes_id_seq', 2, true);


--
-- TOC entry 5121 (class 0 OID 0)
-- Dependencies: 219
-- Name: configuracions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.configuracions_id_seq', 1, true);


--
-- TOC entry 5122 (class 0 OID 0)
-- Dependencies: 223
-- Name: historial_accions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historial_accions_id_seq', 37, true);


--
-- TOC entry 5123 (class 0 OID 0)
-- Dependencies: 233
-- Name: ingreso_productos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ingreso_productos_id_seq', 2, true);


--
-- TOC entry 5124 (class 0 OID 0)
-- Dependencies: 237
-- Name: kardex_productos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kardex_productos_id_seq', 16, true);


--
-- TOC entry 5125 (class 0 OID 0)
-- Dependencies: 217
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 18, true);


--
-- TOC entry 5126 (class 0 OID 0)
-- Dependencies: 253
-- Name: notificacion_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notificacion_users_id_seq', 1, false);


--
-- TOC entry 5127 (class 0 OID 0)
-- Dependencies: 251
-- Name: notificacions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notificacions_id_seq', 1, false);


--
-- TOC entry 5128 (class 0 OID 0)
-- Dependencies: 249
-- Name: participante_pujas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.participante_pujas_id_seq', 1, false);


--
-- TOC entry 5129 (class 0 OID 0)
-- Dependencies: 247
-- Name: participantes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.participantes_id_seq', 1, false);


--
-- TOC entry 5130 (class 0 OID 0)
-- Dependencies: 231
-- Name: producto_imagens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.producto_imagens_id_seq', 25, true);


--
-- TOC entry 5131 (class 0 OID 0)
-- Dependencies: 229
-- Name: productos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productos_id_seq', 2, true);


--
-- TOC entry 5132 (class 0 OID 0)
-- Dependencies: 225
-- Name: qrs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.qrs_id_seq', 1, false);


--
-- TOC entry 5133 (class 0 OID 0)
-- Dependencies: 235
-- Name: salida_productos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.salida_productos_id_seq', 1, false);


--
-- TOC entry 5134 (class 0 OID 0)
-- Dependencies: 239
-- Name: subastas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subastas_id_seq', 1, false);


--
-- TOC entry 5135 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- TOC entry 5136 (class 0 OID 0)
-- Dependencies: 245
-- Name: venta_detalles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.venta_detalles_id_seq', 6, true);


--
-- TOC entry 5137 (class 0 OID 0)
-- Dependencies: 243
-- Name: ventas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ventas_id_seq', 3, true);


--
-- TOC entry 4866 (class 2606 OID 24638)
-- Name: categorias categorias_nombre_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_nombre_unique UNIQUE (nombre);


--
-- TOC entry 4868 (class 2606 OID 24636)
-- Name: categorias categorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (id);


--
-- TOC entry 4886 (class 2606 OID 24731)
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id);


--
-- TOC entry 4858 (class 2606 OID 24594)
-- Name: configuracions configuracions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configuracions
    ADD CONSTRAINT configuracions_pkey PRIMARY KEY (id);


--
-- TOC entry 4862 (class 2606 OID 24613)
-- Name: historial_accions historial_accions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_accions
    ADD CONSTRAINT historial_accions_pkey PRIMARY KEY (id);


--
-- TOC entry 4878 (class 2606 OID 24676)
-- Name: ingreso_productos ingreso_productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingreso_productos
    ADD CONSTRAINT ingreso_productos_pkey PRIMARY KEY (id);


--
-- TOC entry 4882 (class 2606 OID 24705)
-- Name: kardex_productos kardex_productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kardex_productos
    ADD CONSTRAINT kardex_productos_pkey PRIMARY KEY (id);


--
-- TOC entry 4856 (class 2606 OID 24585)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4898 (class 2606 OID 24805)
-- Name: notificacion_users notificacion_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificacion_users
    ADD CONSTRAINT notificacion_users_pkey PRIMARY KEY (id);


--
-- TOC entry 4896 (class 2606 OID 24798)
-- Name: notificacions notificacions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificacions
    ADD CONSTRAINT notificacions_pkey PRIMARY KEY (id);


--
-- TOC entry 4894 (class 2606 OID 24784)
-- Name: participante_pujas participante_pujas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participante_pujas
    ADD CONSTRAINT participante_pujas_pkey PRIMARY KEY (id);


--
-- TOC entry 4892 (class 2606 OID 24767)
-- Name: participantes participantes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participantes
    ADD CONSTRAINT participantes_pkey PRIMARY KEY (id);


--
-- TOC entry 4876 (class 2606 OID 24662)
-- Name: producto_imagens producto_imagens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto_imagens
    ADD CONSTRAINT producto_imagens_pkey PRIMARY KEY (id);


--
-- TOC entry 4870 (class 2606 OID 24840)
-- Name: productos productos_codigo_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_codigo_unique UNIQUE (codigo);


--
-- TOC entry 4872 (class 2606 OID 24655)
-- Name: productos productos_nombre_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_nombre_unique UNIQUE (nombre);


--
-- TOC entry 4874 (class 2606 OID 24648)
-- Name: productos productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id);


--
-- TOC entry 4864 (class 2606 OID 24627)
-- Name: qrs qrs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrs
    ADD CONSTRAINT qrs_pkey PRIMARY KEY (id);


--
-- TOC entry 4880 (class 2606 OID 24690)
-- Name: salida_productos salida_productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salida_productos
    ADD CONSTRAINT salida_productos_pkey PRIMARY KEY (id);


--
-- TOC entry 4884 (class 2606 OID 24717)
-- Name: subastas subastas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subastas
    ADD CONSTRAINT subastas_pkey PRIMARY KEY (id);


--
-- TOC entry 4860 (class 2606 OID 24604)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4890 (class 2606 OID 24750)
-- Name: venta_detalles venta_detalles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_detalles
    ADD CONSTRAINT venta_detalles_pkey PRIMARY KEY (id);


--
-- TOC entry 4888 (class 2606 OID 24738)
-- Name: ventas ventas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_pkey PRIMARY KEY (id);


--
-- TOC entry 4899 (class 2606 OID 24614)
-- Name: historial_accions historial_accions_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_accions
    ADD CONSTRAINT historial_accions_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4902 (class 2606 OID 24677)
-- Name: ingreso_productos ingreso_productos_producto_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingreso_productos
    ADD CONSTRAINT ingreso_productos_producto_id_foreign FOREIGN KEY (producto_id) REFERENCES public.productos(id);


--
-- TOC entry 4904 (class 2606 OID 24706)
-- Name: kardex_productos kardex_productos_producto_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kardex_productos
    ADD CONSTRAINT kardex_productos_producto_id_foreign FOREIGN KEY (producto_id) REFERENCES public.productos(id);


--
-- TOC entry 4911 (class 2606 OID 24785)
-- Name: participante_pujas participante_pujas_participante_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participante_pujas
    ADD CONSTRAINT participante_pujas_participante_id_foreign FOREIGN KEY (participante_id) REFERENCES public.participantes(id);


--
-- TOC entry 4909 (class 2606 OID 24768)
-- Name: participantes participantes_subasta_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participantes
    ADD CONSTRAINT participantes_subasta_id_foreign FOREIGN KEY (subasta_id) REFERENCES public.subastas(id);


--
-- TOC entry 4910 (class 2606 OID 24773)
-- Name: participantes participantes_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participantes
    ADD CONSTRAINT participantes_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4901 (class 2606 OID 24663)
-- Name: producto_imagens producto_imagens_producto_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto_imagens
    ADD CONSTRAINT producto_imagens_producto_id_foreign FOREIGN KEY (producto_id) REFERENCES public.productos(id);


--
-- TOC entry 4900 (class 2606 OID 24649)
-- Name: productos productos_categoria_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_categoria_id_foreign FOREIGN KEY (categoria_id) REFERENCES public.categorias(id);


--
-- TOC entry 4903 (class 2606 OID 24691)
-- Name: salida_productos salida_productos_producto_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salida_productos
    ADD CONSTRAINT salida_productos_producto_id_foreign FOREIGN KEY (producto_id) REFERENCES public.productos(id);


--
-- TOC entry 4905 (class 2606 OID 24718)
-- Name: subastas subastas_producto_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subastas
    ADD CONSTRAINT subastas_producto_id_foreign FOREIGN KEY (producto_id) REFERENCES public.productos(id);


--
-- TOC entry 4907 (class 2606 OID 24756)
-- Name: venta_detalles venta_detalles_producto_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_detalles
    ADD CONSTRAINT venta_detalles_producto_id_foreign FOREIGN KEY (producto_id) REFERENCES public.productos(id);


--
-- TOC entry 4908 (class 2606 OID 24751)
-- Name: venta_detalles venta_detalles_venta_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_detalles
    ADD CONSTRAINT venta_detalles_venta_id_foreign FOREIGN KEY (venta_id) REFERENCES public.ventas(id);


--
-- TOC entry 4906 (class 2606 OID 24739)
-- Name: ventas ventas_cliente_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_cliente_id_foreign FOREIGN KEY (cliente_id) REFERENCES public.clientes(id);


-- Completed on 2026-04-09 13:18:10

--
-- PostgreSQL database dump complete
--

\unrestrict 3nc7iwpjPvFreRiFxUceDGYBJqTH0GlmsBZgh5ofUJlHBmWSpwMgHkIqB10iZ5z

