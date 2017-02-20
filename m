From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: ti_hecc: canfdtest rx freeze
Date: Mon, 20 Feb 2017 10:08:20 +0100
Message-ID: <CAGm1_kux90=SkCquSB3Rdh0rJdQA1DPgt42849sw-pvnNWBAXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33536 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbdBTJIs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 20 Feb 2017 04:08:48 -0500
Received: by mail-wm0-f47.google.com with SMTP id t18so20948888wmt.0
        for <linux-can@vger.kernel.org>; Mon, 20 Feb 2017 01:08:47 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>, "Grim, Dennis" <Dennis.Grim@teejet.com>, Marc Kleine-Budde <mkl@pengutronix.de>

I have a trouble with ti_hecc driver. When doing tx I have no
problems, but rx path freezes after about 18 frames.

The problem is that in ti_hecc_rx_poll() the while loop will be left
when we flip the mailboxes:

                } else if (priv->rx_next == HECC_MAX_TX_MBOX - 1) {
                        priv->rx_next = HECC_RX_FIRST_MBOX;
                        break;
                }

but, if there are still unhandled packets we leave the routine without
enabling RX mailbox interrupts. So if we don't receive any other
interrupts CAN interface "freezes". So removing break fixes this
issue.

But when running canfdtest -vv can0 for example against PEAK's USB-CAN
ti_hecc stops to receive frames after about 1 minute. Invoking "ip
link set can0 down" freezes the system.

I've applied Wolfgang's patch from 12.12.2016 with multiple spin_lock
fixes, but it didn't improve the situation.

Any idea?

Should I submit at least the break removing patch?

Regards,
Yegor
