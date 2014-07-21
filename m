From: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Subject: [libsocketcan 2/2] Update can_set_ctrlmode() documentation
Date: Mon, 21 Jul 2014 13:43:20 +0400
Message-ID: <1405935800-26622-5-git-send-email-nebaruzdin@gmail.com>
References: <1405935800-26622-1-git-send-email-nebaruzdin@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:63321 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503AbaGUJng (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 21 Jul 2014 05:43:36 -0400
Received: by mail-la0-f42.google.com with SMTP id pv20so4105831lab.15
        for <linux-can@vger.kernel.org>; Mon, 21 Jul 2014 02:43:35 -0700 (PDT)
Received: from localhost.localdomain (lvk-gate.cs.msu.ru. [188.44.42.233])
        by mx.google.com with ESMTPSA id ks4sm10999632lac.18.2014.07.21.02.43.34
        for <linux-can@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Jul 2014 02:43:34 -0700 (PDT)
In-Reply-To: <1405935800-26622-1-git-send-email-nebaruzdin@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
---
 src/libsocketcan.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/src/libsocketcan.c b/src/libsocketcan.c
index fe3a0b3..21884b6 100644
--- a/src/libsocketcan.c
+++ b/src/libsocketcan.c
@@ -774,13 +774,20 @@ int can_set_restart_ms(const char *name, __u32 restart_ms)
  *
  * @param cm pointer of a can_ctrlmode struct
  *
- * This sets the control mode of the can device. There're currently three
- * different control modes:
- * - LOOPBACK
- * - LISTEN_ONLY
- * - TRIPPLE_SAMPLING
+ * This sets the control mode of the can device. There are currently the
+ * following modes available (each mapped to its own macro):
  *
- * You have to define the control mode struct yourself. a can_ctrlmode struct
+ * @code
+ * #define CAN_CTRLMODE_LOOPBACK           0x01    /* Loopback mode */
+ * #define CAN_CTRLMODE_LISTENONLY         0x02    /* Listen-only mode */
+ * #define CAN_CTRLMODE_3_SAMPLES          0x04    /* Triple sampling mode */
+ * #define CAN_CTRLMODE_ONE_SHOT           0x08    /* One-Shot mode */
+ * #define CAN_CTRLMODE_BERR_REPORTING     0x10    /* Bus-error reporting */
+ * #define CAN_CTRLMODE_FD                 0x20    /* CAN FD mode */
+ * #define CAN_CTRLMODE_PRESUME_ACK        0x40    /* Ignore missing CAN ACKs */
+ * @endcode
+ *
+ * You have to define the control mode struct yourself. A can_ctrlmode struct
  * is declared as:
  *
  * @code
@@ -791,16 +798,8 @@ int can_set_restart_ms(const char *name, __u32 restart_ms)
  * @endcode
  *
  * You can use mask to select modes you want to control and flags to determine
- * if you want to turn the selected mode(s) on or off. Every control mode is
- * mapped to an own macro
- *
- * @code
- * #define CAN_CTRLMODE_LOOPBACK   0x1
- * #define CAN_CTRLMODE_LISTENONLY 0x2
- * #define CAN_CTRLMODE_3_SAMPLES  0x4
- * @endcode
- *
- * e.g. the following pseudocode
+ * if you want to turn the selected mode(s) on or off. E. g. the following
+ * pseudocode will turn the loopback mode on and listenonly mode off:
  *
  * @code
  * struct can_ctrlmode cm;
@@ -810,8 +809,6 @@ int can_set_restart_ms(const char *name, __u32 restart_ms)
  * can_set_ctrlmode(candev, &cm);
  * @endcode
  *
- * will turn the loopback mode on and listenonly mode off.
- *
  * @return 0 if success
  * @return -1 if failed
  */
-- 
2.0.2

