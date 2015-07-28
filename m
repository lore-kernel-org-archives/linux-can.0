From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: xilinx: fix RX FIFO overflow error handling
Date: Tue, 28 Jul 2015 10:07:13 +0200
Message-ID: <55B73831.1080804@pengutronix.de>
References: <1437685986-25824-1-git-send-email-andrea.scian@dave.eu>
 <55B1BBEA.7020506@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="tNGoTjVVN9ulDUoJhwwdrxvh7a7qfsSHl"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55B1BBEA.7020506@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, Andrea Scian <andrea.scian@dave.eu>
Cc: wg@grandegger.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, Kedareswara rao Appana <appana.durga.rao@xilinx.com>linux-can <linux-can@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tNGoTjVVN9ulDUoJhwwdrxvh7a7qfsSHl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/24/2015 06:15 AM, Michal Simek wrote:
> + Kedar
>=20
> On 07/23/2015 11:13 PM, Andrea Scian wrote:
>> Simply resetting the peripheral on RX FIFO overflow in not enough,
>> because we also need to re-initialize the whole device.
>> Also always enable RX FIFO overflow interrupt otherwise we may hang
>> until another interrupt arrives (this happens if FIFO overrun and just=

>> read from CAN bus with candump)
>>
>> Signed-off-by: Andrea Scian <andrea.scian@dave.eu>

Sorry, I missed the original patch. Can you repost it to:
linux-can@vger.kernel.org

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--tNGoTjVVN9ulDUoJhwwdrxvh7a7qfsSHl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVtzgxAAoJEP5prqPJtc/H+5AH/2V7b4iOOU4G+hDyj3TFFyWQ
J0a/nde5BGNBfHEyQV1adLEwjA/gB6qRonk/Byv2NtB2gN0bkEzWr6gZAm0RBUA6
UEL0gNoR7c2BK3pSCCj1g+aNs4hTuwqwsNyu3gcbcN0SDc3SGoqMU7XsatTKgx+J
CAiiZS0YTTJQBZo0btjofoG+Tkyf62WPIgAEdPFeLoSFXb7TxpxrGZelwhMrS13X
Ryf5Q7CiaApZkr5I7boLIxSYGtkuTN4SSrwp1XhsG6eyvyxZIxZuhSV1VAvoByv/
/QLtRMVp3n86jRgHdNMP1cpBzXV/VblF4p4wK5h37cy58TdfRBqSYqqccaGcyvY=
=yCcz
-----END PGP SIGNATURE-----

--tNGoTjVVN9ulDUoJhwwdrxvh7a7qfsSHl--
