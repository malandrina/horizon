--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

DROP INDEX public.signersaccount;
DROP INDEX public.priceindex;
DROP INDEX public.paysissuerindex;
DROP INDEX public.ledgersbyseq;
DROP INDEX public.getsissuerindex;
DROP INDEX public.accountlines;
DROP INDEX public.accountbalances;
ALTER TABLE ONLY public.txhistory DROP CONSTRAINT txhistory_pkey;
ALTER TABLE ONLY public.txhistory DROP CONSTRAINT txhistory_ledgerseq_txindex_key;
ALTER TABLE ONLY public.trustlines DROP CONSTRAINT trustlines_pkey;
ALTER TABLE ONLY public.storestate DROP CONSTRAINT storestate_pkey;
ALTER TABLE ONLY public.signers DROP CONSTRAINT signers_pkey;
ALTER TABLE ONLY public.peers DROP CONSTRAINT peers_pkey;
ALTER TABLE ONLY public.offers DROP CONSTRAINT offers_pkey;
ALTER TABLE ONLY public.ledgerheaders DROP CONSTRAINT ledgerheaders_pkey;
ALTER TABLE ONLY public.ledgerheaders DROP CONSTRAINT ledgerheaders_ledgerseq_key;
ALTER TABLE ONLY public.accounts DROP CONSTRAINT accounts_pkey;
DROP TABLE public.txhistory;
DROP TABLE public.trustlines;
DROP TABLE public.storestate;
DROP TABLE public.signers;
DROP TABLE public.peers;
DROP TABLE public.offers;
DROP TABLE public.ledgerheaders;
DROP TABLE public.accounts;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE accounts (
    accountid character varying(51) NOT NULL,
    balance bigint NOT NULL,
    seqnum bigint NOT NULL,
    numsubentries integer NOT NULL,
    inflationdest character varying(51),
    homedomain character varying(32),
    thresholds text,
    flags integer NOT NULL,
    CONSTRAINT accounts_balance_check CHECK ((balance >= 0)),
    CONSTRAINT accounts_numsubentries_check CHECK ((numsubentries >= 0))
);


--
-- Name: ledgerheaders; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ledgerheaders (
    ledgerhash character(64) NOT NULL,
    prevhash character(64) NOT NULL,
    bucketlisthash character(64) NOT NULL,
    ledgerseq integer,
    closetime bigint NOT NULL,
    data text NOT NULL,
    CONSTRAINT ledgerheaders_closetime_check CHECK ((closetime >= 0)),
    CONSTRAINT ledgerheaders_ledgerseq_check CHECK ((ledgerseq >= 0))
);


--
-- Name: offers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE offers (
    accountid character varying(51) NOT NULL,
    offerid bigint NOT NULL,
    paysalphanumcurrency character varying(4),
    paysissuer character varying(51),
    getsalphanumcurrency character varying(4),
    getsissuer character varying(51),
    amount bigint NOT NULL,
    pricen integer NOT NULL,
    priced integer NOT NULL,
    price bigint NOT NULL,
    CONSTRAINT offers_amount_check CHECK ((amount >= 0)),
    CONSTRAINT offers_offerid_check CHECK ((offerid >= 0))
);


--
-- Name: peers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE peers (
    ip character varying(15) NOT NULL,
    port integer DEFAULT 0 NOT NULL,
    nextattempt timestamp without time zone NOT NULL,
    numfailures integer DEFAULT 0 NOT NULL,
    rank integer DEFAULT 0 NOT NULL,
    CONSTRAINT peers_numfailures_check CHECK ((numfailures >= 0)),
    CONSTRAINT peers_port_check CHECK (((port > 0) AND (port <= 65535))),
    CONSTRAINT peers_rank_check CHECK ((rank >= 0))
);


--
-- Name: signers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE signers (
    accountid character varying(51) NOT NULL,
    publickey character varying(51) NOT NULL,
    weight integer NOT NULL
);


--
-- Name: storestate; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE storestate (
    statename character(32) NOT NULL,
    state text
);


--
-- Name: trustlines; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE trustlines (
    accountid character varying(51) NOT NULL,
    issuer character varying(51) NOT NULL,
    alphanumcurrency character varying(4) NOT NULL,
    tlimit bigint DEFAULT 0 NOT NULL,
    balance bigint DEFAULT 0 NOT NULL,
    flags integer NOT NULL,
    CONSTRAINT trustlines_balance_check CHECK ((balance >= 0)),
    CONSTRAINT trustlines_tlimit_check CHECK ((tlimit >= 0))
);


