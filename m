From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH RESEND 3/5] can: flexcan: adopt pinctrl support
Date: Tue, 03 Jul 2012 12:00:52 +0200
Message-ID: <4FF2C2D4.7070408@pengutronix.de>
References: <1336352040-28447-1-git-send-email-shawn.guo@linaro.org> <1336352040-28447-4-git-send-email-shawn.guo@linaro.org> <4FF0D401.4050101@pengutronix.de> <20120702015206.GA21003@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigACFC88963E0E5E2956459322"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41821 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981Ab2GCKAz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 3 Jul 2012 06:00:55 -0400
In-Reply-To: <20120702015206.GA21003@S2101-09.ap.freescale.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigACFC88963E0E5E2956459322
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/02/2012 03:52 AM, Shawn Guo wrote:
> On Mon, Jul 02, 2012 at 12:49:37AM +0200, Marc Kleine-Budde wrote:
>>> +	pinctrl =3D devm_pinctrl_get_select_default(&pdev->dev);
>>> +	if (IS_ERR(pinctrl))
>>> +		return PTR_ERR(pinctrl);
>>> +
>>>  	if (pdev->dev.of_node) {
>>>  		const u32 *clock_freq_p;
>>
>> I'm on mx28 and trying to load the flexcan driver via DT, but
>> devm_pinctrl_get_select_default fails with -19.
>>
> You need to have pinctrl state setup in dts, some like:
>=20
> http://article.gmane.org/gmane.linux.ports.arm.kernel/174148

Works like charm.

tnx, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigACFC88963E0E5E2956459322
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/ywtQACgkQjTAFq1RaXHNYagCghQ5IJKurTSJIIR4KCtVGvvhN
2iIAn071J5q5FR6GkLfk7+17oBC/9ytM
=SbE8
-----END PGP SIGNATURE-----

--------------enigACFC88963E0E5E2956459322--
