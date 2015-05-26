From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: PROBLEM: Attempt to Enable CAN Network with MCP251x SPI
 Interface Results in Kernel Panics at Boot
Date: Tue, 26 May 2015 12:25:34 -0500
Message-ID: <20150526172534.GS26599@saruman.tx.rr.com>
References: <388824CB4174CA41B696BDD3405FBE6459CFEE9C@stlex-1.stl.dukemfg.local>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rBVNTu5JXDAWzN2S"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <388824CB4174CA41B696BDD3405FBE6459CFEE9C-lm7LCZzvWt/H8pOAoaTGmBpNBvFTKpGeZkel5v8DVj8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jesse James <jjames-V/Cy32gump9BDgjK7y7TUQ@public.gmane.org>
Cc: "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

--rBVNTu5JXDAWzN2S
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2015 at 05:21:23PM +0000, Jesse James wrote:
> Hello,
>=20
> I recently purchased a A10-OLinuXino-LIME from
> https://www.olimex.com/.=A0 This board uses the Allwinner A10 Cortex-8
> chipset.=A0 Using the kernel from https://github.com/linux-sunxi and
> commit e37d760b363888f3a65cd6455c99a75cac70a7b8, I was able to

this commit is not upstream, you need to ask for support from whoever
maintains linux-sunxi

> successfully build and run kernel 3.4.90+ on the above mentioned

yeah, this kernel is pretty old, you really need to contact linux-sunxi
maintainers.

> board.
>=20
> I attempted to enable the CAN Network with the MCP251x SPI interface
> enabled, config file is attached, and now the kernel "panics" at
> boot.=A0 The short hand looks like the following: (Full boot log is
> attached)
>=20
> /////////////////////////////////////////////////////////////////////////=
//////////////////////
> <6>ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [=A0=A0=A0 1.272001] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driv=
er
> <1>Unable to handle kernel paging request at virtual address 71c007b4
> [=A0=A0=A0 1.284403] Unable to handle kernel paging request at virtual ad=
dress 71c007b4
> <1>pgd =3D c0004000
> [=A0=A0=A0 1.293294] pgd =3D c0004000
> <1>[71c007b4] *pgd=3D00000000[=A0=A0=A0 1.298345] [71c007b4] *pgd=3D00000=
000
>=20
> <0>Internal error: Oops: 5 [#1] PREEMPT ARM
> [=A0=A0=A0 1.306038] Internal error: Oops: 5 [#1] PREEMPT ARM
> <d>Modules linked in:[=A0=A0=A0 1.312825] Modules linked in:
>=20
> CPU: 0=A0=A0=A0 Not tainted=A0 (3.4.90+ #8)
> [=A0=A0=A0 1.319284] CPU: 0=A0=A0=A0 Not tainted=A0 (3.4.90+ #8)
> PC is at sunxi_gpio_request_array.part.4+0xdc/0x4c4

this isn't even a USB bug. Unless you can reproduce this problem with
v4.0 or v4.1-rc5, then there's nothing this forum can do to help you
out, sorry.

--=20
balbi

--rBVNTu5JXDAWzN2S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVZKyOAAoJEIaOsuA1yqRE13oP/2WrHNFNos37PQv/LrzfTJpQ
H20Z8Vv9Nr0qj+mfC7HNk+2aZDrn3vpiRNLTH/Rl/KNPTMQ64Nxqc4l/Bhm/fqB2
DggK1wKgw1AChVhJOFEgn7wzbUMLyLoD5BLbwihrno+O5tmfGSJ2AiR+XJvJqTxT
HtjehSUBxnY2aDx6SVU8fYoH2ZXaniiH/mK5ay0Dv8sY8A2ZSEx5KacIDq2gDSKN
p7T2hCuLAxyyTPZdKuSaEFU/j8u4JEQxLgztd4KAgLl5syU5xv2HfLYY7FWUVFTB
Kc309aAVuLiw0JVe4EqS2qUyrWU7ou5GuIM2xo5u/L44HqKnJc+qOqKR04BoLc0a
PQZkIepfVz3ak5QO0tQso2qQKF+yyVg5t1OmqDxAK7VmDhjnVvsgOJ6+cqcfcLio
cL3m+W+2RLHtIv6+13Vgx+t4vXiJR2SLyS0sVukXETVyGLqAGs3vyQBobOMvxzS/
AnLwUOIBuBIKyp94qeMJk50gE4HptnAUMXA2XPu1lJFAaP97NHawIexgqubRZeqB
pZv1SsDOSJrQjSrM2kV5uUY92Xsg6BaFk04zEoNPzvpIQepyLz6HGobPy3r+SF9r
WikN0mX+E823Ow7bk7Ai4IuOxLde1oREW5mG/XU8f2E4vY4hAIHOFfpNwr+d/mbr
02DQZFZwciv2s4bBW+0R
=8KZm
-----END PGP SIGNATURE-----

--rBVNTu5JXDAWzN2S--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
