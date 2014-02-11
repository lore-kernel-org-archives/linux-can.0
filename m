From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: kvaser_usb: check number of channels returned by
 HW
Date: Tue, 11 Feb 2014 13:36:13 +0100
Message-ID: <52FA193D.40205@pengutronix.de>
References: <1392112884-27101-1-git-send-email-olivier@sobrie.be> <52F9F6F5.6090209@pengutronix.de> <20140211123218.GA8818@hposo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="QIVJ9uNPaj8TrUUS34rKHDllW5fmPt7vQ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52934 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbaBKMgP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Feb 2014 07:36:15 -0500
In-Reply-To: <20140211123218.GA8818@hposo>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Olivier Sobrie <olivier@sobrie.be>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QIVJ9uNPaj8TrUUS34rKHDllW5fmPt7vQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/11/2014 01:33 PM, Olivier Sobrie wrote:
> Hello Marc,
>=20
> On Tue, Feb 11, 2014 at 11:09:57AM +0100, Marc Kleine-Budde wrote:
>> On 02/11/2014 11:01 AM, Olivier Sobrie wrote:
>>> It is needed to check the number of channels returned by the HW
>>> because it cannot be greater than MAX_NET_DEVICES otherwise
>>> it will crash.
>>>
>>> Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
>>
>> Does this bug occur on any kvaser USB hardware?
>=20
> I never see it with the devices I have and nobody reported me a problem=

> regarding this. I found this bug by chance while I was looking to add
> support for Kvaser device from usbcanII family.

Tnx, I'll include the patch in my next pull request to David.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--QIVJ9uNPaj8TrUUS34rKHDllW5fmPt7vQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlL6GT0ACgkQjTAFq1RaXHOSLgCaAgbENecsEbQ3DFUUvy7YJt5V
ByIAoI+ZS/QJdKIjR7obVAZR9LCy4iB+
=0o7t
-----END PGP SIGNATURE-----

--QIVJ9uNPaj8TrUUS34rKHDllW5fmPt7vQ--
