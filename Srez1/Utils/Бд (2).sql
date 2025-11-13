--
-- PostgreSQL database dump
--

\restrict 3LAF70S6S2giHkOu59fzZ47eTkt3u7dRl2p6kLdzVk96r23ucBe0McCQqR2233N

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

-- Started on 2025-11-13 14:56:16

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

--
-- TOC entry 4980 (class 1262 OID 19458)
-- Name: srez1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE srez1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


ALTER DATABASE srez1 OWNER TO postgres;

\unrestrict 3LAF70S6S2giHkOu59fzZ47eTkt3u7dRl2p6kLdzVk96r23ucBe0McCQqR2233N
\connect srez1
\restrict 3LAF70S6S2giHkOu59fzZ47eTkt3u7dRl2p6kLdzVk96r23ucBe0McCQqR2233N

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

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4981 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 19486)
-- Name: material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.material (
    id integer NOT NULL,
    name text NOT NULL,
    material_type_id integer NOT NULL,
    unit_price numeric(12,2) NOT NULL,
    stock_quantity numeric(15,2) NOT NULL,
    min_stock numeric(15,2) NOT NULL,
    package_quantity numeric(15,2) NOT NULL,
    unit_of_measure_id integer NOT NULL,
    CONSTRAINT material_min_stock_check CHECK ((min_stock >= (0)::numeric)),
    CONSTRAINT material_package_quantity_check CHECK ((package_quantity > (0)::numeric)),
    CONSTRAINT material_stock_quantity_check CHECK ((stock_quantity >= (0)::numeric)),
    CONSTRAINT material_unit_price_check CHECK ((unit_price >= (0)::numeric))
);


ALTER TABLE public.material OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 19485)
-- Name: material_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.material_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.material_id_seq OWNER TO postgres;

--
-- TOC entry 4982 (class 0 OID 0)
-- Dependencies: 221
-- Name: material_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.material_id_seq OWNED BY public.material.id;


--
-- TOC entry 223 (class 1259 OID 19505)
-- Name: material_supplier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.material_supplier (
    material_id integer NOT NULL,
    supplier_id integer NOT NULL
);


ALTER TABLE public.material_supplier OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 19460)
-- Name: material_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.material_type (
    id integer NOT NULL,
    name text NOT NULL,
    loss_percentage numeric(5,4) NOT NULL,
    CONSTRAINT material_type_loss_percentage_check CHECK (((loss_percentage >= (0)::numeric) AND (loss_percentage <= (1)::numeric)))
);


ALTER TABLE public.material_type OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 19459)
-- Name: material_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.material_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.material_type_id_seq OWNER TO postgres;

--
-- TOC entry 4983 (class 0 OID 0)
-- Dependencies: 217
-- Name: material_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.material_type_id_seq OWNED BY public.material_type.id;


--
-- TOC entry 225 (class 1259 OID 19521)
-- Name: product_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_type (
    id integer NOT NULL,
    name text NOT NULL,
    coefficient numeric(10,4) NOT NULL,
    CONSTRAINT product_type_coefficient_check CHECK ((coefficient > (0)::numeric))
);


ALTER TABLE public.product_type OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 19520)
-- Name: product_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_type_id_seq OWNER TO postgres;

--
-- TOC entry 4984 (class 0 OID 0)
-- Dependencies: 224
-- Name: product_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_type_id_seq OWNED BY public.product_type.id;


--
-- TOC entry 220 (class 1259 OID 19472)
-- Name: supplier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.supplier (
    id integer NOT NULL,
    name text NOT NULL,
    inn text NOT NULL,
    rating integer NOT NULL,
    start_date date NOT NULL,
    supplier_type_id integer NOT NULL,
    CONSTRAINT supplier_rating_check CHECK (((rating >= 1) AND (rating <= 10)))
);


ALTER TABLE public.supplier OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 19471)
-- Name: supplier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.supplier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.supplier_id_seq OWNER TO postgres;

--
-- TOC entry 4985 (class 0 OID 0)
-- Dependencies: 219
-- Name: supplier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.supplier_id_seq OWNED BY public.supplier.id;


--
-- TOC entry 227 (class 1259 OID 19533)
-- Name: supplier_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.supplier_type (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.supplier_type OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 19532)
-- Name: supplier_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.supplier_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.supplier_type_id_seq OWNER TO postgres;

--
-- TOC entry 4986 (class 0 OID 0)
-- Dependencies: 226
-- Name: supplier_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.supplier_type_id_seq OWNED BY public.supplier_type.id;


--
-- TOC entry 229 (class 1259 OID 19544)
-- Name: unit_of_measure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unit_of_measure (
    id integer NOT NULL,
    symbol text NOT NULL
);