--
-- Name: txhistory; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE txhistory (
    txid character(64) NOT NULL,
    ledgerseq integer NOT NULL,
    txindex integer NOT NULL,
    txbody text NOT NULL,
    txresult text NOT NULL,
    txmeta text NOT NULL,
    CONSTRAINT txhistory_ledgerseq_check CHECK ((ledgerseq >= 0))
);


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY accounts (accountid, balance, seqnum, numsubentries, inflationdest, homedomain, thresholds, flags) FROM stdin;
gspbxqXqEUZkiCCEFFCN9Vu4FLucdjLLdLcsV6E82Qc1T7ehsTC	99999994999999950	5	0	\N		01000000	0
gT9jHoPKoErFwXavCrDYLkSVcVd9oyVv94ydrq6FnPMXpKHPTA	999999990	12884901889	1	\N		01000000	0
gsDu9aPmZy7uH5FzmfJKW7jWyXGHjSWbcb8k6UH743pYzaxWcWd	999999980	12884901890	0	\N		01000000	0
gsPsm67nNK8HtwMedJZFki3jAEKgg1s4nRKrHREFqTzT6ErzBiq	999999980	12884901890	0	\N		01000000	0
gqdUHrgHUp8uMb74HiQvYztze2ffLhVXpPwj7gEZiJRa4jhCXQ	999999970	12884901891	3	\N		01000000	0
gsKuurNYgtBhTSFfsCaWqNb3Ze5Je9csKTSLfjo8Ko2b1f66ayZ	999999980	12884901890	1	\N		01000000	0
\.


--
-- Data for Name: ledgerheaders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY ledgerheaders (ledgerhash, prevhash, bucketlisthash, ledgerseq, closetime, data) FROM stdin;
41310a0181a3a82ff13c049369504e978734cf17da1baf02f7e4d881e8608371	0000000000000000000000000000000000000000000000000000000000000000	e71064e28d0740ac27cf07b267200ea9b8916ad1242195c015fa3012086588d3	1	0	AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA5xBk4o0HQKwnzweyZyAOqbiRatEkIZXAFfowEghliNMAAAABAAAAAAAAAAABY0V4XYoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACgCYloA=
448e8168257d4c443805b6b8e89df7435a0d819e918c7fcf60f1578f9e9286cc	41310a0181a3a82ff13c049369504e978734cf17da1baf02f7e4d881e8608371	24128cf784e4c94f58a5a72a5036a54e82b2e37c1b1b327bd8af8ab48684abf6	2	1433459600	QTEKAYGjqC/xPASTaVBOl4c0zxfaG68C9+TYgehgg3HWnizXf2VvYXCoygkt/wDezda8dXZTRIUXo6e9UAqQU+OwxEKY/BwUmvv0yJlvuSQnrkHkZJuTTKSVmRt4UrhVJBKM94TkyU9YpacqUDalToKy43wbGzJ72K+KtIaEq/YAAAACAAAAAFVw25ABY0V4XYoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACgCYloA=
fb5b4be9a4e643a63d57de8e4558b5408dc84c905cc50a997d10840ca13ede24	448e8168257d4c443805b6b8e89df7435a0d819e918c7fcf60f1578f9e9286cc	b6596afc04a036bac4e29faaea8e31ad8df7fc56dbbd9b742c3b835b58638142	3	1433459601	RI6BaCV9TEQ4Bba46J33Q1oNgZ6RjH/PYPFXj56ShszQfpY2TLswNlWZXey7mQaAgAD7zb8KuBZu1I87KPSEEGrKpB1mPtKNjm69oLOFJzqYRjErEVbt8bSoUP3x3sRDtllq/ASgNrrE4p+q6o4xrY33/FbbvZt0LDuDW1hjgUIAAAADAAAAAFVw25EBY0V4XYoAAAAAAAAAAAAyAAAAAAAAAAAAAAAAAAAACgCYloA=
fe875ab21cebbdbf28d910ae8d56a9a5056645d301059ac366fd132918eb1a7b	fb5b4be9a4e643a63d57de8e4558b5408dc84c905cc50a997d10840ca13ede24	3f2afb2d22daefefa5af61000d34e4c10addecd714d1b506e268a3638fc40bf1	4	1433459602	+1tL6aTmQ6Y9V96ORVi1QI3ITJBcxQqZfRCEDKE+3iTjYmlqtVhHpfJX7RBS6UX81LXdiNUVA3ZIRbeSSp8Kmkb+Jr01SrtuS064ABE6K3L2AUY3pvQF/kagrfeN8Y1CPyr7LSLa7++lr2EADTTkwQrd7NcU0bUG4mijY4/EC/EAAAAEAAAAAFVw25IBY0V4XYoAAAAAAAAAAABaAAAAAAAAAAAAAAAAAAAACgCYloA=
8eab91136664fecf9ee892b6995150b71145a73a688f792af7ea9773676a8b26	fe875ab21cebbdbf28d910ae8d56a9a5056645d301059ac366fd132918eb1a7b	8c51417dce2c6079880ad8fc926b3f217f965b5f4404829ed9030ca205f370e5	5	1433459603	/odashzrvb8o2RCujVappQVmRdMBBZrDZv0TKRjrGnuhq/1su0Bb6wEucGCk5djmIPCZPXBcx+lfSmwDrCdFzUV53KsKYmBtHThZh9yEhAYzw41sLwRku0J0vEXzfeyGjFFBfc4sYHmICtj8kms/IX+WW19EBIKe2QMMogXzcOUAAAAFAAAAAFVw25MBY0V4XYoAAAAAAAAAAACCAAAAAAAAAAAAAAAAAAAACgCYloA=
bf548ad6c3295f649bf94293eac56ddc58e4ec1f9460cf04080e75871c25de08	8eab91136664fecf9ee892b6995150b71145a73a688f792af7ea9773676a8b26	7b3b670b734ce22e8f97119fb47081532c875a240c8812cd31116811e5d26120	6	1433459604	jquRE2Zk/s+e6JK2mVFQtxFFpzpoj3kq9+qXc2dqiyaPw2c6F7xGqDKHmVZMUF+Ip+Vss+x+ispqr+kDZrw2tMe9wagov3GAmQlX5d4cQoRfKr1zCY6HBXQZXIhvEmukeztnC3NM4i6PlxGftHCBUyyHWiQMiBLNMRFoEeXSYSAAAAAGAAAAAFVw25QBY0V4XYoAAAAAAAAAAACMAAAAAAAAAAAAAAABAAAACgCYloA=
ef705d4be6f8d1ddf09dd1436154791c564105c62bf98e7faf921d7a816133f3	bf548ad6c3295f649bf94293eac56ddc58e4ec1f9460cf04080e75871c25de08	14006953f69d810d7ddb7e97ef3ba43d50ac9c9c415c67196928dd8099669232	7	1433459605	v1SK1sMpX2Sb+UKT6sVt3Fjk7B+UYM8ECA51hxwl3gjelfQ9T8Mv1Kn1XCt9qQJoB3X5jfC+YINKo75y0n1fn9POYtpwtFkIIaPn81ljo0bnkteCSpcGZiPpXoqJQMvnFABpU/adgQ19236X7zukPVCsnJxBXGcZaSjdgJlmkjIAAAAHAAAAAFVw25UBY0V4XYoAAAAAAAAAAACWAAAAAAAAAAAAAAABAAAACgCYloA=
\.


