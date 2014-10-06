From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RESEND] [PATCH] net: CAN: at91_can.c: decrease likelyhood of
 RX overruns
Date: Mon, 06 Oct 2014 14:52:33 +0200
Message-ID: <54329091.2040409@pengutronix.de>
References: <1403775686-19352-1-git-send-email-david@protonic.nl>	<5282990.80afdvE4aW@ws-stein>	<20141006112644.672440b2@archvile>	<2417882.RxeThGvgsF@ws-stein> <20141006133942.0f1c820b@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="jL0b0DDbPRjLQLSxd0qlndX0xraE8mndu"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59741 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbaJFMwp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 6 Oct 2014 08:52:45 -0400
In-Reply-To: <20141006133942.0f1c820b@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>, "Hans J. Koch" <hjk@hansjkoch.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jL0b0DDbPRjLQLSxd0qlndX0xraE8mndu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/06/2014 01:39 PM, David Jander wrote:
[...]
>>>> And the same with 500kBit/s:
>>>> plain:      0, 0, lockup
>>>> your patch: 0, 0, 0
>>>> rx-fifo:    0, 0, 0
>>>
>>> This is weird. Either you were lucky, your embedded devices aren't ab=
le to
>>> send back-to-back at that rate specifically, or the situation regardi=
ng
>>> load and latency spikes changed somehow. The results don't make sense=
 to
>>> me.
>>
>> Well, I guess this will change if I would run more than 3 times, but a=
s
>> overruns already occured at 250kBit/s there _is_ still a problem in rx=
-fifo,
>> independently from 1MBit/s drops due to heavy load.
>=20
> Well, I now think that rx-fifo was never intended to improve the driver=

> performance (correct me if I'm wrong, Marc), but only to build a common=

> subsystem around the same concept that seems to be re-invented in at91_=
can,
> flexcan and ti_hecc. It does fix the lockup-bug in at91_can though.

Exactly. It's supposed to abstract the make-a-fifo code from the
hardware and move it into the CAN driver core.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--jL0b0DDbPRjLQLSxd0qlndX0xraE8mndu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQykJEACgkQjTAFq1RaXHOk4gCeKe/ChsacwZCtgYwHYLh7DE+D
gPgAnA6Q3H+7YBe/9e+HEAsPc2l/p+Cv
=zvUe
-----END PGP SIGNATURE-----

--jL0b0DDbPRjLQLSxd0qlndX0xraE8mndu--