ALTER TABLE public.unit_of_measure OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 19543)
-- Name: unit_of_measure_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.unit_of_measure_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.unit_of_measure_id_seq OWNER TO postgres;

--
-- TOC entry 4987 (class 0 OID 0)
-- Dependencies: 228
-- Name: unit_of_measure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.unit_of_measure_id_seq OWNED BY public.unit_of_measure.id;


--
-- TOC entry 4773 (class 2604 OID 19489)
-- Name: material id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material ALTER COLUMN id SET DEFAULT nextval('public.material_id_seq'::regclass);


--
-- TOC entry 4771 (class 2604 OID 19463)
-- Name: material_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material_type ALTER COLUMN id SET DEFAULT nextval('public.material_type_id_seq'::regclass);


--
-- TOC entry 4774 (class 2604 OID 19524)
-- Name: product_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_type ALTER COLUMN id SET DEFAULT nextval('public.product_type_id_seq'::regclass);


--
-- TOC entry 4772 (class 2604 OID 19475)
-- Name: supplier id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier ALTER COLUMN id SET DEFAULT nextval('public.supplier_id_seq'::regclass);


--
-- TOC entry 4775 (class 2604 OID 19536)
-- Name: supplier_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier_type ALTER COLUMN id SET DEFAULT nextval('public.supplier_type_id_seq'::regclass);


--
-- TOC entry 4776 (class 2604 OID 19547)
-- Name: unit_of_measure id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_of_measure ALTER COLUMN id SET DEFAULT nextval('public.unit_of_measure_id_seq'::regclass);


--
-- TOC entry 4967 (class 0 OID 19486)
-- Dependencies: 222
-- Data for Name: material; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.material VALUES (2, 'Каолин', 1, 18.20, 1030.00, 3500.00, 25.00, 1);
INSERT INTO public.material VALUES (3, 'Гидрослюда', 1, 17.20, 2147.00, 3500.00, 25.00, 1);
INSERT INTO public.material VALUES (4, 'Монтмориллонит', 1, 17.67, 3000.00, 3000.00, 30.00, 1);
INSERT INTO public.material VALUES (6, 'Стекло', 2, 2.40, 3000.00, 1500.00, 500.00, 1);
INSERT INTO public.material VALUES (7, 'Дегидратированная глина', 2, 21.95, 3000.00, 2500.00, 20.00, 1);
INSERT INTO public.material VALUES (8, 'Шамот', 2, 27.50, 2300.00, 1960.00, 20.00, 1);
INSERT INTO public.material VALUES (9, 'Техническая сода', 3, 54.55, 1200.00, 1500.00, 25.00, 1);
INSERT INTO public.material VALUES (11, 'Кварц', 4, 375.96, 1500.00, 2500.00, 10.00, 1);
INSERT INTO public.material VALUES (12, 'Полевой шпат', 4, 15.99, 750.00, 1500.00, 100.00, 1);
INSERT INTO public.material VALUES (14, 'Порошок цветной', 5, 84.39, 511.00, 1750.00, 25.00, 1);
INSERT INTO public.material VALUES (15, 'Кварцевый песок', 2, 4.29, 3000.00, 1600.00, 50.00, 1);
INSERT INTO public.material VALUES (16, 'Жильный кварц', 2, 18.60, 2556.00, 1600.00, 25.00, 1);
INSERT INTO public.material VALUES (17, 'Барий углекислый', 4, 303.64, 340.00, 1500.00, 25.00, 1);
INSERT INTO public.material VALUES (18, 'Бура техническая', 4, 125.99, 165.00, 1300.00, 25.00, 1);
INSERT INTO public.material VALUES (19, 'Углещелочной реагент', 3, 3.45, 450.00, 1100.00, 25.00, 1);
INSERT INTO public.material VALUES (20, 'Пирофосфат натрия', 3, 700.99, 356.00, 1200.00, 25.00, 1);
INSERT INTO public.material VALUES (1, 'Глина', 1, 15.29, 1570.00, 5500.00, 30.00, 1);
INSERT INTO public.material VALUES (5, 'Перлит', 2, 13.99, 150.00, 1000.00, 50.00, 2);
INSERT INTO public.material VALUES (13, 'Краска-раствор', 5, 200.90, 1496.00, 2500.00, 5.00, 2);
INSERT INTO public.material VALUES (10, 'Жидкое стекло', 3, 76.59, 500.00, 1500.00, 15.00, 1);
INSERT INTO public.material VALUES (22, 'пластелин', 1, 20.00, 1430.00, 4500.00, 16.00, 1);
INSERT INTO public.material VALUES (21, 'репа', 4, 40.00, 150.00, 10.00, 15.00, 1);


