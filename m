From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH net-next] can: replace the dev_dbg/info/err/... with the new netdev_xxx macros
Date: Wed, 1 Feb 2012 10:51:43 -0500
Message-ID: <201202011051.45893.vapier@gentoo.org>
References: <4EE61D71.90401@grandegger.com> <4F2864FD.8010909@pengutronix.de> <4F290FF6.4090107@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2179590.9VJoDG7l08";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:33663 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753043Ab2BAPvd (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 1 Feb 2012 10:51:33 -0500
In-Reply-To: <4F290FF6.4090107@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Anant Gole <anantgole@ti.com>, Chris Elston <celston@katalix.com>, Sebastian Haas <haas@ems-wuensche.com>, Matthias Fuchs <matthias.fuchs@esd.eu>, uclinux-dist-devel@blackfin.uclinux.org

--nextPart2179590.9VJoDG7l08
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 01 February 2012 05:12:06 Wolfgang Grandegger wrote:
> On 01/31/2012 11:02 PM, Marc Kleine-Budde wrote:
> > On 12/12/2011 04:27 PM, Wolfgang Grandegger wrote:
> >> CC: Barry Song <barry.song@analog.com>
> >> CC: Anant Gole <anantgole@ti.com>
> >> CC: Chris Elston <celston@katalix.com>
> >> CC: Sebastian Haas <haas@ems-wuensche.com>
> >> CC: Matthias Fuchs <matthias.fuchs@esd.eu>
> >> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> >=20
> > ...removed Barry Song <barry.song@analog.com> from Cc, the address in
> > unknown.
>=20
> Is there somebody else we should inform about patches for the bfin_can
> driver. Maybe Mike (now on CC)?

for Blackfin devs, you can CC uclinux-dist-devel@blackfin.uclinux.org to ge=
t the=20
relevant people.  Barry Song no longer works for ADI.

the bfin_can.c changes in here look fine to me (not that i tried compiling =
them,=20
but looks straight forward enough):
http://thread.gmane.org/gmane.linux.can/251/focus=3D257

Acked-by: Mike Frysinger <vapier@gentoo.org>
=2Dmike

--nextPart2179590.9VJoDG7l08
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPKV+RAAoJEEFjO5/oN/WBWqYQAJi61AO+StV9FvaY4LVU2qTT
Srnxe0hdq6IEYjUYaRlN3dEY4GQ7IlXomWJzW9rpPW7QdoxLFinzvue+3EjLviZd
hXTJTHU2UoMpQ9aB/svNxVuzJyguyWGPq597ixRZrZbsSx2VoVGEBR6UZ3rmdGT+
z45nreqRMFMbNqVaJDpR7A1STCUW/ZcEYrBoTr+uWRu/RbszRG/+5VLmUPC3On5C
8PLSLXkeWNgAHvHMIzSMUlb2ljQoqx6KjiptgRB8GV/UR0Ip62p7jn2zFEKH1hUK
RzG6JE1ys6tz//yXhm2R8J6ulIIf/6IMC7alLBJMwNqRN2Y3LThaQtvNkosrTT2a
aYU1M4FySBhBV7jfpgRuxszxpCCtsOhQ/2ibpkaGI/ukikznr9ZXX8hI0WV4O8CH
SL9pCvv0qg8SdcxT/RzPagsYR2RbkGdcYkfNnS2cJUBGW4Wf87YbC9Y3rhagsp52
s0vJyLqoNXfmYo0zC9M9wIzFkXM9MKc/fBLAsa+2d/4ZX/mzjR6YvlF1pF542UZV
pzmmqYeNkidTpU80ebUYJVtXPlTPKM0uoBN4dVAnS4seGGqTrvS9QTpCmxIhQf4u
4XubyISlDByO3UmCZ9g/SK2qOsxJKSHkosmPduHmVHXUNrVCn5Zk5bZ6lksKTQj/
Fevx6Wt/ZnMaGUsSCR4K
=Ch27
-----END PGP SIGNATURE-----

--nextPart2179590.9VJoDG7l08--
