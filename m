From: T Thayer <tthayer.linux@gmail.com>
Subject: D_CAN problems after devm_ioremap_resource conversion.
Date: Wed, 25 Sep 2013 15:36:19 -0500
Message-ID: <CAF03EBdqih4s1iUwZXqZtgNHx-btBdfrNoHy2z9xVuaS-ki41Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ve0-f195.google.com ([209.85.128.195]:51003 "EHLO
	mail-ve0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755879Ab3IYUgU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Sep 2013 16:36:20 -0400
Received: by mail-ve0-f195.google.com with SMTP id db12so24034veb.10
        for <linux-can@vger.kernel.org>; Wed, 25 Sep 2013 13:36:19 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: tushar.behera@linaro.org
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, wg@grandegger.com, davem@davemloft.net

Hello.

I've run into a problem with the Altera CycloneV SoCFPGA D_CAN driver
implementation after the devm_request_and_ioremap() to
devm_ioremap_resources() change (git commit
32766fff24a761079636bb96c389411d24a334c6. As another data point, I do
not have problems with 3.10 (which did not have the
devm_ioremap_resources() change).

I looked through the CAN mailing list archives but could not find any
issues that matched my symptoms.

Board #1 running 3.11 (git commit
d25903f894849fa799141e774c4ad34199e3e6a1) that I configure as:
canconfig can0 bitrate 500000
canconfig can0 start
candump can0


Board #2 running 3.10 that I configure as:
canconfig can0 bitrate 500000
canconfig can0 start
cansend can0 -i 0x123 0x11 0x22 0x33 0x44 0x55 0x66 0x77 0x88

But nothing appears on the Board#1 dump.

The strange thing is that if I type something (ie. the letter "A") in
Board#1's terminal window and then change to Board#2's terminal window
and do another
cansend can0 -i 0x123 0x11 0x22 0x33 0x44 0x55 0x66 0x77 0x88

then 2 messages show up on the candump (the original one and the one
just sent). From then on, typing
cansend can0 -i 0x123 0x11 0x22 0x33 0x44 0x55 0x66 0x77 0x88

shows up on Board#1. It almost seems like typing any character in
Board#1's terminal (which is waiting for data via candump) frees up
the candump buffer printout.

I don't know if this is an issue with candump or with the CAN driver.
It doesn't seem like a candump issue because it works OK if I revert
and rebuild the kernel before the above commit.  (and it breaks if I
update my tree to after the above commit and rebuild).

Thank you for any insight you may have,

Thor
