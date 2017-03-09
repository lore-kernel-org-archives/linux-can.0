From: kbuild test robot <fengguang.wu@intel.com>
Subject: [mkl-can-next:j1939 1/38] net/can/j1939/socket.c:510:13-20: WARNING
 opportunity for memdup_user
Date: Thu, 9 Mar 2017 21:32:54 +0800
Message-ID: <201703092151.dwyeu4qr%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:13114 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbdCINdH (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 9 Mar 2017 08:33:07 -0500
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: kbuild-all@01.org, linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git j1939
head:   a6a69925d6ac346bbaf98df159bc3493cd8d55a0
commit: 5d073ddf073b82cfda82e86a0809b11895604009 [1/38] can-j1939: Import SAE J1939


coccinelle warnings: (new ones prefixed by >>)

>> net/can/j1939/socket.c:510:13-20: WARNING opportunity for memdup_user

vim +510 net/can/j1939/socket.c

   494			char __user *optval, unsigned int optlen)
   495	{
   496		struct sock *sk = sock->sk;
   497		struct j1939_sock *jsk = j1939_sk(sk);
   498		int tmp, count;
   499		struct j1939_filter *filters, *ofilters;
   500	
   501		if (level != SOL_CAN_J1939)
   502			return -EINVAL;
   503	
   504		switch (optname) {
   505		case SO_J1939_FILTER:
   506			if (optval) {
   507				if (optlen % sizeof(*filters) != 0)
   508					return -EINVAL;
   509				count = optlen / sizeof(*filters);
 > 510				filters = kmalloc(optlen, GFP_KERNEL);
   511				if (!filters)
   512					return -ENOMEM;
   513				if (copy_from_user(filters, optval, optlen)) {
   514					kfree(filters);
   515					return -EFAULT;
   516				}
   517			} else {
   518				filters = NULL;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
