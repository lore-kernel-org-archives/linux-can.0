From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/3] can: m_can: Make hclk optional
Date: Thu, 20 Jul 2017 12:42:33 +0300
Message-ID: <11cb765b-d69a-d7d5-b1e4-b55200764e63@cogentembedded.com>
References: <20170719230926.10872-1-fcooper@ti.com>
 <20170719230926.10872-2-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170719230926.10872-2-fcooper@ti.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org, quentin.schulz@free-electrons.com
List-Id: linux-can.vger.kernel.org

Hello!

On 7/20/2017 2:09 AM, Franklin S Cooper Jr wrote:

> Hclk is the MCAN's interface clock. However, for OMAP based devices such as
> DRA7 SoC family the interface clock is handled by hwmod. Therefore, this
> interface clock is managed by hwmod driver via pm_runtime_get and
> pm_runtime_put calls. Therefore, this interface clock isn't defined in DT
> and thus the driver shouldn't fail if this clock isn't found.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>   drivers/net/can/m_can/m_can.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index f4947a7..7fe9145 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1568,8 +1568,13 @@ static int m_can_plat_probe(struct platform_device *pdev)
>   	hclk = devm_clk_get(&pdev->dev, "hclk");
>   	cclk = devm_clk_get(&pdev->dev, "cclk");
>   
> -	if (IS_ERR(hclk) || IS_ERR(cclk)) {
> -		dev_err(&pdev->dev, "no clock found\n");
> +	if (IS_ERR(hclk)) {
> +		dev_warn(&pdev->dev, "can't find hclk\n");
> +		hclk = 0;

    s/0/NULL/.

[...]

MBR, Sergei
