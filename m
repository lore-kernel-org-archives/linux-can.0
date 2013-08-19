From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [Socketcan-users] Finding a transmitter's CAN ID
Date: Mon, 19 Aug 2013 17:11:50 +0200
Message-ID: <521235B6.6020502@pengutronix.de>
References: <1376923439605-7678.post@n3.nabble.com> <521232ED.4050607@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cF9FrLkFIFrivEjTOrIKTd1Et16XNW5hO"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40793 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946Ab3HSPL7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 Aug 2013 11:11:59 -0400
In-Reply-To: <521232ED.4050607@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Rob__V <r.valler@enextra.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cF9FrLkFIFrivEjTOrIKTd1Et16XNW5hO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/19/2013 04:59 PM, Marc Kleine-Budde wrote:
>> I am currently working on a project with several embedded platforms co=
nnect
>> via CAN:
>> 1 x Linux board connected via SocketCAN
>> N x embedded boards using the Atmega16M1 (CAN) MCU.
>>
>> The Linux board is 'treated' as the master and needs to know the CAN I=
D of
>> each
>> atmega board that sends it a CAN message. So my question is :
>>
>> How is the Linux/SocketCAN board able to determine the CAN ID of other=

>> networked nodes when they transmit ?

When we're talking about RAW CAN frames, there is no such thing as CAN
id of a node, it's not an address. Neither sending nor receiving. Think
of the CAN id more as a part of the data of the CAN frame.

Depending on your higher level protocol there might be an addressing
scheme which makes use of the CAN id. Then there is probably a CAN id
(or part of) associated which each node.

Are you using some kind of (standardised) protocol on top of RAW CAN?

>> Of course, each CAN node can determine the target ID for each message =
but
>> I am not sure if the source ID is known ... outside of arbitration.

For arbitration purpose the CAN id of each CAN frame is used. All nodes
that receive the CAN frame receive the same CAN id, in particular the
CAN id the sending node put into the CAN frame.

Under Linux the CAN if is stored in the "can_id" member of the "struct
can_frame" (which is used for both sending and receiving CAN frames).

> struct can_frame {
>         canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
>         __u8    can_dlc; /* frame payload length in byte (0 .. CAN_MAX_=
DLEN) */
>         __u8    data[CAN_MAX_DLEN] __attribute__((aligned(8)));
> };

Hope that helps,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--cF9FrLkFIFrivEjTOrIKTd1Et16XNW5hO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlISNbYACgkQjTAFq1RaXHPT0ACfT0o3Y20RKDnv6ohOFUbS8Z/s
G6EAoIpre4UjNLhBB5j0C/78e5K6NM3s
=1god
-----END PGP SIGNATURE-----

--cF9FrLkFIFrivEjTOrIKTd1Et16XNW5hO--
