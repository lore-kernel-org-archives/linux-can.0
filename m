From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Question about D_CAN implementation
Date: Tue, 12 Nov 2013 23:50:03 +0100
Message-ID: <5282B09B.6020307@pengutronix.de>
References: <CAF03EBfWAS=JG923ainNts0zqnCKGfBTbNWihC8qsFXu6QfwGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="vKE5IhiSr50pQmMGCrxc6geKA6DRi13dp"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34150 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757186Ab3KLWuM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Nov 2013 17:50:12 -0500
In-Reply-To: <CAF03EBfWAS=JG923ainNts0zqnCKGfBTbNWihC8qsFXu6QfwGg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: T Thayer <tthayer.linux@gmail.com>
Cc: anilkumar@ti.com, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vKE5IhiSr50pQmMGCrxc6geKA6DRi13dp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/12/2013 11:30 PM, T Thayer wrote:
> I'm experimenting with the combined C_CAN/D_CAN Linux driver for the
> Altera CycloneV SoC which uses the Bosch D_CAN module..
>=20
> I'm having some problems though. Specifically, I'm seeing 2 copies of
> a frame get transmitted.

Where do you see 2 copies of the frame?

> Strangely, the IRQ Status register =3D 0x800A inside the c_can_poll()
> function indicates a RX message object (0 <  RX < 16) instead of a TX
> message object.
>=20
> If I use the standalone D_CAN driver which was in the
> drivers/net/can/d_can directory, it seems to work fine (IRQ Status =3D
> 0x8011). I believe this directory was removed when the c_can and d_can
> drivers were combined (SHA 69927fccd96b15bd228bb82d)

There never was a mainline kernel with drivers/net/can/d_can.

> I noticed some significant differences - particularly in the
> c_can_poll() function.
> IRQ Status Test.
> - d_can.c ANDs the irqstatus with STATUS_INTERRUPT
> - c_can.c checks to see if the irqstatus =3D=3D STATUS_INTERRUPT.
> After IRQ Status Test.
> - d_can.c has a separate if/else if loop to determine whether the
> Message was RX/TX
> - c_can.c has is a continuation of the IRQ status test (else if, else i=
f)
>=20
> Another symptom is that the tx_packet statistics aren't incrementing
> as I send data. However, this may be related to the IRQ indicating a
> RX message object.
>=20
> Thank you for any insight you may have,

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--vKE5IhiSr50pQmMGCrxc6geKA6DRi13dp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKCsJsACgkQjTAFq1RaXHNlsgCeLus5/1M2fk6WoQOoKwKKzDBz
guUAn1ynGOF3FHEFJRhnTPauJm0MbtF7
=Uuna
-----END PGP SIGNATURE-----

--vKE5IhiSr50pQmMGCrxc6geKA6DRi13dp--
