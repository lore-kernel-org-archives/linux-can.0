From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC] can: Introducing CANFD for af_can & can-raw
Date: Wed, 21 Mar 2012 12:43:31 +0100
Message-ID: <4F69BEE3.2040705@pengutronix.de>
References: <20120321091055.GA433@vandijck-laurijssen.be> <E1SAIM4-0007a6-Sf@smtprelay03.ispgateway.de> <20120321110502.GA3372@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA51A0793C2BCE8282C67D91F"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54077 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835Ab2CULnm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Mar 2012 07:43:42 -0400
In-Reply-To: <20120321110502.GA3372@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: dev@sebastianhaas.info, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA51A0793C2BCE8282C67D91F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/21/2012 12:05 PM, Kurt Van Dijck wrote:
> Hi Sebastian,
>=20
> On the ICC, Bosch presentend CANFD[1].
> I'll share my interpretation:
> * CANFD is meant as a successor of CAN.
> * it addressess data throughput in 2 ways:
>   - higher data bitrate for data using a second
>     set of bittimings.
>   - longer message payload (up to 64 byte).
> * it remains very compatible to CAN, although _NOT_
>   bus-compatible (ie. you put it on a seperate bus).

This means:
You cannot have a Bus using one (or more) of the CAN-FD features with
non CAN-FD compatible nodes.

=46rom my point of view this can be translated into a new property in
"can.ctrlmode_supported". A device adds "CAN_CTRLMODE_CANFD" if it
supports CAN FD mode. Then it's a global setting to put the device into
CAN FD mode.

In the TX path the stack should refuse the new 64 byte frames at all or
frames with dlc > 8 byes if the device is not in CAN FD mode. What about
the RX path? We can just use the new 64 byte CAN frames and have to
tweak the CAN_RAW if the read from the userspace is too small.

regards, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigA51A0793C2BCE8282C67D91F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9pvuYACgkQjTAFq1RaXHNPVQCcCYqb3TEMhSxpmUe/Semd3o9l
XK4AnRk3XOr4BS59Pvd7O34/bmyGIyJ4
=cNys
-----END PGP SIGNATURE-----

--------------enigA51A0793C2BCE8282C67D91F--
