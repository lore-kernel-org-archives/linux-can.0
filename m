From: T Thayer <tthayer.linux@gmail.com>
Subject: Question about D_CAN implementation
Date: Tue, 12 Nov 2013 16:30:41 -0600
Message-ID: <CAF03EBfWAS=JG923ainNts0zqnCKGfBTbNWihC8qsFXu6QfwGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ve0-f176.google.com ([209.85.128.176]:45415 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756298Ab3KLWal (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Nov 2013 17:30:41 -0500
Received: by mail-ve0-f176.google.com with SMTP id c14so4811099vea.7
        for <linux-can@vger.kernel.org>; Tue, 12 Nov 2013 14:30:41 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: anilkumar@ti.com
Cc: linux-can@vger.kernel.org

Hi,

I'm experimenting with the combined C_CAN/D_CAN Linux driver for the
Altera CycloneV SoC which uses the Bosch D_CAN module..

I'm having some problems though. Specifically, I'm seeing 2 copies of
a frame get transmitted.

Strangely, the IRQ Status register = 0x800A inside the c_can_poll()
function indicates a RX message object (0 <  RX < 16) instead of a TX
message object.

If I use the standalone D_CAN driver which was in the
drivers/net/can/d_can directory, it seems to work fine (IRQ Status =
0x8011). I believe this directory was removed when the c_can and d_can
drivers were combined (SHA 69927fccd96b15bd228bb82d)

I noticed some significant differences - particularly in the
c_can_poll() function.
IRQ Status Test.
- d_can.c ANDs the irqstatus with STATUS_INTERRUPT
- c_can.c checks to see if the irqstatus == STATUS_INTERRUPT.
After IRQ Status Test.
- d_can.c has a separate if/else if loop to determine whether the
Message was RX/TX
- c_can.c has is a continuation of the IRQ status test (else if, else if)

Another symptom is that the tx_packet statistics aren't incrementing
as I send data. However, this may be related to the IRQ indicating a
RX message object.

Thank you for any insight you may have,


Thor
