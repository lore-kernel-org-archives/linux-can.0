From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: AW: AW: flexcan missing error state transitions
Date: Tue, 22 Aug 2017 16:06:36 +0200
Message-ID: <71679863-5b47-faf2-ca44-27eb1abf16c6@pengutronix.de>
References: <5213bc7ebd454acea568aba682d696ca@SGPMBX1017.APAC.bosch.com>
 <150333230375.13890.2773067532209799515@maxwell>
 <8e8b90f72f374fb1ab82bc29b8cfc108@SI-MBX1030.de.bosch.com>
 <150333966184.28484.15326759292718336833@maxwell>
 <e54b0db7ec524bcca65e1975aaf13b2b@SI-MBX1030.de.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="5Nv288aBS0SV8GpXWpuBfjfBwCniVk9ge"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41869 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932823AbdHVOGn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Aug 2017 10:06:43 -0400
In-Reply-To: <e54b0db7ec524bcca65e1975aaf13b2b@SI-MBX1030.de.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "wg@grandegger.com" <wg@grandegger.com>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5Nv288aBS0SV8GpXWpuBfjfBwCniVk9ge
Content-Type: multipart/mixed; boundary="KA5OVHV8mgAvXVwfqbMkBl0gnBn8ogJQk";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>,
 Andri Yngvason <andri.yngvason@marel.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "wg@grandegger.com" <wg@grandegger.com>
Cc: "hs@denx.de" <hs@denx.de>,
 "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>,
 "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Message-ID: <71679863-5b47-faf2-ca44-27eb1abf16c6@pengutronix.de>
Subject: Re: AW: AW: flexcan missing error state transitions
References: <5213bc7ebd454acea568aba682d696ca@SGPMBX1017.APAC.bosch.com>
 <150333230375.13890.2773067532209799515@maxwell>
 <8e8b90f72f374fb1ab82bc29b8cfc108@SI-MBX1030.de.bosch.com>
 <150333966184.28484.15326759292718336833@maxwell>
 <e54b0db7ec524bcca65e1975aaf13b2b@SI-MBX1030.de.bosch.com>
In-Reply-To: <e54b0db7ec524bcca65e1975aaf13b2b@SI-MBX1030.de.bosch.com>

--KA5OVHV8mgAvXVwfqbMkBl0gnBn8ogJQk
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 08/22/2017 03:50 PM, Jonas Mark (ST-FIR/ENG1) wrote:
> Hello Andri,
>=20
>>> Which polling interval do you think would be appropriate? It
>>> somehow has to be
>> a reasonable trade-off between latency and CPU usage. That's a good
>> question. I don't think that there is a really good answer to it.=20
>> It would be nice to see intermittent state-transitions happening,
>> so I would say as fast as possible without affecting CPU usage to a
>> significant degree. The polling timer should not be a high
>> resolution timer or anything that would preempt an rt task.
>>=20
>> This value could also depend on the bitrate as that will affect the
>> rate at which the error-counter can change. E.g. on 125 k rate, you
>> will receive at most one frame per 1 ms. This means that the error
>> state will change at at least 64 ms intervals, so we would have to
>> sample at 32 ms intervals to catch all the transitions. For 1 M
>> this would be around 2 ms.
>>=20
>> Note that this is all somewhat speculative as I do not know exactly
>> how fast the error counters are incremented/decremented.
>=20
> We agree that there is a sensible lower boundary for the polling
> interval which depends on the bitrate. And there is a upper boundary
> which depends on the application.
>=20
> We are currently thinking about whether it would be possible to do
> the polling only in case the controller is actually experiencing
> trouble.

Why not enable bus errors on broken controllers. Disable once a bus
error hits and re-enable them after a configurable timeout with a proper
default. I have a patch somewhere, although it applies only against the
pre rx-offload version of the driver.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--KA5OVHV8mgAvXVwfqbMkBl0gnBn8ogJQk--

--5Nv288aBS0SV8GpXWpuBfjfBwCniVk9ge
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmcOm0ACgkQHv7KIOw4
HPbGHQf/TLDV+QJyZy5uPwldkLLcRS+jfPC7A8Ne0WG1izVnUpnEXKURbgvQ9htF
L8FP7gFxD6QdlLUFLPpn0A38zc/ILKjTd6z++GIiODQ1u95Oymkl6kH86vVbI0do
+H9CNOcy4pGr3cRhW8oGvLQBofjWExP5iQNGuxocAkjCG09mwa2CxwXhK++HjUhM
FJZvi62+AkoJXLWrLtmjHBxgSn7TmZ+dYiOqpS2R+dlDsFFXlmupuJNlltgYo0S6
0Euu7/R2KYx35LeUqaRqdxWQ3RMR1rz3u/mtRXbQiK7clsuMFjEMGEpDU2hLx6Gl
F3H5v9CryzB0pREC96xstIP9t35wkw==
=TOoi
-----END PGP SIGNATURE-----

--5Nv288aBS0SV8GpXWpuBfjfBwCniVk9ge--
