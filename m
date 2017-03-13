From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: at91 driver lost CAN messages
Date: Mon, 13 Mar 2017 10:47:10 +0100
Message-ID: <1cfeef11-69e0-53c1-f95a-0340cce5803e@pengutronix.de>
References: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de>
 <ee9c0d9d-6cd6-f93b-2f2b-8306777781c3@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="BUldtU44Tpnb56U50gkTQN1eVS5tBStmB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60747 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751537AbdCMJrX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Mar 2017 05:47:23 -0400
In-Reply-To: <ee9c0d9d-6cd6-f93b-2f2b-8306777781c3@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Efim Monjak <emonjak@lipowsky.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BUldtU44Tpnb56U50gkTQN1eVS5tBStmB
Content-Type: multipart/mixed; boundary="6plgAOHdemtVEUcWDTsjNPceEv4Mup8qG";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Efim Monjak <emonjak@lipowsky.de>, linux-can@vger.kernel.org
Message-ID: <1cfeef11-69e0-53c1-f95a-0340cce5803e@pengutronix.de>
Subject: Re: at91 driver lost CAN messages
References: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de>
 <ee9c0d9d-6cd6-f93b-2f2b-8306777781c3@hartkopp.net>
In-Reply-To: <ee9c0d9d-6cd6-f93b-2f2b-8306777781c3@hartkopp.net>

--6plgAOHdemtVEUcWDTsjNPceEv4Mup8qG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/12/2017 12:06 AM, Oliver Hartkopp wrote:
> thanks for the patch!
>=20
> In fact I always thought NAPI is too heavy for CAN controllers. NAPI wa=
s=20
> intended for a very high interrupt load on some ethernet controllers=20
> with some considerable RX FIFO.
>=20
> I have a 20 CAN interfaces (SJA1000 driver) Core i7 system receiving=20
> ~22.000 frames/s without any problems, with an one-element FIFO and=20
> without NAPI.
>=20
> @Marc: What was the reason to implement NAPI that days? Has it ever bee=
n=20
> proved that NAPI had a remarkable positive effect in opposite to a=20
> direct CAN frame processing in the interrupt context?

On SMP systems the network stack doesn't seem to guarantee the order of
frames when put into the stack in IRQ context.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--6plgAOHdemtVEUcWDTsjNPceEv4Mup8qG--

--BUldtU44Tpnb56U50gkTQN1eVS5tBStmB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAljGaqMACgkQHv7KIOw4
HPaGiwf9F160fVO9tjdDAkoR3c1qkVhKTSWKfhiob6+CXyGRm8QHvpF5VcJ5hHLC
+5tFXizVLUO1+hZqzYGikyTHT5iyC6XK36wO+5+pYs/Q3MNsH+oHu8lmMIExw1P5
iF8z+B0iDhfj6Fv4EXJzgmE9A3c7nS58zMeqm3kgJmLKiozjUMby5E8i6WCz2Nwq
yn4lfuBB6dxHICI81dYxNJ/gYpHqkiqT0mHVTGnRW9V+gaeEUrzb9s/2KByf9MuB
Zpzpx2AF7947hRNZDAdVX9cv1S0PbfOr54no9xDvleJx2Pfga+eR6F4CBVXTpyEC
LjUGdBBrrW5mRQhf2/RIbMLuqQqHLg==
=eT2W
-----END PGP SIGNATURE-----

--BUldtU44Tpnb56U50gkTQN1eVS5tBStmB--
