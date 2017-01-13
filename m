From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 4/4] can: peak: add support for PEAK PCAN-PCIe FD
 CAN-FD boards
Date: Fri, 13 Jan 2017 14:15:12 +0100
Message-ID: <db248428-c8e8-17ea-20fe-4b8a6548a120@pengutronix.de>
References: <1484136978-3823-1-git-send-email-s.grosjean@peak-system.com>
 <1484136978-3823-5-git-send-email-s.grosjean@peak-system.com>
 <1180cb22-d2e2-19a4-d0d7-d534dcec6274@hartkopp.net>
 <2a721fb7-38a3-a535-191a-0623742f3645@peak-system.com>
 <a7ca612b-2c62-2a15-7ff0-8791db422647@hartkopp.net>
 <50f5c95a-9978-9b08-8c82-4d3731a6601e@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="hq41DblLCWelVsuGpabuE6d3qa8XChV3D"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:45299 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751641AbdAMNPV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 13 Jan 2017 08:15:21 -0500
In-Reply-To: <50f5c95a-9978-9b08-8c82-4d3731a6601e@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hq41DblLCWelVsuGpabuE6d3qa8XChV3D
Content-Type: multipart/mixed; boundary="VnH10Uu9vliX8L8JITIdDPqkS5LRXfXQF";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <s.grosjean@peak-system.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>
Message-ID: <db248428-c8e8-17ea-20fe-4b8a6548a120@pengutronix.de>
Subject: Re: [PATCH v3 4/4] can: peak: add support for PEAK PCAN-PCIe FD
 CAN-FD boards
References: <1484136978-3823-1-git-send-email-s.grosjean@peak-system.com>
 <1484136978-3823-5-git-send-email-s.grosjean@peak-system.com>
 <1180cb22-d2e2-19a4-d0d7-d534dcec6274@hartkopp.net>
 <2a721fb7-38a3-a535-191a-0623742f3645@peak-system.com>
 <a7ca612b-2c62-2a15-7ff0-8791db422647@hartkopp.net>
 <50f5c95a-9978-9b08-8c82-4d3731a6601e@peak-system.com>
In-Reply-To: <50f5c95a-9978-9b08-8c82-4d3731a6601e@peak-system.com>

--VnH10Uu9vliX8L8JITIdDPqkS5LRXfXQF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/13/2017 12:45 PM, Stephane Grosjean wrote:
>=20
> Le 12/01/2017 =C3=A0 17:30, Oliver Hartkopp a =C3=A9crit :
>> On 01/12/2017 12:40 PM, Stephane Grosjean wrote:
>>
>>> There's one potential fix by setting something like an "ECHO" bit to =
any
>>> transmitted frame; The driver rx path will be able to distinguish
>>> between these "echoed" frames and the - application - "looped back"
>>> frames, so that the rx stats will be ok.
>>
>> That would be cool!
>> I remember discussing about a good echo functionality with Philipp.
>> Can you also pass some extra data along with the CAN frame down to the=
=20
>> controller (e.g. to carry an index into the echo skb table?).
>>
>> Because even when you know that the received frame was echoed, you=20
>> need to got through your saved echo skb list to pick the oldest skb=20
>> for this interface/CAN-ID/mtu combination. This stored skb has to be=20
>> sent back into the system.
>>
>> Do not create a new skb for echo'ed skbs! See echo skb handling in dev=
=2Ec
>>
>=20
> We all agree that the echo skbs array should not be a limitation in the=
=20
> tx flow, so this should be large enough to save the maximum number of=20
> CAN frames written, before being obliged to stop the network tx queue, =

> right?
>=20
> In the case of this IP core, I'm able to write ~205 (0 data byte) CAN=20
> frames in the Tx DMA area. Do you see any problem to allocate such a=20
> large array in the can device context?

You probably want to limit the on-the-fly TX frames to a sensible
number, as it may introduce latencies.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--VnH10Uu9vliX8L8JITIdDPqkS5LRXfXQF--

--hq41DblLCWelVsuGpabuE6d3qa8XChV3D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlh40uAACgkQPTuqJayp
JWorIggAt4P9uklg5IT8xPhHrQxYb9nlwxpAU3rJhEAV+036NIhKFDiE+qiV3XxR
ieKwz4clirq7zerCIa5ITOPx7VIhlGSY/iq6/2yzoayV5rU7n9xbaYGemAaFrcvO
wpeIG/MzXADZ8R5LbnDJaorcs4LFA6NT75NpPy0wRBHABsC0j/E4r/fqh4OLtN97
Ixpqg/4dV4M9arei3TWPeMSJ94Cq8yg3Rpu6CxBRx5fcTyxi+g71oy1zwABivV7k
OoVc0yU+9ua7BrF8eqyb4WSDgw9HCFqSwZrVtTGr9MXhE629fN7EkVKFL9o1dZJe
GJXNS+B9unKaFS3DU7GgMXm5oS6neQ==
=JF5H
-----END PGP SIGNATURE-----

--hq41DblLCWelVsuGpabuE6d3qa8XChV3D--
