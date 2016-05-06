From: Mikhail Kofanov <c5r@yandex.ru>
Subject: Re: can: flexcan: patch
Date: Fri, 06 May 2016 16:47:32 +0300
Message-ID: <629131462542452@web29o.yandex.ru>
References: <14855451462460611@web29h.yandex.ru> <572C7149.6040307@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from forward15o.cmail.yandex.net ([37.9.109.212]:39078 "EHLO
	forward15o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757007AbcEFNzX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 6 May 2016 09:55:23 -0400
In-Reply-To: <572C7149.6040307@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can <linux-can@vger.kernel.org>

https://git.kernel.org/cgit/linux/kernel/git/mkl/linux-can-next.git/tre=
e/?id=3Dffd461f80d536336811d573f197f3e6d9872d054




06.05.2016, 13:26, "Marc Kleine-Budde" <mkl@pengutronix.de>:
> On 05/05/2016 05:03 PM, Mikhail Kofanov wrote:
>> =9AHello!
>>
>> =9AThere is small patch for imx flexcan driver.
>> =9A1. Improve state change handling
>> =9A2. add tx/rx error counter to state change error frame
>>
>> =9ATested on imx25 based custom board.
>
> Against which kernel version does this patch apply?
>
>> =9Adiff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.=
c
>> =9Aindex e2d7ded..84d1fd8 100644
>> =9A--- a/drivers/net/can/flexcan.c
>> =9A+++ b/drivers/net/can/flexcan.c
>> =9A@@ -581,11 +581,14 @@ static int flexcan_poll_state(struct net_de=
vice *dev, u32 reg_esr)
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Astruct flexcan_priv *priv =3D netdev_priv=
(dev);
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Astruct sk_buff *skb;
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Astruct can_frame *cf;
>> =9A+ struct flexcan_regs __iomem *regs =3D priv->regs;
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Aenum can_state new_state =3D 0, rx_state =
=3D 0, tx_state =3D 0;
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Aint flt;
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Astruct can_berr_counter bec;
>>
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Aflt =3D reg_esr & FLEXCAN_ESR_FLT_CONF_MA=
SK;
>> =9A+ /* always send error counters in error frame */
>> =9A+ __flexcan_get_berr_counter(dev, &bec);
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Aif (likely(flt =3D=3D FLEXCAN_ESR_FLT_CON=
=46_ACTIVE)) {
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Atx_state =3D unli=
kely(reg_esr & FLEXCAN_ESR_TX_WRN) ?
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=
=9A=9ACAN_STATE_ERROR_WARNING : CAN_STATE_ERROR_ACTIVE;
>> =9A@@ -593,7 +596,6 @@ static int flexcan_poll_state(struct net_devi=
ce *dev, u32 reg_esr)
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=
=9A=9ACAN_STATE_ERROR_WARNING : CAN_STATE_ERROR_ACTIVE;
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Anew_state =3D max=
(tx_state, rx_state);
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A} else {
>> =9A- __flexcan_get_berr_counter(dev, &bec);
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Anew_state =3D flt=
 =3D=3D FLEXCAN_ESR_FLT_CONF_PASSIVE ?
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=
=9A=9ACAN_STATE_ERROR_PASSIVE : CAN_STATE_BUS_OFF;
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Arx_state =3D bec.=
rxerr >=3D bec.txerr ? new_state : 0;
>> =9A@@ -603,6 +605,8 @@ static int flexcan_poll_state(struct net_devi=
ce *dev, u32 reg_esr)
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A/* state hasn't changed */
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Aif (likely(new_state =3D=3D priv->can.sta=
te))
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Areturn 0;
>> =9A+ netdev_dbg(dev, "reg_esr=3D0x%x flt=3D0x%x ctrl=3D0x%08x new_st=
ate=3D%d\n", reg_esr, flt, flex
>> =9A+ new_state);
>>
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Askb =3D alloc_can_err_skb(dev, &cf);
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Aif (unlikely(!skb))
>> =9A@@ -613,6 +617,8 @@ static int flexcan_poll_state(struct net_devi=
ce *dev, u32 reg_esr)
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Aif (unlikely(new_state =3D=3D CAN_STATE_B=
US_OFF))
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Acan_bus_off(dev);
>>
>> =9A+ cf->data[6] =3D bec.txerr;
>> =9A+ cf->data[7] =3D bec.rxerr;
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Adev->stats.rx_packets++;
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Adev->stats.rx_bytes +=3D cf->can_dlc;
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Anetif_receive_skb(skb);
>> =9A@@ -679,7 +685,7 @@ static int flexcan_poll(struct napi_struct *n=
api, int quota)
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A/* The error bits are cleared on read,
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A* use saved value from irq handler.
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A*/
>> =9A- reg_esr =3D flexcan_read(&regs->esr) | priv->reg_esr;
>> =9A+ reg_esr =3D flexcan_read(&regs->esr) | (priv->reg_esr & FLEXCAN=
_ESR_ERR_BUS);
>>
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A/* handle state changes */
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Awork_done +=3D flexcan_poll_state(dev, re=
g_esr);
>> =9A@@ -721,24 +727,29 @@ static irqreturn_t flexcan_irq(int irq, voi=
d *dev_id)
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Aif (reg_esr & FLEXCAN_ESR_ALL_INT)
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Aflexcan_write(reg=
_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
>>
>> =9A+
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A/* schedule NAPI in case of:
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A* - rx IRQ
>> =9A- * - state change IRQ
>> =9A+ * - tx/rx warning or bus-off
>> =9A+ * - any state change
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A* - bus error IRQ and bus error report=
ing is activated
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A*/
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Aif ((reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_A=
VAILABLE) ||
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A(reg_esr & FLEXCAN_ESR_ERR_ST=
ATE) ||
>> =9A+ ((reg_esr & FLEXCAN_ESR_FLT_CONF_MASK) !=3D (priv->reg_esr & FL=
EXCAN_ESR_FLT_CONF_MAS
>
> There seems to be a problem with this mail, the rest of this line is
> missing.
>
> Marc
>
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Aflexcan_has_and_handle_berr(p=
riv, reg_esr)) {
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A/* The error bits=
 are cleared on read,
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A* save them fo=
r later use.
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A*/
>> =9A- priv->reg_esr =3D reg_esr & FLEXCAN_ESR_ERR_BUS;
>> =9A+ priv->reg_esr =3D reg_esr;
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Aflexcan_write(FLE=
XCAN_IFLAG_DEFAULT &
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=
=9A=9A=9A=9A=9A=9A=9A=9A~FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->imask1=
);
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Aflexcan_write(pri=
v->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=
=9A=9A=9A=9A=9A=9A=9A=9A&regs->ctrl);
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Anapi_schedule(&pr=
iv->napi);
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A}
>> =9A+ else
>> =9A+ priv->reg_esr =3D reg_esr;
>>
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A/* FIFO overflow */
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Aif (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OV=
ERFLOW) {
>
> --
> Pengutronix e.K. | Marc Kleine-Budde |
> Industrial Linux Solutions | Phone: +49-231-2826-924 |
> Vertretung West/Dortmund | Fax: +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686 | http://www.pengutronix.de |