--
-- Data for Name: offers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY offers (accountid, offerid, paysalphanumcurrency, paysissuer, getsalphanumcurrency, getsissuer, amount, pricen, priced, price) FROM stdin;
gqdUHrgHUp8uMb74HiQvYztze2ffLhVXpPwj7gEZiJRa4jhCXQ	1	USD	gsPsm67nNK8HtwMedJZFki3jAEKgg1s4nRKrHREFqTzT6ErzBiq	EUR	gsDu9aPmZy7uH5FzmfJKW7jWyXGHjSWbcb8k6UH743pYzaxWcWd	199999990	1	1	10000000
\.


--
-- Data for Name: peers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY peers (ip, port, nextattempt, numfailures, rank) FROM stdin;
\.


--
-- Data for Name: signers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY signers (accountid, publickey, weight) FROM stdin;
\.


--
-- Data for Name: storestate; Type: TABLE DATA; Schema: public; Owner: -
--

COPY storestate (statename, state) FROM stdin;
databaseinitialized             	true
forcescponnextlaunch            	false
lastclosedledger                	ef705d4be6f8d1ddf09dd1436154791c564105c62bf98e7faf921d7a816133f3
historyarchivestate             	{\n    "version": 0,\n    "currentLedger": 7,\n    "currentBuckets": [\n        {\n            "curr": "7e1a84c94dcef98503222a4310f5b7f5e998758fe99dd6ab091bb998822218e0",\n            "next": {\n                "state": 0\n            },\n            "snap": "bf491e8084efa39267821a65fac82b0709dfd75fbe39ef03a84b7c9158f29407"\n        },\n        {\n            "curr": "f002aca0a60842463a336962458d95511075b503e116dae1c982a5be7fdbc7d4",\n            "next": {\n                "state": 1,\n                "output": "bf491e8084efa39267821a65fac82b0709dfd75fbe39ef03a84b7c9158f29407"\n            },\n            "snap": "0000000000000000000000000000000000000000000000000000000000000000"\n        },\n        {\n            "curr": "0000000000000000000000000000000000000000000000000000000000000000",\n            "next": {\n                "state": 0\n            },\n            "snap": "0000000000000000000000000000000000000000000000000000000000000000"\n        },\n        {\n            "curr": "0000000000000000000000000000000000000000000000000000000000000000",\n            "next": {\n                "state": 0\n            },\n            "snap": "0000000000000000000000000000000000000000000000000000000000000000"\n        },\n        {\n            "curr": "0000000000000000000000000000000000000000000000000000000000000000",\n            "next": {\n                "state": 0\n            },\n            "snap": "0000000000000000000000000000000000000000000000000000000000000000"\n        },\n        {\n            "curr": "0000000000000000000000000000000000000000000000000000000000000000",\n            "next": {\n                "state": 0\n            },\n            "snap": "0000000000000000000000000000000000000000000000000000000000000000"\n        },\n        {\n            "curr": "0000000000000000000000000000000000000000000000000000000000000000",\n            "next": {\n                "state": 0\n            },\n            "snap": "0000000000000000000000000000000000000000000000000000000000000000"\n        },\n        {\n            "curr": "0000000000000000000000000000000000000000000000000000000000000000",\n            "next": {\n                "state": 0\n            },\n            "snap": "0000000000000000000000000000000000000000000000000000000000000000"\n        },\n        {\n            "curr": "0000000000000000000000000000000000000000000000000000000000000000",\n            "next": {\n                "state": 0\n            },\n            "snap": "0000000000000000000000000000000000000000000000000000000000000000"\n        },\n        {\n            "curr": "0000000000000000000000000000000000000000000000000000000000000000",\n            "next": {\n                "state": 0\n            },\n            "snap": "0000000000000000000000000000000000000000000000000000000000000000"\n        },\n        {\n            "curr": "0000000000000000000000000000000000000000000000000000000000000000",\n            "next": {\n                "state": 0\n            },\n            "snap": "0000000000000000000000000000000000000000000000000000000000000000"\n        }\n    ]\n}
\.


