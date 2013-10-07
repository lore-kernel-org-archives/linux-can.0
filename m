From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/7] can: berr_limit support
Date: Mon, 07 Oct 2013 21:42:18 +0200
Message-ID: <52530E9A.7050403@pengutronix.de>
References: <1381156840-24071-1-git-send-email-mkl@pengutronix.de> <52530DB6.2020407@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6PuJMxQMVIC0Fh9WhRAHFaBWAv6QN3JmR"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35703 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995Ab3JGTmY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Oct 2013 15:42:24 -0400
In-Reply-To: <52530DB6.2020407@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6PuJMxQMVIC0Fh9WhRAHFaBWAv6QN3JmR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/07/2013 09:38 PM, Wolfgang Grandegger wrote:
> Hi Marc,
>=20
> On 10/07/2013 04:40 PM, Marc Kleine-Budde wrote:
>> Hello,
>>
>> this series does first some cleanups in can/dev.c, the implementation =
of three
>> functions is sorted by IFLA_CAN_*, that we can see at the first look, =
that all
>> needed IFLA_CAN_* are handled and that new code can be added at the en=
d.=20
>>
>> Then the bus error limiting (short: berr_limit) infrastructure + netli=
nk
>> configuration interface is added. Last patch is an example implementat=
ion on
>> the flexcan hardware.
>>
>> The CAN bus, like the old 10BASE2 Ethernet, needs bus termination. An =
open CAN
>> bus doesn't work and will produce lots of CAN bus errors.
>>
>> If the user wants to detect an open CAN bus, the CAN bus error interru=
pts have
>> to be enabled. This is represented by the control mode
>> CAN_CTRLMODE_BERR_REPORTING.
>>
>> On an unterminated CAN bus at 500 kbit/s, this can lead to more then 8=
000
>> interrupts/s on some SoCs with integrated CAN cores. These interrupts =
and the
>> associated processing in software lead to a significant load and may r=
eader the
>> system unresponsive and even unusable at CAN bus speeds of 1000 kbit/s=
=2E
>=20
> And there might be more than just one interface.

Which makes it even worse.

>> This patch adds the infrastructure to limit these interrupts. The driv=
er has to
>> implement the do_berr_restart() callback, which re-enables the bus err=
or
>> interrupts. The idea is to delay the re-enabling of the interrupts aft=
er they
>> have been served. The delay is configured by berr_limit_delay. A value=
 of 0
>> means interrupts are restarted immediately, any other other value will=
 start a
>> timer and call do_berr_restart() when the timer fires.
>=20
> IIRC, some versions of the Flexcan controller need bus error interupts
> enabled otherwise state changes are not realized. This makes an
> efficient support for CAN_CTRLMODE_BERR_REPORTING impossible, which can=

> normally be achieved by simply masking the interrupt source. Does state=

> change reporting still work properly with this kind of interrupt
> throttling? Apart from that the approach looks good.

I'll do some tests with another imx system. I think the state change
will be delayed until the bus error interrupts will be enabled again.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--6PuJMxQMVIC0Fh9WhRAHFaBWAv6QN3JmR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJTDpoACgkQjTAFq1RaXHOENACfZi5kQ1PBtCzDUM6TbdaptHRp
pwMAoJBQgzkFVXFywbcV3Vp91a7teNnj
=SuPZ
-----END PGP SIGNATURE-----

--6PuJMxQMVIC0Fh9WhRAHFaBWAv6QN3JmR--
