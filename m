From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: git-tree, NOW!
Date: Thu, 01 Dec 2011 10:16:38 +0100
Message-ID: <4ED745F6.8030302@pengutronix.de>
References: <48E9EDF6.4000009@pengutronix.de> <4ED6B460.2010508@pengutronix.de>
	<4ED7351E.2010907@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3654523178922976308=="
Return-path: <socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <4ED7351E.2010907-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
List-Unsubscribe: <https://lists.berlios.de/mailman/options/socketcan-core>,
	<mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/socketcan-core>
List-Post: <mailto:socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/socketcan-core>,
	<mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org, "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============3654523178922976308==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2693A81CDA7022AB4B7653BD"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2693A81CDA7022AB4B7653BD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/01/2011 09:04 AM, Wolfgang Grandegger wrote:
>> I think we need a git tree. It's the second time our humble network
>> maintainer merged some patches to early. IMHO both times related to ba=
d
>> communication.......
>=20
> What do you mean? Usually we do not communicate anything to Dave for th=
e
> normal v1->v2->v3->... review and patch update process (this does not
> excuse the bad quality of my last series). The problem is that it's not=

> easy for him to follow our work and therefore we need our own GIT tree.=


Yes - exactly. I think we're meaning the same:
It's hard to figure out for him when a series is "ready", (or at least
we think it is). We haven't communicated a "series is still in review"
nor a "series is now ready".

I like Oliver's remark to first keep the discussion on the linux-can
mailinglist and post the "final" series on netdev.

> That's also what Dave asks for. Apart from the tree he asks for someone=

> who acts as the one and only interface to him.

Yes, technically that could/should be the git tree, in persona Wolfgang
or/and (as Dave asked for one person) Oliver.

>> I've setup a git repo on gitorious:
>>
>> https://gitorious.org/linux-can/linux-can
>>
>> It's based on net-next, and currently David's net-next/master is pushi=
ng
>> there. It probably takes some time, the box pushing has just 4 mbit/s
>> upstream.
>>
>> Comments?
>=20
> Apart from net-next, we may also need the net tree (as branch?).

During merge windows David merges into his net-next tree, anyway I can
setup linux-can and linux-can-next, based on the linux-net and
linux-net-next trees.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig2693A81CDA7022AB4B7653BD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7XRfkACgkQjTAFq1RaXHPo6QCfeadZEetWWWmjxVTrNwWKdxGM
B9wAoIiPvr+8iXggJ4injy7K2FVcANef
=NvC9
-----END PGP SIGNATURE-----

--------------enig2693A81CDA7022AB4B7653BD--

--===============3654523178922976308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Socketcan-core mailing list
Socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
https://lists.berlios.de/mailman/listinfo/socketcan-core

--===============3654523178922976308==--
