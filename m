From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: arbitration lost error reporting
Date: Mon, 09 Dec 2013 11:32:52 +0100
Message-ID: <52A59C54.5070500@pengutronix.de>
References: <1385334220-31887-1-git-send-email-mkl@pengutronix.de> <loom.20131205T164221-222@post.gmane.org> <52A0BCD9.4090309@grandegger.com> <loom.20131205T202627-307@post.gmane.org> <52A0E185.1080402@grandegger.com> <loom.20131206T100036-664@post.gmane.org> <52A1A323.1030605@pengutronix.de> <loom.20131206T114831-779@post.gmane.org> <52A1B8DA.1030700@pengutronix.de> <52A1BCEE.5070101@hartkopp.net> <52A21082.9010102@grandegger.com> <loom.20131209T093912-850@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="0mdc4JomHPHvV5fW8e9gFG4teQTsDXf8d"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43203 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab3LIKdD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Dec 2013 05:33:03 -0500
In-Reply-To: <loom.20131209T093912-850@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Richard Andrysek <richard.andrysek@rg-mechatronics.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0mdc4JomHPHvV5fW8e9gFG4teQTsDXf8d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/09/2013 10:01 AM, Richard Andrysek wrote:
> Wolfgang Grandegger <wg <at> grandegger.com> writes:
>=20
> ...
>>>> big change of going mainline. The implementation is similar to
>>>> CAN_CTRLMODE_BERR_REPORTING, just look for it in the kernel source t=
ree
>>>> and add a new define for arbitration lost error reporting.
>>>>
>>>> Do you have a preferred name for the define?
>>>> - CAN_CTRLMODE_AERR_REPORTING
>>>> - CAN_CTRLMODE_ARBITRATIONERR_REPORTING to
>>>
>>> Loosing the arbitration is not an error. It just can happen from time=
 to
> time.
>>
>> Well, if it does not happen often, why do we want to suppress reportin=
g
>> this error? I still do not see what it's good for.
>>
>> Wolfgang.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can" i=
n
>> the body of a message to majordomo <at> vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>=20
> How do you define not often? Is it not often one time per ~130us? For X=

> channels you should divide it through X. Please assume this case stocha=
stic
> =3D> not always.=20
> Next if the information is for an application irrelevant, why I need to=

> generate an IRQ and use CPU resources?
>=20
> How to fight with such case:
>=20
> 1) Use time triggered protocol - not always possible=20
> 2) Slow done communication - not always possible
> 3) Buy faster machine - not always possible
> 4) Combination of 1..4 - ...
>=20
> or
>=20
> 5) Let a freedom to a programmer, for the price that he shall to know i=
t.

+1

Feel free to implement it, as outlined in the previous mails.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--0mdc4JomHPHvV5fW8e9gFG4teQTsDXf8d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKlnFQACgkQjTAFq1RaXHNJjACeMs3qjs/Z3+IQAcHUVMkj82dT
KcYAnA2vLBVbheNhAN5IUrZ9owV+bB4h
=gDDi
-----END PGP SIGNATURE-----

--0mdc4JomHPHvV5fW8e9gFG4teQTsDXf8d--