--
-- Data for Name: trustlines; Type: TABLE DATA; Schema: public; Owner: -
--

COPY trustlines (accountid, issuer, alphanumcurrency, tlimit, balance, flags) FROM stdin;
gT9jHoPKoErFwXavCrDYLkSVcVd9oyVv94ydrq6FnPMXpKHPTA	gsDu9aPmZy7uH5FzmfJKW7jWyXGHjSWbcb8k6UH743pYzaxWcWd	EUR	9223372036854775807	1000000010	1
gqdUHrgHUp8uMb74HiQvYztze2ffLhVXpPwj7gEZiJRa4jhCXQ	gsPsm67nNK8HtwMedJZFki3jAEKgg1s4nRKrHREFqTzT6ErzBiq	USD	9223372036854775807	200000010	1
gqdUHrgHUp8uMb74HiQvYztze2ffLhVXpPwj7gEZiJRa4jhCXQ	gsDu9aPmZy7uH5FzmfJKW7jWyXGHjSWbcb8k6UH743pYzaxWcWd	EUR	9223372036854775807	199999990	1
gsKuurNYgtBhTSFfsCaWqNb3Ze5Je9csKTSLfjo8Ko2b1f66ayZ	gsPsm67nNK8HtwMedJZFki3jAEKgg1s4nRKrHREFqTzT6ErzBiq	USD	9223372036854775807	999999990	1
\.


--
-- Data for Name: txhistory; Type: TABLE DATA; Schema: public; Owner: -
--

