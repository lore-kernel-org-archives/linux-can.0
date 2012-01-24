From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [Socketcan-users] increase buffer size
Date: Tue, 24 Jan 2012 17:17:11 +0100
Message-ID: <4F1ED987.3050903@hartkopp.net>
References: <1567213.2GCzMlGyKY@lisa> <4F1E9DA9.9060804@hartkopp.net> <3362435.B6CXOz5dhC@lisa>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:48001 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755079Ab2AXQRS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Jan 2012 11:17:18 -0500
In-Reply-To: <3362435.B6CXOz5dhC@lisa>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Steffen Rose <ro@emtas.de>
Cc: linux-can@vger.kernel.org

On 24.01.2012 16:42, Steffen Rose wrote:

> Hello Oliver
> 
> Am Dienstag, 24. Januar 2012, 13:01:45 schrieb Oliver Hartkopp:
>> ifconfig can0 txqueuelen 1000
>> ip link set can0 txqueuelen 1000
> 
> You wrote, that this command do not change the socket quere, this command 
> change the quere within the can adaptation. I hope, I understand this 
> correctly.


You have an amount of rx/tx buffersizes inside each socket.

You may refer to the  '-r' option of the candump tool which can modify the
socket rx buffer size.

But there is currently no quota for the socket tx buffer size, as the CAN
frames are put directly into the CAN netdevice queue (which can by modified
with the commands 'ip' and 'ifconfig').

> Is there a dependency to a specific SocketCAN version? Especially I'm 
> interested on embedded linux devices.


No. SocketCAN is the official CAN networking stack of Linux.
I also run it on a MPC5200 based embedded device.

> Is the quere part of the common 
> socketcan code or is it depend of the implementation?


The queue implementation is part of Linux' general network stack on which
SocketCAN bases.

Regards,
Oliver

