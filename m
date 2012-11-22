From: kbuild test robot <fengguang.wu@intel.com>
Subject: [can:for-davem 2/3] drivers/net/can/usb/kvaser_usb.c:431
 kvaser_usb_send_simple_msg() error: doing dma on the stack ((null))
Date: Thu, 22 Nov 2012 20:22:17 +0800
Message-ID: <50ae18f9.g1Qzcmfv5xzx4tke%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6386 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932087Ab2KVSug (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 22 Nov 2012 13:50:36 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Olivier Sobrie <olivier@sobrie.be>
Cc: linux-can@vger.kernel.org, Daniel Berglund <db@kvaser.com>, Marc Kleine-Budde <mkl@pengutronix.de>

tree:   git://gitorious.org/linux-can/linux-can-next for-davem
head:   21c837dccb1b249864b9c8475f51dad355b42554
commit: f0fbcc3bab6ff298bbb8c91de2ddf2824996181f [2/3] can: kvaser_usb: Add support for Kvaser CAN/USB devices


smatch warnings:

+ drivers/net/can/usb/kvaser_usb.c:431 kvaser_usb_send_simple_msg() error: doing dma on the stack ((null))
+ drivers/net/can/usb/kvaser_usb.c:1073 kvaser_usb_set_opt_mode() error: doing dma on the stack ((null))
+ drivers/net/can/usb/kvaser_usb.c:1174 kvaser_usb_flush_queue() error: doing dma on the stack ((null))
+ drivers/net/can/usb/kvaser_usb.c:1384 kvaser_usb_set_bittiming() error: doing dma on the stack ((null))

vim +431 drivers/net/can/usb/kvaser_usb.c

f0fbcc3b Olivier Sobrie 2012-11-21  415  end:
f0fbcc3b Olivier Sobrie 2012-11-21  416  	kfree(buf);
f0fbcc3b Olivier Sobrie 2012-11-21  417  
f0fbcc3b Olivier Sobrie 2012-11-21  418  	return err;
f0fbcc3b Olivier Sobrie 2012-11-21  419  }
f0fbcc3b Olivier Sobrie 2012-11-21  420  
f0fbcc3b Olivier Sobrie 2012-11-21  421  static int kvaser_usb_send_simple_msg(const struct kvaser_usb *dev,
f0fbcc3b Olivier Sobrie 2012-11-21  422  				      u8 msg_id, int channel)
f0fbcc3b Olivier Sobrie 2012-11-21  423  {
f0fbcc3b Olivier Sobrie 2012-11-21  424  	struct kvaser_msg msg = {
f0fbcc3b Olivier Sobrie 2012-11-21  425  		.len = MSG_HEADER_LEN + sizeof(struct kvaser_msg_simple),
f0fbcc3b Olivier Sobrie 2012-11-21  426  		.id = msg_id,
f0fbcc3b Olivier Sobrie 2012-11-21  427  		.u.simple.channel = channel,
f0fbcc3b Olivier Sobrie 2012-11-21  428  		.u.simple.tid = 0xff,
f0fbcc3b Olivier Sobrie 2012-11-21  429  	};
f0fbcc3b Olivier Sobrie 2012-11-21  430  
f0fbcc3b Olivier Sobrie 2012-11-21 @431  	return kvaser_usb_send_msg(dev, &msg);
f0fbcc3b Olivier Sobrie 2012-11-21  432  }
f0fbcc3b Olivier Sobrie 2012-11-21  433  
f0fbcc3b Olivier Sobrie 2012-11-21  434  static int kvaser_usb_get_software_info(struct kvaser_usb *dev)
f0fbcc3b Olivier Sobrie 2012-11-21  435  {
f0fbcc3b Olivier Sobrie 2012-11-21  436  	struct kvaser_msg msg;
f0fbcc3b Olivier Sobrie 2012-11-21  437  	int err;
f0fbcc3b Olivier Sobrie 2012-11-21  438  
f0fbcc3b Olivier Sobrie 2012-11-21  439  	err = kvaser_usb_send_simple_msg(dev, CMD_GET_SOFTWARE_INFO, 0);

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