COPY txhistory (txid, ledgerseq, txindex, txbody, txresult, txmeta) FROM stdin;
ab38509dc9e16c08b084d7f7279fd45f5f4d348ab3b2ed9877c697beaa7e4108	3	1	iZsoQO1WNsVt3F8Usjl1958bojiNJpTkxW7N3clg5e8AAAAKAAAAAAAAAAEAAAAAAAAAAAAAAAEAAAAAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAADuaygAAAAABiZsoQM3TFsRujhDB2Rc814MNXNntPMftJFqeA+wl3uJSSrsP9QG019df7DolzxdnIIXjdB6/KCUrlfA9bRI0ztxEwAw=	qzhQncnhbAiwhNf3J5/UX19NNIqzsu2Yd8aXvqp+QQgAAAAAAAAACgAAAAAAAAABAAAAAAAAAAAAAAAA	AAAAAgAAAAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAAAO5rKAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAQAAAACJmyhA7VY2xW3cXxSyOXX3nxuiOI0mlOTFbs3dyWDl7wFjRXgh7zX2AAAAAAAAAAEAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAA=
88d85fff231b69afb52095b55f0e5d41a860036829bfdad02aa772f47d0ec5de	3	2	iZsoQO1WNsVt3F8Usjl1958bojiNJpTkxW7N3clg5e8AAAAKAAAAAAAAAAIAAAAAAAAAAAAAAAEAAAAAAAAAAKD8GPxXf3CMjVKv3qhzs6au2HaMHH0s5B32RVUQithJAAAAADuaygAAAAABiZsoQLgd+spR1dFr7zdELyadC1y/28BC78oRG80QBGwpeCtRAVmbrOZ6MPvwHNIGbapZD8lEfiVsTP6F0hqtAXXusgU=	iNhf/yMbaa+1IJW1Xw5dQahgA2gpv9rQKqdy9H0Oxd4AAAAAAAAACgAAAAAAAAABAAAAAAAAAAAAAAAA	AAAAAgAAAAAAAAAAoPwY/Fd/cIyNUq/eqHOzpq7YdowcfSzkHfZFVRCK2EkAAAAAO5rKAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAQAAAACJmyhA7VY2xW3cXxSyOXX3nxuiOI0mlOTFbs3dyWDl7wFjRXfmVGvsAAAAAAAAAAIAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAA=
0971ddff00734a3b5741023c6200502e887419d57032c76cacb89d9d9860e54a	3	3	iZsoQO1WNsVt3F8Usjl1958bojiNJpTkxW7N3clg5e8AAAAKAAAAAAAAAAMAAAAAAAAAAAAAAAEAAAAAAAAAAG5oJtVdnYOVdZqtXpTHBtbcY0mCmfcBIKEgWnlvFIhaAAAAADuaygAAAAABiZsoQA/132EALcixXlz4RKdR2WYmz8hwcLxKBcOLKiQEEVDxQzedQRMtVTgd2ZemhI45GMbPaki9sDzQOVgpzoK9SQE=	CXHd/wBzSjtXQQI8YgBQLoh0GdVwMsdsrLidnZhg5UoAAAAAAAAACgAAAAAAAAABAAAAAAAAAAAAAAAA	AAAAAgAAAAAAAAAAbmgm1V2dg5V1mq1elMcG1txjSYKZ9wEgoSBaeW8UiFoAAAAAO5rKAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAQAAAACJmyhA7VY2xW3cXxSyOXX3nxuiOI0mlOTFbs3dyWDl7wFjRXequaHiAAAAAAAAAAMAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAA=
527a9354ca0029fa8d18da6a6772638501bccd143b743764135ce5bb3396c53b	3	4	iZsoQO1WNsVt3F8Usjl1958bojiNJpTkxW7N3clg5e8AAAAKAAAAAAAAAAQAAAAAAAAAAAAAAAEAAAAAAAAAADtgvwDuOWAQ97R1RTtUdwNDHpD/CUepzdQPXlonciLVAAAAADuaygAAAAABiZsoQKkA3ZoTTDVaocflstyylSaRLKlbvEnxuqY8+Exl+pc7WEQPtabX8qHgy7J+Wjs1ks3P3Us+MKNa+AnXrDVt8w0=	UnqTVMoAKfqNGNpqZ3JjhQG8zRQ7dDdkE1zluzOWxTsAAAAAAAAACgAAAAAAAAABAAAAAAAAAAAAAAAA	AAAAAgAAAAAAAAAAO2C/AO45YBD3tHVFO1R3A0MekP8JR6nN1A9eWidyItUAAAAAO5rKAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAQAAAACJmyhA7VY2xW3cXxSyOXX3nxuiOI0mlOTFbs3dyWDl7wFjRXdvHtfYAAAAAAAAAAQAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAA=
928b1c9a45888f7fb5a55a5e28a63f20da17a9cb4054c0f8329b7405c5aea71b	3	5	iZsoQO1WNsVt3F8Usjl1958bojiNJpTkxW7N3clg5e8AAAAKAAAAAAAAAAUAAAAAAAAAAAAAAAEAAAAAAAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAADuaygAAAAABiZsoQBVT3/FpPnSFEm75dAWdN0LUm3k2IiwsgKRJcM65Xo2KDazdqhKgT/UjEf+Kt/BvKsJJUrHtV2gN3mkQMTHm9w0=	koscmkWIj3+1pVpeKKY/INoXqctAVMD4Mpt0BcWupxsAAAAAAAAACgAAAAAAAAABAAAAAAAAAAAAAAAA	AAAAAgAAAAAAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAAAO5rKAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAQAAAACJmyhA7VY2xW3cXxSyOXX3nxuiOI0mlOTFbs3dyWDl7wFjRXczhA3OAAAAAAAAAAUAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAA=
9f9a64b131f6c9d25174c211f774fb65723134925caba4b42cb4ca9effd82b4b	4	1	O2C/AO45YBD3tHVFO1R3A0MekP8JR6nN1A9eWidyItUAAAAKAAAAAwAAAAEAAAAAAAAAAAAAAAEAAAAAAAAABQAAAAFFVVIAoPwY/Fd/cIyNUq/eqHOzpq7YdowcfSzkHfZFVRCK2El//////////wAAAAE7YL8A+aBfJk+0h419nfo+DZkzreSTlIY1mnIHK4nYnD5EPBjWB+fW+ElH6P2OKWDcu8JycC7hH7BULUROIps/UraABg==	n5pksTH2ydJRdMIR93T7ZXIxNJJcq6S0LLTKnv/YK0sAAAAAAAAACgAAAAAAAAABAAAAAAAAAAUAAAAA	AAAAAgAAAAAAAAABO2C/AO45YBD3tHVFO1R3A0MekP8JR6nN1A9eWidyItUAAAABRVVSAKD8GPxXf3CMjVKv3qhzs6au2HaMHH0s5B32RVUQithJAAAAAAAAAAB//////////wAAAAEAAAABAAAAADtgvwDuOWAQ97R1RTtUdwNDHpD/CUepzdQPXlonciLVAAAAADuayfYAAAADAAAAAQAAAAEAAAAAAAAAAAEAAAAAAAAAAAAAAA==
dcaf1b8d58bd76167154c04ad0c310b3d919a255f4b476c8bb7ee762c5d3e3c2	4	2	bmgm1V2dg5V1mq1elMcG1txjSYKZ9wEgoSBaeW8UiFoAAAAKAAAAAwAAAAEAAAAAAAAAAAAAAAEAAAAAAAAABQAAAAFVU0QAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe9//////////wAAAAFuaCbVtbQvGPXCCFatP4VaT8PfIRDwHp0uHtlA0LMIAMASqt6zZ0lIzkLA7W2lH14wDDW+AzliMHDJCVrpMYCMG8doAQ==	3K8bjVi9dhZxVMBK0MMQs9kZolX0tHbIu37nYsXT48IAAAAAAAAACgAAAAAAAAABAAAAAAAAAAUAAAAA	AAAAAgAAAAAAAAABbmgm1V2dg5V1mq1elMcG1txjSYKZ9wEgoSBaeW8UiFoAAAABVVNEALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAAAAAAAB//////////wAAAAEAAAABAAAAAG5oJtVdnYOVdZqtXpTHBtbcY0mCmfcBIKEgWnlvFIhaAAAAADuayfYAAAADAAAAAQAAAAEAAAAAAAAAAAEAAAAAAAAAAAAAAA==
87a445ed06c79066dbb7bc3590271091008a859f1a89ac16df336f8a3695922f	4	3	rqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAAKAAAAAwAAAAEAAAAAAAAAAAAAAAEAAAAAAAAABQAAAAFVU0QAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe9//////////wAAAAGuo3ot9c0nvpho6+8IB5dVUv/rCwPzGDS6vf6F3mcg6/SqpSgmK8LKOxx1I5mJuemKaHxWiOiRvsCJi4eqhIlRtozrCw==	h6RF7QbHkGbbt7w1kCcQkQCKhZ8aiawW3zNvijaVki8AAAAAAAAACgAAAAAAAAABAAAAAAAAAAUAAAAA	AAAAAgAAAAAAAAABrqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAABVVNEALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAAAAAAAB//////////wAAAAEAAAABAAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAADuayfYAAAADAAAAAQAAAAEAAAAAAAAAAAEAAAAAAAAAAAAAAA==
5acd6fddfaeb11ed332927d74087babdbcc2b3ca86168376a42207b6c0d0d644	4	4	bmgm1V2dg5V1mq1elMcG1txjSYKZ9wEgoSBaeW8UiFoAAAAKAAAAAwAAAAIAAAAAAAAAAAAAAAEAAAAAAAAABQAAAAFFVVIAoPwY/Fd/cIyNUq/eqHOzpq7YdowcfSzkHfZFVRCK2El//////////wAAAAFuaCbV/w/aO1Z1Srfv4Bmx20H+iho/G16zhDeE77eAzwR8Gzg0Suj1NLMdN4Aq8Ds4V0Tr0y3a5tgyktWPNPSdgY/XCg==	Ws1v3frrEe0zKSfXQIe6vbzCs8qGFoN2pCIHtsDQ1kQAAAAAAAAACgAAAAAAAAABAAAAAAAAAAUAAAAA	AAAAAgAAAAAAAAABbmgm1V2dg5V1mq1elMcG1txjSYKZ9wEgoSBaeW8UiFoAAAABRVVSAKD8GPxXf3CMjVKv3qhzs6au2HaMHH0s5B32RVUQithJAAAAAAAAAAB//////////wAAAAEAAAABAAAAAG5oJtVdnYOVdZqtXpTHBtbcY0mCmfcBIKEgWnlvFIhaAAAAADuayewAAAADAAAAAgAAAAIAAAAAAAAAAAEAAAAAAAAAAAAAAA==
f97bc27bb24e9a9441deb32ef52ac5e3df55e876f2d0f2be80b356e9177cb58b	5	1	oPwY/Fd/cIyNUq/eqHOzpq7YdowcfSzkHfZFVRCK2EkAAAAKAAAAAwAAAAEAAAAAAAAAAAAAAAEAAAAAAAAAAW5oJtVdnYOVdZqtXpTHBtbcY0mCmfcBIKEgWnlvFIhaAAAAAUVVUgCg/Bj8V39wjI1Sr96oc7Omrth2jBx9LOQd9kVVEIrYSQAAAAAL68IAAAAAAaD8GPxTZrVZItVtqkO7eX6CRtNRNC0gHqyF30GGd0TOXGjg+GFF7Moh7yiLJzVLrVsY1Y9wxze6li5VQCckt3tK/TYP	+XvCe7JOmpRB3rMu9SrF499V6Hby0PK+gLNW6Rd8tYsAAAAAAAAACgAAAAAAAAABAAAAAAAAAAEAAAAA	AAAAAgAAAAEAAAAAoPwY/Fd/cIyNUq/eqHOzpq7YdowcfSzkHfZFVRCK2EkAAAAAO5rJ9gAAAAMAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAQAAAAFuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAAAFFVVIAoPwY/Fd/cIyNUq/eqHOzpq7YdowcfSzkHfZFVRCK2EkAAAAAC+vCAH//////////AAAAAQ==
dc94538a35e5b30387324ce287fc96946c1a010c4ae252dad5ed1c7bec88916f	5	2	tbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAAKAAAAAwAAAAEAAAAAAAAAAAAAAAEAAAAAAAAAAa6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAAVVTRAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAA7msoAAAAAAbW4F0dlh95CDN/AN8YPDQefU7vwY8fRu1sXubGhwqtpQn8RharQSansGY4B5pUdtelbIKyETWimdBm2XtdamaNqrqgI	3JRTijXlswOHMkzih/yWlGwaAQxK4lLa1e0ce+yIkW8AAAAAAAAACgAAAAAAAAABAAAAAAAAAAEAAAAA	AAAAAgAAAAEAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAAAO5rJ9gAAAAMAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAQAAAAGuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAFVU0QAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAAAO5rKAH//////////AAAAAQ==
cb8eaeb1850b5058b33eb948b05b455a381de250c54671412225993a6f3fd2df	5	3	oPwY/Fd/cIyNUq/eqHOzpq7YdowcfSzkHfZFVRCK2EkAAAAKAAAAAwAAAAIAAAAAAAAAAAAAAAEAAAAAAAAAATtgvwDuOWAQ97R1RTtUdwNDHpD/CUepzdQPXlonciLVAAAAAUVVUgCg/Bj8V39wjI1Sr96oc7Omrth2jBx9LOQd9kVVEIrYSQAAAAA7msoAAAAAAaD8GPzZFvjOiPgMFvEVJ0z9FxizYQGWbjkUYg9pZKVxHaNMEN71VuaP+lQbR7pQgchwQCAOt7bybH/29B6N+0hTmG4I	y46usYULUFizPrlIsFtFWjgd4lDFRnFBIiWZOm8/0t8AAAAAAAAACgAAAAAAAAABAAAAAAAAAAEAAAAA	AAAAAgAAAAEAAAAAoPwY/Fd/cIyNUq/eqHOzpq7YdowcfSzkHfZFVRCK2EkAAAAAO5rJ7AAAAAMAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAQAAAAE7YL8A7jlgEPe0dUU7VHcDQx6Q/wlHqc3UD15aJ3Ii1QAAAAFFVVIAoPwY/Fd/cIyNUq/eqHOzpq7YdowcfSzkHfZFVRCK2EkAAAAAO5rKAH//////////AAAAAQ==
49cfaf8425c1a3bf2db73da7c5bf95ebbc7ca422c1a65bc060f08529c5305cca	5	4	tbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAAKAAAAAwAAAAIAAAAAAAAAAAAAAAEAAAAAAAAAAW5oJtVdnYOVdZqtXpTHBtbcY0mCmfcBIKEgWnlvFIhaAAAAAVVTRAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAAL68IAAAAAAbW4F0ftNLTfBmV0GMIxDCdMpcLXR1icebi2q9rV6dEqbko7ImUllVqVdaH87NVRfXnsGsoYyPCtF/BRfMvWmBQASZkE	Sc+vhCXBo78ttz2nxb+V67x8pCLBplvAYPCFKcUwXMoAAAAAAAAACgAAAAAAAAABAAAAAAAAAAEAAAAA	AAAAAgAAAAEAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAAAO5rJ7AAAAAMAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAQAAAAFuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAAAFVU0QAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAAAC+vCAH//////////AAAAAQ==
dffaa6b14246bb4cc3ab8ac414aec9cb93e86003cb22ff1297b3fe4623974d98	6	1	bmgm1V2dg5V1mq1elMcG1txjSYKZ9wEgoSBaeW8UiFoAAAAKAAAAAwAAAAMAAAAAAAAAAAAAAAEAAAAAAAAAAwAAAAFFVVIAoPwY/Fd/cIyNUq/eqHOzpq7YdowcfSzkHfZFVRCK2EkAAAABVVNEALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAAAvrwgAAAAABAAAAAQAAAAAAAAAAAAAAAW5oJtUOdlmbqofTBGjLhS8PRBlb63OP8NeOpL+MWAijhCcrUnfi59EBpnE+PGr+eR0OqWKmB8jv4CbAOdeM311fFrUM	3/qmsUJGu0zDq4rEFK7Jy5PoYAPLIv8Sl7P+RiOXTZgAAAAAAAAACgAAAAAAAAABAAAAAAAAAAMAAAAAAAAAAAAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAAAAAAAABAAAAAUVVUgCg/Bj8V39wjI1Sr96oc7Omrth2jBx9LOQd9kVVEIrYSQAAAAFVU0QAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAAAC+vCAAAAAAEAAAAB	AAAAAgAAAAAAAAACbmgm1V2dg5V1mq1elMcG1txjSYKZ9wEgoSBaeW8UiFoAAAAAAAAAAQAAAAFFVVIAoPwY/Fd/cIyNUq/eqHOzpq7YdowcfSzkHfZFVRCK2EkAAAABVVNEALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAAAvrwgAAAAABAAAAAQAAAAEAAAAAbmgm1V2dg5V1mq1elMcG1txjSYKZ9wEgoSBaeW8UiFoAAAAAO5rJ4gAAAAMAAAADAAAAAwAAAAAAAAAAAQAAAAAAAAAAAAAA
be7a12b20365db042bb64eda66494bc8aeb69a70fbdca1ce38f3471dc2b7b5fe	7	1	rqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAAKAAAAAwAAAAIAAAAAAAAAAAAAAAEAAAAAAAAAAgAAAAFVU0QAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAAAAAAACjtgvwDuOWAQ97R1RTtUdwNDHpD/CUepzdQPXlonciLVAAAAAUVVUgCg/Bj8V39wjI1Sr96oc7Omrth2jBx9LOQd9kVVEIrYSQAAAAAAAAAKAAAAAAAAAAGuo3otl2aS1ncnEiB5ThR/8RgN42jGz4Awp2zrbsAOViSh5RC1WKbt5+R1zFcH+54G/EgIp2ADTm29C+jIPawF6yxyDw==	vnoSsgNl2wQrtk7aZklLyK62mnD73KHOOPNHHcK3tf4AAAAAAAAACgAAAAAAAAABAAAAAAAAAAIAAAAAAAAAAW5oJtVdnYOVdZqtXpTHBtbcY0mCmfcBIKEgWnlvFIhaAAAAAAAAAAEAAAABRVVSAKD8GPxXf3CMjVKv3qhzs6au2HaMHH0s5B32RVUQithJAAAAAAAAAAo7YL8A7jlgEPe0dUU7VHcDQx6Q/wlHqc3UD15aJ3Ii1QAAAAFFVVIAoPwY/Fd/cIyNUq/eqHOzpq7YdowcfSzkHfZFVRCK2EkAAAAAAAAACg==	AAAABgAAAAEAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAAAO5rJ7AAAAAMAAAACAAAAAQAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAQAAAAE7YL8A7jlgEPe0dUU7VHcDQx6Q/wlHqc3UD15aJ3Ii1QAAAAFFVVIAoPwY/Fd/cIyNUq/eqHOzpq7YdowcfSzkHfZFVRCK2EkAAAAAO5rKCn//////////AAAAAQAAAAEAAAABbmgm1V2dg5V1mq1elMcG1txjSYKZ9wEgoSBaeW8UiFoAAAABRVVSAKD8GPxXf3CMjVKv3qhzs6au2HaMHH0s5B32RVUQithJAAAAAAvrwfZ//////////wAAAAEAAAABAAAAAW5oJtVdnYOVdZqtXpTHBtbcY0mCmfcBIKEgWnlvFIhaAAAAAVVTRAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAAL68IKf/////////8AAAABAAAAAQAAAAGuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAFVU0QAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAAAO5rJ9n//////////AAAAAQAAAAEAAAACbmgm1V2dg5V1mq1elMcG1txjSYKZ9wEgoSBaeW8UiFoAAAAAAAAAAQAAAAFFVVIAoPwY/Fd/cIyNUq/eqHOzpq7YdowcfSzkHfZFVRCK2EkAAAABVVNEALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAAAvrwfYAAAABAAAAAQ==
\.


