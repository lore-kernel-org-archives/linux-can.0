From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [Gitorious] Activity: dschanoeh updated merge request for...
Date: Mon, 05 Dec 2011 11:28:54 +0100
Message-ID: <4EDC9CE6.7000705@pengutronix.de>
References: <20111129121452.B4F9F7590F@steelheart.shortcut.kunder.linpro.no>	<4ED4E74D.3090608@pengutronix.de>	<CAEuXk91Bh+Z0yTqQebmW-EmrU59c-dFz_zKj8ky0ssgFBy23bQ@mail.gmail.com>	<4EDA705B.1050106@pengutronix.de> <CAEuXk934A1Vu_3bZ_kyhxO_XJiqoLOY0zuSRxxNxpmLXPjmRCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4684B9B014C3DD9B467B498E"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49068 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755904Ab1LEK3D (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 5 Dec 2011 05:29:03 -0500
In-Reply-To: <CAEuXk934A1Vu_3bZ_kyhxO_XJiqoLOY0zuSRxxNxpmLXPjmRCg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jan-Niklas Meier <dschanoeh@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4684B9B014C3DD9B467B498E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/04/2011 10:57 AM, Jan-Niklas Meier wrote:
>>> To be able to compile a subset of the tools I checked if the isotp.h =
and
>>> gw.h are present in the include directory (I don't have them both) an=
d only
>>> compile the corresponding utils if the headers are present. This way =
it
>>> should still be possible to compile subsets of the tools on machines =
with
>>> old kernels and not ending up with tools you can not use afterwards.
>>
>> What about the external kernel modules use case?
>=20
> Thank you very much for the clarification. Now I understand why you
> did this. Still if your kernel's CAN API is much older than the
> headers included in the current can-utils the programs will compile
> fine but it is possible that some of them will fail at runtime right?

Yes. If the kernel doesn't implement the features your userspace program
needs.

> Method signatures could have changed or some methods are not present
> in the old kernel. For example using a program with some specific
> parameters could lead to strange behavior for the user. Is that true
> or am I missing something?

Yes - you're missing the policy. The Kernel-Userspace interface must not
be changed in an incompatible way, at least once an interface is in the
mainline kernel. This includes not only the API but also the ABI (the
binary interface) to the kernel. This rule is (next to) 100% hard for
system calls, ioctls, etc... modern things like the sysfs tend to change
sometimes.

For example, the isotp programs will fail with "Protocol not supported"
during socket creation.

>>> I tried to rewrite the autoconf.ac because there are macros I'm havin=
g

[...]

>> That might be the problem, don't run autoconf, run $(./autogen.sh) ins=
tead.
>=20
> \o/ Yay! That's the hint I needed. I didn't know that there is a
> different way to generate a ./configure that autoconf.

[...]

> I did the same and it works fine with both HEADs of your master and
> master-squashed branches. Still I get some warnings during autoreconf:
>=20
> configure.ac:22: warning: The macro `AC_LIBTOOL_WIN32_DLL' is obsolete.=

> configure.ac:22: You should run autoupdate.
> [...]
> configure.ac:24: warning: The macro `AC_PROG_LIBTOOL' is obsolete.
> configure.ac:24: You should run autoupdate.

These are deprecation warnings from the autotools. IIRC these come from
libtool-2.x, but you need them for pre pre 2.x to work. Debian lenny
(this is old-stable, isn't it?) uses still libtool-1.5. Maybe some old
redhat versions, too.

cheers, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig4684B9B014C3DD9B467B498E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7cnOoACgkQjTAFq1RaXHOO5QCfT0RAA9ugcPj/OG2vDhKC3sSk
OtcAn3JsQr1HzA862/J9edMVN6Q69K2o
=hNSs
-----END PGP SIGNATURE-----

--------------enig4684B9B014C3DD9B467B498E--
