From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: State of ISO-TP in SocketCAN?
Date: Wed, 22 Jul 2015 20:25:34 +0200
Message-ID: <55AFE01E.1080700@hartkopp.net>
References: <C0D0FD46-6144-4CFF-9730-FC6920E35766@codm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:27082 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbbGVSZh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Jul 2015 14:25:37 -0400
In-Reply-To: <C0D0FD46-6144-4CFF-9730-FC6920E35766@codm.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tobias Schmitt <tobias.schmitt@codm.de>, linux-can@vger.kernel.org

On 22.07.2015 11:45, Tobias Schmitt wrote:

> And now I'm very confused and maybe on a complete wrong track.

No, you aren't :-)

> Is there a official and stable way to use ISOTP as a protocol in SocketCAN, and where can I find it?

https://github.com/hartkopp/can-isotp-modules

> Is it still in development and can I help with it somehow?

Yes. It is still under development. Not that much - but it is.

After clonig the above git repo just do

cd can-isotp-modules/net/can
./make_isotp.sh

and then as user 'root'

modprobe can
insmod ./can-isotp.ko

Or you might copy can-isotp.ko to your local modules tree

cp can-isotp.ko /lib/modules/`uname -r`/kernel/net/can/
depmod -A


Please remember to take care of the tx-queue-len referenced in README.isotp

Regarding the state of the ISO-TP implementation:

The implementation is somehow stable. The latest changes were added to 
implement the ISO15765-2:2015 protocol which can use CAN FD frames.
The ISO-TP (segmentation) protocol itself is working properly.

The reason why isotp.c is not is mainline Linux is that I'm unsure with the 
final socket API and probably some transmission control to make the hack with 
the tx-queue-len obsolete.

With ISO-TP for CAN FD the PDU size is not limited to 4095 byte but you can 
specify PDUs up to 4GB (2^32-1). Currently you can read write a complete PDU 
buffer - but when having e.g. a 128 kbyte PDU creating a buffer of such size 
in kernel looks wrong. So maybe some improved buffering as to be implemented 
or some throttling/control when reading/writing the PDU from/to the socket.

So if you have ideas about how to solve these final issues I definitely would 
appreciate to discuss them here :-)

Best regards,
Oliver
