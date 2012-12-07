From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC v2 0/7] pch_can/c_can: fix races and add PCH support to
 c_can
Date: Fri, 07 Dec 2012 10:26:37 +0100
Message-ID: <50C1B64D.8030209@grandegger.com>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com> <4036287.fuKZ6k5idx@ws-stein> <50C0AC38.8080405@grandegger.com> <9545085.epYbjMqEeA@ws-stein> <50C12B77.1060501@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:46969 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099Ab2LGJ0q (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 7 Dec 2012 04:26:46 -0500
In-Reply-To: <50C12B77.1060501@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

On 12/07/2012 12:34 AM, Marc Kleine-Budde wrote:
> On 12/06/2012 06:14 PM, Alexander Stein wrote:
>>> This is a typical out-of-sequence reception with a 
>>> RX-goes-into-first-free-mailbox hardware. I've implemented the
>>> algorithm used in the at91 and fixed the one for the ti_hecc.
>>
>> Marc, do you mean out-of-sequence reception with such mailbox types
>> can happen even with the algorithm used in c_can and at91?
> 
> It can happen, if the algorithm isn't implemented properly and adopted
> to the needs of the hardware. On the unmodified ti_hecc we see this
> out-of-sequence problems, too.

Yep, that's the tricky part and the pch_can and c_can use a different
approach to solve the problem. Let's concentrate on the c_can driver.
Key-point is that the controller does put the message into the FIFO
object with the lowest number. Here is the relevant code:

/*
 * theory of operation:
 *
 * c_can core saves a received CAN message into the first free message
 * object it finds free (starting with the lowest). Bits NEWDAT and
 * INTPND are set for this message object indicating that a new message
 * has arrived. To work-around this issue, we keep two groups of message
 * objects whose partitioning is defined by C_CAN_MSG_OBJ_RX_SPLIT.
 *
 * To ensure in-order frame reception we use the following
 * approach while re-activating a message object to receive further
 * frames:
 * - if the current message object number is lower than
 *   C_CAN_MSG_RX_LOW_LAST, do not clear the NEWDAT bit while clearing
 *   the INTPND bit.
 * - if the current message object number is equal to
 *   C_CAN_MSG_RX_LOW_LAST then clear the NEWDAT bit of all lower
 *   receive message objects.
 * - if the current message object number is greater than
 *   C_CAN_MSG_RX_LOW_LAST then clear the NEWDAT bit of
 *   only this message object.
 */
static int c_can_do_rx_poll(struct net_device *dev, int quota)
{
	u32 num_rx_pkts = 0;
	unsigned int msg_obj, msg_ctrl_save;
	struct c_can_priv *priv = netdev_priv(dev);
	u32 val = c_can_read_reg32(priv, C_CAN_INTPND1_REG);

	for (msg_obj = C_CAN_MSG_OBJ_RX_FIRST;
			msg_obj <= C_CAN_MSG_OBJ_RX_LAST && quota > 0;
			val = c_can_read_reg32(priv, C_CAN_INTPND1_REG),
			msg_obj++) {
		/*
		 * as interrupt pending register's bit n-1 corresponds to
		 * message object n, we need to handle the same properly.
		 */
		if (val & (1 << (msg_obj - 1))) {
			c_can_object_get(dev, IFACE_RX, msg_obj, IF_COMM_ALL &
					~IF_COMM_TXRQST);
			msg_ctrl_save = priv->read_reg(priv,
					C_CAN_IFACE(MSGCTRL_REG, IFACE_RX));

			if (msg_ctrl_save & IF_MCONT_EOB)
				return num_rx_pkts;

			if (msg_ctrl_save & IF_MCONT_MSGLST) {
				c_can_handle_lost_msg_obj(dev, IFACE_RX,
								msg_obj);
				num_rx_pkts++;
				quota--;
				continue;
			}

			if (!(msg_ctrl_save & IF_MCONT_NEWDAT))
				continue;

			/* read the data from the message object */
			c_can_read_msg_object(dev, IFACE_RX, msg_ctrl_save);

			if (msg_obj < C_CAN_MSG_RX_LOW_LAST)
				c_can_mark_rx_msg_obj(dev, IFACE_RX,
						msg_ctrl_save, msg_obj);
			else if (msg_obj > C_CAN_MSG_RX_LOW_LAST)
				/* activate this msg obj */
				c_can_activate_rx_msg_obj(dev, IFACE_RX,
						msg_ctrl_save, msg_obj);
			else if (msg_obj == C_CAN_MSG_RX_LOW_LAST)
				/* activate all lower message objects */
				c_can_activate_all_lower_rx_msg_obj(dev,
						IFACE_RX, msg_ctrl_save);

			num_rx_pkts++;
			quota--;
		}
	}

	return num_rx_pkts;
}


I see a problem if the current message object number is greater than
C_CAN_MSG_RX_LOW_LAST, which is #8. Lets assume the FIFO filled up to
message number #8 when we read INTPND1_REG. Before the we call
c_can_activate_all_lower_rx_msg_obj(), another message is received
into #9. Then we call c_can_activate_all_lower_rx_msg_obj() and shortly
after another messages is received into #0. The next time we enter
this function it will read first #1 and then #9, which is the wrong
order.

Wolfgang.
