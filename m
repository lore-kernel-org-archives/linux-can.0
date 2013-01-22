From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v11] usb_8dev: Add support for USB2CAN interface from
 8 devices
Date: Tue, 22 Jan 2013 22:34:13 +0100
Message-ID: <50FF05D5.1010909@pengutronix.de>
References: <1358577045-5252-1-git-send-email-krumboeck@universalnet.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2BCQGDCBLOVHWROLKIBQO"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358577045-5252-1-git-send-email-krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bernd Krumboeck <b.krumboeck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org, gediminas-LljXPT5IorFWk0Htik3J/w@public.gmane.org, Bernd Krumboeck <krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2BCQGDCBLOVHWROLKIBQO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/19/2013 07:30 AM, Bernd Krumboeck wrote:
> Add device driver for USB2CAN interface from "8 devices" (http://www.8d=
evices.com).
>=20
> changes since v10:
> * small cleanups
>=20
> changes since v9:
> * fixed syslog messages
> * fixed crc error number
> * increased MAX_RX_URBS and MAX_TX_URBS
>=20
> changes since v8:
> * remove all sysfs files
>=20
> changes since v7:
> * add sysfs documentation
> * fix minor styling issue
> * fixed can state for passive mode
> * changed handling for crc errors
>=20
> changes since v6:
> * changed some variable types to big endian equivalent
> * small cleanups
>=20
> changes since v5:
> * unlock mutex on error
>=20
> changes since v4:
> * removed FSF address
> * renamed struct usb_8dev
> * removed unused variable free_slots
> * replaced some _to_cpu functions with pointer equivalent
> * fix return value for usb_8dev_set_mode
> * handle can errors with separate function
> * fix overrun error handling
> * rewrite error handling for usb_8dev_start_xmit
> * fix urb submit in usb_8dev_start
> * various small fixes
>=20
> Signed-off-by: Bernd Krumboeck <krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org>
> Acked-by: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
> Tested-by: Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>

Thanks for you patience :) Applied to can-next.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2BCQGDCBLOVHWROLKIBQO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD/BdkACgkQjTAFq1RaXHNQjgCfXiINpQpikhw8zOMMkQwF93Fp
VK0An3VXzfkqL/GkFyJAiBYo4G4ZPJ32
=vkEp
-----END PGP SIGNATURE-----

------enig2BCQGDCBLOVHWROLKIBQO--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
