From: T Thayer <tthayer.linux@gmail.com>
Subject: Re: [PATCH 05/16] c_can: use 32 bit access for D_CAN
Date: Sat, 16 Nov 2013 10:37:20 -0600
Message-ID: <CAF03EBcKxO_JckT9BtxbHwax5o4rsQ1P+5X3ox_oJ_U+PPrLWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ve0-f180.google.com ([209.85.128.180]:50383 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab3KPQhV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 16 Nov 2013 11:37:21 -0500
Received: by mail-ve0-f180.google.com with SMTP id jz11so325149veb.25
        for <linux-can@vger.kernel.org>; Sat, 16 Nov 2013 08:37:20 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: b.spranger@linutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Hi,

What is the status of this patch?

This fixes the problem I was seeing for the D_CAN portion of the
driver which was
1. Transmitting 2 copies (probably the result of an AutoRetry)
2. Triggering a RX IRQ on a transmit because the Message Object # was
assigned to RX.
3. CAN statistics were not incrementing properly.

I just joined this mailing list and I don't have this email in my
history so I'm copying it below.

Thanks,

TT

--------------- snipped -----------------

On 09/09/2013 09:25 AM, Benedikt Spranger wrote:
> Other than the C_CAN 16 bit memory interface the D_CAN uses a 32bit memory
> interface. This causes some trouble while accessing the IFxCMR register in
> two 16bit chunks. Use 32bit access on D_CAN.
>
> Signed-off-by: Benedikt Spranger <b.spranger <at> linutronix.de>
> ---
>  drivers/net/can/c_can/c_can.c | 56 +++++++++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
> index 886163f..b3cfb85 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
>  <at>  <at>  -262,11 +262,32  <at>  <at>  static inline int get_tx_echo_msg_obj(const struct c_can_priv *priv)
>
>  static u32 c_can_read_reg32(struct c_can_priv *priv, enum reg index)

What about introducing priv->{read,write}_reg32 function pointers?

>  {
> - u32 val = priv->read_reg(priv, index);
> - val |= ((u32) priv->read_reg(priv, index + 1)) << 16;
> + u32 val;
> +
> + if (priv->type == BOSCH_D_CAN || priv->type == BOSCH_D_CAN_FLEXCARD) {
> + val = readl(priv->base + priv->regs[index]);
> + } else {
> + val = priv->read_reg(priv, index);
> + val |= ((u32) priv->read_reg(priv, index + 1)) << 16;
> + }
>   return val;
>  }
>
> +static void c_can_writereg32(struct c_can_priv *priv, enum reg index,
> + u16 high, u16 low)
> +{

If we decide not to introduce read/write 32 bit function pointers,
please rename your function to c_can_write_reg32() to match the pattern
of the read_reg32() function.

As you have converted some of the potential users of write_reg32() to
work with a single 32 bit value instead of two 16 bits, I think it's
better to call this function with a single 32 bite value.

> + u32 val;
> +
> + if (priv->type == BOSCH_D_CAN || priv->type == BOSCH_D_CAN_FLEXCARD) {
> + val = high << 16;
> + val |= low;
> + writel(val, priv->base + priv->regs[index]);
> + } else {
> + priv->write_reg(priv, index + 1, high);
> + priv->write_reg(priv, index, low);
> + }
> +}
> +
>  static void c_can_enable_all_interrupts(struct c_can_priv *priv,
>   int enable)
>  {
>  <at>  <at>  -309,10 +330,8  <at>  <at>  static inline void c_can_object_get(struct net_device *dev,
>   * register and message RAM must be complete in 6 CAN-CLK
>   * period.
>   */
> - priv->write_reg(priv, C_CAN_IFACE(COMMSK_REG, iface),
> - IFX_WRITE_LOW_16BIT(mask));
> - priv->write_reg(priv, C_CAN_IFACE(COMREQ_REG, iface),
> - IFX_WRITE_LOW_16BIT(objno));
> + c_can_writereg32(priv, C_CAN_IFACE(COMREQ_REG, iface),
> + IFX_WRITE_LOW_16BIT(mask), IFX_WRITE_LOW_16BIT(objno));
>
>   if (c_can_msg_obj_is_busy(priv, iface))
>   netdev_err(dev, "timed out in object get\n");
>  <at>  <at>  -329,9 +348,8  <at>  <at>  static inline void c_can_object_put(struct net_device *dev,
>   * register and message RAM must be complete in 6 CAN-CLK
>   * period.
>   */
> - priv->write_reg(priv, C_CAN_IFACE(COMMSK_REG, iface),
> - (IF_COMM_WR | IFX_WRITE_LOW_16BIT(mask)));
> - priv->write_reg(priv, C_CAN_IFACE(COMREQ_REG, iface),
> + c_can_writereg32(priv, C_CAN_IFACE(COMREQ_REG, iface),
> + IF_COMM_WR | IFX_WRITE_LOW_16BIT(mask),
>   IFX_WRITE_LOW_16BIT(objno));
>
>   if (c_can_msg_obj_is_busy(priv, iface))
>  <at>  <at>  -496,23 +514,19  <at>  <at>  static void c_can_setup_receive_object(struct net_device *dev, int iface,
>  {
>   struct c_can_priv *priv = netdev_priv(dev);
>
> - priv->write_reg(priv, C_CAN_IFACE(MASK1_REG, iface),
> - IFX_WRITE_LOW_16BIT(mask));
> -
>   /* According to C_CAN documentation, the reserved bit
>   * in IFx_MASK2 register is fixed 1
>   */
> - priv->write_reg(priv, C_CAN_IFACE(MASK2_REG, iface),
> - IFX_WRITE_HIGH_16BIT(mask) | BIT(13));
> -
> + c_can_writereg32(priv, C_CAN_IFACE(MASK1_REG, iface),
> + IFX_WRITE_HIGH_16BIT(mask) | BIT(13),
> + IFX_WRITE_LOW_16BIT(mask));
>   id |= IF_ARB_MSGVAL;
> - priv->write_reg(priv, C_CAN_IFACE(ARB1_REG, iface),
> - IFX_WRITE_LOW_16BIT(id));
> - priv->write_reg(priv, C_CAN_IFACE(ARB2_REG, iface),
> - (IFX_WRITE_HIGH_16BIT(id)));
> + c_can_writereg32(priv, C_CAN_IFACE(ARB1_REG, iface),
> + IFX_WRITE_HIGH_16BIT(id), IFX_WRITE_LOW_16BIT(id));
> + c_can_writereg32(priv, C_CAN_IFACE(MSGCTRL_REG, iface), 0, mcont);
>
> - priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), mcont);
> - c_can_object_put(dev, iface, objno, IF_COMM_ALL & ~IF_COMM_TXRQST);
> + c_can_object_put(dev, iface, objno, IF_COMM_WR | IF_COMM_MASK |
> + IF_COMM_ARB | IF_COMM_CONTROL | IF_COMM_CLR_INT_PND);

I think the last change is unrelated.

>
>   netdev_dbg(dev, "obj no:%d, msgval:0x%08x\n", objno,
>   c_can_read_reg32(priv, C_CAN_MSGVAL1_REG));
>

Marc
