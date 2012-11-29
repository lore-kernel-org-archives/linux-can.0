From: kbuild test robot <fengguang.wu@intel.com>
Subject: [can:for-davem 3/5] drivers/net/can/usb/ems_usb.c:903:6: warning: unused variable 'err'
Date: Thu, 29 Nov 2012 21:26:43 +0800
Message-ID: <50b76293.9VF7dj0y5in3n8rs%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63103 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753039Ab2K2N1c (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 29 Nov 2012 08:27:32 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

tree:   git://gitorious.org/linux-can/linux-can-next for-davem
head:   31f03931a244878209a41ab337f7260d8b4da6a6
commit: 8c9a8243358bf335df940d5273363360358148a9 [3/5] can: ems_usb: remove obsolete variable open_time
config: make ARCH=x86_64 allyesconfig

All warnings:

drivers/net/can/usb/ems_usb.c: In function 'ems_usb_set_mode':
drivers/net/can/usb/ems_usb.c:903:6: warning: unused variable 'err' [-Wunused-variable]

vim +903 +/err drivers/net/can/usb/ems_usb.c

702171ad Sebastian Haas      2009-09-16  887  
194b9a4c Marc Kleine-Budde   2012-07-16  888  static const struct can_bittiming_const ems_usb_bittiming_const = {
702171ad Sebastian Haas      2009-09-16  889  	.name = "ems_usb",
702171ad Sebastian Haas      2009-09-16  890  	.tseg1_min = 1,
702171ad Sebastian Haas      2009-09-16  891  	.tseg1_max = 16,
702171ad Sebastian Haas      2009-09-16  892  	.tseg2_min = 1,
702171ad Sebastian Haas      2009-09-16  893  	.tseg2_max = 8,
702171ad Sebastian Haas      2009-09-16  894  	.sjw_max = 4,
702171ad Sebastian Haas      2009-09-16  895  	.brp_min = 1,
702171ad Sebastian Haas      2009-09-16  896  	.brp_max = 64,
702171ad Sebastian Haas      2009-09-16  897  	.brp_inc = 1,
702171ad Sebastian Haas      2009-09-16  898  };
702171ad Sebastian Haas      2009-09-16  899  
702171ad Sebastian Haas      2009-09-16  900  static int ems_usb_set_mode(struct net_device *netdev, enum can_mode mode)
702171ad Sebastian Haas      2009-09-16  901  {
702171ad Sebastian Haas      2009-09-16  902  	struct ems_usb *dev = netdev_priv(netdev);
8c9a8243 Marc Kleine-Budde   2012-07-20 @903  	int err = 0;
702171ad Sebastian Haas      2009-09-16  904  
702171ad Sebastian Haas      2009-09-16  905  	switch (mode) {
702171ad Sebastian Haas      2009-09-16  906  	case CAN_MODE_START:
702171ad Sebastian Haas      2009-09-16  907  		if (ems_usb_write_mode(dev, SJA1000_MOD_NORMAL))
aabdfd6a Wolfgang Grandegger 2012-02-01  908  			netdev_warn(netdev, "couldn't start device");
702171ad Sebastian Haas      2009-09-16  909  
702171ad Sebastian Haas      2009-09-16  910  		if (netif_queue_stopped(netdev))
702171ad Sebastian Haas      2009-09-16  911  			netif_wake_queue(netdev);

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
