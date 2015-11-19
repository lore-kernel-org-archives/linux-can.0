From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: can: kvaser_usb: Add support for Kvaser CAN/USB devices
Date: Thu, 19 Nov 2015 15:42:19 +0300
Message-ID: <20151119124219.GC2638@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:20302 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757174AbbKSMmh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Nov 2015 07:42:37 -0500
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: olivier@sobrie.be
Cc: linux-can@vger.kernel.org

Hello Olivier Sobrie,

The patch 080f40a6fa28: "can: kvaser_usb: Add support for Kvaser
CAN/USB devices" from Nov 21, 2012, leads to the following static
checker warning:

	drivers/net/can/usb/kvaser_usb.c:949 kvaser_usb_rx_error()
	0x08 | 0x18 has 0x08 set on both sides

drivers/net/can/usb/kvaser_usb.c
   941          switch (dev->family) {
   942          case KVASER_LEAF:
   943                  if (es->leaf.error_factor) {
   944                          cf->can_id |= CAN_ERR_BUSERROR | CAN_ERR_PROT;
   945  
   946                          if (es->leaf.error_factor & M16C_EF_ACKE)
   947                                  cf->data[3] |= (CAN_ERR_PROT_LOC_ACK);
   948                          if (es->leaf.error_factor & M16C_EF_CRCE)
   949                                  cf->data[3] |= (CAN_ERR_PROT_LOC_CRC_SEQ |
   950                                                  CAN_ERR_PROT_LOC_CRC_DEL);

CAN_ERR_PROT_LOC_CRC_SEQ is 0x08
CAN_ERR_PROT_LOC_CRC_DEL is 0x18

It's weird that the bits overlap.  Was that intentional?  Why isn't it
enough to just say?:
					cf->data[3] |= CAN_ERR_PROT_LOC_CRC_DEL;

The static checker complains about most places where
CAN_ERR_PROT_LOC_CRC_SEQ is used.  I see us setting the flag but not I
don't see where we test for this so I'm not sure.

   951                          if (es->leaf.error_factor & M16C_EF_FORME)
   952                                  cf->data[2] |= CAN_ERR_PROT_FORM;
   953                          if (es->leaf.error_factor & M16C_EF_STFE)
   954                                  cf->data[2] |= CAN_ERR_PROT_STUFF;
   955                          if (es->leaf.error_factor & M16C_EF_BITE0)
   956                                  cf->data[2] |= CAN_ERR_PROT_BIT0;
   957                          if (es->leaf.error_factor & M16C_EF_BITE1)
   958                                  cf->data[2] |= CAN_ERR_PROT_BIT1;
   959                          if (es->leaf.error_factor & M16C_EF_TRE)
   960                                  cf->data[2] |= CAN_ERR_PROT_TX;
   961                  }
   962                  break;
   963          case KVASER_USBCAN:

regards,
dan carpenter
