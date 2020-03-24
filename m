From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: How to send a CAN message while in a kernel module?
Date: Tue, 24 Mar 2020 08:20:12 +0100
Message-ID: <dce40c51-4329-09d7-5c5f-b527ebcb13ba@hartkopp.net>
References: <CAOHJ0jSS=g4rQtXGkEFocafEqQAtxEOvq5eSXBC2FY_Esb23OA@mail.gmail.com>
 <2cb68f43-a551-c69d-b43f-3b044b948142@hartkopp.net>
 <CAOHJ0jRQx2U1APx92DTGFGzGLY9+tds3R4Sz8Tz8+LToWx_44g@mail.gmail.com>
 <ead77f42-f0f9-9b5a-ce5a-5e7f641d8a14@hartkopp.net>
 <CAOHJ0jQq80B64O6nG-aNSUhUrczVL0r4GZj-AUWcs4coiERG+Q@mail.gmail.com>
 <5edb635d-f248-6c79-766c-d818de52c229@hartkopp.net>
 <CAOHJ0jTksLTcRuvx8xarRdcCA4oKKggi1pYQy725Lf-Zav6xGw@mail.gmail.com>
 <a8ebf3b8-3a7e-596d-7b83-5ce772d093a8@hartkopp.net>
 <CAOHJ0jQmfUMW2tE_xQvm8RmH-KBzGZ=rxG--kCJ0_yabE3FbYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:18997 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgCXHUY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 24 Mar 2020 03:20:24 -0400
In-Reply-To: <CAOHJ0jQmfUMW2tE_xQvm8RmH-KBzGZ=rxG--kCJ0_yabE3FbYA@mail.gmail.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Robert Barrows <robb.barrows@gmail.com>
Cc: linux-can <linux-can@vger.kernel.org>



On 23/03/2020 22.37, Robert Barrows wrote:
>> The CAN controller gets the frame from a FIFO (netdev tx queue) which
>> has a length of 10 elements by default.
> Any way I can force my way to the head of the queue?  I see
> skb->priority but I thought that was for TCP packets.

Yes.

>> But when you generate additional traffic (e.g. with cangen) you might
>> get some jitter.
>> Is this relevant on your box / use-case?
> It is possible there could be a lot of packets flying around and I would
> like to keep my jitter <100uS. Any tips?

Please take a look into slide 41 - 45 of this PDF:
https://wiki.automotivelinux.org/_media/agl-distro/agl2017-socketcan-print.pdf

The academic report about this can be found here
http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf

You still have to cope with the txqueue length of 10 so you probably 
need to create a setup that drains the tx queue before your 
jitter/time-sensitive CAN frame is enqueued.

Another option would be to implement multiple tx queues on CAN drivers - 
but that has not been focused AFAIK.

Best,
Oliver
