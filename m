From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Mon, 07 Apr 2014 14:07:21 +0200
Message-ID: <534294F9.8030102@pengutronix.de>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <533DAB54.8010008@grandegger.com> <9040333.kfdMrH1CV1@ws-stein> <alpine.DEB.2.02.1404071405460.14882@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="HdXXdXHOwp4kjKOaRHfmCdpB2lIeqVnhW"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37784 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510AbaDGMHX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Apr 2014 08:07:23 -0400
In-Reply-To: <alpine.DEB.2.02.1404071405460.14882@ionos.tec.linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HdXXdXHOwp4kjKOaRHfmCdpB2lIeqVnhW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/07/2014 02:06 PM, Thomas Gleixner wrote:
> On Mon, 7 Apr 2014, Alexander Stein wrote:
>=20
>> Hello Wolfgang,
>>
>> On Thursday 03 April 2014 20:41:24, Wolfgang Grandegger wrote:
>>> On 04/03/2014 04:14 PM, Alexander Stein wrote:
>>>> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.co=
m>
>>>
>>> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
>>>
>>> In my patch stack I have also th patch below. Could you please give i=
t
>>> I try before I re-submit it. Thanks.
>>
>> With this patch the driver still works, at least MSI is working. The o=
ther problems still exist.
>>
>=20
> Which problems do still exist?

IIRC:
Either potentially reordered frames or dropped frames.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--HdXXdXHOwp4kjKOaRHfmCdpB2lIeqVnhW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNClPkACgkQjTAFq1RaXHP0rgCfYeiO48qB3MOy3/LwuvfJMuCX
1MAAnioHBv09w3bMzTAInzQ1Ck+1knY6
=T600
-----END PGP SIGNATURE-----

--HdXXdXHOwp4kjKOaRHfmCdpB2lIeqVnhW--
