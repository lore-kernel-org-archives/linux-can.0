From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: git-tree, NOW!
Date: Thu, 01 Dec 2011 10:37:11 +0100
Message-ID: <4ED74AC7.40605@pengutronix.de>
References: <48E9EDF6.4000009@pengutronix.de>
	<4ED6B460.2010508@pengutronix.de>	<4ED7351E.2010907@grandegger.com>
	<4ED745F6.8030302@pengutronix.de> <4ED7494F.6080603@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4516673400014233979=="
Return-path: <socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <4ED7494F.6080603-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
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
--===============4516673400014233979==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig357CDE561B89C7CCFFEC2B4E"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig357CDE561B89C7CCFFEC2B4E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/01/2011 10:30 AM, Wolfgang Grandegger wrote:
> On 12/01/2011 10:16 AM, Marc Kleine-Budde wrote:
[...]

> Yes. So far we just tried to signal "patch is now ready" by adding our
> "acked-by"... which does not work for a series of patches, espcially if=

> it touches other sub-systems as well (powerpc, devicetree).

Yes - but David sometimes merges patches if they are not reviewed. Like
the pch-can driver, where I missed to reply to net-dev.

>> I like Oliver's remark to first keep the discussion on the linux-can
>> mailinglist and post the "final" series on netdev.
>=20
> Yes, don't ask me why I did not do that first, especially because some
> tested-by's would have be useful. I also learned that some more serious=

> compile tests have to be done for different archs (x86, powerpc, arm, .=
=2E.).

>>> That's also what Dave asks for. Apart from the tree he asks for someo=
ne
>>> who acts as the one and only interface to him.
>>
>> Yes, technically that could/should be the git tree, in persona Wolfgan=
g
>> or/and (as Dave asked for one person) Oliver.
>=20
> Oliver?

+1

>>>> I've setup a git repo on gitorious:
>>>>
>>>> https://gitorious.org/linux-can/linux-can
>>>>
>>>> It's based on net-next, and currently David's net-next/master is pus=
hing
>>>> there. It probably takes some time, the box pushing has just 4 mbit/=
s
>>>> upstream.
>>>>
>>>> Comments?
>>>
>>> Apart from net-next, we may also need the net tree (as branch?).
>>
>> During merge windows David merges into his net-next tree, anyway I can=

>> setup linux-can and linux-can-next, based on the linux-net and
>> linux-net-next trees.
>=20
> Do we need two trees? I thinks you can save a lot of bandwith (and disk=

> space) by using just one tree and two branches.

If you want to safe bandwith on your PC, you can $(git remote add) them
into one tree.

Meanwhile there's a linux-can and a linux-can-next on gitorious. The
latter one is still uploading.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig357CDE561B89C7CCFFEC2B4E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7XSscACgkQjTAFq1RaXHPs5gCeLxoJ+Cz8E/laiNSGWtlL6Rn3
aAwAoI7C04Gw+Jh/5OKdcrMFamN2VR9E
=6tHu
-----END PGP SIGNATURE-----

--------------enig357CDE561B89C7CCFFEC2B4E--

--===============4516673400014233979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Socketcan-core mailing list
Socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
https://lists.berlios.de/mailman/listinfo/socketcan-core

--===============4516673400014233979==--
