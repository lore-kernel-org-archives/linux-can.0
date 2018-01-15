From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: peak/usb: fix potential bug in packet fragmentation
Date: Mon, 15 Jan 2018 15:41:07 +0100
Message-ID: <be6ef351-664d-81d2-80f8-bc4215f147ae@pengutronix.de>
References: <20180115104141.4352-1-s.grosjean@peak-system.com>
 <51f04cfe-cb9f-b6f8-25a3-8d6df20dfbad@pengutronix.de>
 <VI1PR0302MB332549CCF19F5E36A661F7FFD6EB0@VI1PR0302MB3325.eurprd03.prod.outlook.com>
 <c5907a33-a653-a2d3-61ea-ac5c64d06318@pengutronix.de>
 <VI1PR0302MB3325B674EB5235EEFC303D9ED6EB0@VI1PR0302MB3325.eurprd03.prod.outlook.com>
 <d7e89bb0-b0ec-8c0d-c3db-7f448c6cc17c@pengutronix.de>
 <VI1PR0302MB3325F6935A768304A38526A2D6EB0@VI1PR0302MB3325.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="DWStm3aBtLHQTef5reiHQWubjiyKWffvn"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47393 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933679AbeAOOla (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 15 Jan 2018 09:41:30 -0500
In-Reply-To: <VI1PR0302MB3325F6935A768304A38526A2D6EB0@VI1PR0302MB3325.eurprd03.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?St=c3=a9phane_Grosjean?= <s.grosjean@peak-system.com>, linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DWStm3aBtLHQTef5reiHQWubjiyKWffvn
Content-Type: multipart/mixed; boundary="W6lqN7Fb8Cf7YwyIR0G1kGRRPkczGVuxa";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?St=c3=a9phane_Grosjean?= <s.grosjean@peak-system.com>,
 linux-can Mailing List <linux-can@vger.kernel.org>
Message-ID: <be6ef351-664d-81d2-80f8-bc4215f147ae@pengutronix.de>
Subject: Re: [PATCH] can: peak/usb: fix potential bug in packet fragmentation
References: <20180115104141.4352-1-s.grosjean@peak-system.com>
 <51f04cfe-cb9f-b6f8-25a3-8d6df20dfbad@pengutronix.de>
 <VI1PR0302MB332549CCF19F5E36A661F7FFD6EB0@VI1PR0302MB3325.eurprd03.prod.outlook.com>
 <c5907a33-a653-a2d3-61ea-ac5c64d06318@pengutronix.de>
 <VI1PR0302MB3325B674EB5235EEFC303D9ED6EB0@VI1PR0302MB3325.eurprd03.prod.outlook.com>
 <d7e89bb0-b0ec-8c0d-c3db-7f448c6cc17c@pengutronix.de>
 <VI1PR0302MB3325F6935A768304A38526A2D6EB0@VI1PR0302MB3325.eurprd03.prod.outlook.com>
In-Reply-To: <VI1PR0302MB3325F6935A768304A38526A2D6EB0@VI1PR0302MB3325.eurprd03.prod.outlook.com>

--W6lqN7Fb8Cf7YwyIR0G1kGRRPkczGVuxa
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 01/15/2018 03:20 PM, St=C3=A9phane Grosjean wrote:
>>>> Yes... like this:
>>>>
>>>>>> +       if (unlikely(dev->udev->speed !=3D USB_SPEED_HIGH))
>>>>>> +               packet_len =3D min(packet_len,
>>>>>> + PCAN_UFD_LOSPD_PKT_SIZE);
>>>>
>>>
>>> Yep! Ok. But for my personal knowledge, what could be the reason? Is
>> there any kinda gcc optimization behind?
>>
>> There is this macro in the kernel, it's easier to read and it does typ=
e checking,
>> see
>> http://elixir.free-
>> electrons.com/linux/latest/source/include/linux/kernel.h#L799
>=20
> Ok. But don't we lose the unlikey() optimization, when using the
> min() macro? I mean that the size of the cmds sent by this way is
> generally less than 64 B...

Yes, the unlikely for the size. But a USB transfer will take a lot of
cycles anyway :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--W6lqN7Fb8Cf7YwyIR0G1kGRRPkczGVuxa--

--DWStm3aBtLHQTef5reiHQWubjiyKWffvn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpcvYMACgkQHv7KIOw4
HPaaQQgA1fVMe9ft9zbeRDVP84xg5t8MoPXAuYKsLXvlaVuLlJzpV9TN/Evv4bG/
o/lWZu9iJAWYZ6eIeZ4UJxOCaS1HzclcAfXWmmUInue/f2kcnUqYY32VLJwv3K8D
sOYTz+AEnUEC7ZKOU6j44zRyg6TLjzA69kuoed0DtOLQ3K2M+vZzdr+1XtgFoy3E
I5+xl1KrknPJ16RdOjdkHtlnTyeFyzIzpD9tEBKlJ+0xTaalLHHwjRhqAAbckQ6V
Rq/r/ngr8BcVQjhiDk57T2IlnaUz6OneiGX85pmJw2fh8JifWyPCntpMAlCSGbxP
H57zNBh6kzab806Vs4vcZoUXW6HtKw==
=Bgbj
-----END PGP SIGNATURE-----

--DWStm3aBtLHQTef5reiHQWubjiyKWffvn--
