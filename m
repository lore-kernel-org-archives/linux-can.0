From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] can: mcba_usb: Add support for Microchip CAN BUS
 Analyzer
Date: Thu, 4 May 2017 14:42:37 +0300
Message-ID: <20170504114236.zx7ktyrwiktpkmjw@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:27129 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751540AbdEDLmu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 May 2017 07:42:50 -0400
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: remigiusz.kollataj@mobica.com
Cc: linux-can@vger.kernel.org

Hello Remigiusz Kołłątaj,

The patch 51f3baad7de9: "can: mcba_usb: Add support for Microchip CAN
BUS Analyzer" from Apr 14, 2017, leads to the following static
checker warning:

	drivers/net/can/usb/mcba_usb.c:366 mcba_usb_start_xmit()
	error: 'usb_msg.dlc' from user is not capped properly

drivers/net/can/usb/mcba_usb.c
   320  static netdev_tx_t mcba_usb_start_xmit(struct sk_buff *skb,
   321                                         struct net_device *netdev)
   322  {
   323          struct mcba_priv *priv = netdev_priv(netdev);
   324          struct can_frame *cf = (struct can_frame *)skb->data;
                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Smatch distrusts skb->data.

   325          struct mcba_usb_ctx *ctx = NULL;
   326          struct net_device_stats *stats = &priv->netdev->stats;
   327          u16 sid;
   328          int err;
   329          struct mcba_usb_msg_can usb_msg = {
   330                  .cmd_id = MBCA_CMD_TRANSMIT_MESSAGE_EV
   331          };
   332  
   333          if (can_dropped_invalid_skb(netdev, skb))
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
We do actually cap cf->can_dlc here but it's limited to
CANFD_MAX_DLEN (64) on one path.  Also instead of calling it ->can_dlc
we call it "->len".  My devel versions of Smatch could have parsed this
if we had kept the types consistent.

   334                  return NETDEV_TX_OK;
   335  
   336          ctx = mcba_usb_get_free_ctx(priv, cf);
   337          if (!ctx)
   338                  return NETDEV_TX_BUSY;
   339  
   340          can_put_echo_skb(skb, priv->netdev, ctx->ndx);
   341  
   342          if (cf->can_id & CAN_EFF_FLAG) {
   343                  /* SIDH    | SIDL                 | EIDH   | EIDL
   344                   * 28 - 21 | 20 19 18 x x x 17 16 | 15 - 8 | 7 - 0
   345                   */
   346                  sid = MCBA_SIDL_EXID_MASK;
   347                  /* store 28-18 bits */
   348                  sid |= (cf->can_id & 0x1ffc0000) >> 13;
   349                  /* store 17-16 bits */
   350                  sid |= (cf->can_id & 0x30000) >> 16;
   351                  put_unaligned_be16(sid, &usb_msg.sid);
   352  
   353                  /* store 15-0 bits */
   354                  put_unaligned_be16(cf->can_id & 0xffff, &usb_msg.eid);
   355          } else {
   356                  /* SIDH   | SIDL
   357                   * 10 - 3 | 2 1 0 x x x x x
   358                   */
   359                  put_unaligned_be16((cf->can_id & CAN_SFF_MASK) << 5,
   360                                     &usb_msg.sid);
   361                  usb_msg.eid = 0;
   362          }
   363  
   364          usb_msg.dlc = cf->can_dlc;
   365  
   366          memcpy(usb_msg.data, cf->data, usb_msg.dlc);
                       ^^^^^^^^^^^^
This only has room for 8 bytes, so 64 might be a buffer overflow?

regards,
dan carpenter
