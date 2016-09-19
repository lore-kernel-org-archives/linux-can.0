From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939
Date: Mon, 19 Sep 2016 20:52:35 +0200
Message-ID: <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="uIjwEtFrHowoFo0lShbAkEo0xqfaTMwFh"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47958 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750971AbcISSwr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Sep 2016 14:52:47 -0400
In-Reply-To: <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can <linux-can@vger.kernel.org>
Cc: David Jander <david@protonic.nl>, Kurt Van Dijck <kurt.van.dijck@eia.be>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uIjwEtFrHowoFo0lShbAkEo0xqfaTMwFh
Content-Type: multipart/mixed; boundary="WdnrET3eQv5uetCIB2rT8TlVvRlNvx9tf";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 linux-can <linux-can@vger.kernel.org>
Cc: David Jander <david@protonic.nl>, Kurt Van Dijck <kurt.van.dijck@eia.be>
Message-ID: <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
Subject: Re: j1939
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net>
In-Reply-To: <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net>

--WdnrET3eQv5uetCIB2rT8TlVvRlNvx9tf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/19/2016 08:27 PM, Oliver Hartkopp wrote:
> On 09/19/2016 06:54 PM, Marc Kleine-Budde wrote:
>=20
>>
>> Another thing that IMHO has to be sorted out is the use of module
>> parameters:
>>
>>> ./main.c:49:MODULE_PARM_DESC(padding, "Pad all packets to 8 bytes, an=
d stuff with 0xff");
>>> ./transport.c:60:MODULE_PARM_DESC(transport_burst_count, "Number of p=
ackets to send in burst between flow control (1..255, default 255)");
>>> ./transport.c:61:MODULE_PARM_DESC(transport_max_size, "Maximum packet=
 size (default 100k)");
>>> ./transport.c:62:MODULE_PARM_DESC(transport_retry_time, "Packet retra=
nsmission timeout in msecs, used in case of buffer full. (default 20)");
>>> ./transport.c:63:MODULE_PARM_DESC(transport_packet_delay, "Delay betw=
een packets to avoid buffer overruns (default 0)");
>>
>> Better convert them to netlink options.
>>
>=20
> What about putting them into socket depended sockopts with setsockopt()=
?

Is it a per interface or a per socket setting?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--WdnrET3eQv5uetCIB2rT8TlVvRlNvx9tf--

--uIjwEtFrHowoFo0lShbAkEo0xqfaTMwFh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJX4DPzAAoJED07qiWsqSVqHV4IAJinUNAVI58ga5jIF+pMKFIH
xrHZpoekpqkvGFZQycE0huPeJnF2WlMDduSoqPbj9UyO/nA7O6SB2KjaGFB9QXzU
QUE0mwpQT4LXlAy4FaJlbHm2hIzISHyfHdJZqkbh5E0ImKqapn1uob1RdFXUDPlE
iicPJd7cxZu668/nx4OhyULciV8kPzWottb/jeOWBnx/TKKJVMG01JTv67+2suWp
L+hYf+gVvaVfrpyyriyLu2vHDy2H/7L0ZCE7xx48xA1C9bW8C0LyO2mgtqI3wYwo
B78ESJOnDbkj2E5o5lYubwo8CrLyCeUhDoTj4ts51/Nfol+MgGbwYqYjqyq7S/A=
=pzBp
-----END PGP SIGNATURE-----

--uIjwEtFrHowoFo0lShbAkEo0xqfaTMwFh--
