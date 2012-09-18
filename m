From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Tue, 18 Sep 2012 14:34:24 +0200
Message-ID: <50586A50.5060300@pengutronix.de>
References: <2478881.znSzbTXnK5@uschi> <505777BC.3000705@hartkopp.net> <5058659E.2010804@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3C4E0DBB6243BD8ED6B73354"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38524 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932495Ab2IRMed (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Sep 2012 08:34:33 -0400
In-Reply-To: <5058659E.2010804@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, =?ISO-8859-1?Q?Heinz-J=FCrg?= =?ISO-8859-1?Q?en_Oertel?= <oe@port.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3C4E0DBB6243BD8ED6B73354
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/18/2012 02:14 PM, Wolfgang Grandegger wrote:
> On 09/17/2012 09:19 PM, Oliver Hartkopp wrote:
>> Hello Heinz,
>>
>> On 17.09.2012 15:58, Heinz-J=FCrgen Oertel wrote:
>>
>>>
>>> is there a way to empty the tx buffer ?
>>
>>
>> Usually the buffer does not get empty due to a problem of the CAN cont=
roller
>> and/or the CAN network.
>>
>> So even if you could flush the queue the CAN controller is probably st=
ill
>> stuck with his processed frame.
>>
>> Setting the interface to DOWN and UP again re-initializes the CAN cont=
roller
>> and flushes all the queues.
>>
>> This would work - but all open sockets would get a notification of the=

>> interface went down.
>>
>> Btw. IIRC there's a IFLA_CAN_RESTART functionality to kick the CAN con=
troller
>> if it got stuck. It can by triggered by a netlink message. This is the=
 same
>> configuration interface that's used to set the bittiming:
>>
>> http://lxr.linux.no/#linux+v3.5.4/include/linux/can/netlink.h#L103
>>
>> But i have currently no source code example as i always use the 'ip' t=
ool from
>> the iproute2 package to configure my CAN interfaces:
>>
>> http://lxr.linux.no/#linux+v3.5.4/Documentation/networking/can.txt#L64=
6
>>
>> Following that documentation
>>
>> 	ip link set can0 type can restart
>>
>> should do it for 'can0'.
>=20
> No, this does only works if a bus-off is pending. See:
>=20
> http://lxr.linux.no/#linux+v3.5.4/drivers/net/can/dev.c#L413
>=20
> Well, the name IFLA_CAN_RESTART is not really well chosen.

Hmmm, it corresponds somewhat to the restart-ms property.

We have several customers who asked how to abort pending TX messages,
too. Which involves:
a) clear the TX-queue in Linux
b) clear queue in hardware
c) abort currently transmitting CAN frame

I think c) would be a usecase of its own, too.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig3C4E0DBB6243BD8ED6B73354
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBYalQACgkQjTAFq1RaXHNk/ACfV8OZIzJJngr+gBnJ/VVr5s42
kCwAniibFtFeBvEqz+J2PuCUEDEdiSuH
=QClN
-----END PGP SIGNATURE-----

--------------enig3C4E0DBB6243BD8ED6B73354--
