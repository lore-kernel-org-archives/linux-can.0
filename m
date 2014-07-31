From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: C_CAN: can frame drops
Date: Thu, 31 Jul 2014 14:42:55 +0200
Message-ID: <53DA39CF.2070303@pengutronix.de>
References: <BAY176-W240BDB3FFF425370BF5B47D3FE0@phx.gbl> <53D204A4.1060502@pengutronix.de> <BAY176-W4D41B1290DE5D3B2BD6D0D3FC0@phx.gbl> <53D2126C.40600@pengutronix.de> <BAY176-W426E5C1C47CA0379DFCD84D3FC0@phx.gbl> <53D214E2.7020205@pengutronix.de> <BAY176-W40C40CD192EBD241673159D3FC0@phx.gbl> <53D219E8.5060307@pengutronix.de> <BAY176-W36138D837FA40B1721062ED3FC0@phx.gbl> <53D234D9.2010602@hartkopp.net> <CA+V-a8vm+WQXcSwPp7e7yKQehs0+BYkHhZg-EfEL1gWE_cBF=g@mail.gmail.com>,<53D91AB5.5060507@hartkopp.net> <BAY176-W523AF4513C195E7972FE52D3E60@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="tFT8GjXqxJACR4KgvUqs7wDmkTJnWlgGA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54938 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbaGaMnG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 31 Jul 2014 08:43:06 -0400
In-Reply-To: <BAY176-W523AF4513C195E7972FE52D3E60@phx.gbl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ssagarr Patil <hugarsagar@outlook.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Prabhakar Lad <prabhakar.csengg@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tFT8GjXqxJACR4KgvUqs7wDmkTJnWlgGA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/31/2014 02:41 PM, Ssagarr Patil wrote:
> Hi Oliver,
>=20
> Sorry for the delayed response! was busy with other work load.
>=20
>>
>>>>>> If you want to log all CAN
>>>>>> messages, you can probably make use of recvmmsg() to receive more =
than
>>>>>> one CAN frame at a time (instead of using recvmsg() or read()). Wh=
en
>>>>>> writing to disk, don't write a single CAN frame at a time, it's be=
tter
>>>>>> to write large blocks, i.e. several 4k of data.
>>>>>>
>>>>> I am using the v3.16 (the master branch from git://gitorious.org/li=
nux-can/linux-can.git)
>>>>>
>>>>> OK will try experiment with recvmmsg() & and writing to disk with l=
arge blocks.
>>>>>
>>>>
>>>> I implemented a proof-of-concept for recvmmsg() for candump.
>>>>
>>>> You can try:
>>>>
>>>> https://gitorious.org/linux-can/canpump
>>>>
>>>
>>> Any plans of adding this into mainline can-utils ?
>>>
>>
>> Hm - currently not.
>>
>> If it turns out to really help to increase the throughput for e.g. can=
dump it
>> would be worth thinking to integrate it into candump.
>>
>> But so far there was no feedback from Sagar, if it was at least helpfu=
l.
>>
> Yes it was beneficial I used MSG_WAITALL flag for recvmmsg() so that=20
> it waits for n frames and there is no memory wastage.
>=20
> Also is it possible to configure qdiscs for improving the performance ?=


AFAIK qdiscs are only used in the tx path.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--tFT8GjXqxJACR4KgvUqs7wDmkTJnWlgGA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPaOc8ACgkQjTAFq1RaXHNldwCfS5bxUQB+TWAZK6Tt/caIV+cC
YfUAnjFcXPJk0yyqFpAo8G/mPenmFHuX
=rMuw
-----END PGP SIGNATURE-----

--tFT8GjXqxJACR4KgvUqs7wDmkTJnWlgGA--
