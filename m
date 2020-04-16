From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: Remove cases of 'allOf' containing a
 '$ref'
Date: Thu, 16 Apr 2020 11:41:04 +0100
Message-ID: <20200416104104.GE5354@sirena.org.uk>
References: <20200416005549.9683-1-robh@kernel.org>
 <20200416005549.9683-2-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7728558634019002172=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200416005549.9683-2-robh@kernel.org>
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


--===============7728558634019002172==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/2994txjAzEdQwm5"
Content-Disposition: inline


--/2994txjAzEdQwm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 15, 2020 at 07:55:49PM -0500, Rob Herring wrote:
> json-schema versions draft7 and earlier have a weird behavior in that
> any keywords combined with a '$ref' are ignored (silently). The correct
> form was to put a '$ref' under an 'allOf'. This behavior is now changed

Acked-by: Mark Brown <broonie@kernel.org>

--/2994txjAzEdQwm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6YNkAACgkQJNaLcl1U
h9B9Tgf/e6Ex42p5b/rjUYhiAhK+0T+nvTbdLGjxGyRfopnnVMMaYPWXmkdGdh0H
/nGE0rn04EUyWfBkjgCeKuclbzRWJCfQBSl+4dlYbMuX1LKrybV3nRANP03o7A9y
sqPsDL3Qq01Rgb8waJiwmXqcHjxKBbCZd5bzU8ff82hg8jGKMIDVzJdnYrzGJJm7
wLygPWU+Nj65KniavgesiRhfwSLfveuWwAR6SsWCCiOhJOWgl0/KbhceiFTRLJ4c
pQQeBPzy+/C5VH2sYPCZB3/MEQ4/6+CC1AchkSDqGwOooj4KsPXXCjiJtj4YZB86
9wfRx0ePvlfgBQgHYw4LX6341lhYUw==
=Rw7L
-----END PGP SIGNATURE-----

--/2994txjAzEdQwm5--


--===============7728558634019002172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============7728558634019002172==--
