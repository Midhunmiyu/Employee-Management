--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

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
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id bigint NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: employee_employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee_employee (
    id bigint NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    email character varying(255) NOT NULL,
    name character varying(200),
    "position" character varying(100),
    is_active boolean NOT NULL,
    is_admin boolean NOT NULL
);


ALTER TABLE public.employee_employee OWNER TO postgres;

--
-- Name: employee_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.employee_employee ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.employee_employee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: employee_employeecustomfield; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee_employeecustomfield (
    id bigint NOT NULL,
    field_title character varying(100),
    field_value character varying(255),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    employee_id bigint NOT NULL
);


ALTER TABLE public.employee_employeecustomfield OWNER TO postgres;

--
-- Name: employee_employeecustomfield_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.employee_employeecustomfield ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.employee_employeecustomfield_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: token_blacklist_blacklistedtoken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.token_blacklist_blacklistedtoken (
    id bigint NOT NULL,
    blacklisted_at timestamp with time zone NOT NULL,
    token_id bigint NOT NULL
);


ALTER TABLE public.token_blacklist_blacklistedtoken OWNER TO postgres;

--
-- Name: token_blacklist_blacklistedtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.token_blacklist_blacklistedtoken ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.token_blacklist_blacklistedtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: token_blacklist_outstandingtoken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.token_blacklist_outstandingtoken (
    id bigint NOT NULL,
    token text NOT NULL,
    created_at timestamp with time zone,
    expires_at timestamp with time zone NOT NULL,
    user_id bigint,
    jti character varying(255) NOT NULL
);


ALTER TABLE public.token_blacklist_outstandingtoken OWNER TO postgres;

