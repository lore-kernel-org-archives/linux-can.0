From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] can: peak: add support for PEAK PCAN-PCIe FD CAN-FD
 boards
Date: Wed, 26 Apr 2017 22:22:09 +0300
Message-ID: <20170426192209.3ae4mloolqbmr27m@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:20404 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932781AbdDZTWf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Apr 2017 15:22:35 -0400
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: linux-can@vger.kernel.org

Hello Stephane Grosjean,

The patch 8ac8321e4a79: "can: peak: add support for PEAK PCAN-PCIe FD
CAN-FD boards" from Jan 19, 2017, leads to the following static
checker warning:

	drivers/net/can/peak_canfd/peak_canfd.c:402 pucan_handle_status()
	error: uninitialized symbol 'cf'.

drivers/net/can/peak_canfd/peak_canfd.c
   362          skb = alloc_can_err_skb(ndev, &cf);
                                               ^^
If skb is NULL "cf" is uninitialized.

   363  
   364          /* test state error bits according to their priority */
   365          if (pucan_status_is_busoff(msg)) {
   366                  netdev_dbg(ndev, "Bus-off entry status\n");
   367                  priv->can.state = CAN_STATE_BUS_OFF;
   368                  priv->can.can_stats.bus_off++;
   369                  can_bus_off(ndev);
   370                  if (skb)
   371                          cf->can_id |= CAN_ERR_BUSOFF;
   372  
   373          } else if (pucan_status_is_passive(msg)) {
   374                  netdev_dbg(ndev, "Error passive status\n");
   375                  priv->can.state = CAN_STATE_ERROR_PASSIVE;
   376                  priv->can.can_stats.error_passive++;
   377                  if (skb) {
   378                          cf->can_id |= CAN_ERR_CRTL;
   379                          cf->data[1] = (priv->bec.txerr > priv->bec.rxerr) ?
   380                                          CAN_ERR_CRTL_TX_PASSIVE :
   381                                          CAN_ERR_CRTL_RX_PASSIVE;
   382                          cf->data[6] = priv->bec.txerr;
   383                          cf->data[7] = priv->bec.rxerr;
   384                  }
   385  
   386          } else if (pucan_status_is_warning(msg)) {
   387                  netdev_dbg(ndev, "Error warning status\n");
   388                  priv->can.state = CAN_STATE_ERROR_WARNING;
   389                  priv->can.can_stats.error_warning++;
   390                  if (skb) {
   391                          cf->can_id |= CAN_ERR_CRTL;
   392                          cf->data[1] = (priv->bec.txerr > priv->bec.rxerr) ?
   393                                          CAN_ERR_CRTL_TX_WARNING :
   394                                          CAN_ERR_CRTL_RX_WARNING;
   395                          cf->data[6] = priv->bec.txerr;
   396                          cf->data[7] = priv->bec.rxerr;
   397                  }
   398  
   399          } else if (priv->can.state != CAN_STATE_ERROR_ACTIVE) {
   400                  /* back to ERROR_ACTIVE */
   401                  netdev_dbg(ndev, "Error active status\n");
   402                  can_change_state(ndev, cf, CAN_STATE_ERROR_ACTIVE,
   403                                   CAN_STATE_ERROR_ACTIVE);

Presumably we want an "if (skb) " here like we have on the other paths.

   404          } else {
   405                  dev_kfree_skb(skb);


regards,
dan carpenter
