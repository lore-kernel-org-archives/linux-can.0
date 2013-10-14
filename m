From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH can-next] Add broadcast manager documentation
Date: Mon, 14 Oct 2013 22:02:08 +0200
Message-ID: <525C4DC0.5030107@pengutronix.de>
References: <CAENe87otPZVjDkvJJDR4CLE2e4dcyzde1=5rQZWytG_JyOpvsQ@mail.gmail.com> <525C48F8.1050907@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Ekl6OFguT8QeWEugDjjqeivaegOj0Qrli"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53689 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756057Ab3JNUCS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 14 Oct 2013 16:02:18 -0400
In-Reply-To: <525C48F8.1050907@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Brian Thorne <hardbyte@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ekl6OFguT8QeWEugDjjqeivaegOj0Qrli
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/14/2013 09:41 PM, Oliver Hartkopp wrote:
> On 08.10.2013 02:56, Brian Thorne wrote:
>> Hi all,
>>
>> I wanted to use the bcm module and ended up putting together some basi=
c findings
>> that might be a useful addition to the can.txt documentation.
>>
>> I haven't tried submitting any patches before so please point out any =
mistakes.
>>
>> Cheers,
>> Brian
>>
>=20
> Hi Brian,
>=20
> I updated and enhanced your documentation patch for the broadcast manag=
er.
>=20
> Please review and make your annotations inline.
>=20
> Tnx,
> Oliver
>=20
>=20
>=20
>=20
> Signed-off-by: Brian Thorne <hardbyte@gmail.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>=20
> ---
>=20
> diff --git a/Documentation/networking/can.txt b/Documentation/networkin=
g/can.txt
> index 820f553..f227ba6 100644
> --- a/Documentation/networking/can.txt
> +++ b/Documentation/networking/can.txt
> @@ -25,6 +25,10 @@ This file contains
>        4.1.5 RAW socket option CAN_RAW_FD_FRAMES
>        4.1.6 RAW socket returned message flags
>      4.2 Broadcast Manager protocol sockets (SOCK_DGRAM)
> +      4.2.1 Broadcast Manager Operations
> +      4.2.2 Broadcast Manager message flags
> +      4.2.3 Broadcast Manager message sequence transmission
> +      4.2.4 Broadcast Manager multiplex message receive filter
>      4.3 connected transport protocols (SOCK_SEQPACKET)
>      4.4 unconnected transport protocols (SOCK_DGRAM)
> =20
> @@ -593,6 +597,161 @@ solution for a couple of reasons:
>        In order to receive such messages, CAN_RAW_RECV_OWN_MSGS must be=
 set.
> =20
>    4.2 Broadcast Manager protocol sockets (SOCK_DGRAM)
> +
> +  The Broadcast Manager protocol provides a command based configuratio=
n
> +  interface to filter and send (e.g. cyclic) CAN messages in kernel sp=
ace.
> +
> +  Receive filters can be used to down sample frequent messages; detect=
 events
> +  such as message contents changes, packet length changes, and do time=
-out
> +  monitoring of received messages.
> +
> +  Periodic transmissions can be modified at runtime; both the message =
content
> +  and the transmit interval can be altered. Periodic transmissions can=
 use two
> +  intervals, sending a number of messages at a interval ival1, then co=
ntinuing
> +  to send at another given interval ival2.
> +
> +  A BCM socket is not intended for sending individual CAN frames using=
 the
> +  struct can_frame as known from the CAN_RAW socket. Instead a special=
 BCM
> +  configuration message is defined. The basic BCM configuration messag=
e used
> +  to communicate with the broadcast manager and the available operatio=
ns are
> +  defined in the linux/can/bcm.h include. The BCM message consists of =
a

Nitpick
It's "include/uapi/linux/can/bcm.h" in recent kernel trees.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Ekl6OFguT8QeWEugDjjqeivaegOj0Qrli
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJcTcQACgkQjTAFq1RaXHNebQCfW+Be4b3ZwoWcEexA4QIsTpFr
fBIAniPlLauAsAUuhRJzrJitG119A8lm
=mgkm
-----END PGP SIGNATURE-----

--Ekl6OFguT8QeWEugDjjqeivaegOj0Qrli--
