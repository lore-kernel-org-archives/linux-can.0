From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v4 0/6] ARM: dts: sunxi: Add CAN node and can0_pins_a
 pinctrl settings
Date: Wed, 5 Apr 2017 08:22:14 +0200
Message-ID: <20170405062214.ejc4irrypxjoqufu@lukather>
References: <1491330992-9876-1-git-send-email-menschel.p@posteo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="szsydsokvcl6e52r"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1491330992-9876-1-git-send-email-menschel.p@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Menschel <menschel.p@posteo.de>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, wens@csie.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org


--szsydsokvcl6e52r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 04, 2017 at 08:36:26PM +0200, Patrick Menschel wrote:
> The Allwinner A10/A20 SoCs have an on-board CAN (Controller Area Network)
> controller. This patch adds the CAN core to the SoC's include files,
> sun4i-a10.dtsi and sun7i-a20.dtsi.
>=20
> On linux-can mailing list was a discussion about updating the device tree=
 bindings
> https://lkml.org/lkml/2015/9/17/220
> but it did not progress past writing the documentation file.
> Documentation/devicetree/bindings/net/can/sun4i_can.txt
>=20
> The CAN controller can be enabled in a board specific dts file as
> described in the documentation file or by using a device tree overlay.

Applied 1 and 4. The others were already merged.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--szsydsokvcl6e52r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY5I0SAAoJEBx+YmzsjxAgSOEQAKjxcsCT7Rrf5sSDHpcMvezw
bopxOY5Gns17NPohj2yhOHhRMKjaw74SBadlZLcT6U2M/uWS/qXfyYMswVu1F5be
py1BnAcZZ26fp8Xj4K+RFUZvq8dMO8vNUIjy3R3HYbwsaww7zY7w+q5MsvkpR4Wk
lxWr46O2KhjCtTf8NESrlR/hg8PkZUoYhABeaaWTB5W4SkgKLhFcAyDrE/2th7j+
sBJZkN5qyzfl7IZ/EUIsayGjxF/gXhYi4N/0N9pyL164tcCBIcfvs/kIJ0bgPqxu
pxxhrjEL5NOiYMLeLCnZdwNFQoFaVK30bXTQ3SH0qQKRhTtNQDpA+A7TRjMUcsBM
5sjWPAEUpt49vTxaZszxRH3Rs44IGq0il76TQcoGZiSvM0ioNR9DiXqESxTA+ZUs
RzleddwE1UpCk7YEtZk+MbpbBtwWeSuB0fg9l3MYATyp3pc+1DGxzqIOs01TKUjR
lyT3zvCHuXAfpSOz3EuVNWNjMeRjMhMnCMdYvSGPbqxUmtirck1B26d5xS7ZhB/d
jSSibC523Onw8OZIfRbl9B9iXpAfOrLXSELyBJ4Ou9snsRoTOrh0RYvxmAQPqvhf
U7kRzJwvBgzf/98w/0D+DvJ+3KoALQ72mcNOC4Ca8smETlgMx3hSLP5amu0tkq9x
Ltnk+AyUPNbdPyXNlQ2i
=Tx1B
-----END PGP SIGNATURE-----

--szsydsokvcl6e52r--
