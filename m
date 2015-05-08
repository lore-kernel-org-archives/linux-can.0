From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Raw CAN socket support in LXC?
Date: Fri, 8 May 2015 10:28:56 +0200
Message-ID: <554C73C8.5070705@pengutronix.de>
References: <554C6FDE.6080706@actia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="k1ae1wd1AjrS7xN36QqRn6362NINxVOfA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60645 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbbEHI3E (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 8 May 2015 04:29:04 -0400
in-reply-to: <554C6FDE.6080706@actia.se>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: John Ernberg <john.ernberg@actia.se>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: =?UTF-8?Q?Adam_Engstr=c3=b6m?= <adam.engstrom@actia.se>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k1ae1wd1AjrS7xN36QqRn6362NINxVOfA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2015 10:12 AM, John Ernberg wrote:
> We're working on an embedded system where we're planning on wrapping ou=
r=20
> applications in containers as a resource control safety measurement.
>  From our understanding Raw CAN sockets are not yet supported in LXC,=20
> and now we're wondering why.

I don't know - I've never tried to do so. LXC make heavy use of network
namespaces, I think netfilter (NAT, filter) is used to grant access to
the containers.

Can you elaborate your use case in more detail. Do you want to limit the
sending of CAN frames from the containers to the outside? Do you want to
filter on CAN-id or even the contents? What about the receiving side? Do
you want to limit the reception to certain CAN-ids, too?

> Is there any reasoning we should be aware of as to why support has not =

> been added? Except possibly "We have not seen the need" or "No one has =

> taken the time to".

I think all of the above.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--k1ae1wd1AjrS7xN36QqRn6362NINxVOfA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVTHPIAAoJECte4hHFiupUC5MQAIPfLCsEHwEwEcIoFRp7fuOp
HwFcEPZ1d3soXTkZ2ho+0lN3OsbPIDEUEWUaJexphpViIC3pvH5P+kTSJ3OQwHzw
5u6mwDnT1z07rwTXo4v4bKXUijwLWq9uEkoqdgma2o6mR3/MGsRvP8+3qm2YgnNz
m8du49OCZLxQO892lUB2foQdU2iLeit8ft9Gc+cyL4OR7x/xJQw2AhZVVCuCU9hS
bhK4aCSUtDvVwDckGgPSp4pXl+KpM3c30jtK2bvpLCvUs4rtE6WUOKdccAS1SAAF
IyZnLXoUU3rAYNrNc7n4Dr9ahMelp7ew0xMYsA9YfrPgCDfwCLpcxIyyOzGD5c4T
eQxsqL/HkfKH0AyHjwopXldFZRj5WAhD/eMSeIgIWMEVyDFvi3kYuBv+/Ri7epud
wsUf/jFVgcp1IIl5igL/edfL36mQeDW7XaN5ExJuemMhRVFmrdRIwTdfYY0B5ubm
tjgByUpa6WlvhauOdfrhSomSB31NLPF9we2PQFvvQpYcJLqSkB/Bmlw4GMf05sRw
yK5LxGqM0gKkCTq/MINnKdl5qACMS3/xnTVN5fOWBhU9xjjthyLGZXTLwkw4ZS/+
EegPd5X7j59ekHMAPf6Zh4BHaw+0Kogc4Kurgk4ftj4p6FREtJvYj5WDp/G0YR58
b8/fEPuUeDhTM+cMW/VK
=zfTB
-----END PGP SIGNATURE-----

--k1ae1wd1AjrS7xN36QqRn6362NINxVOfA--
