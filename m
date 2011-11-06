From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: git repos @ gitorious.org
Date: Sun, 06 Nov 2011 15:05:36 +0100
Message-ID: <4EB69430.7070801@pengutronix.de>
References: <4EB1A448.6000703@hartkopp.net> <4EB1C132.2070103@pengutronix.de>
	<20111103130841.GG317@e-circ.dyndns.org>
	<20111104161655.GC18026@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4043995259629744387=="
Return-path: <socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <20111104161655.GC18026-MxZ6Iy/zr/UdbCeoMzGj59i2O/JbrIOy@public.gmane.org>
List-Unsubscribe: <https://lists.berlios.de/mailman/options/socketcan-core>,
	<mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/socketcan-core>
List-Post: <mailto:socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/socketcan-core>,
	<mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============4043995259629744387==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCEC82C53E79C8635F8B77F67"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCEC82C53E79C8635F8B77F67
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/04/2011 05:16 PM, Kurt Van Dijck wrote:
> On Thu, Nov 03, 2011 at 02:08:41PM +0100, Kurt Van Dijck wrote:
>> On Wed, Nov 02, 2011 at 11:16:18PM +0100, Marc Kleine-Budde wrote:
>>> On 11/02/2011 09:12 PM, Oliver Hartkopp wrote:
>>>>
>>>> https://gitorious.org/~<kurts_account>/linux-can/can-modules-j1939
>>>> https://gitorious.org/~<kurts_account>/linux-can/can-utils-j1939
>=20
> Since the can-j1939-modules require one to use a modified iproute2,
> I wanted to create an iproute-j1939 within linux-can, but I see no way
> to accomplish this.
>=20
> Any opinions on how to proceed?

Google for the iproute2 git upstream, clone it, modify it. Create a
iproute2 git repo on gitorious, push your changes there.

The git workflow is basically the same as you did to copy the j1939
can-utils to your repo.

Finally send a pull request to the iprout2 upstream.

cheers, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigCEC82C53E79C8635F8B77F67
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk62lDAACgkQjTAFq1RaXHPp2gCdGFa994sjL+UwD13FxFmKc60b
YoAAoIMFFOBWXiLhgfiShDmFQHHdc0Zc
=QHYu
-----END PGP SIGNATURE-----

--------------enigCEC82C53E79C8635F8B77F67--

--===============4043995259629744387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Socketcan-core mailing list
Socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
https://lists.berlios.de/mailman/listinfo/socketcan-core

--===============4043995259629744387==--