--
-- Name: token_blacklist_outstandingtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.token_blacklist_outstandingtoken ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.token_blacklist_outstandingtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add employee	6	add_employee
22	Can change employee	6	change_employee
23	Can delete employee	6	delete_employee
24	Can view employee	6	view_employee
25	Can add employee custom field	7	add_employeecustomfield
26	Can change employee custom field	7	change_employeecustomfield
27	Can delete employee custom field	7	delete_employeecustomfield
28	Can view employee custom field	7	view_employeecustomfield
29	Can add blacklisted token	8	add_blacklistedtoken
30	Can change blacklisted token	8	change_blacklistedtoken
31	Can delete blacklisted token	8	delete_blacklistedtoken
32	Can view blacklisted token	8	view_blacklistedtoken
33	Can add outstanding token	9	add_outstandingtoken
34	Can change outstanding token	9	change_outstandingtoken
35	Can delete outstanding token	9	delete_outstandingtoken
36	Can view outstanding token	9	view_outstandingtoken
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2024-11-07 19:06:18.217811+05:30	8	madhu@gmail.com	3		6	1
2	2024-11-07 19:06:57.008147+05:30	9	madhu@gmail.com	3		6	1
3	2024-11-07 21:31:32.236618+05:30	11	madhu@gmail.com	3		6	1
4	2024-11-07 21:32:48.718593+05:30	12	madhu@gmail.com	3		6	1
5	2024-11-08 14:16:44.792303+05:30	19	taylorcook@example.com	3		6	1
6	2024-11-08 14:16:44.792303+05:30	18	martinjessica@example.net	3		6	1
7	2024-11-08 14:16:44.792303+05:30	17	whitebrian@example.com	3		6	1
8	2024-11-08 14:16:44.792303+05:30	16	davisjesse@example.net	3		6	1
9	2024-11-08 14:16:44.792303+05:30	15	pjackson@example.com	3		6	1
10	2024-11-08 14:16:44.792303+05:30	14	andradedavid@example.org	3		6	1
11	2024-11-08 14:18:05.507536+05:30	25	zbailey@example.org	3		6	1
12	2024-11-08 14:18:05.507536+05:30	24	allisonthomas@example.net	3		6	1
13	2024-11-08 14:18:05.507536+05:30	23	jenniferwilson@example.net	3		6	1
14	2024-11-08 14:18:05.507536+05:30	22	rebeccaoneal@example.org	3		6	1
15	2024-11-08 14:18:05.507536+05:30	21	kaiserjoshua@example.net	3		6	1
16	2024-11-08 14:18:05.507536+05:30	20	jenningstonya@example.com	3		6	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	employee	employee
7	employee	employeecustomfield
8	token_blacklist	blacklistedtoken
9	token_blacklist	outstandingtoken
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	employee	0001_initial	2024-11-05 22:35:22.243807+05:30
2	contenttypes	0001_initial	2024-11-05 22:35:22.271789+05:30
3	admin	0001_initial	2024-11-05 22:35:22.327627+05:30
4	admin	0002_logentry_remove_auto_add	2024-11-05 22:35:22.334524+05:30
5	admin	0003_logentry_add_action_flag_choices	2024-11-05 22:35:22.342519+05:30
6	contenttypes	0002_remove_content_type_name	2024-11-05 22:35:22.368501+05:30
7	auth	0001_initial	2024-11-05 22:35:22.462559+05:30
8	auth	0002_alter_permission_name_max_length	2024-11-05 22:35:22.477549+05:30
9	auth	0003_alter_user_email_max_length	2024-11-05 22:35:22.489541+05:30
10	auth	0004_alter_user_username_opts	2024-11-05 22:35:22.501535+05:30
11	auth	0005_alter_user_last_login_null	2024-11-05 22:35:22.514528+05:30
12	auth	0006_require_contenttypes_0002	2024-11-05 22:35:22.517525+05:30
13	auth	0007_alter_validators_add_error_messages	2024-11-05 22:35:22.531516+05:30
14	auth	0008_alter_user_username_max_length	2024-11-05 22:35:22.547701+05:30
15	auth	0009_alter_user_last_name_max_length	2024-11-05 22:35:22.559695+05:30
16	auth	0010_alter_group_name_max_length	2024-11-05 22:35:22.581682+05:30
17	auth	0011_update_proxy_permissions	2024-11-05 22:35:22.596917+05:30
18	auth	0012_alter_user_first_name_max_length	2024-11-05 22:35:22.613907+05:30
19	sessions	0001_initial	2024-11-05 22:35:22.645887+05:30
20	employee	0002_employeecustomfield	2024-11-06 18:06:58.126479+05:30
21	employee	0003_remove_employeecustomfield_is_active	2024-11-06 21:07:40.426421+05:30
22	employee	0004_alter_employee_name_alter_employee_position	2024-11-07 20:59:17.929187+05:30
23	token_blacklist	0001_initial	2024-11-08 10:50:11.060935+05:30
24	token_blacklist	0002_outstandingtoken_jti_hex	2024-11-08 10:50:11.109211+05:30
25	token_blacklist	0003_auto_20171017_2007	2024-11-08 10:50:11.130596+05:30
26	token_blacklist	0004_auto_20171017_2013	2024-11-08 10:50:11.153131+05:30
27	token_blacklist	0005_remove_outstandingtoken_jti	2024-11-08 10:50:11.174118+05:30
28	token_blacklist	0006_auto_20171017_2113	2024-11-08 10:50:11.188868+05:30
29	token_blacklist	0007_auto_20171017_2214	2024-11-08 10:50:11.27073+05:30
30	token_blacklist	0008_migrate_to_bigautofield	2024-11-08 10:50:11.356347+05:30
31	token_blacklist	0010_fix_migrate_to_bigautofield	2024-11-08 10:50:11.38233+05:30
32	token_blacklist	0011_linearizes_history	2024-11-08 10:50:11.38533+05:30
33	token_blacklist	0012_alter_outstandingtoken_user	2024-11-08 10:50:11.400322+05:30
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
gsnriik9jmoytoa4hbs62sxmxn5gcwmt	.eJxVjEsOwiAUAO_C2pA-vsWl-56B8B4gVQNJaVfGuxuSLnQ7M5k38-HYiz962vwa2ZUBu_wyDPRMdYj4CPXeOLW6byvykfDTdr60mF63s_0blNDL2ELQOWtJCpwghzFJo6TMMM1ijhacVQRo9aQhK9BZoBZEQAaTMVFa9vkCyS43OQ:1t8YF4:nJkAN5kMSqUPXGFzbUuHhlAekCXPYR3XGG0kWgyAifU	2024-11-20 10:36:06.041915+05:30
\.


