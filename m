From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: can-isotp-modules
Date: Wed, 30 Mar 2016 16:54:32 +0200
Message-ID: <56FBE8A8.2080307@hartkopp.net>
References: <zarafa.563c41ac.05a0.6a1e301242cec580@euve35974.vserver.de>
 <56F8FCA6.4060007@posteo.de> <56FBC475.1070703@hartkopp.net>
 <56FBD37A.2080600@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:16720 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbcC3Oyq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 30 Mar 2016 10:54:46 -0400
In-Reply-To: <56FBD37A.2080600@posteo.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Patrick Menschel <menschel.p@posteo.de>, Michael Luxen <mluxen@gmx.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 03/30/2016 03:24 PM, Patrick Menschel wrote:

> looks almost the same as what Michael posted on 03.11.2015 23:29
>> root@beaglebone:~/can-isotp-modules# make
>> make -C /lib/modules/4.1.6-ti-r16/build M=/root/can-isotp-modules modules TOPDIR=/root/can-isotp-modules
>> make[1]: Entering directory '/usr/src/linux-headers-4.1.6-ti-r16'
>>    CC [M]  /root/can-isotp-modules/drivers/net/can/vcan.o

ok - got the problem:

You need to step down into

	/root/can-isotp-modules/net/can

and invoke

	./make_isotp.sh

there.

See README.isotp file.

Regards,
Oliver
