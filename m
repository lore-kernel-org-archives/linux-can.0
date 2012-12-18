From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] usb_8dev: add LED trigger support
Date: Tue, 18 Dec 2012 16:15:14 +0100
Message-ID: <50D08882.5000200@pengutronix.de>
References: <1355779189-23289-1-git-send-email-krumboeck@universalnet.at> <50D07818.9000108@pengutronix.de> <20121218141801.GA29522@balto.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC44A09D00581BBAE31EBA19A"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121218141801.GA29522-lYxsXyORJ9v/PtFMR13I2A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Baltieri <fabio.baltieri-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Bernd Krumboeck <b.krumboeck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org, gediminas-LljXPT5IorFWk0Htik3J/w@public.gmane.org, Bernd Krumboeck <krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC44A09D00581BBAE31EBA19A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/18/2012 03:18 PM, Fabio Baltieri wrote:
> On Tue, Dec 18, 2012 at 03:05:12PM +0100, Marc Kleine-Budde wrote:
>> On 12/17/2012 10:19 PM, Bernd Krumboeck wrote:
>>> Add support for canbus activity led indicators on usb_8dev devices by=

>>> calling appropriate can_led functions.
>>>
>>> These are only enabled when CONFIG_CAN_LEDS is Y, becomes no-op
>>> otherwise.
>>>
>>> Signed-off-by: Bernd Krumboeck <krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org>
>>
>> Thx. Fabio, can you queue this patch your tree and include it in your
>> series when you send the next iteration?
>=20
> Ok I will. Should I add my Signed-off-by to all the patches I'm sending=

> as I'm on the submissiom path?

Yes, correct.

Thanks,
Marc


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigC44A09D00581BBAE31EBA19A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDQiIUACgkQjTAFq1RaXHPq7QCeOLEYkPGNtri9djAX7OYc1yng
nzMAnRqG3FRFlJQhdk+DApfGtpNoWGZG
=7eZW
-----END PGP SIGNATURE-----

--------------enigC44A09D00581BBAE31EBA19A--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
