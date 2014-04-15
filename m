From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Problem with Eurotech COM1273 Dual Channel CAN PC104 Module.
Date: Tue, 15 Apr 2014 14:00:35 +0200
Message-ID: <534D1F63.6080101@hartkopp.net>
References: <CA+s8ZrqFBun4bo2rJJFHb0FrV7m7PLybUVM+jjahKsdW8bdnaQ@mail.gmail.com>	<164afc991761b9eeb0eec6902814d00e@grandegger.com>	<534D0F00.7000202@hartkopp.net> <CA+s8Zrqrd_U0g1GRCDzXncgWLA_kO3Hyhjwy6Oe1S0cYohm2og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:34325 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022AbaDOMAj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Apr 2014 08:00:39 -0400
In-Reply-To: <CA+s8Zrqrd_U0g1GRCDzXncgWLA_kO3Hyhjwy6Oe1S0cYohm2og@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: khurram gulzar <khurramgulzar@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

As I wrote in the other thread:

> The command i am executing is 
> modprobe sja1000_isa port=0x200,0x204 irq=10,11 indirect=1 

The parameters for each interface are given separately

> but in dmesg it says 
>>> probe of sja1000_isa.1 failed with error -16 

That's correct as you did not provide the 'indirect' flags to the _second_
interface :-)

So
	modprobe sja1000_isa port=0x200,0x204 irq=10,11 indirect=1,1

should make it.

> I am now running linux kernel version 3.2 

A good choice :-)

Best regards,
Oliver

