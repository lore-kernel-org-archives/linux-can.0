From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] can: peak: add support for PEAK PCAN-PCIe FD CAN-FD
 boards
Date: Wed, 26 Apr 2017 22:24:59 +0300
Message-ID: <20170426192459.m2o45pjmwycietis@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:21989 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966513AbdDZTZT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Apr 2017 15:25:19 -0400
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: linux-can@vger.kernel.org

Hello Stephane Grosjean,

The patch 8ac8321e4a79: "can: peak: add support for PEAK PCAN-PCIe FD
CAN-FD boards" from Jan 19, 2017, leads to the following static
checker warning:

	drivers/net/can/peak_canfd/peak_canfd.c:504 peak_canfd_handle_msgs_list()
	error: uninitialized symbol 'msg_size'.

drivers/net/can/peak_canfd/peak_canfd.c
   487  /* handle a list of rx_count messages from rx_msg memory address */
   488  int peak_canfd_handle_msgs_list(struct peak_canfd_priv *priv,
   489                                  struct pucan_rx_msg *msg_list, int msg_count)
   490  {
   491          void *msg_ptr = msg_list;
   492          int i, msg_size;
   493  
   494          for (i = 0; i < msg_count; i++) {
                            ^^^^^^^^^^^^^
Can msg_count be zero?

   495                  msg_size = peak_canfd_handle_msg(priv, msg_ptr);
   496  
   497                  /* a null packet can be found at the end of a list */
   498                  if (msg_size <= 0)
   499                          break;
   500  
   501                  msg_ptr += msg_size;
   502          }
   503  
   504          if (msg_size < 0)
                    ^^^^^^^^^^^^
If so, then that's a problem.

   505                  return msg_size;
   506  
   507          return i;
   508  }

regards,
dan carpenter
