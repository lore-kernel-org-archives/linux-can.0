From: Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH 1/2] dt-bindings: Clean-up schema indentation formatting
Date: Thu, 16 Apr 2020 08:42:42 +0200
Message-ID: <20200416064242.azdjulo76ymwgpfq@gilmour.lan>
References: <20200416005549.9683-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s675c5ai5d6avmtq"
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200416005549.9683-1-robh@kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Alexandre Torgue <alexandre.torgue@st.com>, Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Vinod Koul <vkoul@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Mauro Carvalho Chehab <mchehab@kernel.org>, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>
List-Id: linux-can.vger.kernel.org


--s675c5ai5d6avmtq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 15, 2020 at 07:55:48PM -0500, Rob Herring wrote:
> Fix various inconsistencies in schema indentation. Most of these are
> list indentation which should be 2 spaces more than the start of the
> enclosing keyword. This doesn't matter functionally, but affects running
> scripts which do transforms on the schema files.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

For allwinner,
Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--s675c5ai5d6avmtq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXpf+YgAKCRDj7w1vZxhR
xZmqAPwLCqvPnd6KBgcsRgWmwe8BxcsE0xhduyc59wNSaliiHQEAhUMizDtya0EL
yGrmpfvuS8/nRsvbMHGM2twyMWfc6QE=
=F+e6
-----END PGP SIGNATURE-----

--s675c5ai5d6avmtq--
