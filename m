From: John Whitmore <arigead@gmail.com>
Subject: Re: detect auto baud rate on can bus in linux driver.
Date: Sun, 27 Apr 2014 10:44:22 +0100
Message-ID: <20140427094418.GB28319@griso.site>
References: <53590FB6.6090707@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:58109 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160AbaD0Jo1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 27 Apr 2014 05:44:27 -0400
Received: by mail-wg0-f51.google.com with SMTP id z12so4068100wgg.22
        for <linux-can@vger.kernel.org>; Sun, 27 Apr 2014 02:44:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53590FB6.6090707@tataelxsi.co.in>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ratheendran <ba.rsrajeshwaran@tataelxsi.co.in>
Cc: linux-can@vger.kernel.org

On Thu, Apr 24, 2014 at 06:50:54PM +0530, Ratheendran wrote:
> Hi All,
> 
> Need you help in understanding detecting auto baud rate of CAN bus.
> please share your valuable experience.
> 
> I am using imx6 processor which has flexcan hardware driver
> implemented as socketcan stack.
>

I've used auto baud rate detection with the Microchip MCP2515 CAN Controller
connected to a PIC controller, but not with Linux, as yet. I'm working on my
own CAN Bus network so have control of all the nodes. There is a "Ping"
Protocol built into the nodes so that if there is no network traffic in a
certain period of time a random node will fire a "Ping" frame onto the CAN
Bus. That way I'm guaranteed that there will be network traffic to listen to.

In addition to network traffic my network uses a fixed number of baud rates:

10K, 20K, 50K, 125K, 250K, 500, 800K, and 1M

Now given all that on the network I simply set the MCP2515 into listen only
mode at a baud rate of 10K. If the Ping message is set for 10 seconds and I
listen for 30 Seconds I should at least get 3 CAN Frames. If I've got the
wrong baud rate I'll get MERRE errors in listen mode. My driver simply, when
in listen mode, counts received good frames and errors. If after 30 seconds
I've got good frames and no errors then I've found the baud rate being used by
the network and I can drop out of listen mode. If there are any errors then
simply move up to the next baud rate and start listening again.

This all works for me as I'm assured of traffic and have a limited number of
baud rates to search through.

I keep meaning to look at this on Linux but I've been distracted with other
work. I'll get back to it. Not sure how it would fit into the Linux can
architecture. The Driver code would have to count errors and userspace would
have to look at the results and change baud rate, or connect.

Hope that's of some help.
 
> With Regards,
> Ratheendran
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
