From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] dt-bindings: Clean-up schema indentation formatting
Date: Mon, 20 Apr 2020 18:27:47 +0200
Message-ID: <20200420162747.GA3721@ninjato>
References: <20200416005549.9683-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6479079080126694960=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200416005549.9683-1-robh@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, linux-pci@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-remoteproc@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-riscv@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-ser
List-Id: linux-can.vger.kernel.org


--===============6479079080126694960==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2020 at 07:55:48PM -0500, Rob Herring wrote:
> Fix various inconsistencies in schema indentation. Most of these are
> list indentation which should be 2 spaces more than the start of the
> enclosing keyword. This doesn't matter functionally, but affects running
> scripts which do transforms on the schema files.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

I see that people had comments but I can't judge the topics raised. So,
I trust you guys that you find out when it is good to go and for that,
here is my ack:

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6dzX8ACgkQFA3kzBSg
KbauIw//UsNN3sTG1Vo4Bgtp5Vw0s3m8ojCBjku/VuI/dnL/nKMqOKViAqP/ihOW
epD4QCANZZ0InnhrhnkpKlsCZ3/i+OME4nuCopTRpWH5TUrX4T0f+1NLegcwoxw/
UZ1N+HIQrTXUqpkvVw677OEH4fd4qO2mulRZYu7EPi1zhsQs8tyc0spdKvLPg8IR
Wi165b1RDDsH6+ZFy9+KMDjPmklcrXxWRF/Qc5ATOmaSGMEFc3BTb2uVzVO64Oh0
dZXGDontJcsz+7KQSXatmu38Xwys1bGGxhG7nvkSS/DmaFwnbkLx2jBZFz9GzVNm
QZz3tC7olD6edfkgyL76W7dGYQfeA03MZZ88Sgq304Cgv0QwbTM26C0MXhpG1LZR
sIxf8ZSbwOVUAuXRtABR6Pqu4xm9qbIXtth68kmF8KGPPXIaInqZPOaL0T0ApXm8
ggBIcp2KoH117WlUDqmLOWlvSjecvUh5WxegsaGpmzxU/XTs9YxYvWvLNG5tGBs7
Se2LAoLynrGy7LuUQYtRfbYSULgv0cyhO3V6oRjeqNpgekKCqpzStLFWVdCniiuq
z3guYyMgQ13m1XwXHpeXwhUaak/dp7MvZeg9YxXn1g5MGCVQBMKBAak4aBGnxPLR
OZq32nBakfGpLUy17vQXKQ0FsM9g8+mMc0xbGgzyyjca0mQuJCs=
=5aFH
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--


--===============6479079080126694960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============6479079080126694960==--
