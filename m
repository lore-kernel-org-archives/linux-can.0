From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [Socketcan-users] Socketcan-users Digest, Vol 77, Issue 2
Date: Tue, 20 Aug 2013 13:02:40 +0200
Message-ID: <52134CD0.5030209@pengutronix.de>
References: <mailman.17.1376992804.28649.socketcan-users@lists.berlios.de> <8A49CFF5759B8644A46158D75AFC117D68584B51@AUSP01DAG0102.collaborationhost.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="aB1PFItNMlfX6X04ofe61DoKMiVCaGFIQ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45762 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981Ab3HTLCr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 Aug 2013 07:02:47 -0400
In-Reply-To: <8A49CFF5759B8644A46158D75AFC117D68584B51@AUSP01DAG0102.collaborationhost.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Anil Mathews (India - Bangalore)" <anil.mathews@mindteck.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Rob__V <r.valler@enextra.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aB1PFItNMlfX6X04ofe61DoKMiVCaGFIQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/20/2013 12:42 PM, Anil Mathews (India - Bangalore) wrote:
> Hi Rob,

> As per my understanding every CAN node should have a hardcoded
> address accessed from rotary switch,or read from eeprom etc.Every
> message ID should be anded with this CAN ID so that each message will
> be unique in the network.Now each individual CAN nodes will process
> these messages using their filter and mask and if it matches they can
> extract the CAN ID and take appropriate action.All these action code
> for a particular CAN ID our application should be capable to do.

What you describe is a layer on top of raw CAN. There are many different
layers on top of raw CAN, some of them are even standardized. The usage
of the CAN id  depends on the uppers layers.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--aB1PFItNMlfX6X04ofe61DoKMiVCaGFIQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlITTNAACgkQjTAFq1RaXHPmPwCghIO/hwvJ9B2qaVIgmBG+rv8k
Ec0An3zcD5UUqJUhUUmm7ABJ0WLlNEsi
=b1bL
-----END PGP SIGNATURE-----

--aB1PFItNMlfX6X04ofe61DoKMiVCaGFIQ--
