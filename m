From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [Patch] can-utils/slcanpty.c pseudo-terminal interface
Date: Mon, 17 Sep 2012 09:40:39 +0200
Message-ID: <5056D3F7.10506@pengutronix.de>
References: <50564EC7.7020005@myvdr.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig60067DDCB2AF30EB45EDFAE9"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48724 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236Ab2IQHku (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 17 Sep 2012 03:40:50 -0400
In-Reply-To: <50564EC7.7020005@myvdr.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: uescher <linux-can_ger.kernel.org@myvdr.de>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig60067DDCB2AF30EB45EDFAE9
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello,

On 09/17/2012 12:12 AM, uescher wrote:
> Add Support for the Unix 98 pseudo-terminal interface /dev/ptmx /dev/pt=
s/N

Cool, what kind of cool things can we do if this tool supports ptys?

>=20
> please take a look over the little Patch.
> Thanks

Can you add a Signed-off-by[1] to your patch?

[1]
http://lxr.free-electrons.com/source/Documentation/SubmittingPatches#L298=


Please don't use C++ comments, use Standard C comments. /* comment */.
Please remove any trailing whitespace from your patch.

Some nitpicking inline:

>=20
> patch.diff
>=20
>=20
> diff --git a/slcanpty.c b/slcanpty.c
> index 67dcf35..e3b7304 100644
> --- a/slcanpty.c
> +++ b/slcanpty.c
> @@ -26,6 +26,11 @@
>   *
>   */
> =20

I think it's okay to just define _GNU_SOURCE.

> +#ifndef _GNU_SOURCE =20
> +// To get ptsname grantpt and unlockpt definitions from stdlib.h =20
> +#define _GNU_SOURCE =20
> +#endif =20
> +
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -45,6 +50,8 @@
>  /* maximum rx buffer len: extended CAN frame with timestamp */
>  #define SLC_MTU (sizeof("T1111222281122334455667788EA5F\r")+1)
> =20
> +#define DEVICE_NAME_PTMX "/dev/ptmx"
> +
>  #define DEBUG
> =20
>  static int asc2nibble(char c)
> @@ -387,6 +394,8 @@ int main(int argc, char **argv)
>  		fprintf(stderr, "Usage: %s <pty> <can interface>\n", argv[0]);
>  		fprintf(stderr, "e.g. '%s /dev/ptyc0 can0' creates"
>  			" /dev/ttyc0 for the slcan application\n", argv[0]);
> +		fprintf(stderr, "e.g. for pseudo-terminal '%s /dev/ptmx can0' create=
s"
                                                              ^^^^^^^^^
Please use %s....

> +			" /dev/pts/N\n", argv[0]);
                                               ^^^
=2E..and add ", DEVICE_NAME_PTMX" here.

>  		fprintf(stderr, "\n");
>  		return 1;
>  	}
> @@ -408,6 +417,27 @@ int main(int argc, char **argv)
>  			   ECHONL | ECHOPRT | ECHOKE | ICRNL);
>  	tcsetattr(p, TCSANOW, &topts);
> =20
> +	//Support for the Unix 98 pseudo-terminal interface /dev/ptmx /dev/pt=
s/N
> +	if  (strcmp(argv[1],DEVICE_NAME_PTMX) =3D=3D 0) {
                          ^^^

Please add a space after the comma.

> +		if (grantpt(p) < 0) {
> +			perror("grantpt");
> +			return 1;
> +		}
> +
> +		if (unlockpt(p) < 0) {
> +			perror("unlockpt");
> +			return 1;
> +		}
> +
> +		char* name_pts =3D NULL;	/* slave pseudo-terminal device name */
                   ^^^
Please make it "char *name_pts".

> +		name_pts =3D ptsname(p);
> +		if (name_pts =3D=3D NULL) {
> +			perror("ptsname");
> +			return 1;
> +		}
> +		printf("open: %s: slave pseudo-terminal is %s\n", argv[1], name_pts)=
;
> +	}
> +
>  	/* open socket */
>  	s =3D socket(PF_CAN, SOCK_RAW, CAN_RAW);
>  	if (s < 0) {

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig60067DDCB2AF30EB45EDFAE9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBW0/sACgkQjTAFq1RaXHMroACeOxZx84bt3N7JK4ZBICLa+LbA
+x8An1I8jinvw8pa9RFctWJwCWeyd9oW
=kHlR
-----END PGP SIGNATURE-----

--------------enig60067DDCB2AF30EB45EDFAE9--