--
-- Data for Name: employee_employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee_employee (id, password, last_login, email, name, "position", is_active, is_admin) FROM stdin;
30	pbkdf2_sha256$870000$GHdwb56W7yNWD0sbqQP5d9$4ozrIYvcj4U7HjjhIwO0VL3d0bsmZH9qUrOLt+h8/uU=	\N	nguyenkimberly@example.com	Christopher Gillespie	Public relations officer	t	f
31	pbkdf2_sha256$870000$lYzuWyg0xumiZPTklGll5R$NHr7M2yPkqdih5tGfWOIdE/i6kpcbasFbXelfdh+900=	\N	llyons@example.org	Tasha Cruz	Financial adviser	t	f
1	pbkdf2_sha256$870000$Mgyl9XhqBYsnXCM8OvP56u$wN54ysz8sDBZq+e7dtP9nxngMTvM1zcA+XbZPcW6Zr0=	2024-11-08 14:33:39.424071+05:30	admin@veuz.com			t	t
7	pbkdf2_sha256$870000$SwutSnNGqFTblymxSVuDzf$YXk1RnDkBAtINShbiHvbIieMm2Fa8zL1RJBDin3A7e0=	\N	manu@gmail.com	Manu	React Developer	t	f
6	pbkdf2_sha256$870000$Btr31fyGbunXMDRoTq3YDA$B50+8cf85dHtMsnOjff0xTTu9keKI+bL+qcqIdonSAE=	2024-11-08 14:41:25.305373+05:30	mathew@gmail.com	Mathew Abraham	HR	t	f
2	pbkdf2_sha256$870000$qzv0WnBRV15b9sZKBwnxg5$Bjsb/5yegY9Y7TQB9avEi0CXDeWEYxm9rVHrP7lZqSo=	2024-11-06 11:39:24.882425+05:30	midhun@gamil.com	Midhun	Python Developer	t	f
13	pbkdf2_sha256$870000$Is7WXZy1oPzsGgUo1V1ttB$BcGlUIE19/OTM+Sagfop8ci2tXK2lYjR/bom+wk9uI4=	\N	madhu@gmail.com	.	Wordpress Developer	t	f
3	pbkdf2_sha256$870000$m1hGJQiezf1i6vRdGc5Npf$qCjdqSD00y2kg6Y3hs3wHLk4qV60M+QlYBxb1cFnSm4=	2024-11-06 11:13:53.482607+05:30	manav@gmail.com	Manav	SEO	t	f
4	pbkdf2_sha256$870000$8EM5Grf2FjmoyTGUc6Mz7X$TgjwCuc9QIOYl9ZlgpPGLCsjk4wXE6c1R5AqC6Qgbgk=	\N	anjali@gmail.com	Anjali	Tester	t	f
26	pbkdf2_sha256$870000$v45fZSUVy04cGxAL8MLUyT$EBmWoZL1p/9n8nf6J73cxjhCNDNpQm0Ah2EHo44qy9Y=	\N	otrevino@example.net	Brett Stanley	Commissioning editor	t	f
27	pbkdf2_sha256$870000$vPQnbEPvclT9yoYil0h8uZ$nyzzmUqFrzoxtdzJiyPsboVhs4hgb6HnvkESCArXkYI=	\N	floresheather@example.com	Carla Stanley	Librarian, academic	t	f
28	pbkdf2_sha256$870000$YyJXMRPfrilnGBHwFJvdJs$1Cgp9Wevn4VgBV5rTleJtOqB6xRr8TxyzDiTHTU6wy0=	\N	martinezalexander@example.org	Jeffrey Graham	Publishing copy	t	f
29	pbkdf2_sha256$870000$1dhSQhzIcbZ1GMEQviA7Mw$p9lq51/SrVA1S02usluYMTth0OX4j4QpMM/vaYI1esY=	\N	gibsonclaudia@example.com	Joshua Sullivan	Government social research officer	t	f
\.


--
-- Data for Name: employee_employeecustomfield; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee_employeecustomfield (id, field_title, field_value, created_at, updated_at, employee_id) FROM stdin;
32	Phone	94976703688	2024-11-08 12:06:36.525053+05:30	2024-11-08 12:06:36.525053+05:30	6
\.


