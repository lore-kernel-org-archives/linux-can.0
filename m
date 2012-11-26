From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC 0/6] pch_can/c_can: fix races and add PCH support to c_can
Date: Mon, 26 Nov 2012 09:59:14 +0100
Message-ID: <50B32F62.9090507@pengutronix.de>
References: <1353918186-4234-1-git-send-email-wg@grandegger.com> <50B32CAC.4050501@pengutronix.de> <50B32D40.1040507@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBC85D9680C94C01C04CADEE6"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39560 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754081Ab2KZI7S (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 03:59:18 -0500
In-Reply-To: <50B32D40.1040507@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBC85D9680C94C01C04CADEE6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/26/2012 09:50 AM, Wolfgang Grandegger wrote:
> On 11/26/2012 09:47 AM, Marc Kleine-Budde wrote:
>> On 11/26/2012 09:23 AM, Wolfgang Grandegger wrote:
>>> Hello,
>>>
>>> as you might have already realized, Michael has reported problems wit=
h
>>> the PCH_CAN driver. With his help we try to fix these issues and add
>>> PCH PCI support to the C_CAN driver replacing the PCH_CAN driver soon=
er
>>> than later. Here follows my current patch stack for the records. When=

>>> Michael's tests are successful, I'm going to post final patches.
>>>
>>> For Michael I have prepared out-of-tree driver sources allowing to
>>> easily build the drivers also for older 3.x kernel versions. More
>>> tester are welcome.
>>>
>>> As also pointed out by Casper, the problems are obvisouly due to race=
s
>>> with stop and wakeup of the netif tx queue, managing tx_next and
>>> concurrent register accesses. For the moment I have fixed the races b=
y
>>> adding "spin[un]lock_irqsave/restore" but, thinking more about it,
>>> "spinlock_bh" should be enough to protect against softirq context.
>>>
>>> With the C_CAN driver I realized some other minor issues:
>>>
>>> - The C/D_CAN type handling is common code and could go to
>>>   alloc_c_can_dev() or register_c_can_dev().
>>>
>>> Comments are welcome.
>>
>> Please make the patches based on linux-can-next/for-davem
>=20
> OK, will do for the next round. For the moment these are just RFC patch=
es.

AnilKumar Ch has added added a init callback, maybe you can make use of
it, too. And give it a more general name then.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigBC85D9680C94C01C04CADEE6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlCzL2IACgkQjTAFq1RaXHMBYQCghNNSC57QezeaY+sNNBZwDw62
u5YAn24M9F8M2IwlGMIuOdbG/4YUjaf0
=n++9
-----END PGP SIGNATURE-----

--------------enigBC85D9680C94C01C04CADEE6--
