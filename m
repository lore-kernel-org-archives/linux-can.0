From: Jim Morash <jmorash@gmail.com>
Subject: Receiving overloaded and/or out-of-order on iMX6 platform
Date: Tue, 6 Jun 2017 15:55:50 -0700
Message-ID: <CAFFyqAYjEdxVg44=9VC=TqxMs6mbMGK1FFPQ-E_GPpPH0XwTSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wr0-f181.google.com ([209.85.128.181]:36132 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751430AbdFFWzw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Jun 2017 18:55:52 -0400
Received: by mail-wr0-f181.google.com with SMTP id v111so53683030wrc.3
        for <linux-can@vger.kernel.org>; Tue, 06 Jun 2017 15:55:51 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi Linux-CAN,

My team is using SocketCAN on an iMX6 platform, currently running
kernel 3.14.52. Our Linux system is connected to a CAN network of
about 20 cortex M4 microcontrollers, bitrate 250kbps.

Most of the time, everything on this CAN network is fine. We have been
able to intermittently push the flexcan controller into a bad state
(error-warn followed eventually by bus-off) but the issue has proven
difficult to reproduce.

So far it looks like it is most reliably reproducible when we send a
broadcast message to the entire microcontroller network and all of
those nodes respond simultaneously. Our flexcan controller can't
manage to receive all those messages at once, I guess? I found some
old emails by Tom E. that describe a perhaps-related problem with tx
queues but we're a bit confused about how the same principles might
apply to rx:

http://marc.info/?t=148220970300001&r=1&w=2

In this type of situation we also see some frames come in out of
order. I was digging through the linux-can list archives and happened
upon a few messages, about various "rx-offload" patches that are meant
to prevent out-of-order reception. For example:

http://marc.info/?l=linux-can&m=148475186527666&w=2
http://marc.info/?l=linux-can&m=148475343228248&w=2

[side note, gmane list archives are not working, but marc.info is working]

It doesn't look like this feature made it into the official freescale
tree for either 3.14.52 or 4.1.15, but perhaps I am looking in the
wrong places?

http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/net/can?h=imx_3.14.52_1.1.0_ga
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/net/can?h=imx_4.1.15_1.0.0_ga

Thanks in advance for any help available.
Jim
