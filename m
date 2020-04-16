From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: Clean-up schema indentation formatting
Date: Thu, 16 Apr 2020 11:40:24 +0100
Message-ID: <20200416104024.GD5354@sirena.org.uk>
References: <20200416005549.9683-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200416005549.9683-1-robh@kernel.org>
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


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 15, 2020 at 07:55:48PM -0500, Rob Herring wrote:
> Fix various inconsistencies in schema indentation. Most of these are
> list indentation which should be 2 spaces more than the start of the
> enclosing keyword. This doesn't matter functionally, but affects running
> scripts which do transforms on the schema files.

Acked-by: Mark Brown <broonie@kernel.org>

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6YNhcACgkQJNaLcl1U
h9CTpAf+IW4icH5zPKy5c7TecTxfEyWNDjNTt8Pa69ga67NVmMDHKzueRcPb7D3e
ihhK7zM0HDSd8aebO5YtW3GiVBBUyJ0m1CNYvbcsJscIhoOoco+NPJUss00w/0Zs
L0RHGHcgc6lhNve8n+r6QbzSYEeeT9QhqTaPtyPnvMDRUkAYgShAD0ejHjNQWYOt
3KuH8RD18xfK/PWSRsrrxCY3flOTx0RIpS9+oyO+JWIcKd6Y5lCZiBAXGrXEdEjx
bgRsC/mO1YSE03iuDgQnodKThzIoJrygjOkGGDJuYsKY5erh8JZ93l5KPoLkyKCT
SSA9qjNaVs+wMuSlq8WJ3w8m+z5cOA==
=dNaD
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--
