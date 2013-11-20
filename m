From: "Glen, Andrew" <AGlen@bepmarine.com>
Subject: Calls to 'pm_runtime_resume()' made from the interrupt context
 without 'pm_runtime_irq_safe' in 'c_can.c' causing occasional kernel crash.
Date: Wed, 20 Nov 2013 02:07:26 +0000
Message-ID: <2A43324E02E34840B044C9DC922144800904D233@AMDTCEX10.actuant.pri>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail1.bemta7.messagelabs.com ([216.82.254.103]:39892 "EHLO
	mail1.bemta7.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752423Ab3KTCGv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 19 Nov 2013 21:06:51 -0500
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

I've been getting occasional crashes running the 3.12 mainline kernel with a Debian rootfs on an AM335x (Beaglebone Black).

The crash would only ever occur the first time the can0 device is brought up, i.e.: Reboot, call to 'ip link set can0 type can bitrate 250000 triple-sampling on', then 'ip link set can0 up' and about 40% of the time I'd get a crash.

If the 'ip link set can0 up' succeeded I could then bring the can0 device up/down repeatedly with no issues.

Strangely, this problem would not occur running the same kernel with the Ubuntu rootfs - but I think this is unrelated to the issue.

As the crash dump suggests, the problem is caused by a call to '__pm_runtime_resume' being made from within an interrupt routine - occuring when the CAN device is brought up immediately into a bus error (assumedly caused by starting up the can receiver midway through a transmission by another device).

Power management should not occur from within an interrupt routine, so by making a special interrupt version of the routine problematically calling '__pm_runtime_resume' (i.e. 'c_can_get_berr_counter'), but with this call removed, I was initially able to get around the problem.

Further researching into the issue, I found the following in '/Documentation/power/runtime_pm.txt':

It is safe to execute the following helper functions from interrupt context:

pm_request_idle()
pm_request_autosuspend()
pm_schedule_suspend()
pm_request_resume()
pm_runtime_get_noresume()
pm_runtime_get()
pm_runtime_put_noidle()
pm_runtime_put()
pm_runtime_put_autosuspend()
pm_runtime_enable()
pm_suspend_ignore_children()
pm_runtime_set_active()
pm_runtime_set_suspended()
pm_runtime_suspended()
pm_runtime_mark_last_busy()
pm_runtime_autosuspend_expiration()

If pm_runtime_irq_safe() has been called for a device then the following helper
functions may also be used in interrupt context:

pm_runtime_idle()
pm_runtime_suspend()
pm_runtime_autosuspend()
pm_runtime_resume()
pm_runtime_get_sync()
pm_runtime_put_sync()
pm_runtime_put_sync_suspend()
pm_runtime_put_sync_autosuspend()


In 'c_can.c' as we find it in 3.12 mainline, calls to 'pm_runtime_resume()' are being made from the interrupt context (i.e. omap3_intc_handle_irq ->handle_IRQ->irq_exit->do_softirq->__do_softirq->net_rx_action->c_can_poll->c_can_state_change->c_can_get_berr_counter->__pm_runtime_resume) without 'pm_runtime_irq_safe' having first been called.

So it makes sense that these problems were occurring, and that the problem goes away after inserting this call.

I propose something like the following to fix this problem:

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c index a668cd4..638fd22 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
<at>  <at>  -1103,6 +1103,8  <at>  <at>  static int c_can_open(struct net_device *dev)
        int err;
        struct c_can_priv *priv = netdev_priv(dev);

+       pm_runtime_irq_safe(priv->device);
+
        c_can_pm_runtime_get_sync(priv);
        c_can_reset_ram(priv, true);



Regards,
Andrew Glen.

________________________________

Actuant Corporation Email Notice

This message is intended only for the use of the Addressee and may contain information that is PRIVILEGED and/or CONFIDENTIAL.
This email is intended only for the personal and confidential use of the recipient(s) named above. If the reader of this email is not an intended recipient, you have received this email in error and any review, dissemination, distribution or copying is strictly prohibited.
If you have received this email in error, please notify the sender immediately by return mail and permanently delete the copy you received.

Thank you.