--
-- Data for Name: token_blacklist_blacklistedtoken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.token_blacklist_blacklistedtoken (id, blacklisted_at, token_id) FROM stdin;
1	2024-11-08 10:51:43.07569+05:30	1
2	2024-11-08 10:55:19.266988+05:30	2
3	2024-11-08 11:11:13.789455+05:30	3
4	2024-11-08 12:26:45.170658+05:30	4
\.


--
-- Data for Name: token_blacklist_outstandingtoken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.token_blacklist_outstandingtoken (id, token, created_at, expires_at, user_id, jti) FROM stdin;
1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTczMTEyODk5NSwiaWF0IjoxNzMxMDQyNTk1LCJqdGkiOiJjZjI0NmM2NGY2NDU0OGE0ODFjODU5NzExMzJhMDlmZiIsInVzZXJfaWQiOjEzfQ.Fh1pPsUjb8muHf6rJ26iXAfOwLk6sf8ayr6R3eeYolo	\N	2024-11-09 10:39:55+05:30	\N	cf246c64f64548a481c85971132a09ff
2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTczMTEyOTkwMiwiaWF0IjoxNzMxMDQzNTAyLCJqdGkiOiIwYWViN2I0NzA3ODk0NDgxOTYwMjJmYjJmMjNmMzAzOCIsInVzZXJfaWQiOjEzfQ.WpOvAxHZa0ti0BultsTEC9XfyBrdzP1f24BfY_ddc2s	2024-11-08 10:55:02.24373+05:30	2024-11-09 10:55:02+05:30	13	0aeb7b470789448196022fb2f23f3038
3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTczMTEyOTkxOSwiaWF0IjoxNzMxMDQzNTE5LCJqdGkiOiI3MjY3YTI3MDBkOGY0MTZhOTA1OWVhMmU5ZmUxNWUxNyIsInVzZXJfaWQiOjEzfQ.m0aMi1hWQkF7mG1JStarL6JT1-tKmTaWGe5Ox5cDIuc	\N	2024-11-09 10:55:19+05:30	\N	7267a2700d8f416a9059ea2e9fe15e17
4	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTczMTEzMDg5MSwiaWF0IjoxNzMxMDQ0NDkxLCJqdGkiOiIxZDI4MmU4MzI2NTM0NGMxODZjNGQ1ODMzY2ZiNzJmMyIsInVzZXJfaWQiOjEzfQ.ywmsmlZVx6meUbZM3yL_Lm922XXAiWb-NWbKui3cCQw	2024-11-08 11:11:31.147775+05:30	2024-11-09 11:11:31+05:30	13	1d282e83265344c186c4d5833cfb72f3
5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTczMTE0MTA0NCwiaWF0IjoxNzMxMDU0NjQ0LCJqdGkiOiIwMDZiN2ZjMzc0MzI0Y2FhYjY4MTM4NzQ1NmQ2YzRlNyIsInVzZXJfaWQiOjEzfQ.nW-Qao0XfAupqyK2qCM76Iwcu_pLL0vMIQ1WmaDJ2LY	2024-11-08 14:00:44.074564+05:30	2024-11-09 14:00:44+05:30	13	006b7fc374324caab681387456d6c4e7
6	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTczMTE0MTA3MSwiaWF0IjoxNzMxMDU0NjcxLCJqdGkiOiI0MzU2YzFkMjBjMDc0NTE3YjNjN2MwMzQ3ZTMwZTEzNiIsInVzZXJfaWQiOjF9.FJuGDdkxzTVGbGEFOZWTJ4GT4Wo_avhpGEgytboJ6fE	2024-11-08 14:01:11.08084+05:30	2024-11-09 14:01:11+05:30	1	4356c1d20c074517b3c7c0347e30e136
7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTczMTE0MTU0MSwiaWF0IjoxNzMxMDU1MTQxLCJqdGkiOiJhMjc1OTdiZTdhY2U0YTQxOWVhYjBhZTc5ODUxMGE4NCIsInVzZXJfaWQiOjF9.PHomEklVf53NjAY7JkG-1NKD82Ma2qa2XEQxEO--DuQ	2024-11-08 14:09:01.774325+05:30	2024-11-09 14:09:01+05:30	1	a27597be7ace4a419eab0ae798510a84
8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTczMTE0MTU5NywiaWF0IjoxNzMxMDU1MTk3LCJqdGkiOiI4OWRhYTRlYTYxZWM0MDViYTFhNmVkZmRkYmMzNzZmOSIsInVzZXJfaWQiOjF9.et42vOIkqKCY0THIoxudzZMZQgElLEhAMGnf7ktRQNo	2024-11-08 14:09:57.178032+05:30	2024-11-09 14:09:57+05:30	1	89daa4ea61ec405ba1a6edfddbc376f9
9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTczMTE0Mzg2MiwiaWF0IjoxNzMxMDU3NDYyLCJqdGkiOiI0NTM5MGE3NDgzNDA0NDJkODNkYmUwZGE0ZTAzOGQyYiIsInVzZXJfaWQiOjEzfQ.lcqeIW4Kif_silceAmtY-4mVcnlvjXH0UL5Bmzl9O7k	2024-11-08 14:47:42.139599+05:30	2024-11-09 14:47:42+05:30	13	45390a748340442d83dbe0da4e038d2b
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 36, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 16, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 9, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 33, true);


