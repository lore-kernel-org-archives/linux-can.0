From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/6] can: cc770: linux/can/dev.h included twice
Date: Sat,  3 Mar 2012 18:00:10 +0100
Message-ID: <1330794015-14930-2-git-send-email-mkl@pengutronix.de>
References: <1330794015-14930-1-git-send-email-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1330794015-14930-1-git-send-email-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de, Danny Kukawka <danny.kukawka@bisect.de>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Danny Kukawka <danny.kukawka@bisect.de>

drivers/net/can/cc770/cc770.c included 'linux/can/dev.h' twice,
remove the duplicate.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/cc770/cc770.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
index c30f0e6..d42a6a7 100644
--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -34,7 +34,6 @@
 #include <linux/can.h>
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
-#include <linux/can/dev.h>
 #include <linux/can/platform/cc770.h>
 
 #include "cc770.h"
-- 
1.7.4.1
