From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Flexcan
Date: Thu, 02 Apr 2015 14:07:28 +0200
Message-ID: <551D3100.1020209@pengutronix.de>
References: <CAE+ymru296P+LjkT7_ONVc2OGMP9mtXW46Nq5aSnm1etauj9Aw@mail.gmail.com>	<CAE+ymrt-rsXgteuDCvp27BSsQRE5APGDsgsSPhg31Qz3_qZEdQ@mail.gmail.com>	<55187FF1.7020701@optusnet.com.au>	<CAE+ymrsiE39R2ssXeorAoHuSVFdkLeV7oS-ajTLWDs46iADsYw@mail.gmail.com>	<5519E5A9.7080104@optusnet.com.au>	<CAE+ymrvvqL_o3ZTWdq96kQmMe6c3OzqM+SQN3qPpyH1dLMjmrw@mail.gmail.com>	<551A0FF3.4070400@optusnet.com.au> <CAE+ymrt9gfCDEyNNz-b2gOS0NJt=pupm=t3HqbGosbKBC5wa7A@mail.gmail.com> <551C7D79.50906@optusnet.com.au> <loom.20150402T022922-646@post.gmane.org> <551CA777.8070208@optusnet.com.au> <551CE174.2030303@pengutronix.de> <551D298D.7040809@optusnet.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="k7Kw87TlCjXfbj9VA52Fhcp6FUKsqhal1"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46369 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbbDBMH7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 Apr 2015 08:07:59 -0400
In-Reply-To: <551D298D.7040809@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tom Evans <tom_usenet@optusnet.com.au>, dan.egnor@gmail.com, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k7Kw87TlCjXfbj9VA52Fhcp6FUKsqhal1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/02/2015 01:35 PM, Tom Evans wrote:
> On 2/04/2015 5:28 PM, Marc Kleine-Budde wrote:
>> On 04/02/2015 04:20 AM, Tom Evans wrote:
>>> I had to seriously rewrite the FlexCAN drivers for our i.MX53 because=
 the
>>> Ethernet driver blocked the CAN driver for so long the CAN hardware r=
eceive
>>> FIFO overflowed. Linux doesn't even support setting different interru=
pt
>>> priorities on ARM (but my problem was with NAPI).
>>
>> Can you share your changes? I'll have some days to hack on a better
>> generic RX-FIFO implementation for the at91 and flexcan.
>=20
> Sure. "git diff -p" based of the 3.4 kernel sources.

Thanks.

> Working from home over Easter using git under cygwin under Windows via =

> Thunderbird, so the CRLFs and line breaks could be messed up, sorry.=20
> Patches inline and attached. If this lot is useless, tell me what to=20
> type to do it properly and I'll resend on Tuesday.

Uhhh sounds scary - what about switching to Linux over the holidays? :D
As I don't want to push that patch upstream, but get more insight into
the various problem and solutions, this is alright.

BTW: you can send pathes directly via "git send-email".

> flexcan.c.patch.buffer
>=20
> The problem with the FlexCan driver is that it takes the interrupt, the=
n=20
> throws to NAPI to actually read the hardware buffers. How messed up is =

> that? It isn't as if reading 16 bytes or so is going to take THAT long,=
=20
> and as there's only six message buffers it overflows in 600us at 1MHz. =

> In the same kernel, the Ethernet driver DOESN'T throw to NAPI but=20
> handles as many 1500-byte Ethernet frames as there are coming in in the=
=20
> one ISR. Other things can delay NAPI as well. So I fixed it with a=20
> sledgehammer. It reads the messages during the ISR to an internal ring =

> buffer (sized to 100, later to 128)

Sledgehammers are not the best tool for mainline kernel development, but
it's good to demolish old walls and get a clear view to head in the
hopefully right direction.

> flexcan.c.patch.flood
>=20
> A disconnected CAN bus generate an interrupt storm. This patch fixes it=
=20
> the same way it is apparently done in some 3.18 drivers. This may=20
> already be in there.

We're heading for a different solution, limiting the bus errors.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--k7Kw87TlCjXfbj9VA52Fhcp6FUKsqhal1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVHTEWAAoJECte4hHFiupUPqwP/0VOeMz1yvjxRQsi7lE1Twe2
/RdjGvoifGN8EqNWdmgjPeOYe6g2zQ+7VWZWWFaHCpySOtaFPLI4JT9nVmeHcVDw
D9auF4lXtkT5BwQhItS2jkjOMWnrMfUvGfcUB6KMTJ8gZatuFt1+0bd/OWNYsmZz
ptBIp+KcAgruwOYarrTuPkF6lVJrcFnv6VOq3MianDuiOpuES7NhM0Z/Lp3zT5jN
Miq8BOFZMlqtUisO3MzPLB+1c88eT51AgpqzjtAOfwMaxN9yBgY+1bUYGZDV4nRq
Qe0b1E00A+KTq+X7vwhm8vNsT1qpp6T+dTLLyb5ltFwkC4ozbisIjyCbJmrA6DwV
KTCTr7MemGOtwsMy+piQYrUdu24C3QbeRQJu018UFFGr//SguCPl+wKwMld3i2gA
K0fMbIA3vX9k2UsNuW8FICn+OnlaVZjj4zjltZmklzw7GuB/+lMTYayuq4GzRrx8
QK9OSGLDgt9cqe2lwvaLL3cBu3jhfqdvIXEbNeKQ6iqT+E/cST7YLS1V5VyOyeDs
3YIn2fIQ+Qy0EpE7PDzzgSPtDhtSx0QmevAivI0a/MkC3b4UwUE0Rn6rd26X7WML
eyC6PskP6CNTdI3ED+d3gVq2omxOkzrXr+aou1hBeeTn0D10Y8gSljGnE5ItsNWe
Jfy+cfGbA6WT/wN140fO
=o4MN
-----END PGP SIGNATURE-----

--k7Kw87TlCjXfbj9VA52Fhcp6FUKsqhal1--