--
-- TOC entry 4968 (class 0 OID 19505)
-- Dependencies: 223
-- Data for Name: material_supplier; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.material_supplier VALUES (13, 19);
INSERT INTO public.material_supplier VALUES (2, 3);
INSERT INTO public.material_supplier VALUES (2, 9);
INSERT INTO public.material_supplier VALUES (6, 19);
INSERT INTO public.material_supplier VALUES (15, 1);
INSERT INTO public.material_supplier VALUES (5, 6);
INSERT INTO public.material_supplier VALUES (1, 4);
INSERT INTO public.material_supplier VALUES (15, 2);
INSERT INTO public.material_supplier VALUES (7, 9);
INSERT INTO public.material_supplier VALUES (12, 4);
INSERT INTO public.material_supplier VALUES (1, 1);
INSERT INTO public.material_supplier VALUES (14, 19);
INSERT INTO public.material_supplier VALUES (16, 17);
INSERT INTO public.material_supplier VALUES (12, 1);
INSERT INTO public.material_supplier VALUES (11, 9);
INSERT INTO public.material_supplier VALUES (6, 2);
INSERT INTO public.material_supplier VALUES (12, 12);
INSERT INTO public.material_supplier VALUES (4, 9);
INSERT INTO public.material_supplier VALUES (11, 14);
INSERT INTO public.material_supplier VALUES (17, 17);
INSERT INTO public.material_supplier VALUES (10, 12);
INSERT INTO public.material_supplier VALUES (9, 18);
INSERT INTO public.material_supplier VALUES (1, 6);
INSERT INTO public.material_supplier VALUES (11, 16);
INSERT INTO public.material_supplier VALUES (11, 3);
INSERT INTO public.material_supplier VALUES (3, 9);
INSERT INTO public.material_supplier VALUES (5, 9);
INSERT INTO public.material_supplier VALUES (3, 4);
INSERT INTO public.material_supplier VALUES (14, 12);
INSERT INTO public.material_supplier VALUES (17, 2);
INSERT INTO public.material_supplier VALUES (18, 2);
INSERT INTO public.material_supplier VALUES (19, 14);
INSERT INTO public.material_supplier VALUES (20, 2);
INSERT INTO public.material_supplier VALUES (3, 5);
INSERT INTO public.material_supplier VALUES (16, 1);
INSERT INTO public.material_supplier VALUES (5, 18);
INSERT INTO public.material_supplier VALUES (13, 12);
INSERT INTO public.material_supplier VALUES (18, 12);
INSERT INTO public.material_supplier VALUES (2, 1);
INSERT INTO public.material_supplier VALUES (10, 14);
INSERT INTO public.material_supplier VALUES (18, 17);
INSERT INTO public.material_supplier VALUES (8, 1);
INSERT INTO public.material_supplier VALUES (17, 16);
INSERT INTO public.material_supplier VALUES (18, 1);
INSERT INTO public.material_supplier VALUES (8, 2);
INSERT INTO public.material_supplier VALUES (13, 16);
INSERT INTO public.material_supplier VALUES (11, 17);
INSERT INTO public.material_supplier VALUES (18, 18);
INSERT INTO public.material_supplier VALUES (16, 15);
INSERT INTO public.material_supplier VALUES (18, 16);
INSERT INTO public.material_supplier VALUES (19, 12);
INSERT INTO public.material_supplier VALUES (17, 18);
INSERT INTO public.material_supplier VALUES (13, 8);
INSERT INTO public.material_supplier VALUES (19, 16);
INSERT INTO public.material_supplier VALUES (19, 5);
INSERT INTO public.material_supplier VALUES (20, 16);
INSERT INTO public.material_supplier VALUES (16, 18);
INSERT INTO public.material_supplier VALUES (19, 2);
INSERT INTO public.material_supplier VALUES (20, 18);
INSERT INTO public.material_supplier VALUES (9, 16);
INSERT INTO public.material_supplier VALUES (9, 8);
INSERT INTO public.material_supplier VALUES (19, 8);
INSERT INTO public.material_supplier VALUES (18, 7);
INSERT INTO public.material_supplier VALUES (20, 7);
INSERT INTO public.material_supplier VALUES (20, 5);
INSERT INTO public.material_supplier VALUES (16, 5);
INSERT INTO public.material_supplier VALUES (7, 2);


