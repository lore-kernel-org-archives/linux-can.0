From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH can-utils v4 4/4] isotp.h: add explicit license information
Date: Thu, 16 Jan 2014 23:05:25 +0100
Message-ID: <52D857A5.2090206@pengutronix.de>
References: <52D45B4C.3070009@hartkopp.net> <1389650236-13542-1-git-send-email-u.kleine-koenig@pengutronix.de> <1389650236-13542-5-git-send-email-u.kleine-koenig@pengutronix.de> <52D4E0CD.2040706@hartkopp.net> <20140114084616.GR29475@pengutronix.de> <20140116191835.GB25911@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cqgd0oGS8aAwHOJntC8NW2MQwJ2NGGk77"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58871 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbaAPWFa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 16 Jan 2014 17:05:30 -0500
In-Reply-To: <20140116191835.GB25911@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cqgd0oGS8aAwHOJntC8NW2MQwJ2NGGk77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/16/2014 08:18 PM, Uwe Kleine-K=C3=B6nig wrote:
>> On Tue, Jan 14, 2014 at 08:01:33AM +0100, Oliver Hartkopp wrote:
>>> On 13.01.2014 22:57, Uwe Kleine-K=C3=B6nig wrote:
>>>> It seems this file was originally part of the Linux kernel as it was=
 created
>>>> by commit 77de10356fe0 (include: import kernel header files into tre=
e) but I
>>>> couldn't find it in the git history of the kernel.
>>>
>>> This comes from the original development process in the BerliOS SVN.
>>> The fact that these files are kernel header files does not necessaril=
y mean
>>> they have been imported from the kernel source tree :-)
>> Strange concept. Either you need some additional Userspace API in the
>> kernel for your isotp programs or you don't. In the first case there
>> must be a header in the kernel providing that API (if not in mainline
>> that at least in some can tree). In the latter case where everything
>> works with the kernel as is, you shouldn't declare something to be a
>> kernel header that doesn't need to.

> Looking a bit into the isotp*.c files it seems the isotp header falls
> into the first category, i.e. you need kernel support to use these. Is
> that correct? Is there an up-to-date kernel tree somewhere that holds
> the necessary patches? If yes, I suggest to document that tree somewher=
e
> in can-utils to be the source for the kernel headers.

Isotp is an external Kernel module.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--cqgd0oGS8aAwHOJntC8NW2MQwJ2NGGk77
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLYV6UACgkQjTAFq1RaXHNBRgCeIPYluSL8kL244OtARm+d8z2D
dmwAni3jrQrVCdEVULH/SjjgKkAN0KBv
=MvXR
-----END PGP SIGNATURE-----

--cqgd0oGS8aAwHOJntC8NW2MQwJ2NGGk77--
