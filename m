From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: CAN bus transmission timeout
Date: Mon, 28 Oct 2013 15:35:58 +0100
Message-ID: <20131028143558.GB493@vandijck-laurijssen.be>
References: <CAGfq0uuk-7ihMaYvgEGUvnMaNLcxQc6LrvizuFG2g_KHga7iCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay008.isp.belgacom.be ([195.238.6.174]:9467 "EHLO
	mailrelay008.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756595Ab3J1OgL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Oct 2013 10:36:11 -0400
Content-Disposition: inline
In-Reply-To: <CAGfq0uuk-7ihMaYvgEGUvnMaNLcxQc6LrvizuFG2g_KHga7iCw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Kirienko <pavel.kirienko.list@gmail.com>
Cc: linux-can@vger.kernel.org

Hi Pavel,

I believe the queue filling can be solved by reading your own
messages back. As long as you see your own messages, your queue
remains empty.
When your messages is not yet read back, you must assume it did not
get out yet, so it's still in the queue. No need to resend, because
the previous one is yet pending.

When you receive a bus-off indication, you should reset this mechanism.

This address problems 1 & 3.
Problem 2 (old data) remains for 1 transmission period.

receiving your own traffic can be instructed with:

    int recv_own_msgs = 1; /* 0 = disabled (default), 1 = enabled */

    setsockopt(sock, SOL_CAN_RAW, CAN_RAW_RECV_OWN_MSGS,
               &recv_own_msgs, sizeof(recv_own_msgs));

Kind regards,
Kurt

On Mon, Oct 28, 2013 at 05:59:02PM +0400, Pavel Kirienko wrote:
> Hi list,
> 
> Consider the following scenario:
> 
> There is a Linux-powered device connected to a CAN bus. The device
> periodically transmits the CAN message. The nature of the data carried
> by this message is like measurement rather than command, i.e. only the
> most recent one is actually valid, and if some messages are lost that
> is not an issue as long as the latest one was received successfully.
> 
> Then the device in question is being disconnected from the CAN bus for
> some amount of time that is much longer than the interval between
> subsequent message transmissions. The device logic is still trying to
> transmit the messages, but since the bus is disconnected the CAN
> controller is unable to transmit any of them so the messages are being
> accumulated in the TX queue.
> 
> Some time later the CAN bus connection is restored, and all the
> accumulated messages are being kicked on the bus one by one.
> 
> --- Problem ---
> 
> 1. When the CAN bus connection is restored, undefined amount of
> outdated messages will be transmitted from the TX queue.
> 
> 2. While the CAN bus connection is still not available but TX queue is
> already full, transmission of some most recent messages (i.e. the only
> valid messages) will be discarded.
> 
> 3. Once the CAN bus connection is restored, there would be short term
> traffic burst while the TX queue is being flushed. This can alter the
> Time Triggered Bus Scheduling if one is used (it is in my case).
> 
> --- Question ---
> 
> My application uses SocketCAN driver, so basically the question should
> be applied to SocketCAN, but other options are considered too if there
> are any.
> 
> I see two possible solutions: define a message transmission timeout
> (if a message was not transmitted during some predefined amount if
> time, it will be discarded automatically), or abort transmission of
> outdated messages manually (though I doubt it is possible at all with
> socket API).
> 
> Since the first option seems to be most real to me, the questions are:
> 
> 1. How does one define TX timeout for CAN interface under Linux?
> 
> 2. Are there other options exist to solve the problems described
> above, aside from TX timeouts?
> 
> Thanks in advance,
> Pavel Kirienko.
> 
> P.S. reposted from http://stackoverflow.com/questions/19633015
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534