--
-- TOC entry 4963 (class 0 OID 19460)
-- Dependencies: 218
-- Data for Name: material_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.material_type VALUES (1, 'Пластичные материалы', 0.0012);
INSERT INTO public.material_type VALUES (2, 'Добавка', 0.0020);
INSERT INTO public.material_type VALUES (3, 'Электролит', 0.0015);
INSERT INTO public.material_type VALUES (4, 'Глазурь', 0.0030);
INSERT INTO public.material_type VALUES (5, 'Пигмент', 0.0025);


--
-- TOC entry 4970 (class 0 OID 19521)
-- Dependencies: 225
-- Data for Name: product_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product_type VALUES (1, 'Тип продукции 1', 1.2000);
INSERT INTO public.product_type VALUES (2, 'Тип продукции 2', 8.5900);
INSERT INTO public.product_type VALUES (3, 'Тип продукции 3', 3.4500);
INSERT INTO public.product_type VALUES (4, 'Тип продукции 4', 5.6000);


--
-- TOC entry 4965 (class 0 OID 19472)
-- Dependencies: 220
-- Data for Name: supplier; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.supplier VALUES (1, 'БрянскСтройресурс', '9432455179', 8, '2015-12-20', 2);
INSERT INTO public.supplier VALUES (2, 'Стройкомплект', '7803888520', 7, '2017-09-13', 2);
INSERT INTO public.supplier VALUES (12, 'КурскРесурс', '9032455179', 4, '2021-07-23', 2);
INSERT INTO public.supplier VALUES (17, 'Горная компания', '2262431140', 3, '2020-12-22', 2);
INSERT INTO public.supplier VALUES (19, 'Арсенал', '3961234561', 5, '2010-11-25', 2);
INSERT INTO public.supplier VALUES (20, 'КамчаткаСтройМинералы', '9600275878', 7, '2016-12-20', 2);
INSERT INTO public.supplier VALUES (3, 'Железногорская руда', '8430391035', 7, '2016-12-23', 1);
INSERT INTO public.supplier VALUES (4, 'Белая гора', '4318170454', 8, '2019-05-27', 1);
INSERT INTO public.supplier VALUES (5, 'Тульский обрабатывающий завод', '7687851800', 7, '2015-06-16', 1);
INSERT INTO public.supplier VALUES (9, 'ВоронежРудоКомбинат', '3532367439', 8, '2023-11-11', 1);
INSERT INTO public.supplier VALUES (10, 'Смоленский добывающий комбинат', '2362431140', 3, '2018-11-23', 1);
INSERT INTO public.supplier VALUES (13, 'Нижегородская разработка', '3776671267', 9, '2016-05-23', 1);
INSERT INTO public.supplier VALUES (14, 'Речная долина', '7447864518', 8, '2015-06-25', 1);
INSERT INTO public.supplier VALUES (15, 'Карелия добыча', '9037040523', 6, '2017-03-09', 1);
INSERT INTO public.supplier VALUES (18, 'Минерал Ресурс', '4155215346', 7, '2015-05-22', 1);
INSERT INTO public.supplier VALUES (6, 'ГорТехРазработка', '6119144874', 9, '2021-12-27', 3);
INSERT INTO public.supplier VALUES (8, 'ХимБытСервис', '8355114917', 5, '2022-03-13', 3);
INSERT INTO public.supplier VALUES (11, 'МосКарьер', '4159215346', 2, '2012-07-07', 3);
INSERT INTO public.supplier VALUES (16, 'Московский ХимЗавод', '6221520857', 4, '2015-05-07', 3);
INSERT INTO public.supplier VALUES (7, 'Сапфир', '1122170258', 3, '2022-04-10', 4);


--
-- TOC entry 4972 (class 0 OID 19533)
-- Dependencies: 227
-- Data for Name: supplier_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.supplier_type VALUES (1, 'ООО');
INSERT INTO public.supplier_type VALUES (2, 'ЗАО');
INSERT INTO public.supplier_type VALUES (3, 'ПАО');
INSERT INTO public.supplier_type VALUES (4, 'ОАО');


--
-- TOC entry 4974 (class 0 OID 19544)
-- Dependencies: 229
-- Data for Name: unit_of_measure; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.unit_of_measure VALUES (1, 'кг');
INSERT INTO public.unit_of_measure VALUES (2, 'л');


--
-- TOC entry 4988 (class 0 OID 0)
-- Dependencies: 221
-- Name: material_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.material_id_seq', 22, true);


--
-- TOC entry 4989 (class 0 OID 0)
-- Dependencies: 217
-- Name: material_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.material_type_id_seq', 5, true);


--
-- TOC entry 4990 (class 0 OID 0)
-- Dependencies: 224
-- Name: product_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_type_id_seq', 4, true);


