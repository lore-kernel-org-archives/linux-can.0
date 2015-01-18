From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3.19-rc3] c_can: SIE disabled when berr-reporting is off
 to reduce irq flood
Date: Sun, 18 Jan 2015 19:56:05 +0100
Message-ID: <54BC01C5.2070803@pengutronix.de>
References: <9c72f211-becc-4c0f-94f6-0700dfb1195e@GRBSR0089.marel.net> <alpine.DEB.2.02.1501121751530.28201@login> <1735533.0yOonAfCy1@heinz> <alpine.DEB.2.02.1501121948370.28201@login> <54B472B2.4010300@optusnet.com.au> <alpine.DEB.2.02.1501131523290.12789@login> <20150113153243.26859.47218@shannon> <alpine.DEB.2.02.1501181809150.32136@login> <54BBFCAF.2090603@pengutronix.de> <alpine.DEB.2.02.1501181938030.32136@login>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="IF7vwLpnvBnJ0VGN4AamrA05BoWoqOC4e"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39694 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbbARS4R (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 18 Jan 2015 13:56:17 -0500
In-Reply-To: <alpine.DEB.2.02.1501181938030.32136@login>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Viktor Babrian <babrian.viktor@renyi.mta.hu>
Cc: Andri Yngvason <andri.yngvason@marel.com>, Tom Evans <tom_usenet@optusnet.com.au>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IF7vwLpnvBnJ0VGN4AamrA05BoWoqOC4e
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/18/2015 07:52 PM, Viktor Babrian wrote:
>=20
>> NACK. The transitions are important for some applications. I've an not=

>> yet mainlined series that limits the bus errors. I'm going to port the=
m
>> to the current kernel tomorrow. Can you test it?
>=20
> This controller simply does not have a warn->pass state transition=20
> interrupt. The only way to accurately (right on time) report this=20
> transition is to switch on all error interrupts (ie the status interrup=
t)=20
> that cause interrupt flood in some scenarios e.g. when frame is not ack=
ed=20
> by other parties.
> If we don't turn on the status interrupt, the warn->pass state transiti=
on=20
> can be detected later on a successful rx/tx event (or when entering bus=
=20
> off etc).
>=20
> I have learned that the warn->pass transition interrupt is also missing=
=20
> from other controllers as well (like Flexcan). Interrupt flood caused b=
y=20
> enabling error interrupts regardless of the berr-reporting state is an =

> issue there too.
>=20
> Also note that when the system is flooded by these error interrupts,=20
> system performace degrades so much that serial terminal echo becomes=20
> annoyingly long. When this happens, I wonder how usable the "accurate" =

> state transition reports are anyway.

As I said, they are vital to some applications. The bus error limiting
series will follow.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--IF7vwLpnvBnJ0VGN4AamrA05BoWoqOC4e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUvAHLAAoJECte4hHFiupUvqwP/3xI5F8wK8QA9Jj5uZ6lTC9I
ags0+3J3QcFwgXfcwIm4z0xEwMKqVgl8ObHi2nY6smFjMGjWpTXHeP7034XgWzfm
dES2K8Fxx/sZF7Q/nIXBT4oVkTFikTPOEy0wNAV4bfTYfCD9gk0DFfv90b9DmUo0
wt/jZhbEh/qWN0uwikMbgRsrdXXbAZ81KxAqG5O4UoIxYb1QV0K4FOsdoJzlu5g9
Hp0Xk3dMY+HeFEvSy4qlwcbSUKBXTGg76HFFEzZdzspueX4W4bjDQzA0jEpCf1uO
jiotzV00st0fLdKX3FmfK4wRP81MtXdEs9glZgxtdU0luJZomQmBGsUfo5U2n8o8
r31cKPrSHr5fT1N5nur0h94EeDpo4793kt9W2jipiyrIzn4KokXCmXChgM+bQwP5
twi9VRDJWjxSFxHmQsxsAI5Udh6kNiu1wcVze4O5rtPZhhFF6T4M1TSyW669Mz/4
kYIb2X5axTttD7583MlqBYLE2ANtg+CjdEeBQUTfkDxPf3kNmvSAvtjB/VN4h/97
m8FBMvjR0w7o1ngDNvqNfCLuvthiFlkncb8hG10QTVndCyBVJPlMQKv0vcwhCpu/
bqBpYNiEDrNrlb9DjS42n11x+EO5GCCnxGdB4oRRRP4Yc+9J1jiZ9mwZ3yI+hf9C
eYFd1n7KdjQX+9UDzgL1
=jjXC
-----END PGP SIGNATURE-----

--IF7vwLpnvBnJ0VGN4AamrA05BoWoqOC4e--
