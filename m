From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5 5/5] include: Move includes copied from the Linux kernel
 into include/linux
Date: Fri, 17 Jan 2014 15:04:53 +0100
Message-ID: <52D93885.5040109@pengutronix.de>
References: <1389888754-23013-1-git-send-email-mkl@pengutronix.de> <1389888754-23013-6-git-send-email-mkl@pengutronix.de> <20140116192818.GC25911@pengutronix.de> <52D85910.8000200@pengutronix.de> <20140117133709.GD25911@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="J3QEbUpVHjNNFJKViHTLJWETNCNuSxBrj"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55542 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbaAQOjh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jan 2014 09:39:37 -0500
In-Reply-To: <20140117133709.GD25911@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J3QEbUpVHjNNFJKViHTLJWETNCNuSxBrj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/17/2014 02:37 PM, Uwe Kleine-K=C3=B6nig wrote:
> Hallo Marc,
>=20
> On Thu, Jan 16, 2014 at 11:11:28PM +0100, Marc Kleine-Budde wrote:
>> On 01/16/2014 08:28 PM, Uwe Kleine-K=C3=B6nig wrote:
>>> On Thu, Jan 16, 2014 at 05:12:34PM +0100, Marc Kleine-Budde wrote:
>>>> From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>>>>
>>>> This makes it possible to update the copies more easily, e.g.:
>>>>
>>>> 	cd $path_to_linux_repo
>>>> 	make headers_install
>>>> 	rsync -a --delete --exclude .\* usr/include/linux/can* $path_to_can=
_utils/include/linux
>>>>
>>>> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>>
>>> I want to have pointed out in the commit log that it was you who adde=
d
>>> isotp.h to the move. I don't care that much for your split into two
>>> patches to fix the #includes first, but IMHO that should be documente=
d,
>>> too.
>>
>> Yes, but no. I imported the isotp header, but not from the kernel. It
>> was imported from the berlios svn repo.

> I didn't mean isotp when it was added to can-utils, but compared to my
> patch "include: Move includes copied from the Linux kernel into
> include/linux" you also moved isotp.h from socketcan/can to linux/can i=
n
> can-utils. That's what I thought you should point out. That this change=

> makes the changelog wrong is another issue.

Then I'll change the commit message to "move all headers from
socketcan/can to linux/can".

> Where can this external kernel module be found? IMHO it would be worth
> to point to its (hopefully) git repository in isotp{*.c,.h}.

https://gitorious.org/linux-can/can-modules

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--J3QEbUpVHjNNFJKViHTLJWETNCNuSxBrj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLZOIUACgkQjTAFq1RaXHOJXQCeK9gZHpLucQWBrOH/4NtECbjf
2REAnjPA5RE8/WSR1d1oRIIKxVcK1lBL
=IgdA
-----END PGP SIGNATURE-----

--J3QEbUpVHjNNFJKViHTLJWETNCNuSxBrj--
