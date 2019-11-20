From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] can: xilinx_can: Fix usage of skb memory
Date: Wed, 20 Nov 2019 13:37:32 +0100
Message-ID: <30572daa-1c75-37a2-20f5-c1f818acc603@pengutronix.de>
References: <1574251865-19592-1-git-send-email-srinivas.neeli@xilinx.com>
 <1574251865-19592-3-git-send-email-srinivas.neeli@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="VJ7JV65o8ehgq8fGg8Ur0l68J44ivsOpz"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1574251865-19592-3-git-send-email-srinivas.neeli@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Neeli <srinivas.neeli@xilinx.com>, wg@grandegger.com, davem@davemloft.net, michal.simek@xilinx.com, appanad@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, git@xilinx.com, nagasure@xilinx.com
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VJ7JV65o8ehgq8fGg8Ur0l68J44ivsOpz
Content-Type: multipart/mixed; boundary="hle4YSMSiBFJwCiISAd8u83kxFrR0E3Xa";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Srinivas Neeli <srinivas.neeli@xilinx.com>, wg@grandegger.com,
 davem@davemloft.net, michal.simek@xilinx.com, appanad@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 git@xilinx.com, nagasure@xilinx.com
Message-ID: <30572daa-1c75-37a2-20f5-c1f818acc603@pengutronix.de>
Subject: Re: [PATCH 2/2] can: xilinx_can: Fix usage of skb memory
References: <1574251865-19592-1-git-send-email-srinivas.neeli@xilinx.com>
 <1574251865-19592-3-git-send-email-srinivas.neeli@xilinx.com>
In-Reply-To: <1574251865-19592-3-git-send-email-srinivas.neeli@xilinx.com>

--hle4YSMSiBFJwCiISAd8u83kxFrR0E3Xa
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/20/19 1:11 PM, Srinivas Neeli wrote:
> As per linux can framework, driver not allowed to touch the skb memory
> after can_put_echo_skb() call.
> This patch fixes the same.
> https://www.spinics.net/lists/linux-can/msg02199.html

NACK.

Don't make a copy of the CAN frame, move the can_put_echo_skb() after
you don't need the skb anymore.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--hle4YSMSiBFJwCiISAd8u83kxFrR0E3Xa--

--VJ7JV65o8ehgq8fGg8Ur0l68J44ivsOpz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3VM4wACgkQWsYho5Hk
nSBrPggAplHwHyBXpA/MuKwjV84TSemich3Q5fZBolKKoLgLUsbjoFC8Ca5zRciK
VM6IAyZWEHq4xuh5T2gcPegBYt1eQm1ECa2J1UNFpfAoY7YB28+L8H6ncQrE9QdC
nZS+6F4PMdGAYMJ0HzWE9NAom62sw/8A18MuYV4zgFapX1BuiWxe3QFbh02bHAtV
AuFI2B7NtM/M/p+pswzxii9y7BB0g4qvz0jJgQHh4W5I8nKrMZyKx+ulCQRaV4mA
qqBRyCYbtVexQBru5181nsuHxDish1KASQP5OCAD48Ip763mOcqmRTYuG4Wp3HAk
+Gl47CTBvwWDWgA+larxa1AMq1wBGA==
=SK8i
-----END PGP SIGNATURE-----

--VJ7JV65o8ehgq8fGg8Ur0l68J44ivsOpz--