--
-- Name: employee_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employee_employee_id_seq', 31, true);


--
-- Name: employee_employeecustomfield_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employee_employeecustomfield_id_seq', 32, true);


--
-- Name: token_blacklist_blacklistedtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.token_blacklist_blacklistedtoken_id_seq', 4, true);


--
-- Name: token_blacklist_outstandingtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.token_blacklist_outstandingtoken_id_seq', 9, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: employee_employee employee_employee_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_employee
    ADD CONSTRAINT employee_employee_email_key UNIQUE (email);


--
-- Name: employee_employee employee_employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_employee
    ADD CONSTRAINT employee_employee_pkey PRIMARY KEY (id);


--
-- Name: employee_employeecustomfield employee_employeecustomfield_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_employeecustomfield
    ADD CONSTRAINT employee_employeecustomfield_pkey PRIMARY KEY (id);


--
-- Name: token_blacklist_blacklistedtoken token_blacklist_blacklistedtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken
    ADD CONSTRAINT token_blacklist_blacklistedtoken_pkey PRIMARY KEY (id);


--
-- Name: token_blacklist_blacklistedtoken token_blacklist_blacklistedtoken_token_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken
    ADD CONSTRAINT token_blacklist_blacklistedtoken_token_id_key UNIQUE (token_id);


--
-- Name: token_blacklist_outstandingtoken token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken
    ADD CONSTRAINT token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq UNIQUE (jti);


--
-- Name: token_blacklist_outstandingtoken token_blacklist_outstandingtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken
    ADD CONSTRAINT token_blacklist_outstandingtoken_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: employee_employee_email_29cdd800_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX employee_employee_email_29cdd800_like ON public.employee_employee USING btree (email varchar_pattern_ops);


--
-- Name: employee_employeecustomfield_employee_id_abe43f97; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX employee_employeecustomfield_employee_id_abe43f97 ON public.employee_employeecustomfield USING btree (employee_id);


--
-- Name: token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_like ON public.token_blacklist_outstandingtoken USING btree (jti varchar_pattern_ops);


--
-- Name: token_blacklist_outstandingtoken_user_id_83bc629a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX token_blacklist_outstandingtoken_user_id_83bc629a ON public.token_blacklist_outstandingtoken USING btree (user_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_employee_employee_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_employee_employee_id FOREIGN KEY (user_id) REFERENCES public.employee_employee(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: employee_employeecustomfield employee_employeecus_employee_id_abe43f97_fk_employee_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_employeecustomfield
    ADD CONSTRAINT employee_employeecus_employee_id_abe43f97_fk_employee_ FOREIGN KEY (employee_id) REFERENCES public.employee_employee(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: token_blacklist_blacklistedtoken token_blacklist_blacklistedtoken_token_id_3cc7fe56_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken
    ADD CONSTRAINT token_blacklist_blacklistedtoken_token_id_3cc7fe56_fk FOREIGN KEY (token_id) REFERENCES public.token_blacklist_outstandingtoken(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: token_blacklist_outstandingtoken token_blacklist_outs_user_id_83bc629a_fk_employee_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken
    ADD CONSTRAINT token_blacklist_outs_user_id_83bc629a_fk_employee_ FOREIGN KEY (user_id) REFERENCES public.employee_employee(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--
