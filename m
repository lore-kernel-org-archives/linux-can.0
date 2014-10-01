From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Writing socketCAN module for my own hardware
Date: Wed, 01 Oct 2014 15:11:56 +0200
Message-ID: <542BFD9C.1000308@pengutronix.de>
References: <53E9C774.3040401@ep1.ruhr-uni-bochum.de> <53E9CF27.90400@pengutronix.de> <53E9D6F3.4050206@ep1.ruhr-uni-bochum.de> <53E9E614.7060303@pengutronix.de> <542BACC0.4050707@ep1.ruhr-uni-bochum.de> <542BB21B.4030200@pengutronix.de> <542BF456.3030201@ep1.ruhr-uni-bochum.de> <542BF687.1000800@pengutronix.de> <542BF9FD.5060209@ep1.ruhr-uni-bochum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="sAR6KGSw4H1iWHKsFwKMWK8B0uAb8BwD0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46797 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbaJANMD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Oct 2014 09:12:03 -0400
In-Reply-To: <542BF9FD.5060209@ep1.ruhr-uni-bochum.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Florian Feldbauer <florian@ep1.ruhr-uni-bochum.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sAR6KGSw4H1iWHKsFwKMWK8B0uAb8BwD0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/01/2014 02:56 PM, Florian Feldbauer wrote:
>> BTW: what's the use-case of the rpi, better buy a beagle bone black.
>> IIRC you need to attach the CAN phy, and you're ready to go. It comes
>> with two internal CAN cores, the first one is quite easy to setup, the=

>> second one uses the same pins as one the the I2C busses, which has to =
be
>> disabled then... And you can use a proper mainline kernel.

> I'm working at the university for experimental hadron physik. And for
> our experiment we need a low budget, high performance CANbus interface
> running under Linux.

High performance and bit banging in one sentence (or SoC) is a bit
contradictory :)

> We came up with the idea of the Rpi, since it's small, it has ethernet,=

> and it is
> cheap (~30 euro). And with the sja1000 connected to the GPIOs you can
> achieve
> the high data throughput (up to 6666 extended data frames with 8 byte
> length @1Mbit/s)

Beagle Bone is about ~60=E2=82=AC in single quantities.

> Actually I don't know if any other embedded linux board like the beagle=

> bone
> was considered...

:(

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--sAR6KGSw4H1iWHKsFwKMWK8B0uAb8BwD0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQr/ZwACgkQjTAFq1RaXHNhoQCaAj+ECUWOoNTxnN5iS++UkTGj
/IwAn1IXeELeOS+zOWsjghOHPehkTvUg
=uA+D
-----END PGP SIGNATURE-----

--sAR6KGSw4H1iWHKsFwKMWK8B0uAb8BwD0--