--
-- TOC entry 4991 (class 0 OID 0)
-- Dependencies: 219
-- Name: supplier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.supplier_id_seq', 20, true);


--
-- TOC entry 4992 (class 0 OID 0)
-- Dependencies: 226
-- Name: supplier_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.supplier_type_id_seq', 4, true);


--
-- TOC entry 4993 (class 0 OID 0)
-- Dependencies: 228
-- Name: unit_of_measure_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.unit_of_measure_id_seq', 2, true);


--
-- TOC entry 4795 (class 2606 OID 19499)
-- Name: material material_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material
    ADD CONSTRAINT material_name_key UNIQUE (name);


--
-- TOC entry 4797 (class 2606 OID 19497)
-- Name: material material_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material
    ADD CONSTRAINT material_pkey PRIMARY KEY (id);


--
-- TOC entry 4799 (class 2606 OID 19509)
-- Name: material_supplier material_supplier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material_supplier
    ADD CONSTRAINT material_supplier_pkey PRIMARY KEY (material_id, supplier_id);


--
-- TOC entry 4785 (class 2606 OID 19470)
-- Name: material_type material_type_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material_type
    ADD CONSTRAINT material_type_name_key UNIQUE (name);


--
-- TOC entry 4787 (class 2606 OID 19468)
-- Name: material_type material_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material_type
    ADD CONSTRAINT material_type_pkey PRIMARY KEY (id);


--
-- TOC entry 4801 (class 2606 OID 19531)
-- Name: product_type product_type_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_type
    ADD CONSTRAINT product_type_name_key UNIQUE (name);


--
-- TOC entry 4803 (class 2606 OID 19529)
-- Name: product_type product_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_type
    ADD CONSTRAINT product_type_pkey PRIMARY KEY (id);


--
-- TOC entry 4789 (class 2606 OID 19484)
-- Name: supplier supplier_inn_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_inn_key UNIQUE (inn);


--
-- TOC entry 4791 (class 2606 OID 19482)
-- Name: supplier supplier_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_name_key UNIQUE (name);


--
-- TOC entry 4793 (class 2606 OID 19480)
-- Name: supplier supplier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_pkey PRIMARY KEY (id);


--
-- TOC entry 4805 (class 2606 OID 19542)
-- Name: supplier_type supplier_type_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier_type
    ADD CONSTRAINT supplier_type_name_key UNIQUE (name);


--
-- TOC entry 4807 (class 2606 OID 19540)
-- Name: supplier_type supplier_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier_type
    ADD CONSTRAINT supplier_type_pkey PRIMARY KEY (id);


--
-- TOC entry 4809 (class 2606 OID 19551)
-- Name: unit_of_measure unit_of_measure_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_of_measure
    ADD CONSTRAINT unit_of_measure_pkey PRIMARY KEY (id);


--
-- TOC entry 4811 (class 2606 OID 19553)
-- Name: unit_of_measure unit_of_measure_symbol_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_of_measure
    ADD CONSTRAINT unit_of_measure_symbol_key UNIQUE (symbol);


--
-- TOC entry 4813 (class 2606 OID 19500)
-- Name: material material_material_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material
    ADD CONSTRAINT material_material_type_id_fkey FOREIGN KEY (material_type_id) REFERENCES public.material_type(id) ON DELETE RESTRICT;


--
-- TOC entry 4815 (class 2606 OID 19510)
-- Name: material_supplier material_supplier_material_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material_supplier
    ADD CONSTRAINT material_supplier_material_id_fkey FOREIGN KEY (material_id) REFERENCES public.material(id) ON DELETE CASCADE;


--
-- TOC entry 4816 (class 2606 OID 19515)
-- Name: material_supplier material_supplier_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material_supplier
    ADD CONSTRAINT material_supplier_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.supplier(id) ON DELETE CASCADE;


--
-- TOC entry 4814 (class 2606 OID 19584)
-- Name: material material_unit_of_measure_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material
    ADD CONSTRAINT material_unit_of_measure_id_fkey FOREIGN KEY (unit_of_measure_id) REFERENCES public.unit_of_measure(id) ON DELETE RESTRICT;


--
-- TOC entry 4812 (class 2606 OID 19589)
-- Name: supplier supplier_supplier_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_supplier_type_id_fkey FOREIGN KEY (supplier_type_id) REFERENCES public.supplier_type(id) ON DELETE RESTRICT;


-- Completed on 2025-11-13 14:56:16

--
-- PostgreSQL database dump complete
--

\unrestrict 3LAF70S6S2giHkOu59fzZ47eTkt3u7dRl2p6kLdzVk96r23ucBe0McCQqR2233N

