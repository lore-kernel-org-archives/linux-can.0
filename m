From: "Niew Sh." <shniew@gmail.com>
Subject: Re: Using can-utils
Date: Wed, 5 Jun 2013 03:29:48 +0800
Message-ID: <40EE3953-CC75-4A9C-87DF-DAA02292166C@gmail.com>
References: <673526D7-EDE8-4E9E-A0DD-D9B76BDECC5C@gmail.com> <51AE2E02.3000900@hartkopp.net>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:61153 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134Ab3FDT3y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Jun 2013 15:29:54 -0400
Received: by mail-pb0-f43.google.com with SMTP id ma3so686673pbc.16
        for <linux-can@vger.kernel.org>; Tue, 04 Jun 2013 12:29:53 -0700 (PDT)
In-Reply-To: <51AE2E02.3000900@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Very clear. Thank you for fast reply.

On Jun 5, 2013, at 2:12 AM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:

> On 04.06.2013 18:44, Niew Sh. wrote:
> 
>> I'm new to SocketCAN, do i need libsocketcan <git://git.pengutronix.de/git/tools/libsocketcan.git> to use the can-utils from <git://gitorious.org/linux-can/can-utils.git>?
> 
> No.
> 
> can-utils (gitorious)
> -> a set of the major community tools that are usually used and referenced
> (does not need libsocketcan to compile and run)
> 
> libsocketcan
> -> a library for people that want to configure und control CAN interfaces from
> C code (instead of using the 'ip' tool from the iproute2 package).
> 
> 
> canutils (ptx flavour) http://git.pengutronix.de/?p=tools/canutils.git
> -> five tools that are used and referenced in 'PTX dist' board support packs.
> Not that much features but contains 'canconfig' for CAN interface
> configuration as alternative to the 'ip' tool. canconfig uses libsocketcan.
> 
>> I mean to rightly test my CAN hardware.
> 
> I would recommend can-utils (gitorious).
> 
>> What about the can-utils from <http://www.pengutronix.de/software/socket-can/download/canutils/> is that obsolete? Please guide.
>> 
> 
> See above.
> 
> Regards,
> Oliver
> 


Regards,
Sh. Niew

