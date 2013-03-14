From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: CAN j1939 library doubts
Date: Thu, 14 Mar 2013 13:20:45 +0100
Message-ID: <20130314122045.GD3382@vandijck-laurijssen.be>
References: <loom.20130312T213038-40@post.gmane.org>
 <854F9BFD-752B-4B2B-A637-7310BCF8B7D2@emailplus.org>
 <20130313084248.GA449@vandijck-laurijssen.be>
 <loom.20130314T121737-364@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:46117 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757259Ab3CNMUv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 14 Mar 2013 08:20:51 -0400
Content-Disposition: inline
In-Reply-To: <loom.20130314T121737-364@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Giox79 <giovanniparodi79@gmail.com>
Cc: linux-can@vger.kernel.org

On Thu, Mar 14, 2013 at 11:17:51AM +0000, Giox79 wrote:
> Kurt Van Dijck <kurt.van.dijck <at> eia.be> writes:
> 
> > 
> 
> Hi Kurt, 
> thanks for your reply. I have a question related to J1939. My task is to extract 
> from raw can packets info like oil, brake pressure and so on.
> Can you tell me if it is right that after building the kernel for my board using 
> your modified can driver, and using the jspy utils, I will have only to build 
> the J1939 parser?

I think you could do that without jspy.
You could write a program that connect to a j1939 socket, similar to jspy,
and listen to any packet that if of your interest.
You would get the PGN's as binary streams (possible >8 bytes)

Your program will get quite straight-forward then.

I assume you won't need Address Claiming, since you're watching generic PGN's?

> Is there any utility that will allow me parsing the standard (not vendor 
> dependent)packets?
> If I will be successfull building the J1939 in my SW environment, I will try to 
> create a little howto.
> If you think this can be useful, I will send it to you.
> have a nice day

-- 
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534
