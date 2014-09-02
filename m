From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/3] can: flexcan.c: Re-write receive path to use MB queue
 instead of FIFO
Date: Tue, 02 Sep 2014 16:53:46 +0200
Message-ID: <5405D9FA.6050207@pengutronix.de>
References: <1409133487-23367-1-git-send-email-david@protonic.nl>	<1409133487-23367-3-git-send-email-david@protonic.nl>	<5405AA50.6040100@pengutronix.de> <20140902140407.1ee9db68@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="KipMsKG9drB6L2s5O89mfXGpg6STEKc6k"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51000 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626AbaIBOxs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Sep 2014 10:53:48 -0400
In-Reply-To: <20140902140407.1ee9db68@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: wg@grandegger.com, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KipMsKG9drB6L2s5O89mfXGpg6STEKc6k
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/02/2014 02:04 PM, David Jander wrote:
> On Tue, 02 Sep 2014 13:30:24 +0200
> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>=20
>> On 08/27/2014 11:58 AM, David Jander wrote:
>>> The FlexCAN controller has a RX FIFO that is only 6 messages deep, an=
d a
>>> mailbox space capable of holding up to 63 messages.
>>> This space was largely unused, limiting the permissible latency from
>>> interrupt to NAPI to only 6 messages. This patch uses all available M=
Bs
>>> for message reception and frees the MBs in the IRQ handler to greatly=

>>> decrease the likelihood of receive overruns.
>>
>> What about the order of the incoming CAN frames? Is it still preserved=
?
>=20
> Yes, it is preserved as long as latency doesn't exceed 30 frames, which=
 is
> way more than the original driver could take. The algorithm is not triv=
ial,
> therefor I included an explanatory comment to flexcan_copy_rxmbs().

To be honest, I haven't looked at the algorithm in detail. I think we
first have to fix both bugs (the errata and the mailbox initialization
issue).

>> You make use of the CTRL2 register, which is not present on some older=

>> (but supported) flexcan IP cores. You increase FLEXCAN_MCR_MAXMB to
>> 0x40, which is not supported on older IPs. The register rximr, is also=

>> not present on older cores. Don't break support for the older CAN core=
s.
>=20
> Oops. Thanks for pointing that out. I will check the reference manual o=
f the
> i.MX53 (which should have be the oldest supported version of this IP co=
re,
> right?). Of course I do not want to break older CAN cores.
> I will check correctness testing the code on an i.MX28 board which I ha=
ve.

Regarding the versions of the IP cores, we should not trust them, as
they are not public available..

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--KipMsKG9drB6L2s5O89mfXGpg6STEKc6k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQF2foACgkQjTAFq1RaXHMMTQCfTc+U0gsRva+HqLerAU7hszeV
uBgAn2N+EtWImuTBX+7JPJSSZI9Xpe2C
=coTQ
-----END PGP SIGNATURE-----

--KipMsKG9drB6L2s5O89mfXGpg6STEKc6k--
