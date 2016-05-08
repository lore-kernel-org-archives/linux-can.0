From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 6/6] net: can: ifi: Add more detailed error reporting
Date: Sun, 08 May 2016 21:25:24 +0200
Message-ID: <572F92A4.80005@denx.de>
References: <1462660456-6179-1-git-send-email-marex@denx.de> <1462660456-6179-6-git-send-email-marex@denx.de> <572F8C55.5060007@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:33398 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbcEHTZ0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 8 May 2016 15:25:26 -0400
In-Reply-To: <572F8C55.5060007@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 05/08/2016 08:58 PM, Marc Kleine-Budde wrote:
> On 05/08/2016 12:34 AM, Marek Vasut wrote:
>> The updated specification for the IFI CANFD core contains descriptio=
n
>> of more detailed error reporting capability of the core. Implement
>> support for this detailed error reporting.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>>  drivers/net/can/ifi_canfd/ifi_canfd.c | 109 +++++++++++++++++++++++=
+++++++++--
>>  1 file changed, 105 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can=
/ifi_canfd/ifi_canfd.c
>> index ba6cd43..495879f 100644
>> --- a/drivers/net/can/ifi_canfd/ifi_canfd.c
>> +++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
>> @@ -52,7 +52,8 @@
>>  #define IFI_CANFD_TXSTCMD_OVERFLOW		BIT(13)
>> =20
>>  #define IFI_CANFD_INTERRUPT			0xc
>> -#define IFI_CANFD_INTERRUPT_ERROR_WARNING	((u32)BIT(1))
>> +#define IFI_CANFD_INTERRUPT_ERROR_WARNING	BIT(1)
>> +#define IFI_CANFD_INTERRUPT_ERROR_COUNTER	BIT(10)
>>  #define IFI_CANFD_INTERRUPT_TXFIFO_EMPTY	BIT(16)
>>  #define IFI_CANFD_INTERRUPT_TXFIFO_REMOVE	BIT(22)
>>  #define IFI_CANFD_INTERRUPT_RXFIFO_NEMPTY	BIT(24)
>> @@ -103,7 +104,26 @@
>> =20
>>  #define IFI_CANFD_RES1				0x40
>> =20
>> -#define IFI_CANFD_RES2				0x44
>> +#define IFI_CANFD_ERROR_CTR			0x44
>> +#define IFI_CANFD_ERROR_CTR_UNLOCK_MAGIC	0x21302899
>> +#define IFI_CANFD_ERROR_CTR_OVERLOAD_FIRST	BIT(0)
>> +#define IFI_CANFD_ERROR_CTR_ACK_ERROR_FIRST	BIT(1)
>> +#define IFI_CANFD_ERROR_CTR_BIT0_ERROR_FIRST	BIT(2)
>> +#define IFI_CANFD_ERROR_CTR_BIT1_ERROR_FIRST	BIT(3)
>> +#define IFI_CANFD_ERROR_CTR_STUFF_ERROR_FIRST	BIT(4)
>> +#define IFI_CANFD_ERROR_CTR_CRC_ERROR_FIRST	BIT(5)
>> +#define IFI_CANFD_ERROR_CTR_FORM_ERROR_FIRST	BIT(6)
>> +#define IFI_CANFD_ERROR_CTR_OVERLOAD_ALL	BIT(8)
>> +#define IFI_CANFD_ERROR_CTR_ACK_ERROR_ALL	BIT(9)
>> +#define IFI_CANFD_ERROR_CTR_BIT0_ERROR_ALL	BIT(10)
>> +#define IFI_CANFD_ERROR_CTR_BIT1_ERROR_ALL	BIT(11)
>> +#define IFI_CANFD_ERROR_CTR_STUFF_ERROR_ALL	BIT(12)
>> +#define IFI_CANFD_ERROR_CTR_CRC_ERROR_ALL	BIT(13)
>> +#define IFI_CANFD_ERROR_CTR_FORM_ERROR_ALL	BIT(14)
>> +#define IFI_CANFD_ERROR_CTR_BITPOSITION_OFFSET	16
>> +#define IFI_CANFD_ERROR_CTR_BITPOSITION_MASK	0xff
>> +#define IFI_CANFD_ERROR_CTR_ER_RESET		BIT(30)
>> +#define IFI_CANFD_ERROR_CTR_ER_ENABLE		((u32)BIT(31))
>> =20
>>  #define IFI_CANFD_PAR				0x48
>> =20
>> @@ -197,6 +217,8 @@ static void ifi_canfd_irq_enable(struct net_devi=
ce *ndev, bool enable)
>>  	if (enable) {
>>  		enirq =3D IFI_CANFD_IRQMASK_TXFIFO_EMPTY |
>>  			IFI_CANFD_IRQMASK_RXFIFO_NEMPTY;
>> +		if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
>> +			enirq |=3D IFI_CANFD_INTERRUPT_ERROR_COUNTER;
>>  	}
>> =20
>>  	writel(IFI_CANFD_IRQMASK_SET_ERR |
>> @@ -335,6 +357,68 @@ static int ifi_canfd_handle_lost_msg(struct net=
_device *ndev)
>>  	return 1;
>>  }
>> =20
>> +static int ifi_canfd_handle_lec_err(struct net_device *ndev, const =
u32 errctr)
>> +{
>> +	struct ifi_canfd_priv *priv =3D netdev_priv(ndev);
>> +	struct net_device_stats *stats =3D &ndev->stats;
>> +	struct can_frame *cf;
>> +	struct sk_buff *skb;
>> +	const u32 errmask =3D IFI_CANFD_ERROR_CTR_OVERLOAD_FIRST |
>> +			    IFI_CANFD_ERROR_CTR_ACK_ERROR_FIRST |
>> +			    IFI_CANFD_ERROR_CTR_BIT0_ERROR_FIRST |
>> +			    IFI_CANFD_ERROR_CTR_BIT1_ERROR_FIRST |
>> +			    IFI_CANFD_ERROR_CTR_STUFF_ERROR_FIRST |
>> +			    IFI_CANFD_ERROR_CTR_CRC_ERROR_FIRST |
>> +			    IFI_CANFD_ERROR_CTR_FORM_ERROR_FIRST;
>> +
>> +	if (!(errctr & errmask))	/* No error happened. */
>> +		return 0;
>> +
>> +	priv->can.can_stats.bus_error++;
>> +	stats->rx_errors++;
>> +
>> +	/* Propagate the error condition to the CAN stack. */
>> +	skb =3D alloc_can_err_skb(ndev, &cf);
>> +	if (unlikely(!skb))
>> +		return 0;
>> +
>> +	/* Read the error counter register and check for new errors. */
>> +	cf->can_id |=3D CAN_ERR_PROT | CAN_ERR_BUSERROR;
>> +
>> +	if (errctr & IFI_CANFD_ERROR_CTR_OVERLOAD_FIRST)
>> +		cf->data[2] |=3D CAN_ERR_PROT_OVERLOAD;
>> +
>> +	if (errctr & IFI_CANFD_ERROR_CTR_ACK_ERROR_FIRST)
>> +		cf->data[3] =3D CAN_ERR_PROT_LOC_ACK;
>> +
>> +	if (errctr & IFI_CANFD_ERROR_CTR_BIT0_ERROR_FIRST)
>> +		cf->data[2] |=3D CAN_ERR_PROT_BIT0;
>> +
>> +	if (errctr & IFI_CANFD_ERROR_CTR_BIT1_ERROR_FIRST)
>> +		cf->data[2] |=3D CAN_ERR_PROT_BIT1;
>> +
>> +	if (errctr & IFI_CANFD_ERROR_CTR_STUFF_ERROR_FIRST)
>> +		cf->data[2] |=3D CAN_ERR_PROT_STUFF;
>> +
>> +	if (errctr & IFI_CANFD_ERROR_CTR_CRC_ERROR_FIRST)
>> +		cf->data[3] =3D CAN_ERR_PROT_LOC_CRC_SEQ;
>> +
>> +	if (errctr & IFI_CANFD_ERROR_CTR_FORM_ERROR_FIRST)
>> +		cf->data[2] |=3D CAN_ERR_PROT_FORM;
>> +
>> +	/* Reset the error counter, ack the IRQ and re-enable the counter.=
 */
>> +	writel(IFI_CANFD_ERROR_CTR_ER_RESET, priv->base + IFI_CANFD_ERROR_=
CTR);
>> +	writel(IFI_CANFD_INTERRUPT_ERROR_COUNTER,
>> +	       priv->base + IFI_CANFD_INTERRUPT);
>> +	writel(IFI_CANFD_ERROR_CTR_ER_ENABLE, priv->base + IFI_CANFD_ERROR=
_CTR);
>> +
>> +	stats->rx_packets++;
>> +	stats->rx_bytes +=3D cf->can_dlc;
>> +	netif_receive_skb(skb);
>> +
>> +	return 1;
>> +}
>> +
>>  static int ifi_canfd_get_berr_counter(const struct net_device *ndev=
,
>>  				      struct can_berr_counter *bec)
>>  {
>> @@ -470,6 +554,7 @@ static int ifi_canfd_poll(struct napi_struct *na=
pi, int quota)
>> =20
>>  	u32 stcmd =3D readl(priv->base + IFI_CANFD_STCMD);
>>  	u32 rxstcmd =3D readl(priv->base + IFI_CANFD_STCMD);
>> +	u32 errctr =3D readl(priv->base + IFI_CANFD_ERROR_CTR);
>> =20
>>  	/* Handle bus state changes */
>>  	if ((stcmd & stcmd_state_mask) ||
>> @@ -480,6 +565,10 @@ static int ifi_canfd_poll(struct napi_struct *n=
api, int quota)
>>  	if (rxstcmd & IFI_CANFD_RXSTCMD_OVERFLOW)
>>  		work_done +=3D ifi_canfd_handle_lost_msg(ndev);
>> =20
>> +	/* Handle lec errors on the bus */
>> +	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
>> +		work_done +=3D ifi_canfd_handle_lec_err(ndev, errctr);
>> +
>>  	/* Handle normal messages on RX */
>>  	if (!(rxstcmd & IFI_CANFD_RXSTCMD_EMPTY))
>>  		work_done +=3D ifi_canfd_do_rx_poll(ndev, quota - work_done);
>> @@ -499,7 +588,8 @@ static irqreturn_t ifi_canfd_isr(int irq, void *=
dev_id)
>>  	struct net_device_stats *stats =3D &ndev->stats;
>>  	const u32 rx_irq_mask =3D IFI_CANFD_INTERRUPT_RXFIFO_NEMPTY |
>>  				IFI_CANFD_INTERRUPT_RXFIFO_NEMPTY_PER |
>> -				IFI_CANFD_INTERRUPT_ERROR_WARNING;
>> +				IFI_CANFD_INTERRUPT_ERROR_WARNING |
>> +				IFI_CANFD_INTERRUPT_ERROR_COUNTER;
>>  	const u32 tx_irq_mask =3D IFI_CANFD_INTERRUPT_TXFIFO_EMPTY |
>>  				IFI_CANFD_INTERRUPT_TXFIFO_REMOVE;
>>  	const u32 clr_irq_mask =3D ~(IFI_CANFD_INTERRUPT_SET_IRQ |
>=20
> I'll fold this hunk to get rid of another of this warnings :(
>=20
>=20
>>   CC [M]  drivers/net/can/ifi_canfd/ifi_canfd.o
>> drivers/net/can/ifi_canfd/ifi_canfd.c: In function =E2=80=98ifi_canf=
d_isr=E2=80=99:
>> drivers/net/can/ifi_canfd/ifi_canfd.c:595:27: warning: large integer=
 implicitly truncated to unsigned type [-Woverflow]
>>   const u32 clr_irq_mask =3D ~(IFI_CANFD_INTERRUPT_SET_IRQ |
>>                            ^

Thanks for spotting and fixing this!

>> diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can=
/ifi_canfd/ifi_canfd.c
>> index 495879f30906..2d1d22eec750 100644
>> --- a/drivers/net/can/ifi_canfd/ifi_canfd.c
>> +++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
>> @@ -592,8 +592,8 @@ static irqreturn_t ifi_canfd_isr(int irq, void *=
dev_id)
>>                                 IFI_CANFD_INTERRUPT_ERROR_COUNTER;
>>         const u32 tx_irq_mask =3D IFI_CANFD_INTERRUPT_TXFIFO_EMPTY |
>>                                 IFI_CANFD_INTERRUPT_TXFIFO_REMOVE;
>> -       const u32 clr_irq_mask =3D ~(IFI_CANFD_INTERRUPT_SET_IRQ |
>> -                                  IFI_CANFD_INTERRUPT_ERROR_WARNING=
);
>> +       const u32 clr_irq_mask =3D ~((u32)(IFI_CANFD_INTERRUPT_SET_I=
RQ |
>> +                                        IFI_CANFD_INTERRUPT_ERROR_W=
ARNING));
>>         u32 isr;
>> =20
>>         isr =3D readl(priv->base + IFI_CANFD_INTERRUPT);
>=20
> Marc
>=20


--=20
Best regards,
Marek Vasut
