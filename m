From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v2 2/3] can: m_can: m_can_platform: Add support for
 enabling transceiver
Date: Mon, 17 Feb 2020 09:10:47 -0600
Message-ID: <250f905a-33c3-dd17-15c9-e282299dd742@ti.com>
References: <20200217142836.23702-1-faiz_abbas@ti.com>
 <20200217142836.23702-3-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200217142836.23702-3-faiz_abbas@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, sriram.dash@samsung.com, lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org, mkl@pengutronix.de, wg@grandegger.com
List-Id: linux-can.vger.kernel.org

Faiz

On 2/17/20 8:28 AM, Faiz Abbas wrote:
> CAN transceivers on some boards have a standby line which can be
> toggled to enable/disable the transceiver. Model this as an optional
> fixed xceiver regulator.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Acked-by: Sriram Dash <sriram.dash@samsung.com>
> ---
>   drivers/net/can/m_can/m_can_platform.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
> index 38ea5e600fb8..719468fab507 100644
> --- a/drivers/net/can/m_can/m_can_platform.c
> +++ b/drivers/net/can/m_can/m_can_platform.c
> @@ -6,6 +6,7 @@
>   // Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
>   
>   #include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
>   
>   #include "m_can.h"
>   
> @@ -57,6 +58,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
>   {
>   	struct m_can_classdev *mcan_class;
>   	struct m_can_plat_priv *priv;
> +	struct regulator *reg_xceiver;
>   	struct resource *res;
>   	void __iomem *addr;
>   	void __iomem *mram_addr;
> @@ -111,6 +113,10 @@ static int m_can_plat_probe(struct platform_device *pdev)
>   
>   	m_can_init_ram(mcan_class);
>   
> +	reg_xceiver = devm_regulator_get_optional(&pdev->dev, "xceiver");
> +	if (PTR_ERR(reg_xceiver) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +

Where is this regulator enabled?

Shouldn't the regulator be managed by runtime PM as well?

Dan