--
-- Name: accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (accountid);


--
-- Name: ledgerheaders_ledgerseq_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ledgerheaders
    ADD CONSTRAINT ledgerheaders_ledgerseq_key UNIQUE (ledgerseq);


--
-- Name: ledgerheaders_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ledgerheaders
    ADD CONSTRAINT ledgerheaders_pkey PRIMARY KEY (ledgerhash);


--
-- Name: offers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY offers
    ADD CONSTRAINT offers_pkey PRIMARY KEY (offerid);


--
-- Name: peers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY peers
    ADD CONSTRAINT peers_pkey PRIMARY KEY (ip, port);


--
-- Name: signers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY signers
    ADD CONSTRAINT signers_pkey PRIMARY KEY (accountid, publickey);


--
-- Name: storestate_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY storestate
    ADD CONSTRAINT storestate_pkey PRIMARY KEY (statename);


--
-- Name: trustlines_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY trustlines
    ADD CONSTRAINT trustlines_pkey PRIMARY KEY (accountid, issuer, alphanumcurrency);


--
-- Name: txhistory_ledgerseq_txindex_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY txhistory
    ADD CONSTRAINT txhistory_ledgerseq_txindex_key UNIQUE (ledgerseq, txindex);


--
-- Name: txhistory_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY txhistory
    ADD CONSTRAINT txhistory_pkey PRIMARY KEY (txid, ledgerseq);


--
-- Name: accountbalances; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX accountbalances ON accounts USING btree (balance);


--
-- Name: accountlines; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX accountlines ON trustlines USING btree (accountid);


--
-- Name: getsissuerindex; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX getsissuerindex ON offers USING btree (getsissuer);


--
-- Name: ledgersbyseq; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX ledgersbyseq ON ledgerheaders USING btree (ledgerseq);


--
-- Name: paysissuerindex; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX paysissuerindex ON offers USING btree (paysissuer);


--
-- Name: priceindex; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX priceindex ON offers USING btree (price);


--
-- Name: signersaccount; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX signersaccount ON signers USING btree (accountid);


--
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM nullstyle;
GRANT ALL ON SCHEMA public TO nullstyle;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--
