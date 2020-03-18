From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] docs: dt: Fix m_can.txt reference in tcan4x5x.txt
Date: Wed, 18 Mar 2020 11:36:50 +0100
Message-ID: <8a450951-a28d-dabf-6d52-2c827c5b749e@pengutronix.de>
References: <20200317161900.14380-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200317161900.14380-1-dmurphy@ti.com>
Content-Language: de-DE
Sender: linux-doc-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, linux-doc@vger.kernel.org
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org, robh+dt@kernel.org, davem@davemloft.net, wg@grandegger.com, corbet@lwn.net, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On 3/17/20 5:19 PM, Dan Murphy wrote:
> Fix the m_can.txt reference to point to the bosch,m_can.yaml.
> 
> Fixes: 824674b59f72 ("dt-bindings: net: can: Convert M_CAN to json-schema")
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

Mauro Carvalho Chehab has already send a patch. See:
https://lkml.org/lkml/2020/3/17/843

Feel free to ack that patch.

Marc

> ---
>  Documentation/devicetree/bindings/net/can/tcan4x5x.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> index 6bdcc3f84bd3..3613c2c8f75d 100644
> --- a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> +++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> @@ -14,7 +14,7 @@ Required properties:
>                      the interrupt.
>  	- interrupts: interrupt specification for data-ready.
>  
> -See Documentation/devicetree/bindings/net/can/m_can.txt for additional
> +See Documentation/devicetree/bindings/net/can/bosch,m_can.yaml for additional
>  required property details.
>  
>  Optional properties:
> 


-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
