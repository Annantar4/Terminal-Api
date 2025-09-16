--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2025-09-16 10:05:18

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
-- TOC entry 4872 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 66143)
-- Name: terminals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.terminals (
    id integer NOT NULL,
    name character varying NOT NULL,
    location character varying NOT NULL
);


ALTER TABLE public.terminals OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 66142)
-- Name: terminals_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.terminals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.terminals_id_seq OWNER TO postgres;

--
-- TOC entry 4873 (class 0 OID 0)
-- Dependencies: 219
-- Name: terminals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.terminals_id_seq OWNED BY public.terminals.id;


--
-- TOC entry 222 (class 1259 OID 66152)
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    id_card character varying NOT NULL,
    check_in date,
    check_out date,
    tarif character varying,
    status character varying NOT NULL
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 66151)
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transactions_id_seq OWNER TO postgres;

--
-- TOC entry 4874 (class 0 OID 0)
-- Dependencies: 221
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- TOC entry 218 (class 1259 OID 66132)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying NOT NULL,
    email character varying NOT NULL,
    role character varying NOT NULL,
    password character varying NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 66131)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 4875 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4706 (class 2604 OID 66146)
-- Name: terminals id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.terminals ALTER COLUMN id SET DEFAULT nextval('public.terminals_id_seq'::regclass);


--
-- TOC entry 4707 (class 2604 OID 66155)
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- TOC entry 4705 (class 2604 OID 66135)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4864 (class 0 OID 66143)
-- Dependencies: 220
-- Data for Name: terminals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.terminals (id, name, location) FROM stdin;
1	terminal 1	gate 1
2	terminal 2	gate 2
\.


--
-- TOC entry 4866 (class 0 OID 66152)
-- Dependencies: 222
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, id_card, check_in, check_out, tarif, status) FROM stdin;
\.


--
-- TOC entry 4862 (class 0 OID 66132)
-- Dependencies: 218
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, role, password) FROM stdin;
1	test	test@gmail.com	admin	$2a$10$CrEoUQVH6DP.IMWOlD7/meE.g7FEY6rWFCp0.TloaSK7FmA.ctjG2
2	budi	budi@gmail.com	user	$2a$10$UhXeTTXb6i4fIQWgWqVAQur8C59w3HdPEP3mWoGmJH/EnMJooCLLW
3	admin	admin@gmail.com	admin	$2a$10$a06HNeIycswEJA3Dut20uecG.Omu5M5qdISQ3nsZlWx5aqcuBFVHq
\.


--
-- TOC entry 4876 (class 0 OID 0)
-- Dependencies: 219
-- Name: terminals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.terminals_id_seq', 2, true);


--
-- TOC entry 4877 (class 0 OID 0)
-- Dependencies: 221
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 1, false);


--
-- TOC entry 4878 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- TOC entry 4713 (class 2606 OID 66150)
-- Name: terminals terminals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.terminals
    ADD CONSTRAINT terminals_pkey PRIMARY KEY (id);


--
-- TOC entry 4715 (class 2606 OID 66159)
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- TOC entry 4709 (class 2606 OID 66141)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4711 (class 2606 OID 66139)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


-- Completed on 2025-09-16 10:05:18

--
-- PostgreSQL database dump complete
--

