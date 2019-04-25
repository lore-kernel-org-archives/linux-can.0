From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH RESEND] can: m_can: implement errata "Needless activation
 of MRAF irq"
Date: Thu, 25 Apr 2019 08:34:16 +0200
Message-ID: <20190425063416.iuwbtqdhffuidaju@M43218.corp.atmel.com>
References: <1554209445-19879-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1554209445-19879-1-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugen.Hristev@microchip.com
Cc: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-can.vger.kernel.org

On Tue, Apr 02, 2019 at 12:56:18PM +0000, Eugen.Hristev@microchip.com wrote:
> 
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> During frame reception while the MCAN is in Error Passive state
> and the Receive Error Counter has thevalue MCAN_ECR.REC = 127, it may happen
> that MCAN_IR.MRAF is set although there was no Message RAM access failure.
> If MCAN_IR.MRAF is enabled, an interrupt to the Host CPU is generated.
> Work around:
> The Message RAM Access Failure interrupt routine needs to check whether
>  MCAN_ECR.RP = '1' and MCAN_ECR.REC = '127'.
> In this case, reset MCAN_IR.MRAF. No further action is required.
> This affects versions older than 3.2.0
> 
> Errata explained on Sama5d2 SoC which includes this hardware block:
> http://ww1.microchip.com/downloads/en/DeviceDoc/SAMA5D2-Family-Silicon-Errata-and-Data-Sheet-Clarification-DS80000803B.pdf chapter 6.2
> 
> Reproducibility: If 2 devices with m_can are connected back to back,
> configuring different bitrate on them will lead to interrupt storm on the
> receiving side, with error "Message RAM access failure occurred".
> Another way is to have a bad hardware connection. Bad wire connection can lead
> to this issue as well.
> 
> This patch fixes the issue according to provided workaround.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Sounds good.

Reviewed-by: Ludovic Desroches <ludovic.desroches@microchip.com>

> ---
>  drivers/net/can/m_can/m_can.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 9b44940..deb274a 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -822,6 +822,27 @@ static int m_can_poll(struct napi_struct *napi, int quota)
>  	if (!irqstatus)
>  		goto end;
>  
> +	/* Errata workaround for issue "Needless activation of MRAF irq"
> +	 * During frame reception while the MCAN is in Error Passive state
> +	 * and the Receive Error Counter has the value MCAN_ECR.REC = 127,
> +	 * it may happen that MCAN_IR.MRAF is set although there was no
> +	 * Message RAM access failure.
> +	 * If MCAN_IR.MRAF is enabled, an interrupt to the Host CPU is generated
> +	 * The Message RAM Access Failure interrupt routine needs to check
> +	 * whether MCAN_ECR.RP = ’1’ and MCAN_ECR.REC = 127.
> +	 * In this case, reset MCAN_IR.MRAF. No further action is required.
> +	 */
> +	if ((priv->version <= 31) && (irqstatus & IR_MRAF) &&
> +	    (m_can_read(priv, M_CAN_ECR) & ECR_RP)) {
> +		struct can_berr_counter bec;
> +
> +		__m_can_get_berr_counter(dev, &bec);
> +		if (bec.rxerr == 127) {
> +			m_can_write(priv, M_CAN_IR, IR_MRAF);
> +			irqstatus &= ~IR_MRAF;
> +		}
> +	}
> +
>  	psr = m_can_read(priv, M_CAN_PSR);
>  	if (irqstatus & IR_ERR_STATE)
>  		work_done += m_can_handle_state_errors(dev, psr);
> -- 
> 2.7.4
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
