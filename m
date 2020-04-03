From: =?UTF-8?Q?Andrejus_Fal=C4=8Dikas?= <andrejus.f@8devices.com>
Subject: Fwd: usb_8dev - WARN_ON(in_irq()) Ticket #00560
Date: Fri, 3 Apr 2020 16:04:28 +0300
Message-ID: <CAFnz-BWK_c63YyZ2KzMq=EWn6yfEQyyX+Vo7WSh4SddyY7PCfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ed1-f48.google.com ([209.85.208.48]:39136 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390715AbgDCNEo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Apr 2020 09:04:44 -0400
Received: by mail-ed1-f48.google.com with SMTP id a43so9167646edf.6
        for <linux-can@vger.kernel.org>; Fri, 03 Apr 2020 06:04:43 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: socketcan@hartkopp.net
Cc: michal.sojka@cvut.cz, linux-can@vger.kernel.org

Hello Mr. Oliver Hartkopp,

I would like to notify you that the case described as the issue is
caused by non-standard use of the device and protocol.

Firstly, the model situation with only a single device on the CAN bus
is invalid and very rarely occurs in real life due to the purpose and
underlying principles of the CAN2.0 protocol. Every CAN message sent
to the bus should be acknowledged by other bus node(s) or it will
increment the error counter and will be retransmitted.

The proper usage of a single device (e. g. for testing or
self-diagnostic purposes) would be to enable loopback mode on when
initialising the device in question, as that will ensure that the
device acknowledges the messages it sends to the bus.

Secondly, usage of termination resistors is a must on a CAN bus, and
according to ISO 11898-2 (CAN High Speed) standard the bus is a linear
bus that must be terminated at each end with 120 Ohm resistors. The
termination resistors are needed to suppress reflections as well as
return the bus to its recessive or idle state.

Moreover, the kernel warnings appear to be caused by the socketCAN
layer using netif_rx() function inside an interrupt, they can be
easily recreated using the obsoleted first generation USB2CAN device
and most likely any other device using socketCAN.

Finally, TX URB aborted(-2) errors are expected in the described
scenario as error code -2 (-ENODEV) simply notifies that the specified
device for the URB to be submitted no longer exists (as is expected
when device is brought down).

Taking into account the findings above we will close this ticket as
the issue was caused by non-standard usage of the device.

Best regards,
Andrejus F.
