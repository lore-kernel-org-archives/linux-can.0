From: Elenita Hinds <ecathinds@gmail.com>
Subject: [PATCH] j1939: Fix to softirq tasklet race condition when session is destroyed
Date: Wed, 14 Feb 2018 11:45:31 -0600
Message-ID: <CAHChkrvWdUN6KYg9fbnfA2Mg3ie=PNOPuaSvEwqOzj7uG8xJ3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:35872 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161258AbeBNRpc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 14 Feb 2018 12:45:32 -0500
Received: by mail-io0-f196.google.com with SMTP id t22so6065167iob.3
        for <linux-can@vger.kernel.org>; Wed, 14 Feb 2018 09:45:32 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be, o.rempel@pengutronix.de

Hi all.

I was seeing the kernel panic when receiving J1939 packets
promiscuously over both can0 and can1
(with multi-frame messages). The panic is due to the following line in
kernel/softirq.c (line 518):

if (!test_and_clear_bit(TASKLET_STATE_SCHED,
        &t->state))
    BUG();  <=== panic here!!

The issue seems similar to a previous patch in can/bcm.c
(see commit https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/commit/?id=a06393ed03167771246c4c43192d9c264bc48412),
wherein a race condition can occur while the tasklets are being or
have terminated and the soft irq is checking the flag at the same
time. I mimicked the bcm fix and the panic went away.

Below is a proposed fix. Please review.


Regards,
Elenita (Hinds)

----

diff --git net/can/j1939/transport.c net/can/j1939/transport.c
index c15412dae565..9114ae7cdf72 100644
--- net/can/j1939/transport.c
+++ net/can/j1939/transport.c
@@ -121,10 +121,27 @@ static inline struct list_head *sessionq(bool extd)
 static inline void j1939_session_destroy(struct session *session)
 {
     kfree_skb(session->skb);
-    hrtimer_cancel(&session->rxtimer);
-    hrtimer_cancel(&session->txtimer);
-    tasklet_disable(&session->rxtask);
-    tasklet_disable(&session->txtask);
+
+        /* When terminating a session, a hrtimer or a tasklet might run.
+         * When the hrtimer triggers its associated tasklet and vice versa,
+         * we need to make sure they are not running or scheduled to run.
+         * Otherwise, a race condition can occur when the soft irq is
+         * handling the tasklet, resulting in kernel panic.
+         */
+    while (test_bit(TASKLET_STATE_SCHED, &session->rxtask.state) ||
+        test_bit(TASKLET_STATE_RUN, &session->rxtask.state) ||
+        hrtimer_active(&session->rxtimer)) {
+        hrtimer_cancel(&session->rxtimer);
+        tasklet_disable(&session->rxtask);
+    }
+
+    while (test_bit(TASKLET_STATE_SCHED, &session->txtask.state) ||
+        test_bit(TASKLET_STATE_RUN, &session->txtask.state) ||
+        hrtimer_active(&session->txtimer)) {
+        hrtimer_cancel(&session->txtimer);
+        tasklet_disable(&session->txtask);
+    }
+
     kfree(session);
 }
