From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3 5/6] can: m_can: Configuration for TX and TX event
 FIFOs
Date: Sat, 25 Mar 2017 17:16:01 +0100
Message-ID: <b46cde32-2e06-2685-1a90-9d8a48d9dd5e@hartkopp.net>
References: <1490374171-15190-1-git-send-email-mario.huettel@de.bosch.com>
 <1490374171-15190-5-git-send-email-mario.huettel@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:25199 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbdCYQTF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 25 Mar 2017 12:19:05 -0400
In-Reply-To: <1490374171-15190-5-git-send-email-mario.huettel@de.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mario Huettel <mario.huettel@de.bosch.com>, linux-can@vger.kernel.org



On 03/24/2017 05:49 PM, Mario Huettel wrote:
> * TX/TX Event FIFO sizes are configured for version >= v3.1.x
>
> Signed-off-by: Mario Huettel <mario.huettel@de.bosch.com>
> ---
>  drivers/net/can/m_can/m_can.c | 39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 7f19ce5..a9f7de4 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -382,6 +382,18 @@ static inline void m_can_fifo_write(const struct m_can_priv *priv,
>  	       fpi * TXB_ELEMENT_SIZE + offset);
>  }
>
> +static inline u32 m_can_txe_fifo_read(const struct m_can_priv *priv,
> +				      u32 fgi,
> +				      u32 offset) {
> +	return readl(priv->mram_base + priv->mcfg[MRAM_TXE].off +
> +			fgi * TXE_ELEMENT_SIZE + offset);
> +}
> +
> +static inline bool m_can_tx_fifo_full(const struct m_can_priv *priv)
> +{
> +		return !!(m_can_read(priv, M_CAN_TXFQS) & TXFQS_TFQF);
> +}
> +
>  static inline void m_can_config_endisable(const struct m_can_priv *priv,
>  					  bool enable)
>  {
> @@ -925,6 +937,7 @@ static int m_can_set_bittiming(struct net_device *dev)
>   * - configure rx fifo
>   * - accept non-matching frame into fifo 0
>   * - configure tx buffer
> + *		- >= v3.1.x: TX FIFO is used
>   * - configure mode
>   * - setup bittiming
>   */
> @@ -941,15 +954,31 @@ static void m_can_chip_config(struct net_device *dev)
>  	/* Accept Non-matching Frames Into FIFO 0 */
>  	m_can_write(priv, M_CAN_GFC, 0x0);
>
> -	/* only support one Tx Buffer currently */
> -	m_can_write(priv, M_CAN_TXBC, (1 << TXBC_NDTB_SHIFT) |
> -		    priv->mcfg[MRAM_TXB].off);
> +	if (priv->version == 30) {
> +		/* only support one Tx Buffer currently */
> +		m_can_write(priv, M_CAN_TXBC, (1 << TXBC_NDTB_SHIFT) |
> +				priv->mcfg[MRAM_TXB].off);
> +	} else {
> +		/* TX FIFO is used for newer IP Core versions */
> +		m_can_write(priv, M_CAN_TXBC,
> +			    (priv->mcfg[MRAM_TXB].num << TXBC_TFQS_SHIFT) |

Are you sure?

Shouldn't this be TXBC_NDTB_SHIFT too?

Regards,
Oliver
