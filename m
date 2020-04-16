From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] dt-bindings: Clean-up schema indentation formatting
Date: Thu, 16 Apr 2020 09:27:54 +0200
Message-ID: <20200416072754.GB1023@kunai>
References: <20200416005549.9683-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6198192554883868411=="
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


--===============6198192554883868411==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline


--PmA2V3Z32TCmWXqI
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

Acked-by: Wolfram Sang <wsa@the-dreams.de> # for I2C


--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6YCPoACgkQFA3kzBSg
KbYO9w/+I4SkxzsKIBEPYPlNhQjpS6257EsfctnShX5MtTXuuVlEM9PKrWOlHqUv
VPZp1gNSi0U/GchhYvzhAQ0yia0RzJoIb9lP8a+B/i2n77CDCgIRyWBqSA/dX2Ts
FqwsTUS4HND9WJve1vPA6xRF0GlFYSCgXTHGgqxWNOdZHkTjIog1Pm+3C6pk+CbX
eKDEHPFiVzkgUvkspatPeh/+nVLQSJ1CA0V0Qstqqu6+c2ciLJxYnh3cstsjThRS
u+Hp1Tj1TGmJtiHEoDYpNbUuGxu8dE+iHMeM4EnePh2KraRRQ+o35bx0QdhhzcU2
2AZf2VMtoqV5XgcyRM6B05wxjD5XQWSEcRPaA4KSiR2G3tFi+WYiVRHI8Pekbgzl
0HPDsprCCwqNPUVqeqcyMOlYPYpOCIcCz17nZKd0ZDv9SphmwAXjvc2KNHg3lnVi
U7BU6i+P4fM8P7Lx496uw1CjUOKtLdM74WYDliTT3timGh1ZYB9l2AC8yTJqBQDY
zRnBeFyItoXVtZbkAQgoGOTuIn6ZUY+ZzUquour0XK2PGJuxxArp0rFcEFAAeccC
/iHPV6k2vWKT/r/wRa5qjwZZrvi0N98xyWX89B0rfqjVasG6DqrTcEnfY/0g8JOo
S0O569k351VYcMrKIrtqc6RsnSOAwPpJskVLGf4j5KhQ1waxcTg=
=JRiG
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--


--===============6198192554883868411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============6198192554883868411==--
