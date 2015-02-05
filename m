From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: can: kvaser_usb: Consolidate and unify state change handling
Date: Thu, 5 Feb 2015 11:12:39 +0300
Message-ID: <20150205081239.GA30683@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:41308 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbbBEINI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Feb 2015 03:13:08 -0500
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: ahmed.darwish@valeo.com
Cc: linux-can@vger.kernel.org

Hello Ahmed S. Darwish,

The patch 96d7f10634e6: "can: kvaser_usb: Consolidate and unify state
change handling" from Jan 26, 2015, leads to the following Smatch
warning:

	drivers/net/can/usb/kvaser_usb.c:827 kvaser_usb_rx_error_update_can_state()
	warn: impossible condition '(es->txerr >= 256) => (0-255 >= 256)'

drivers/net/can/usb/kvaser_usb.c
   824          else if (es->status & M16C_STATE_BUS_PASSIVE)
   825                  new_state = CAN_STATE_ERROR_PASSIVE;
   826          else if (es->status & M16C_STATE_BUS_ERROR) {
   827                  if ((es->txerr >= 256) || (es->rxerr >= 256))
   828                          new_state = CAN_STATE_BUS_OFF;
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Dead code.  We normally ignore these "impossible condition" warnings if
it feels like the condition makes the code more readable.  But in this
case, I wonder if the code works as intended.  It's not clear to me.

   829                  else if ((es->txerr >= 128) || (es->rxerr >= 128))
   830                          new_state = CAN_STATE_ERROR_PASSIVE;
   831                  else if ((es->txerr >= 96) || (es->rxerr >= 96))

regards,
dan carpenter
