From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Fwd: [PATCH] tun/tap: Add the missed return value check of
 register_netdevice_notifier
Date: Thu, 24 Aug 2017 14:10:03 +0200
Message-ID: <b5a0b625-b474-cd67-d4d7-feeaa36b372e@hartkopp.net>
References: <1500543694-23465-1-git-send-email-xiangxia.m.yue@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:13519 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbdHXMKK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Aug 2017 08:10:10 -0400
In-Reply-To: <1500543694-23465-1-git-send-email-xiangxia.m.yue@gmail.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Marc,

just going through your set of patches for the midlayer handling 
simplifications, I was thinking about adding these kind of checks too.

I would suggest these checks to be implemented within a general code 
improvement.

This patch 
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5edfbd3c0697e643f179dba819a7c09375b42543) 
didn't make its way into -stable either.

So I would leave it up to you where in the midlayer patchset these 
checks are to be introduced.

Regards,
Oliver

-------- Forwarded Message --------
Subject: [PATCH] tun/tap: Add the missed return value check of 
register_netdevice_notifier
Date: Thu, 20 Jul 2017 02:41:34 -0700
From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
To: netdev@vger.kernel.org
CC: Tonghao Zhang <xiangxia.m.yue@gmail.com>

There is some codes of tun/tap module which did not check the return
value of register_netdevice_notifier. Add the check now.

Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
---
  drivers/net/tun.c | 10 +++++++++-
  1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 3d4c245..32ad873 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2598,8 +2598,16 @@ static int __init tun_init(void)
  		goto err_misc;
  	}
  -	register_netdevice_notifier(&tun_notifier_block);
+	ret = register_netdevice_notifier(&tun_notifier_block);
+	if (ret) {
+		pr_err("Can't register netdevice notifier\n");
+		goto err_notifier;
+	}
+
  	return  0;
+
+err_notifier:
+	misc_deregister(&tun_miscdev);
  err_misc:
  	rtnl_link_unregister(&tun_link_ops);
  err_linkops:
-- 
1.8.3.1

