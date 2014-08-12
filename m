From: Florian Feldbauer <florian@ep1.ruhr-uni-bochum.de>
Subject: Writing socketCAN module for my own hardware
Date: Tue, 12 Aug 2014 09:51:16 +0200
Message-ID: <53E9C774.3040401@ep1.ruhr-uni-bochum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.kph.uni-mainz.de ([134.93.132.3]:27927 "EHLO
	mail.kph.uni-mainz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbaHLIPk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Aug 2014 04:15:40 -0400
Received: from dell33pvf5j.him.kph ([10.32.91.234])
	(authenticated bits=0)
	by mail.kph.uni-mainz.de (8.14.5/8.14.5) with ESMTP id s7C7pJPh048275
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <linux-can@vger.kernel.org>; Tue, 12 Aug 2014 09:51:19 +0200 (CEST)
	(envelope-from florian@ep1.ruhr-uni-bochum.de)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hey all,

I have developed a CAN interface for the Raspberry Pi computer using th=
e=20
SJA1000 directly connected to the GPIOs of the CPU.
So far this interface is used as chardev and works fine.
But I'm also developing a user-space program using this CAN interface.=20
This program should also be compatible with other CAN interfaces like=20
the ones from PEAK or Kvazer. So I thought using socketCAN would be a=20
good idea.

Is there any documentation on how to write a socketCAN compatible kerne=
l=20
module for my own hardware?
I tried writing something similar to the sja1000_isa driver...
So far my modified kernel compiles and I can change bitrate and bring=20
the interface up.
But as soon as I try to send a CAN frame I get the error:
Error 105: No buffer space available

Any help appreciated!

Best regards,
=46lorian

--=20
----------------------------------------
| Dr. Florian Feldbauer                |
|                                      |
| Helmholtz-Institut Mainz /           |
| Johannes Gutenberg-Universit=E4t Mainz |
| Johann-Joachim-Becher-Weg 36         |
| D-55128 Mainz                        |
|                                      |
| Office: SB1 / 00-213                 |
| Phone:  (+49)6131 / 39-29605         |
----------------------------------------

