From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v4] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Wed, 05 Dec 2012 17:00:19 +0100
Message-ID: <50BF6F93.9050107@pengutronix.de>
References: <50BE7C7E.8080406@universalnet.at> <50BF1E58.4090603@grandegger.com> <50BF6D05.4070609@volkswagen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC64F74DB12AE653710816CD8"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50BF6D05.4070609-l29pVbxQd1IUtdQbppsyvg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Hartkopp <oliver.hartkopp-l29pVbxQd1IUtdQbppsyvg@public.gmane.org>
Cc: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, Bernd Krumboeck <krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org>, "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org, gediminas-LljXPT5IorFWk0Htik3J/w@public.gmane.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC64F74DB12AE653710816CD8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/05/2012 04:49 PM, Oliver Hartkopp wrote:
> On 05.12.2012 11:13, Wolfgang Grandegger wrote:
>=20
>>> +    outmsg.command =3D USB_8DEV_OPEN;
>>> +    outmsg.opt1 =3D USB_8DEV_BAUD_MANUAL;
>>> +    outmsg.data[0] =3D (bt->prop_seg + bt->phase_seg1);
>>
>> Minor issue. Brackets not needed.
>>
>>> +    outmsg.data[1] =3D bt->phase_seg2;
>>> +    outmsg.data[2] =3D bt->sjw;
>>> +
>=20
> That's correct from a compilers point of view.
> But in this case i would preserve the [0] as it is better to read in
> conjunction with the two lines below ( ..[1] ..[2] )
>=20
> The semantic has to be understood by humans ;-)

I think Wolfgang was talking about the round bracket not the square
bracket. :D

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigC64F74DB12AE653710816CD8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC/b5cACgkQjTAFq1RaXHM4IACaAkoXidp9k0qezfjFUqudtY72
wxwAn20qhpMaxtfbaK+e4q5nexnXieMs
=mKiC
-----END PGP SIGNATURE-----

--------------enigC64F74DB12AE653710816CD8--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
