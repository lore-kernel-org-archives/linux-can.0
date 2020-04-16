From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/2] dt-bindings: Clean-up schema indentation formatting
Date: Thu, 16 Apr 2020 14:43:59 +0200
Message-ID: <20200416124359.GB5785@ravnborg.org>
References: <20200416005549.9683-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:33886 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2636077AbgDPMoR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Apr 2020 08:44:17 -0400
Content-Disposition: inline
In-Reply-To: <20200416005549.9683-1-robh@kernel.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Alexandre Torgue <alexandre.torgue@st.com>, Thierry Reding <thierry.reding@gmail.com>, Vinod Koul <vkoul@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Mauro Carvalho Chehab <mchehab@kernel.org>, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Linu

Hi Rob.

On Wed, Apr 15, 2020 at 07:55:48PM -0500, Rob Herring wrote:
> Fix various inconsistencies in schema indentation. Most of these are
> list indentation which should be 2 spaces more than the start of the
> enclosing keyword. This doesn't matter functionally, but affects running
> scripts which do transforms on the schema files.

Are there any plans to improve the tooling so we get warnigns for this?
Otherwise I am afraid we will see a lot of patches that gets this wrong.

As a follow-up patch it would be good if example-schema.yaml
could gain some comments about the correct indentions.

Some comments in the following.

> diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
> index 49e0362ddc11..b388c5aa7984 100644
> --- a/Documentation/devicetree/bindings/arm/altera.yaml
> +++ b/Documentation/devicetree/bindings/arm/altera.yaml
> @@ -13,8 +13,8 @@ properties:
>    compatible:
>      items:
>        - enum:
> -        - altr,socfpga-cyclone5
> -        - altr,socfpga-arria5
> -        - altr,socfpga-arria10
> +          - altr,socfpga-cyclone5
> +          - altr,socfpga-arria5
> +          - altr,socfpga-arria10
>        - const: altr,socfpga

So here "- enum" do not need the extra indent.
Is it because this is not a list?

>  ...
> diff --git a/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml b/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml
> index 66213bd95e6e..6cc74523ebfd 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml
> +++ b/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml
> @@ -25,7 +25,7 @@ select:
> 
>  properties:
>    compatible:
> -   items:
> +    items:
>        - const: amlogic,meson-gx-ao-secure
>        - const: syscon

This is something I had expected the tooling to notice.
I had expected the two "- const" to be indented with 4 spaces, not two.
So there is something I do not understand.


> diff --git a/Documentation/devicetree/bindings/arm/nxp/lpc32xx.yaml b/Documentation/devicetree/bindings/arm/nxp/lpc32xx.yaml
> index 07f39d3eee7e..f7f024910e71 100644
> --- a/Documentation/devicetree/bindings/arm/nxp/lpc32xx.yaml
> +++ b/Documentation/devicetree/bindings/arm/nxp/lpc32xx.yaml
> @@ -17,9 +17,8 @@ properties:
>            - nxp,lpc3230
>            - nxp,lpc3240
>        - items:
> -        - enum:
> -            - ea,ea3250
> -            - phytec,phy3250
> -        - const: nxp,lpc3250
> -
> +          - enum:
> +              - ea,ea3250
> +              - phytec,phy3250
> +          - const: nxp,lpc3250
>  ...

And here "- enum" receive extra indent.

I trust you know what you are doing - but I do not get it.

Some pointers or examples for the correct indention would be great.
I cannot review this patch as long as I do not know the rules.

My request to update example-schema.yaml was one way to teach me.
(Some people will say that is difficult/impossible to teach me,
but thats another story:-) ).

	Sam
