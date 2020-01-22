From: "Sriram Dash" <sriram.dash-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH 2/3] can: m_can: m_can_platform: Add support for
 enabling transceiver through the STB line
Date: Wed, 22 Jan 2020 20:23:57 +0530
Message-ID: <002101d5d133$c8352100$589f6300$@samsung.com>
References: <20200122080310.24653-1-faiz_abbas@ti.com>
        <CGME20200122080213epcas5p46e361ac6fa299521c1bab3ab20862b46@epcas5p4.samsung.com>
        <20200122080310.24653-3-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200122080310.24653-3-faiz_abbas-l0cyMroinI0@public.gmane.org>
Content-Language: en-in
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Faiz Abbas' <faiz_abbas-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, dmurphy-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-can.vger.kernel.org

> From: linux-can-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org <linux-can-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> On
> Behalf Of Faiz Abbas
> Subject: [PATCH 2/3] can: m_can: m_can_platform: Add support for enabling
> transceiver through the STB line
> 
> CAN transceivers on some boards have an STB (standby) line which can be
> toggled to enable/disable the transceiver. Add support for enabling the
> transceiver using a GPIO connected to the STB line.
> 

Looks good to me. 
Other than Dan's concern on stb  as standby,
Acked-by: Sriram Dash <sriram.dash-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

> Signed-off-by: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/net/can/m_can/m_can_platform.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/can/m_can/m_can_platform.c
> b/drivers/net/can/m_can/m_can_platform.c
> index 38ea5e600fb8..b4e1423bd5d8 100644
> --- a/drivers/net/can/m_can/m_can_platform.c
> +++ b/drivers/net/can/m_can/m_can_platform.c
> @@ -6,6 +6,7 @@
>  // Copyright (C) 2018-19 Texas Instruments Incorporated -
http://www.ti.com/
> 
>  #include <linux/platform_device.h>
> +#include <linux/gpio/consumer.h>
> 
>  #include "m_can.h"
> 
> @@ -57,6 +58,7 @@ static int m_can_plat_probe(struct platform_device
*pdev)
> {
>  	struct m_can_classdev *mcan_class;
>  	struct m_can_plat_priv *priv;
> +	struct gpio_desc *stb;
>  	struct resource *res;
>  	void __iomem *addr;
>  	void __iomem *mram_addr;
> @@ -111,6 +113,16 @@ static int m_can_plat_probe(struct platform_device
> *pdev)
> 
>  	m_can_init_ram(mcan_class);
> 
> +	stb = devm_gpiod_get_optional(&pdev->dev, "stb", GPIOD_OUT_HIGH);
> +	if (IS_ERR(stb)) {
> +		ret = PTR_ERR(stb);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev,
> +				"gpio request failed, ret %d\n", ret);
> +
> +		goto failed_ret;
> +	}
> +
>  	ret = m_can_class_register(mcan_class);
> 
>  failed_ret:
> --
> 2.19.2
