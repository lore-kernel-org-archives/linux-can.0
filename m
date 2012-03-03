From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: read() question from newbie
Date: Sat, 03 Mar 2012 10:05:52 +0100
Message-ID: <4F51DEF0.9060501@hartkopp.net>
References: <CABHoAvngDnUfh6w7NXQksrmeLq52_cRp809rFZ+HriwYpZqo9w@mail.gmail.com> <CABHoAvmTvVfVKfwiZdf_=htKHYa554wpcPCRoEFujqwnxp9tkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:18825 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046Ab2CCJF5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 3 Mar 2012 04:05:57 -0500
In-Reply-To: <CABHoAvmTvVfVKfwiZdf_=htKHYa554wpcPCRoEFujqwnxp9tkg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Economides <mecono@gmail.com>
Cc: linux-can@vger.kernel.org

On 02.03.2012 23:09, Michael Economides wrote:

> I am trying to use the cantest program to read.  It just blocks on the
> read, and stays there forever.
> 
>  I can see on my scope there are can messages coming across the bus (from a
> different microcontroller attached to the bus).
> 
> I have already verified I can write using cantest.
> 
> In other words, this works:  ./cantest can0 1F334455#1122334455667788
> 
> But this doesn't:  ./cantest can0
> 


Hello Mike,

where is this tool 'cantest' from?

I don't know it either from the SocketCAN utils

https://gitorious.org/linux-can/can-utils

nor from the Pengutronix canutils

http://git.pengutronix.de/?p=tools/canutils.git;a=summary

Maybe you can alternatively try the SocketCAN utils to test.

Regards,
Oliver
