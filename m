From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 4/4] j1939: remove proc support
Date: Thu, 25 Jan 2018 09:56:17 +0100
Message-ID: <bc7051ae-846c-dc73-c177-ef7306e85320@pengutronix.de>
References: <20180124110659.438-1-o.rempel@pengutronix.de>
 <20180124110659.438-4-o.rempel@pengutronix.de>
 <20180124201307.GB4214@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="YRHXYKvgOZFqUcZrkBr6eNgLqLhRwGBfD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38707 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbeAYI4q (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Jan 2018 03:56:46 -0500
In-Reply-To: <20180124201307.GB4214@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YRHXYKvgOZFqUcZrkBr6eNgLqLhRwGBfD
Content-Type: multipart/mixed; boundary="kLdv7RBEP1PY4ZjFIBBpbRiilH4zQBLPw";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
Message-ID: <bc7051ae-846c-dc73-c177-ef7306e85320@pengutronix.de>
Subject: Re: [PATCH 4/4] j1939: remove proc support
References: <20180124110659.438-1-o.rempel@pengutronix.de>
 <20180124110659.438-4-o.rempel@pengutronix.de>
 <20180124201307.GB4214@airbook.vandijck-laurijssen.be>
In-Reply-To: <20180124201307.GB4214@airbook.vandijck-laurijssen.be>

--kLdv7RBEP1PY4ZjFIBBpbRiilH4zQBLPw
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/24/2018 09:13 PM, Kurt Van Dijck wrote:
> I'm in favor of stripping all unnecessary, but ...

[...]

>> -  7 can-j1939 SYSCTL
>> -    7.1 /proc/sys/net/can-j1939/transport_max_payload_in_bytes
>> -    7.2 /proc/sys/net/can-j1939/transport_cts_nr_of_frames
>> -    7.3 /proc/sys/net/can-j1939/transport_tx_retry_ms
>=20
> Those parameters shape the kernels behaviour on transport sessions.
> It makes sense to configure them globally.
> Should this be returned to module parameters then?
I've split up the patch and removed the procfs for now, but the sysctl
support stays in. I even have taken two more of Oleksij's patches that
update the sysctl related parts of the documentation.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--kLdv7RBEP1PY4ZjFIBBpbRiilH4zQBLPw--

--YRHXYKvgOZFqUcZrkBr6eNgLqLhRwGBfD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlppm7EACgkQHv7KIOw4
HPaM3wf/TRU080ePsJWdjUtW+r9ZQRoteMxbkqapnvl0YyZEPDdUeJNN9pisMWJz
jJakgr6NKj2CGAN0xl87yMZdPvY0CmOae1IGmCHLyUo+Uhnpgj9i10UH35JJH612
IGWQnDliBE9dzPz97v94J/aTkRxZW9QNN4uu+I8Z+T/XkDkj8fuEi9mMQZQQSu9s
Vin9YX0aRTqTRFmi4EtUnT+ErcGMfXixpyj7w1hWEYaFrArdy5q/5hPH1h8sgl/h
WzNsbXzOnRbUQ19ANG6q7gFfFsfy6L2wnww3lCW4dDqqJV8aKqojScLuopC28iTM
rtJN6KGVZDAy1nOgiCh8jgnK+Sl2GQ==
=Yql/
-----END PGP SIGNATURE-----

--YRHXYKvgOZFqUcZrkBr6eNgLqLhRwGBfD--
