From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 7/7 v9] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Tue, 27 Jan 2015 14:07:24 +0100
Message-ID: <54C78D8C.30107@pengutronix.de>
References: <1422009085-11858-1-git-send-email-s.grosjean@peak-system.com> <1422009085-11858-8-git-send-email-s.grosjean@peak-system.com> <54C64633.9080204@pengutronix.de> <54C65912.5020309@peak-system.com> <54C659C0.4040207@pengutronix.de> <54C66063.9050500@peak-system.com> <54C6628D.7010902@pengutronix.de> <54C6ABE1.8000504@hartkopp.net> <54C6ACBD.2020806@pengutronix.de> <54C74589.9050603@hartkopp.net> <54C746AE.60801@pengutronix.de> <54C78C6E.3070705@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="BVoTCuhFpO7BFAAPTM9xdBe7Th6qTqd21"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56684 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbbA0NHd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 27 Jan 2015 08:07:33 -0500
In-Reply-To: <54C78C6E.3070705@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BVoTCuhFpO7BFAAPTM9xdBe7Th6qTqd21
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/27/2015 02:02 PM, Stephane Grosjean wrote:
> Hi guys,
>=20
> Le 27/01/2015 09:05, Marc Kleine-Budde a =C3=A9crit :
>> On 01/27/2015 09:00 AM, Oliver Hartkopp wrote:
>>>>> I assume it is better to set the ctrlmode directly in the struct ca=
n_priv
>>>>> element in  pcan_usb_fd_init() after retrieving the firmware versio=
n.
>>>> Even better.
>>>>
>>>>> IMO it doesn't make sense to transport this info through the mechan=
ic above
>>>>> which mostly initialized quasi constant settings for the adapter.
>>>> If we check the firmware version, it doesn't make sende to put the
>>>> information into that struct (IMHO)
>>> Just to be sure: We stated to have the same opinion here, right?
>> Yes, check the firmware version and set ctrlmode directly.
>>
>>>>> +/* describes the PCAN-USB Pro FD adapter */
>>>>> +struct peak_usb_adapter pcan_usb_pro_fd =3D {
>>>>>
>>>>> be
>>>>>
>>>>> +/* describes the PCAN-USB Pro FD adapter */
>>>>> +const struct peak_usb_adapter pcan_usb_pro_fd =3D {
>>>> Yes, but it probably needs some more modifications in the driver.
>>> I don't know if this struct is "read-only" all the time.
>>> If so it is easy to change.
>> I haven't checked but I _think_ it should be possible to make it read
>> only everywhere.
>>
>>> I pity you, Stephane - but we will make it :-))
>> :)
>>
>> Marc
>=20
> My :) as well as my ACK too...
>=20
> But putting "const" here leads to several other changes in=20
> pcan_usb_core.h and pcan_usb_core.c (as well as in older pcan_usb.c and=
=20
> pcan_usb_pro.c files, where same struct peak_adapter static objects are=
=20
> used to define the corresponding USB adapter).
>=20
> Do you need another patch which does this, once for all?

Yes, make a patch that converts the existing driver...btw while there
you can convert static struct peak_usb_adapter not to be NULL terminated
but work with ARRAY_SIZE().

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--BVoTCuhFpO7BFAAPTM9xdBe7Th6qTqd21
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUx42SAAoJECte4hHFiupU38gP/R3wE9mptoaFpninwHlY5Ti1
JZyq4wCixV6LoaxBuH/7IWz+Bx5iAvzjZuODw2bI8W1O9hmmCS5w/4GgxswJ+WVq
yNxTigSehKaBmSMl8X527bIGFbmRc4UonSraXjrJNN3g2ZgQFIZiDIc8B8gPhLVX
pHJcdigTWoqI3Kx1tPo0thfsVgqHcxkzIUkizS855Txu00vnkKYPJAAne2n45wae
SRF+u6HzQ0LRc5UFo1oTejj3fJzMdKD/XrtQfpduD69Ta3qmrTg9VQTFSRsLoKP7
UGWESYnS+g2PiW/GXvfAyqlrAnVlZEZAD19DgeXgBeI0lJDEtaiazz1ZIpttfUvV
8z8t5wiJ7v3BIQEK1DPfgCsQQ8K96keP4zM1WFOrWTkGPAYTmDamfCc82UfPonsw
josUkzujQiT+9tHKchHQtnkWH+yKbr9VZywwIUSI5tjHyEULkGIzig4a3FdK5wTj
IWOq7AmXl8p5eDZlIkMFLc7GN/KiNybG8IL3knFJf+l3/VPhpsfSmZRYRr0MvQ6j
yzCear1CJ19+0na/feL5+9uEOkofwqJUKZqhCdB4O9fm3CCkXVppjzGa/L8mX+iB
KKFL8ILeq50cJHmLExhw5Wd+dEFHN0JG3/R20QN+UPjX8xXUCKgK7ceWVwYWYwFQ
/OBK+fLrw0Zg8DGidT+S
=gJbl
-----END PGP SIGNATURE-----

--BVoTCuhFpO7BFAAPTM9xdBe7Th6qTqd21--
