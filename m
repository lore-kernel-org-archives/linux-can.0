From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: State of ISO-TP in SocketCAN?
Date: Thu, 23 Jul 2015 20:29:17 +0200
Message-ID: <55B1327D.10507@hartkopp.net>
References: <C0D0FD46-6144-4CFF-9730-FC6920E35766@codm.de> <55AFE01E.1080700@hartkopp.net> <1689D99C-35FD-4CC4-ADDB-375F1B6F7ACC@codm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:42780 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385AbbGWS3W (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Jul 2015 14:29:22 -0400
In-Reply-To: <1689D99C-35FD-4CC4-ADDB-375F1B6F7ACC@codm.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tobias Schmitt <tobias.schmitt@codm.de>
Cc: linux-can@vger.kernel.org

Hi Tobias,

On 23.07.2015 20:02, Tobias Schmitt wrote:

> But I have one more question: I tested a lot with socketcand and the isotp utilities in can-utils today. In all of the programs you have to define the source and destination IDs on the can bus very static.
> In our application we use extended adressing, the master device on CAN has a specific id (0x00) and has to listen to the slave devices (which need to have different IDs for adressing).
>
> So I either need to open a socket for every slave device, or in case of possible wildcards the program call could be:
>
> ./isotprecv -s * -d 0 -x 0:**
>
> Is there any possibility to use the SocketCAN isotp protocol the "wildcard"-way I intend? I could also pass the information about the sender device into the payload of the isotp message. But why is there extended adressing then?

No, intentionally not.

Whenever you have a transport protocol channel for segmented PDUs you have to 
provide two CAN-IDs to match FF/CF and FC messages on the 'virtual channel' on 
the bus.

The extended addressing is just some kind of 'extension for the CAN-ID'.

E.g. If you would have a wildcard, to what address should you send the FC 
then? You would need to implement some connection tracking - even when you are 
communicating simultaneously to different nodes.

The functional addressing does not need segmentation, so you can create and 
send functional PDUs by 'handmade' ISO-TP CAN frames via CAN_RAW sockets.

When your application needs to 'listen' on several transport channels you may 
create as much sockets as you need and read from them simultaneously e.g. with 
the select() syscall.

Does that help for your use-case? Can you tell about your use-case?

Regards,
Oliver

