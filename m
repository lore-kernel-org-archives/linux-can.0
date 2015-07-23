From: Tobias Schmitt <tobias.schmitt@codm.de>
Subject: Re: State of ISO-TP in SocketCAN?
Date: Thu, 23 Jul 2015 20:02:01 +0200
Message-ID: <1689D99C-35FD-4CC4-ADDB-375F1B6F7ACC@codm.de>
References: <C0D0FD46-6144-4CFF-9730-FC6920E35766@codm.de> <55AFE01E.1080700@hartkopp.net>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.codm.de ([213.178.9.190]:35861 "EHLO aria.codm.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753721AbbGWSCF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Jul 2015 14:02:05 -0400
In-Reply-To: <55AFE01E.1080700@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org


> After clonig the above git repo just do
> 
> [...]

I completely missed the additional makefiles in subfolders. Thank you! Everything works fine now!

> 
> [...]
> The ISO-TP (segmentation) protocol itself is working properly.

Perfect. ISO-TP itself is the main point for us since we do not use CAN FD.

But I have one more question: I tested a lot with socketcand and the isotp utilities in can-utils today. In all of the programs you have to define the source and destination IDs on the can bus very static.
In our application we use extended adressing, the master device on CAN has a specific id (0x00) and has to listen to the slave devices (which need to have different IDs for adressing).

So I either need to open a socket for every slave device, or in case of possible wildcards the program call could be:

./isotprecv -s * -d 0 -x 0:**

Is there any possibility to use the SocketCAN isotp protocol the "wildcard"-way I intend? I could also pass the information about the sender device into the payload of the isotp message. But why is there extended adressing then?

> So if you have ideas about how to solve these final issues I definitely would appreciate to discuss them here :-)

I have to add that I'm just a cs student in my bachelor internship and might be not the right person to discuss this topics. At the moment I'm studying the Linux Device Drivers 4th Edition book and also the whole SocketCAN project. But maybe in a few weeks I might have an opinion about it :-).

Best regards
Tobias