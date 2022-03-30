--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: ubuntu; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE ubuntu WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE ubuntu OWNER TO postgres;

\connect ubuntu

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: restaurants; Type: TABLE; Schema: public; Owner: michaeltyiska
--

CREATE TABLE public.restaurants (
    id bigint NOT NULL,
    name character varying(50) NOT NULL,
    location character varying(50) NOT NULL,
    price_range integer NOT NULL
);


ALTER TABLE public.restaurants OWNER TO michaeltyiska;

--
-- Name: restaurants_id_seq; Type: SEQUENCE; Schema: public; Owner: michaeltyiska
--

CREATE SEQUENCE public.restaurants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.restaurants_id_seq OWNER TO michaeltyiska;

--
-- Name: restaurants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: michaeltyiska
--

ALTER SEQUENCE public.restaurants_id_seq OWNED BY public.restaurants.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: michaeltyiska
--

CREATE TABLE public.reviews (
    id bigint NOT NULL,
    restaurant_id bigint NOT NULL,
    name character varying(50) NOT NULL,
    review text NOT NULL,
    rating integer NOT NULL,
    CONSTRAINT reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.reviews OWNER TO michaeltyiska;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: michaeltyiska
--

CREATE SEQUENCE public.reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reviews_id_seq OWNER TO michaeltyiska;

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: michaeltyiska
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: restaurants id; Type: DEFAULT; Schema: public; Owner: michaeltyiska
--

ALTER TABLE ONLY public.restaurants ALTER COLUMN id SET DEFAULT nextval('public.restaurants_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: michaeltyiska
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Data for Name: restaurants; Type: TABLE DATA; Schema: public; Owner: michaeltyiska
--

COPY public.restaurants (id, name, location, price_range) FROM stdin;
1	test	houston	2
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: michaeltyiska
--

COPY public.reviews (id, restaurant_id, name, review, rating) FROM stdin;
\.


--
-- Name: restaurants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: michaeltyiska
--

SELECT pg_catalog.setval('public.restaurants_id_seq', 1, true);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: michaeltyiska
--

SELECT pg_catalog.setval('public.reviews_id_seq', 1, false);


--
-- Name: restaurants restaurants_pkey; Type: CONSTRAINT; Schema: public; Owner: michaeltyiska
--

ALTER TABLE ONLY public.restaurants
    ADD CONSTRAINT restaurants_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: michaeltyiska
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_restaurant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: michaeltyiska
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_restaurant_id_fkey FOREIGN KEY (restaurant_id) REFERENCES public.restaurants(id);


--
-- Name: DATABASE ubuntu; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON DATABASE ubuntu TO michaeltyiska;


--
-- PostgreSQL database dump complete
--

