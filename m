From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: arbitration lost error reporting (was: Re: [PATCH v6] can: sja1000:
 fix {pre,post}_irq() handling and IRQ handler return value)
Date: Fri, 06 Dec 2013 12:45:30 +0100
Message-ID: <52A1B8DA.1030700@pengutronix.de>
References: <1385334220-31887-1-git-send-email-mkl@pengutronix.de> <loom.20131205T164221-222@post.gmane.org> <52A0BCD9.4090309@grandegger.com> <loom.20131205T202627-307@post.gmane.org> <52A0E185.1080402@grandegger.com> <loom.20131206T100036-664@post.gmane.org> <52A1A323.1030605@pengutronix.de> <loom.20131206T114831-779@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="KHQAFQOoikW5pfOtdcDgNLOV8qCn0H3la"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45797 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757844Ab3LFLpk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 6 Dec 2013 06:45:40 -0500
In-Reply-To: <loom.20131206T114831-779@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Richard Andrysek <richard.andrysek@rg-mechatronics.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KHQAFQOoikW5pfOtdcDgNLOV8qCn0H3la
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2013 11:57 AM, Richard Andrysek wrote:
>> You can send a diff, to illustrate your changes.
>=20
> $ diff /cygdrive/X/bug1/sja1000.c /cygdrive/X/modified_sja1000.c

"diff -u" is preferred, but no need to resend it.

>>> But I prefare to make some kind of "ioctl" support for that. There ar=
e
>>> applications, where it shall not happend. Concurrently I've played wi=
th
>>> taskset and priorities.
>>
>> ioctl() is not a option here, but there are two options:
>> 1) We can put the arbitration lost error to the bus errors,
>>    but I think that's wrong.
>> 2) You can add another ctrlmode to disable arbitration lost error
>>    reporting.

> As Wolgang mentioned it has nothing to do with the patch v6.
> Enabling/diabling IRQs is a new feature. So I don't know, if here it is=
 a
> right place to continue about that.

Yes, why not? :)
As I outlined above you have two options. I prefer option 2 and it has a
big change of going mainline. The implementation is similar to
CAN_CTRLMODE_BERR_REPORTING, just look for it in the kernel source tree
and add a new define for arbitration lost error reporting.

Do you have a preferred name for the define?
- CAN_CTRLMODE_AERR_REPORTING
- CAN_CTRLMODE_ARBITRATIONERR_REPORTING to

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--KHQAFQOoikW5pfOtdcDgNLOV8qCn0H3la
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKhuNoACgkQjTAFq1RaXHP81QCfXFBRG7sMsWQUmhJHMuUJt8ky
GFIAn1YyBirNet+WWN9V/1Tk/x8HA8Hp
=5reg
-----END PGP SIGNATURE-----

--KHQAFQOoikW5pfOtdcDgNLOV8qCn0H3la--
