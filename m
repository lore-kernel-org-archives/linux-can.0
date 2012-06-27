From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 4/4] can: flexcan: add transceiver switch support when
 use device tree
Date: Wed, 27 Jun 2012 13:46:53 +0200
Message-ID: <4FEAF2AD.1070308@pengutronix.de>
References: <1340785161-3598-1-git-send-email-jason77.wang@gmail.com> <1340785161-3598-2-git-send-email-jason77.wang@gmail.com> <1340785161-3598-3-git-send-email-jason77.wang@gmail.com> <1340785161-3598-4-git-send-email-jason77.wang@gmail.com> <1340785161-3598-5-git-send-email-jason77.wang@gmail.com> <4FEAC3AA.500@pengutronix.de> <4FEAD897.5070408@gmail.com> <CAAQ0ZWSOJog+S3780wD63ObJ6YUfC9T_zOUPzto3esF-W4fnXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig96CEAEBA5816A224731605AC"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40754 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605Ab2F0Lq7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jun 2012 07:46:59 -0400
In-Reply-To: <CAAQ0ZWSOJog+S3780wD63ObJ6YUfC9T_zOUPzto3esF-W4fnXw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Hui Wang <jason77.wang@gmail.com>, davem@davemloft.net, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig96CEAEBA5816A224731605AC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/27/2012 01:22 PM, Shawn Guo wrote:
> On 27 June 2012 17:55, Hui Wang <jason77.wang@gmail.com> wrote:
>> After read and compared with his patch:
>> 1. Shawn use gpio_is_valid(gpio) instead of (gpio >=3D 0), it is good.=

>> 2. Shawn add a flag to record active level, it is good.
>> 3. Shawn only add 1 gpio, this is not enough for imx6 sabre lite board=
=2E
>> 4. Shawn forget to call gpio_release()
>=20
> I'm about to resend my series to have linux-can copied and use
> devm_gpio_request_one instead.  Do you want me to add STBY gpio
> support into my patch?

devm is a good idea.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig96CEAEBA5816A224731605AC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/q8q0ACgkQjTAFq1RaXHPTtwCfTFAoOHwMLrm7/tCFnEZHs8ds
X5IAnjy1//4PBwHMTaYCU1Z6hH8gEckV
=U5Y0
-----END PGP SIGNATURE-----

--------------enig96CEAEBA5816A224731605AC--
