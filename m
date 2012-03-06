From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: can: usb: PEAK-System Technik PCAN-USB specific part
Date: Tue, 6 Mar 2012 14:21:08 +0300
Message-ID: <20120306112108.GA4362@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:34685 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759077Ab2CFLVU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 6 Mar 2012 06:21:20 -0500
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: linux-can@vger.kernel.org

Hello Stephane Grosjean,

The patch 46be265d3388: "can: usb: PEAK-System Technik PCAN-USB 
specific part" from Mar 2, 2012, leads to the following warning:

drivers/net/can/usb/peak_usb/pcan_usb.c:751 pcan_usb_encode_msg()
	 error: wrong number of bits for 'cpu_to_le32' (16 vs 32)

drivers/net/can/usb/peak_usb/pcan_usb.c
   742          /* can id */
   743          if (cf->can_id & CAN_EFF_FLAG) {
   744                  __le32 tmp32 = cpu_to_le32(cf->can_id & CAN_ERR_MASK);
   745  
   746                  tmp32 <<= 3;
   747                  *pc |= PCAN_USB_STATUSLEN_EXT_ID;
   748                  memcpy(++pc, &tmp32, 4);
   749                  pc += 4;
   750          } else {
   751                  __le16 tmp16 = cpu_to_le32(cf->can_id & CAN_ERR_MASK);
                        ^^^^^^^^^^^^
A little endian 32 bit can't fit here.

   752  
   753                  tmp16 <<= 5;
   754                  memcpy(++pc, &tmp16, 2);
   755                  pc += 2;

regards,
dan carpenter

