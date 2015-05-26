From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: PROBLEM: Attempt to Enable CAN Network with MCP251x SPI
 Interface Results in Kernel Panics at Boot
Date: Tue, 26 May 2015 12:52:39 -0500
Message-ID: <20150526175239.GT26599@saruman.tx.rr.com>
References: <388824CB4174CA41B696BDD3405FBE6459CFEE9C@stlex-1.stl.dukemfg.local>
 <20150526172534.GS26599@saruman.tx.rr.com>
 <388824CB4174CA41B696BDD3405FBE6459CFEEBE@stlex-1.stl.dukemfg.local>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6wUvnnXCCq76soZt"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <388824CB4174CA41B696BDD3405FBE6459CFEEBE-lm7LCZzvWt/H8pOAoaTGmBpNBvFTKpGeZkel5v8DVj8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jesse James <jjames-V/Cy32gump9BDgjK7y7TUQ@public.gmane.org>
Cc: "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>, "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

--6wUvnnXCCq76soZt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

(please avoid top-posting, see http://elinux.org/Netiquette for details)

On Tue, May 26, 2015 at 05:41:45PM +0000, Jesse James wrote:
> Thank you for the quick response.  I was able to switch to the head of
> the master branch and duplicate the issue as well, see below.  The

by "head of master" do you Linus' master ? What is the commit hash
you're using ?

> reason I added the USB group was due to the lines from the boot log:
>=20
> [    0.195398] [usb_manager]: CONFIG_USB_SW_SUNXI_USB0_OTG
> [    0.202738] WRN:L268(drivers/usb/sunxi_usb/manager/usb_manager.c):ERR:=
 usbc0 port_type(-16777249) is unkown
> [    0.211219] WRN:L426(drivers/usb/sunxi_usb/manager/usb_manager.c):ERR:=
 check_usb_board_info failed
> [    0.218891] WRN:L480(drivers/usb/sunxi_usb/manager/usb_manager.c):ERR:=
 get_usb_cfg

this directory and files don't exist in Linus' tree. Again, you need you
ask for support from Sunxi maintainers

--=20
balbi

--6wUvnnXCCq76soZt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVZLLnAAoJEIaOsuA1yqREO0UP/Rq5sFaNfMu7ANJjFy5fLiRs
FR79Jxh9mG24qL4ZdTWih+Cv4lM4/WHv7VmP6FSBeO3QSqfl6KtWwPFAo9hgKdHp
FPhvwEurdNODNPK7QXLqs+pqLuKviR5it72TtoDJOA/r9DqPeppLTv4qQ67Z3e9G
BTqqOB01LjCQxmjA5kUyzh2bNbmZGX2kXrwvmKCU8gSBbS07UbJwh1WdB7MVrfq7
wQNauu0fFZlBFhUPRLIsiQO4GmXVxz+5nx4b9itYA32hTaqFGNQsCrCK/Md/NsQW
SVz+SH2CTBI+k46BU+ilqwdW5bFqEeWV7LDa8MMU8FIxojS0U/jjGjiX1PikHg5t
eGazLipwX3eoEo4OV821JEltp5PFdnjBb+OoxA0oTCS76HCeQgbFDIVaVNQYHIzW
lR9FoueXwJ4yF08b1iWDafTZG0Kk4gUUb6U3D49Utp6K1o2oGDGnlf+DcbrlwTL0
0fLfqJiZiJc55CA/9oTEDMgasp5Av3DJ55gpCbGXVNW795zJnBcxJfylWfJdfAYI
p+xPC+InqNe705lDU8/PnWTPEqP/BEZ1xWAz3eYUpSrC6eT5dPScXLLFDs5RtD24
k3C+0JJfN+aj7FFI/YTPM5fd/xwkdphsoeGJ/DQb39pSfybTb/E1SVwUU+HehWnv
DYDvGHcjDBdISrUNQ3+F
=yeIP
-----END PGP SIGNATURE-----

--6wUvnnXCCq76soZt--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
