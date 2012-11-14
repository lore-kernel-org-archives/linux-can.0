From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v8] can: grcan: Add device driver for GRCAN and GRHCAN
 cores
Date: Wed, 14 Nov 2012 16:12:27 +0100
Message-ID: <50A3B4DB.40502@pengutronix.de>
References: <509C47CB.8060701@pengutronix.de> <1352732256-12712-1-git-send-email-andreas@gaisler.com> <50A2B88A.3040609@pengutronix.de> <50A34D49.2070908@gaisler.com> <50A359A1.30700@pengutronix.de> <50A37A5B.8060808@gaisler.com> <50A37F0A.7050204@pengutronix.de> <50A3B3AD.5080507@gaisler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4B3E86E20DC50D853923D15D"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39950 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932736Ab2KNPMm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 14 Nov 2012 10:12:42 -0500
In-Reply-To: <50A3B3AD.5080507@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-can@vger.kernel.org, software@gaisler.com, Wolfgang Grandegger <wg@grandegger.com>, devicetree-discuss@lists.ozlabs.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4B3E86E20DC50D853923D15D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/14/2012 04:07 PM, Andreas Larsson wrote:
> On 2012-11-14 12:22, Marc Kleine-Budde wrote:
>> On 11/14/2012 12:02 PM, Andreas Larsson wrote:
>>> On 2012-11-14 09:43, Marc Kleine-Budde wrote:
>>>> Handle incoming events (rx or tx-complete) until:
>>>> a) number of handled events =3D=3D budget
>>>> or
>>>> b) no more events pending.
>>>>
>>>>      while (work_done < budget && interrupts_pending()) {
>>>>          work_done +=3D handle_rx(budget - work_done);
>>>>          work_done +=3D handle_tx(budget - work_done);
>>>>      }
>>>
>>> That could starve handle_tx completely though under high rx pressure,=

>>> but I can prevent that by making sure that half of the budget is held=

>>> back in the first call to handle_rx.
>>
>> What about making the budget big enough to handle both rx and tx in on=
e
>> napi call. Have a look at the marvell driver [1] for inspiration.
>=20
> Even if I set the budget to something large, unless I limit the rx side=

> in some way it could go on multiple rounds around the circular buffer
> until it have used all the budget. So in some way or another,
> grcan_receive must be hindered from using all the budget.
>=20
> Sorry, but I am not sure what aspect of the marvell driver poll handlin=
g
> you want me to mimic. Without having analyzed exactly how the queueing
> works yet, it seems to make sure that every function that is called fro=
m
> the poll function gets ample opportunity to do work by not letting one
> function hogging all the budget. If you want me to mimic it in the
> aspect of doing work in series of 16 or something like that, sure, no
> problem. If it is something else you want to point to, please let me
> know what.
>=20
>=20
> The simplest way to make sure that both tx and rx gets to run is to tak=
e
> inspiration from the ethoc driver [1] and just let the tx side get just=

> as much budget as the rx side and be done with it. With the echo frames=

> for can, the budget should be halved for each I guess to make sure no
> more frames are delivered than the budget, but apart from that I don't
> see the problem with such a simple approach.

Good point, if there already is an implementation, do it that way.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig4B3E86E20DC50D853923D15D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCjtN4ACgkQjTAFq1RaXHNX9wCeO4OdBbQT1+TemquwFvGwTwT+
ZAYAnRSKCaWJbQeaFASh2SND7Fquo1Zk
=FBpd
-----END PGP SIGNATURE-----

--------------enig4B3E86E20DC50D853923D15D--
