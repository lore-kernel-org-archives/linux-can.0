From: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Subject: SJA1000 register accesses
Date: Mon,  5 Sep 2016 20:58:51 +0300
Message-ID: <20160905175852.1513-1-nebaruzdin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35130 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932234AbcIESAz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 5 Sep 2016 14:00:55 -0400
Received: by mail-lf0-f48.google.com with SMTP id l131so37419391lfl.2
        for <linux-can@vger.kernel.org>; Mon, 05 Sep 2016 11:00:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2168:c20:3f01:8219:34ff:fe1f:3777])
        by smtp.gmail.com with ESMTPSA id 136sm5000314ljj.0.2016.09.05.11.00.52
        for <linux-can@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Sep 2016 11:00:52 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

We use CAN at 1 Mbit/s with sometimes pretty high bus load (our client wants to
do some strange things over CAN). So my colleagues were complaining that CAN
consumes too much CPU on our machines, which negatively affects the work of
other network interfaces.

While investigating if we can do anything about this, I have learned that
sja1000 interrupt handler wastes 90 % of the time on register accesses.
Particularly, when the driver deals with the transmit/receive buffer, it needs
to access up to 13 consecutive bytes (frame information byte + 2/4 CAN ID bytes
+ 0-8 payload bytes). At the moment, this is done with 13 ioread8()/iowrite8()
calls. Considering that PCI bus transactions are at least 32 bits wide, I
believe we can do much better.

Thus I made the patch. I tested it on the machine with Intel Core 2 Duo E4700
CPU (2.60 GHz) and ELCUS CAN-200PCI (SJA1000-based) card under the maximum load
(cangen -ig 0) and got the following results:

> ==========================================================================================================
>			CPU load: irq/can0, irq/can1	Bus load		Frames per second (+/- 100)
> ----------------------------------------------------------------------------------------------------------
> Traffic\Variant	Current		Patched		Current	Patched		Current	Patched
> ----------------------------------------------------------------------------------------------------------
> STD random		25 %, 26 %	22 %, 23 %	88 %	92 %		7900	8200
> EXT random		23 %, 24 %	20 %, 20 %	91 %	94 %		6600	6900
> STD RTR random	37 %, 31 %	34 %, 31 %	73 %	77 %		13400	14000
> EXT RTR random	31 %, 27 %	28 %, 25 %	80 %	85 %		10000	10600
> STD 8 bytes payload	23 %, 25 %	21 %, 21 %	90 %	94 %		6600	7000
> EXT 8 bytes payload	22 %, 24 %	19 %, 19 %	91 %	96 %		5700	6000
> STD 5 bytes payload	26 %, 27 %	24 %, 23 %	88 %	91 %		8400	8600
> STD 1 byte payload	30 %, 31 %	29 %, 30 %	82 %	83 %		12600	12800

These results are obtained with the help of cangen, htop and canbusload. can0
was the sender and can1 — the receiver. As you can see, in all cases the CPU
load decreased while the number of transmitted frames and the bus load went up.
