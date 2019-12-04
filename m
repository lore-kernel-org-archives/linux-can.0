From: Naga Sureshkumar Relli <nagasure@xilinx.com>
Subject: RE: [PATCH V2] can: xilinx_can: Fix missing Rx can packets on CANFD2.0
Date: Wed, 4 Dec 2019 03:59:38 +0000
Message-ID: <MN2PR02MB5727E5E2BF394AC2898D5E1FAF5D0@MN2PR02MB5727.namprd02.prod.outlook.com>
References: <1575375396-3403-1-git-send-email-srinivas.neeli@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1575375396-3403-1-git-send-email-srinivas.neeli@xilinx.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "davem@davemloft.net" <davem@davemloft.net>, Michal Simek <michals@xilinx.com>, Appana Durga Kedareswara Rao <appanad@xilinx.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Srinivas Neeli <sneeli@xilinx.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, git <git@xilinx.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-can.vger.kernel.org

Reviewed-by: Naga Sureshkumar Relli	<naga.sureshkumar.relli@xilinx.com>

> -----Original Message-----
> From: Srinivas Neeli <srinivas.neeli@xilinx.com>
> Sent: Tuesday, December 3, 2019 5:47 PM
> To: wg@grandegger.com; mkl@pengutronix.de; davem@davemloft.net; Michal Simek
> <michals@xilinx.com>; Appana Durga Kedareswara Rao <appanad@xilinx.com>
> Cc: linux-can@vger.kernel.org; netdev@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git <git@xilinx.com>; Naga
> Sureshkumar Relli <nagasure@xilinx.com>; Srinivas Neeli <sneeli@xilinx.com>
> Subject: [PATCH V2] can: xilinx_can: Fix missing Rx can packets on CANFD2.0
> 
> CANFD2.0 core uses BRAM for storing acceptance filter ID(AFID) and MASK
> (AFMASK)registers. So by default AFID and AFMASK registers contain random data. Due to
> random data, we are not able to receive all CAN ids.
> 
> Initializing AFID and AFMASK registers with Zero before enabling acceptance filter to
> receive all packets irrespective of ID and Mask.
> 
> Fixes: 0db9071353a0 ("can: xilinx: add can 2.0 support")
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> ---
>  drivers/net/can/xilinx_can.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c index
> 464af939cd8a..c1dbab8c896d 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -60,6 +60,8 @@ enum xcan_reg {
>  	XCAN_TXMSG_BASE_OFFSET	= 0x0100, /* TX Message Space */
>  	XCAN_RXMSG_BASE_OFFSET	= 0x1100, /* RX Message Space */
>  	XCAN_RXMSG_2_BASE_OFFSET	= 0x2100, /* RX Message Space */
> +	XCAN_AFR_2_MASK_OFFSET	= 0x0A00, /* Acceptance Filter MASK */
> +	XCAN_AFR_2_ID_OFFSET	= 0x0A04, /* Acceptance Filter ID */
>  };
> 
>  #define XCAN_FRAME_ID_OFFSET(frame_base)	((frame_base) + 0x00)
> @@ -1809,6 +1811,11 @@ static int xcan_probe(struct platform_device *pdev)
> 
>  	pm_runtime_put(&pdev->dev);
> 
> +	if (priv->devtype.flags & XCAN_FLAG_CANFD_2) {
> +		priv->write_reg(priv, XCAN_AFR_2_ID_OFFSET, 0x00000000);
> +		priv->write_reg(priv, XCAN_AFR_2_MASK_OFFSET, 0x00000000);
> +	}
> +
>  	netdev_dbg(ndev, "reg_base=0x%p irq=%d clock=%d, tx buffers: actual %d, using
> %d\n",
>  		   priv->reg_base, ndev->irq, priv->can.clock.freq,
>  		   hw_tx_max, priv->tx_max);
> --
> 2.7.4
