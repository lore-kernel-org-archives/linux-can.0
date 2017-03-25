From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3 2/6] can: m_can: Removed initialization of FIFO water
 marks
Date: Sat, 25 Mar 2017 16:33:54 +0100
Message-ID: <f46f9069-bdd0-54db-1ef7-f7a361de4d11@hartkopp.net>
References: <1490374171-15190-1-git-send-email-mario.huettel@de.bosch.com>
 <1490374171-15190-2-git-send-email-mario.huettel@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:19284 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbdCYPd6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 25 Mar 2017 11:33:58 -0400
In-Reply-To: <1490374171-15190-2-git-send-email-mario.huettel@de.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mario Huettel <mario.huettel@de.bosch.com>, linux-can@vger.kernel.org



On 03/24/2017 05:49 PM, Mario Huettel wrote:
> FIFO water marks disabled because the driver doesn't handle water mark events.
>
> Signed-off-by: Mario Huettel <mario.huettel@de.bosch.com>

Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>

> ---
>  drivers/net/can/m_can/m_can.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 6797977..ddcbe8b 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -864,11 +864,11 @@ static void m_can_chip_config(struct net_device *dev)
>  	/* rx fifo configuration, blocking mode, fifo size 1 */
>  	m_can_write(priv, M_CAN_RXF0C,
>  		    (priv->mcfg[MRAM_RXF0].num << RXFC_FS_OFF) |
> -		    RXFC_FWM_1 | priv->mcfg[MRAM_RXF0].off);
> +		     priv->mcfg[MRAM_RXF0].off);
>
>  	m_can_write(priv, M_CAN_RXF1C,
>  		    (priv->mcfg[MRAM_RXF1].num << RXFC_FS_OFF) |
> -		    RXFC_FWM_1 | priv->mcfg[MRAM_RXF1].off);
> +		     priv->mcfg[MRAM_RXF1].off);
>
>  	cccr = m_can_read(priv, M_CAN_CCCR);
>  	cccr &= ~(CCCR_TEST | CCCR_MON | (CCCR_CMR_MASK << CCCR_CMR_SHIFT) |
>
