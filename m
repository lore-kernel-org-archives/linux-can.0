From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] can-utils: add Makefile for Android build system
Date: Thu, 22 Mar 2012 11:51:29 +0100
Message-ID: <4F6B0431.1020803@pengutronix.de>
References: <1332236859-22204-1-git-send-email-yegorslists@googlemail.com> <1332236859-22204-2-git-send-email-yegorslists@googlemail.com> <4F685737.6090700@pengutronix.de> <4F6AFBCE.40305@visionsystems.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4A56894530B37DD391EF6967"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47603 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309Ab2CVKvo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Mar 2012 06:51:44 -0400
In-Reply-To: <4F6AFBCE.40305@visionsystems.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: yegor_sub1@visionsystems.de
Cc: yegorslists@googlemail.com, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4A56894530B37DD391EF6967
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/22/2012 11:15 AM, Yegor Yefremov wrote:
> Am 20.03.2012 11:08, schrieb Marc Kleine-Budde:
>> On 03/20/2012 10:47 AM, yegorslists@googlemail.com wrote:
>>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>>
>>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> Looks a bit ugly to me (as a non Android developer) repeating some
>> variables so many times. Is it usual to write android makefiles like t=
his?
>=20
> Yes, it is really ugly :-( I'd like Android to have Buildroot like
> build system, so that native autotools/cmake/ etc. could be used
> directly. I've looked at other external packages in Android and took
> their Android.mk as a template.

Okay...seems you know what you're doing :)

>> There are some trailing whitespaces. No need to recommit the patch, I'=
ve
>> removed them.
>=20
> Working with quilt was easier regarding trailing white spaces. I'm
> looking for git way of removing them.
>=20
> I've seen the first patch committed, this is one is still not
> committed as far as I can see. Do I need to rework something?

No - I just wanted to have a statement on the ugliness :) I'll commit
the patch now.

Thanks, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig4A56894530B37DD391EF6967
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9rBDEACgkQjTAFq1RaXHNHwQCcC39TVsH5xug5pP5PpLzl1/by
2CAAnA6AozNfdvtaHY38mW+/MFrU/I2O
=yXQ1
-----END PGP SIGNATURE-----

--------------enig4A56894530B37DD391EF6967--
