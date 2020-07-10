From: trix@redhat.com
Subject: [PATCH] can: j1939: fix double free in j1939_netdev_start
Date: Fri, 10 Jul 2020 06:45:36 -0700
Message-ID: <20200710134536.4399-1-trix@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robin@protonic.nl, linux@rempel-privat.de, kernel@pengutronix.de, socketcan@hartkopp.net, mkl@pengutronix.de, davem@davemloft.net, kuba@kernel.org, ecathinds@gmail.com, lkp@intel.com, bst@pengutronix.de, maxime.jayat@mobile-devices.fr
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
List-Id: linux-can.vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags this error

j1939/main.c:292:2: warning: Attempt to free released memory [unix.Malloc]
        kfree(priv);
        ^~~~~~~~~~~

The problem block of code is

	ret = j1939_can_rx_register(priv);
	if (ret < 0)
		goto out_priv_put;

	return priv;

 out_priv_put:
	j1939_priv_set(ndev, NULL);
	dev_put(ndev);
	kfree(priv);

When j1939_can_rx_register fails, it frees priv via the
j1939_priv_put release function __j1939_priv_release.

Since j1939_priv_put is used widely, remove the second
free from j1939_netdev_start.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/can/j1939/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 137054bff9ec..991a74bc491b 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -289,7 +289,6 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
  out_priv_put:
 	j1939_priv_set(ndev, NULL);
 	dev_put(ndev);
-	kfree(priv);
 
 	return ERR_PTR(ret);
 }
-- 
2.18.1
