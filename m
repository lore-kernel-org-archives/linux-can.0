From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [GIT PULL] Disintegrate UAPI for can
Date: Wed, 10 Oct 2012 21:55:27 +0200
Message-ID: <5075D2AF.1010409@pengutronix.de>
References: <5075B2F4.60708@pengutronix.de> <30687.1349789402@warthog.procyon.org.uk> <27643.1349892024@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCBBC7362FF2770E479476DAF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48434 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756172Ab2JJTzk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 10 Oct 2012 15:55:40 -0400
In-Reply-To: <27643.1349892024@warthog.procyon.org.uk>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: socketcan@hartkopp.net, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCBBC7362FF2770E479476DAF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/10/2012 08:00 PM, David Howells wrote:
> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>=20
>> On 10/09/2012 03:30 PM, David Howells wrote:
>>> Can you merge the following branch into the can tree please.
>>>
>>> This is to complete part of the Userspace API (UAPI) disintegration f=
or which
>>> the preparatory patches were pulled recently.  After these patches, u=
serspace
>>> headers will be segregated into:
>>>
>>> 	include/uapi/linux/.../foo.h
>>>
>>> for the userspace interface stuff, and:
>>>
>>> 	include/linux/.../foo.h
>>>
>>> for the strictly kernel internal stuff.
>>
>> Nice work David. The upstream for can-next is David Miller's net-next
>> tree. He doesn't like if I pull unrelated stuff into my tree, so I'm
>> going to cherry pick your patch. This is not yet possible, as net-next=

>> doesn't include the latest patches from the 3.7 merge window, so that
>> compilation breaks. After the merge window closes David Miller merges
>> back the latest changes to net-next. I'll postpone your patch until
>> then, this means the code will go into v3.8. I'm not familiar with the=

>> UAPI conversion, should your patch go via linux-can and David's net in=
to
>> v3.7?
>=20
> It's okay for the patch to go into 3.8 if that is easier for you.  As i=
t's
> scripted, I can regenerate your branch after -rc1 if that helps too.

I don't mind, as long as it compiles (using you tag), and it does, the
patch doesn't break anything. From the linux-can and David Miller's net
point of view, v3.7 is closed for new features just bug fixes are
allowed. But I'm open to make an exception, if UAPI hits mainline in
v3.7 on most subsystems. Hopefully David sees it the same way.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigCBBC7362FF2770E479476DAF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlB10rMACgkQjTAFq1RaXHM8rwCfUp33JTr0iZ+xepiDxqG1mHgu
qPIAn26/x4xYzrLulKWpHUMKjkVViUsb
=kasl
-----END PGP SIGNATURE-----

--------------enigCBBC7362FF2770E479476DAF--
