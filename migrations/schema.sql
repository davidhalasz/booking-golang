--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

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
-- Name: reservations; Type: TABLE; Schema: public; Owner: halaszdavid
--

CREATE TABLE public.reservations (
    id character varying(255) NOT NULL,
    first_name character varying(255) DEFAULT ''::character varying NOT NULL,
    last_name character varying(255) DEFAULT ''::character varying NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(255) DEFAULT ''::character varying NOT NULL,
    start_date character varying(255) NOT NULL,
    end_date character varying(255) NOT NULL,
    room_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.reservations OWNER TO halaszdavid;

--
-- Name: restrictions; Type: TABLE; Schema: public; Owner: halaszdavid
--

CREATE TABLE public.restrictions (
    id character varying(255) NOT NULL,
    restriction_name character varying(255) DEFAULT ''::character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.restrictions OWNER TO halaszdavid;

--
-- Name: room_restrictions; Type: TABLE; Schema: public; Owner: halaszdavid
--

CREATE TABLE public.room_restrictions (
    id character varying(255) NOT NULL,
    start_date character varying(255) NOT NULL,
    end_date character varying(255) NOT NULL,
    room_id integer NOT NULL,
    reservation_id integer NOT NULL,
    restriction_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.room_restrictions OWNER TO halaszdavid;

--
-- Name: rooms; Type: TABLE; Schema: public; Owner: halaszdavid
--

CREATE TABLE public.rooms (
    id character varying(255) NOT NULL,
    room_name character varying(255) DEFAULT ''::character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.rooms OWNER TO halaszdavid;

--
-- Name: schema_migration; Type: TABLE; Schema: public; Owner: halaszdavid
--

CREATE TABLE public.schema_migration (
    version character varying(14) NOT NULL
);


ALTER TABLE public.schema_migration OWNER TO halaszdavid;

--
-- Name: users; Type: TABLE; Schema: public; Owner: halaszdavid
--

CREATE TABLE public.users (
    id character varying(255) NOT NULL,
    first_name character varying(255) DEFAULT ''::character varying NOT NULL,
    last_name character varying(255) DEFAULT ''::character varying NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(60) NOT NULL,
    access_level integer DEFAULT 1 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO halaszdavid;

--
-- Name: reservations reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: halaszdavid
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_pkey PRIMARY KEY (id);


--
-- Name: restrictions restrictions_pkey; Type: CONSTRAINT; Schema: public; Owner: halaszdavid
--

ALTER TABLE ONLY public.restrictions
    ADD CONSTRAINT restrictions_pkey PRIMARY KEY (id);


--
-- Name: room_restrictions room_restrictions_pkey; Type: CONSTRAINT; Schema: public; Owner: halaszdavid
--

ALTER TABLE ONLY public.room_restrictions
    ADD CONSTRAINT room_restrictions_pkey PRIMARY KEY (id);


--
-- Name: rooms rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: halaszdavid
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- Name: schema_migration schema_migration_pkey; Type: CONSTRAINT; Schema: public; Owner: halaszdavid
--

ALTER TABLE ONLY public.schema_migration
    ADD CONSTRAINT schema_migration_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: halaszdavid
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: schema_migration_version_idx; Type: INDEX; Schema: public; Owner: halaszdavid
--

CREATE UNIQUE INDEX schema_migration_version_idx ON public.schema_migration USING btree (version);


--
-- PostgreSQL database dump complete
--

