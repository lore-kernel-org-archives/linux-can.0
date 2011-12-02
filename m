From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RFC PATCH] CAN MAINTAINERS
Date: Fri, 02 Dec 2011 13:22:03 +0100
Message-ID: <4ED8C2EB.1070507@pengutronix.de>
References: <48E9EDF6.4000009@pengutronix.de>	<4ED6B460.2010508@pengutronix.de>	<4ED7351E.2010907@grandegger.com>	<4ED745F6.8030302@pengutronix.de>
	<4ED7494F.6080603@grandegger.com>	<4ED74AC7.40605@pengutronix.de>
	<4ED75BD0.6070802@hartkopp.net> <4ED75EED.6010009@pengutronix.de>
	<4ED89050.3040201@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6348541629214489590=="
Return-path: <socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <4ED89050.3040201-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>
List-Unsubscribe: <https://lists.berlios.de/mailman/options/socketcan-core>,
	<mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/socketcan-core>
List-Post: <mailto:socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/socketcan-core>,
	<mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>
Cc: socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org, Urs Thuermann <urs-5sm3ckEb1NlYFmeL5InDC7NAH6kLmebB@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============6348541629214489590==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7A184A4D5E35F6E3389A65F5"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7A184A4D5E35F6E3389A65F5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/02/2011 09:46 AM, Oliver Hartkopp wrote:
> Hey Marc,
>=20
> i'm not as good as you using git. Indeed i'm a git newbie and do not ha=
ve the
> time right now to get in that deep that i dare to post correct pull req=
uests
> to netdev.
>=20
> Following the hints from Dave i checked the MAINTAINERS file how the wi=
reless
> guys handle their subsystem in detail. Regarding John Linville, who's
> collecting all the stuff from several people to send finally push reque=
sts to
> Dave i would suggest that you become our 'John Linville for CAN'.

Wolfgang and me talked about this (via PM), too. We do the job together,
but I send the pull requests to Dave.

> You speak git fluently and you know the project very good - so my sugge=
stion
> to clean up the MAINTAINTERS file is this:

The cleanups look got, however, do we need the linux-can tree. Do the
wireless people have two trees?

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 717d9e9..af8a0a9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1707,11 +1707,8 @@ F:	arch/x86/include/asm/tce.h
>=20
>  CAN NETWORK LAYER
>  M:	Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>
> -M:	Oliver Hartkopp <oliver.hartkopp-l29pVbxQd1IUtdQbppsyvg@public.gmane.org>
> -M:	Urs Thuermann <urs.thuermann-l29pVbxQd1IUtdQbppsyvg@public.gmane.org>
>  L:	linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> -L:	netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

this should focus the discussion on linux-can

> -W:	http://developer.berlios.de/projects/socketcan/
> +W:	http://gitorious.org/linux-can

the can utils are now migrated (im my repo still)

>  S:	Maintained
>  F:	net/can/
>  F:	include/linux/can.h
> @@ -1723,8 +1720,7 @@ F:	include/linux/can/gw.h
>  CAN NETWORK DRIVERS
>  M:	Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
>  L:	linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> -L:	netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> -W:	http://developer.berlios.de/projects/socketcan/
> +W:	http://gitorious.org/linux-can
>  S:	Maintained
>  F:	drivers/net/can/
>  F:	include/linux/can/dev.h
> @@ -4587,6 +4583,17 @@ F:	include/linux/wireless.h
>  F:	include/net/iw_handler.h
>  F:	drivers/net/wireless/
>=20
> +NETWORKING [CAN]
> +M:	Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> +L:	linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> +W:	http://gitorious.org/linux-can
> +T:	git://gitorious.org/linux-can/linux-can.git

do we need this tree?

> +T:	git://gitorious.org/linux-can/linux-can-next.git
> +S:	Maintained
> +F:	net/can/
> +F:	drivers/net/can/
> +F:	include/linux/can*
> +
>  NETWORKING DRIVERS
>  L:	netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>  W:	http://www.linuxfoundation.org/en/Net

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig7A184A4D5E35F6E3389A65F5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7Ywu8ACgkQjTAFq1RaXHN8SwCfZar5WU847dE4Cs48Kdu81m44
GM4AoIdgWJdFKvys2SOrxqfPvJU6PIiW
=zq7+
-----END PGP SIGNATURE-----

--------------enig7A184A4D5E35F6E3389A65F5--

--===============6348541629214489590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Socketcan-core mailing list
Socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
https://lists.berlios.de/mailman/listinfo/socketcan-core

--===============6348541629214489590==--
