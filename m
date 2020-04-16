From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] dt-bindings: Remove cases of 'allOf' containing a
 '$ref'
Date: Thu, 16 Apr 2020 09:27:37 +0200
Message-ID: <20200416072737.GA1023@kunai>
References: <20200416005549.9683-1-robh@kernel.org>
 <20200416005549.9683-2-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200416005549.9683-2-robh@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, linux-pci@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-remoteproc@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-riscv@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-ser
List-Id: linux-can.vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2020 at 07:55:49PM -0500, Rob Herring wrote:
> json-schema versions draft7 and earlier have a weird behavior in that
> any keywords combined with a '$ref' are ignored (silently). The correct
> form was to put a '$ref' under an 'allOf'. This behavior is now changed
> in the 2019-09 json-schema spec and '$ref' can be mixed with other
> keywords. The json-schema library doesn't yet support this, but the
> tooling now does a fixup for this and either way works.
>=20
> This has been a constant source of review comments, so let's change this
> treewide so everyone copies the simpler syntax.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Wolfram Sang <wsa@the-dreams.de> # for I2C


--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6YCOQACgkQFA3kzBSg
KbZcAg/7BNCS6Plzd0nif30LvUASyKL2fqZ54PDaxkVsHFZ6ILioIzHIss7e8ai/
YkJmKgNKbLtEgg6dNTfoqLN5p52ekU7WvY/r9pDTFJiW0Lllc3aF1LNIC/owey/B
GVXJCFK5qNr0hkMOsS55AW6rBaHMKA73o4hbAByJkdet+EtP0hMphL/0iC6P3g85
edXGHYYNs2ZFcKE4mMMGWc6/kEFsokOp/hWh4nxpGZz9Rpe6C2Q97bvwivhJTLs8
+ef1qvMxtLOjAKNsUB6Kx8yjLKw6qMx/4o0l9ybVUc7WIUxG5E8dNenqDTyqUXej
C1ZQLA8r7cVz6tLihoEeXMNPRBMFXwijjbDA2ai8kVt1nU5eY7/W9MmJfYOdmERQ
fBc8c9sk7nHQGqzXlLD4uONayWHGecD52lns65PUrrCPgyH3tMK2Ds8NPthfl7A/
sx9ezOIP+wbAP07OKg2tPI+q6GdCnGgHpIzUVS0UZjbMGawC/yeW7Kszqa8Dhsp/
xH9sIw5p4Bmwvpct9Y/yFJ7zK0Udyd8Ro4AeF0oeHG7dmWb1RhLGZfg5yfmCJw30
xOMgjKhuD+Uh7raT2JnX3h2lTbKtoZtHldcjOVBmwRDFd7vo3b9yU73FcuGf6QHC
zfdSI05xzxbecqL9It624taFNLcWV0SKltTN2XHG/9EeTqfo+gA=
=vXQq
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
