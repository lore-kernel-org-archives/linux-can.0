From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3] can: flexcan: disable bus error interrupts for the
 i.MX6q
Date: Thu, 11 Oct 2012 17:28:16 +0200
Message-ID: <5076E590.5000903@pengutronix.de>
References: <1349962762-24500-1-git-send-email-mkl@pengutronix.de> <5076E34C.3090404@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF04EFE3C168AFA824040A898"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44923 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932303Ab2JKP22 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 11 Oct 2012 11:28:28 -0400
In-Reply-To: <5076E34C.3090404@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, Hui Wang <jason77.wang@gmail.com>, Shawn Guo <shawn.guo@linaro.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF04EFE3C168AFA824040A898
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/11/2012 05:18 PM, Wolfgang Grandegger wrote:
> Hi Marc,
>=20
> On 10/11/2012 03:39 PM, Marc Kleine-Budde wrote:
>> From: Wolfgang Grandegger <wg@grandegger.com>
>>
>> Due to a bug in most Flexcan cores, the bus error interrupt needs
>> to be enabled. Otherwise we don't get any error warning or passive
>> interrupts. This is _not_ necessary for the i.MX6q and this patch
>> disables bus error interrupts if "berr-reporting" is not requested.
>> This avoids bus error flooding, which might harm, especially on
>> low-end systems.
>=20
> Should be something like:
>=20
> This patch adds some Flexcan version info and removes the feature flag
> FLEXCAN_HAS_BROKEN_ERR_STATE for the i.MX6Q. It also has the line
> [TR]WRN_INT properly connected.

Tnx, I've send a v4 with the new commit message.

>=20
>> Cc: Hui Wang <jason77.wang@gmail.com>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
>> [mkl: convert to incremental patch]
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>> Changes since v3:
>> - convert to incremental patch
>> - update mx6 glitch filter information
>> ---
>> Hello Wolfgang,
>>
>> I've converted your patch so that it can be applied to current net, wh=
ere David
>> already accepted your v1 version of the patch.
>=20
> Thanks, I will not have time before this evening. Looks good, apart fro=
m
> the commit message. Feel free to go ahead.

Will do,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigF04EFE3C168AFA824040A898
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlB25ZcACgkQjTAFq1RaXHM5mQCfayurBprlfiAqdZ3pmA28hoqf
9DIAn1g63gb3I/WdnlSDtKpxrChY9pmi
=jJxh
-----END PGP SIGNATURE-----

--------------enigF04EFE3C168AFA824040A898--
