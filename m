From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3] can: gw: ensure DLC boundaries after CAN frame
 modification
Date: Sat, 5 Jan 2019 11:56:16 +0100
Message-ID: <d07efb4f-462f-3edb-04d9-5ab632b972cd@pengutronix.de>
References: <20190104145526.28492-1-mkl@pengutronix.de>
 <20190104.134126.1987487762349795104.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="m77tETFvuokQikysZXhY3UW5X7TgzOuDX"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190104.134126.1987487762349795104.davem@davemloft.net>
Sender: stable-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, netdev@vger.kernel.org, socketcan@hartkopp.net, ieatmuttonchuan@gmail.com, meissner@suse.de, mkubecek@suse.cz, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m77tETFvuokQikysZXhY3UW5X7TgzOuDX
Content-Type: multipart/mixed; boundary="kQjTefZ6VkzAbYlif6y4onN66huEZHmo4";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: David Miller <davem@davemloft.net>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, netdev@vger.kernel.org,
 socketcan@hartkopp.net, ieatmuttonchuan@gmail.com, meissner@suse.de,
 mkubecek@suse.cz, stable@vger.kernel.org
Message-ID: <d07efb4f-462f-3edb-04d9-5ab632b972cd@pengutronix.de>
Subject: Re: [PATCH v3] can: gw: ensure DLC boundaries after CAN frame
 modification
References: <20190104145526.28492-1-mkl@pengutronix.de>
 <20190104.134126.1987487762349795104.davem@davemloft.net>
In-Reply-To: <20190104.134126.1987487762349795104.davem@davemloft.net>

--kQjTefZ6VkzAbYlif6y4onN66huEZHmo4
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 1/4/19 10:41 PM, David Miller wrote:
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> Date: Fri,  4 Jan 2019 15:55:26 +0100
>=20
>> From: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>> Muyu Yu provided a POC where user root with CAP_NET_ADMIN can create a=
 CAN
>> frame modification rule that makes the data length code a higher value=
 than
>> the available CAN frame data size. In combination with a configured ch=
ecksum
>> calculation where the result is stored relatively to the end of the da=
ta
>> (e.g. cgw_csum_xor_rel) the tail of the skb (e.g. frag_list pointer in=

>> skb_shared_info) can be rewritten which finally can cause a system cra=
sh.
>>
>> Michael Kubecek suggested to drop frames that have a DLC exceeding the=

>> available space after the modification process and provided a patch th=
at can
>> handle CAN FD frames too. Within this patch we also limit the length f=
or the
>> checksum calculations to the maximum of Classic CAN data length (8).
>>
>> CAN frames that are dropped by these additional checks are counted wit=
h the
>> CGW_DELETED counter which indicates misconfigurations in can-gw rules.=

>>
>> This fixes CVE-2019-3701.
>>
>> Reported-by: Muyu Yu <ieatmuttonchuan@gmail.com>
>> Reported-by: Marcus Meissner <meissner@suse.de>
>> Suggested-by: Michal Kubecek <mkubecek@suse.cz>
>> Tested-by: Muyu Yu <ieatmuttonchuan@gmail.com>
>> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Cc: linux-stable <stable@vger.kernel.org> # >=3D v3.2
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> Marc, do you want me to apply this directly to my net tree?

No, I'll send a pull request.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--kQjTefZ6VkzAbYlif6y4onN66huEZHmo4--

--m77tETFvuokQikysZXhY3UW5X7TgzOuDX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlwwjVAACgkQk9IU1zQo
ZfH6twf/de8RPq5c/ArqjqV5I226oAI9XD7pA5+1OOr4d2BbwuDw61wxFHrlRK3F
tS4SvUEQGS/6b49BXFR4pqw+nYoEgg05GtMbNT21RqNDMhcoVNOR5YAz7+irjKd6
86UjKwsufiA+wOOefORDss7vJAIThQz6OZqb17s/nIWtQIjVIc0QGIRHy1yl+j/o
YnqWP36o8s9EzTmryJT5IZMmtrxSDemVOG5Zes4u6DkblH+18FC+erjL02PUJwlQ
RfdF4NfuZri71p83biuIGKJ71E4w+zqKqW9bH4/JE4HhKWEzVJ/ln8qTUoqgOQpL
ryk62JuFieCLu9WrvtgcmZZLW3En6g==
=xueP
-----END PGP SIGNATURE-----

--m77tETFvuokQikysZXhY3UW5X7TgzOuDX--
